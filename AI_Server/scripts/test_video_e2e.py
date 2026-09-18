"""End-to-end GPU test for the video pipeline (no HTTP/DB involved).

Renders one 720p/4s clip and one 1080p/4s clip through the real service code
path — model loading, CPU offload, latent upsample and mp4 export — then
probes the produced files (duration, fps, resolution, audio streams).

Run: .venv/Scripts/python.exe scripts/test_video_e2e.py
"""

import json
import subprocess
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from services.video_generator import get_video_generator  # noqa: E402

PROMPT = "a lone astronaut surfing the red dunes of mars, golden hour, wide shot"


def probe(path: Path) -> dict:
    """ffprobe-free metadata via the ffmpeg binary shipped with imageio-ffmpeg."""
    import imageio_ffmpeg

    ffmpeg = imageio_ffmpeg.get_ffmpeg_exe()
    result = subprocess.run(
        [ffmpeg, "-hide_banner", "-i", str(path)],
        capture_output=True,
        text=True,
    )
    info = {"size_mb": round(path.stat().st_size / 1e6, 1)}
    for line in result.stderr.splitlines():
        line = line.strip()
        if line.startswith("Duration:"):
            info["duration"] = line.split("Duration:")[1].split(",")[0].strip()
        if " Video:" in line:
            info["video_stream"] = line.split("Video:")[1].strip()[:90]
        if " Audio:" in line:
            info["audio_stream"] = line.split("Audio:")[1].strip()[:60]
    return info


def run_case(quality: str) -> None:
    print(f"\n=== Rendering {quality} / 4s ===", flush=True)
    gen = get_video_generator()
    out_path, width, height = gen.generate(PROMPT, "16:9", quality, 4)
    print(f"OUT: {out_path} ({width}x{height})", flush=True)
    print("PROBE:", json.dumps(probe(out_path), indent=1), flush=True)


if __name__ == "__main__":
    run_case("720p")
    run_case("1080p")
    print("\nE2E TEST PASSED", flush=True)
