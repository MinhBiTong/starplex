"""Download the text-to-video models into AI_Server/models/.

Run from AI_Server with your normal venv:

    python scripts/download_video_models.py

Downloads (~29 GB total, resumable — just re-run if it breaks):
  - jbilcke-hf/LTX-Video-2b-0-9-8-distilled-HFIE -> models/ltxv-2b-distilled
    (complete diffusers pipeline for the 8-step distilled LTX-Video 0.9.8 2B;
     the official Lightricks 2B-distilled repos on HF are empty placeholders,
     this conversion carries the real weights. varnish/ and ltx_video/ are
     skipped — only the diffusers pipeline files are fetched)
  - linoyts/LTX-Video-spatial-upscaler-0.9.8      -> models/ltxv-spatial-upscaler-0.9.8
    (2x latent upsampler used by the "1080p" quality tier, matched to 0.9.8)

After downloading, the server loads them offline (AI_LOCAL_FILES_ONLY=True).

Tips for a slow/flaky connection:
  - Set HF_TOKEN (https://huggingface.co/settings/tokens) for higher rate
    limits and faster CDN edges.
  - This script disables the Xet transfer backend (HF_HUB_DISABLE_XET=1),
    which is the most common source of "CAS Client Error" drops; plain
    HTTPS resumes cleanly. Remove the line below on a stable link for
    potentially higher throughput.
"""

import os
import shutil
import time
from pathlib import Path

# Must be set before huggingface_hub is imported: the flag is read at import
# time. See module docstring for why Xet is disabled by default here.
os.environ.setdefault("HF_HUB_DISABLE_XET", "1")

from huggingface_hub import hf_hub_download, snapshot_download

SERVER_DIR = Path(__file__).resolve().parents[1]

MODELS = [
    (
        "jbilcke-hf/LTX-Video-2b-0-9-8-distilled-HFIE",
        SERVER_DIR / "models" / "ltxv-2b-distilled",
        [
            "model_index.json",
            "scheduler/*",
            "tokenizer/*",
            "text_encoder/*",
            "transformer/*",
            "vae/*",
        ],
    ),
    (
        "linoyts/LTX-Video-spatial-upscaler-0.9.8",
        SERVER_DIR / "models" / "ltxv-spatial-upscaler-0.9.8",
        ["latent_upsampler/*", "model_index.json"],
    ),
]

ATTEMPTS = 5


def _download(repo_id: str, local_dir: Path, allow_patterns: list[str]) -> None:
    for attempt in range(1, ATTEMPTS + 1):
        try:
            snapshot_download(
                repo_id=repo_id,
                local_dir=str(local_dir),
                allow_patterns=allow_patterns,
                max_workers=4,
            )
            return
        except Exception as error:
            print(
                f"  Attempt {attempt}/{ATTEMPTS} failed: "
                f"{type(error).__name__}: {str(error)[:200]}",
                flush=True,
            )
            if attempt == ATTEMPTS:
                raise
            wait = min(60, 10 * attempt)
            print(f"  Resuming in {wait}s (partial files are kept)...", flush=True)
            time.sleep(wait)


def main() -> None:
    if not os.environ.get("HF_TOKEN"):
        print(
            "Heads-up: no HF_TOKEN set — downloads work but are rate-limited. "
            "Set one for higher limits: https://huggingface.co/settings/tokens",
            flush=True,
        )
    for repo_id, local_dir, allow_patterns in MODELS:
        print(f"Downloading {repo_id} -> {local_dir}", flush=True)
        _download(repo_id, local_dir, allow_patterns)
        print(f"Done: {repo_id}", flush=True)

    # The HFIE pipeline ships a slow-only T5 tokenizer; transformers 5.x then
    # tries a slow->fast conversion that misreads spiece.model as a tiktoken
    # file. The canonical fast tokenizer.json (same T5 vocab) fixes loading.
    tokenizer_json = Path(
        hf_hub_download("google/flan-t5-xxl", "tokenizer.json")
    )
    target = SERVER_DIR / "models" / "ltxv-2b-distilled" / "tokenizer" / "tokenizer.json"
    target.parent.mkdir(parents=True, exist_ok=True)
    shutil.copyfile(tokenizer_json, target)
    print(f"Patched tokenizer: {target}", flush=True)
    print("All video models downloaded.")


if __name__ == "__main__":
    main()
