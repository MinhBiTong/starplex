import gc
import threading
from functools import lru_cache
from pathlib import Path

import torch

from config import settings


class PromptTranslationError(RuntimeError):
    pass


_translator_load_lock = threading.Lock()


def _translation_dtype(device: str) -> torch.dtype:
    configured = settings.TRANSLATION_DTYPE.strip().lower()
    if configured == "float16":
        return torch.float16
    if configured == "bfloat16":
        return torch.bfloat16
    if configured == "float32" or device != "cuda":
        return torch.float32

    # TranslateGemma is distributed in bfloat16. Keeping its native dtype is
    # important: on this model/GPU combination, forcing float16 can produce an
    # empty generation even though inference itself does not raise an error.
    return torch.bfloat16


@lru_cache(maxsize=1)
def _get_translator():
    # Keep the 4B model loaded after the first request. The lock prevents two
    # simultaneous first requests from loading it twice.
    with _translator_load_lock:
        model_dir = Path(settings.TRANSLATION_MODEL_DIR)
        if not model_dir.is_dir() or not (model_dir / "config.json").is_file():
            raise PromptTranslationError(
                "TranslateGemma model is not installed. "
                f"Download it into {model_dir}."
            )

        try:
            from transformers import AutoModelForImageTextToText, AutoProcessor

            device = settings.TRANSLATION_DEVICE
            if device == "auto":
                device = "cuda" if torch.cuda.is_available() else "cpu"
            dtype = _translation_dtype(device)
            if device == "cuda":
                torch.backends.cuda.matmul.allow_tf32 = True
                torch.backends.cudnn.allow_tf32 = True
                torch.set_float32_matmul_precision("high")

            processor = AutoProcessor.from_pretrained(
                str(model_dir),
                local_files_only=settings.AI_LOCAL_FILES_ONLY,
            )
            model = AutoModelForImageTextToText.from_pretrained(
                str(model_dir),
                # Transformers 5 uses ``dtype``; unlike diffusers, it warns
                # that the older ``torch_dtype`` spelling is deprecated.
                dtype=dtype,
                device_map="auto" if device == "cuda" else None,
                local_files_only=settings.AI_LOCAL_FILES_ONLY,
            )
            if device != "cuda":
                model = model.to(device)
            model.eval()
            print(f"TranslateGemma model loaded from {model_dir} on {device}")
            return processor, model
        except PromptTranslationError:
            raise
        except Exception as error:
            raise PromptTranslationError(
                "TranslateGemma model could not be loaded. "
                f"Check the local model directory: {model_dir}."
            ) from error


def translate_prompt_to_english(prompt: str) -> str:
    prompt = prompt.strip()
    if not prompt:
        raise PromptTranslationError("Prompt cannot be empty")

    return _translate_prompt_uncached(prompt)


@lru_cache(maxsize=64)
def _translate_prompt_uncached(prompt: str) -> str:

    try:
        processor, model = _get_translator()
        messages = [
            {
                "role": "user",
                "content": [
                    {
                        "type": "text",
                        "source_lang_code": "vi",
                        "target_lang_code": "en",
                        "text": prompt,
                    }
                ],
            }
        ]
        inputs = processor.apply_chat_template(
            messages,
            tokenize=True,
            add_generation_prompt=True,
            return_dict=True,
            return_tensors="pt",
        )
        if hasattr(model, "device"):
            inputs = inputs.to(model.device)

        with torch.inference_mode():
            generated = model.generate(
                **inputs,
                max_new_tokens=128,
                do_sample=False,
                use_cache=True,
            )

        input_length = inputs["input_ids"].shape[-1]
        translated = processor.decode(
            generated[0][input_length:],
            skip_special_tokens=True,
        ).strip()
    except PromptTranslationError:
        raise
    except Exception as error:
        raise PromptTranslationError("Prompt translation failed") from error

    if not translated:
        raise PromptTranslationError("Prompt translation returned an empty result")
    return translated


def release_translator() -> None:
    """Release TranslateGemma's CUDA allocations before loading SDXL.

    TranslateGemma is dispatched across CUDA and CPU by Accelerate, so it
    cannot be moved with ``model.to('cpu')``. Clearing the cached model is the
    safe way to release its GPU layers between the translation and image
    stages. The next request lazily loads it again.
    """
    if settings.TRANSLATION_KEEP_LOADED:
        return
    if settings.TRANSLATION_DEVICE == "cpu" or (
        settings.TRANSLATION_DEVICE == "auto" and not torch.cuda.is_available()
    ):
        return

    _get_translator.cache_clear()
    gc.collect()
    if torch.cuda.is_available():
        torch.cuda.empty_cache()
