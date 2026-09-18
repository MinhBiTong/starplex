# Text-to-Video — cài đặt và vận hành

Chức năng text-to-video chạy hoàn toàn local trên GPU 8 GB (RTX 4060 Laptop):

- **Model**: LTX-Video **0.9.8 2B distilled** (pipeline diffusers đầy đủ, 8 bước
  sampling). Repo chính thức `Lightricks/LTX-Video-2B-0.9.6-Distilled-04-25`
  trên HF hiện là repo rỗng (chỉ có README), nên script tải bản conversion
  chuẩn `jbilcke-hf/LTX-Video-2b-0-9-8-distilled-HFIE`
- **Chất lượng**: `720p` (render trực tiếp 1280×704) và `1080p` (render 960×544
  rồi upscale latent 2x bằng `linoyts/LTX-Video-spatial-upscaler-0.9.8` →
  1920×1088)
- **Thời lượng**: 4 / 6 / 8 giây @ 24 fps (97 / 145 / 193 frame — đúng lưới 8n+1
  của sampler LTX)
- **Âm thanh**: MMAudio chạy trong venv riêng (tùy chọn). Không cấu hình → video
  vẫn trả về nhưng câm.

## 1. Cài model (bắt buộc)

```bash
cd AI_Server
pip install -r requirements.txt   # imageio/imageio-ffmpeg đã thêm cho video
python scripts/download_video_models.py
```

Tải ~29 GB vào `AI_Server/models/`. Script **tự resume** khi đứt kết nối —
chạy lại chính lệnh đó nếu gặp lỗi mạng (lỗi `CAS Client Error`/Xet đã được
tránh sẵn bằng `HF_HUB_DISABLE_XET=1`; muốn nhanh hơn trên mạng ổn định thì
xóa dòng đó trong script). Nên set `HF_TOKEN` để không bị giới hạn tốc độ.
Sau khi tải xong, server chạy offline hoàn toàn (`AI_LOCAL_FILES_ONLY=True`
giữ nguyên).

## 2. Âm thanh MMAudio (tùy chọn)

MMAudio cần venv riêng vì dependency (torchmcubes biên dịch từ nguồn) xung đột
với môi trường server chính:

```bat
AI_Server\scripts\setup_mmaudio.bat
```

Yêu cầu: Python 3.10–3.11, git, MSVC C++ Build Tools. Script in ra đường dẫn
python của venv — thêm vào `AI_Server/.env`:

```
MMAUDIO_PYTHON=C:\...\AI_Server\mmaudio_venv\Scripts\python.exe
MMAUDIO_MODEL=small
```

Không cấu hình `MMAUDIO_PYTHON` = video câm (không lỗi).

## 3. API

### `POST /api/v1/generate/video` (JWT, rate limit 2/phút)

```json
{
  "prompt": "a lone astronaut surfing the red dunes of mars, golden hour",
  "aspect_ratio": "16:9",
  "duration_seconds": 6,
  "quality": "1080p",
  "type": "video"
}
```

Trả về **ngay** `202` với `{generation_id, status: "processing", credit_cost, ...}`.
Credits bị trừ lúc submit, hoàn lại tự động nếu job thất bại.

### `GET /api/v1/generate/video/{generation_id}`

Poll mỗi ~5 giây:

```json
{
  "generation_id": 42,
  "status": "completed",
  "video_url": "http://host:8000/videos/reel_....mp4",
  "resolution": "1920x1088",
  "duration_seconds": 6,
  "credit_cost": 36
}
```

`status` ∈ `processing | completed | failed`. File mp4 phục vụ tĩnh tại `/videos/`.

### Giá credit

`= video_credit_cost × hệ số thời lượng × hệ số chất lượng`, làm tròn, tối thiểu 1:

| | 4s (×1.0) | 6s (×1.5) | 8s (×2.0) |
|---|---|---|---|
| 720p (×1.0) | 12 | 18 | 24 |
| 1080p (×2.0) | 24 | 36 | 48 |

`video_credit_cost` (mặc định 12) đổi được trong Admin → Settings.

## 4. Vận hành

- Video job là **background task trong tiến trình server**, có GPU lock chung
  với image: request ảnh đến trong lúc render video sẽ chờ tới lượt. Thứ tự
  nào cũng vậy — một GPU, một job tại một thời điểm.
- Restart server giữa chừng job nào đang `processing` → job đó được đánh
  `failed` + hoàn credit khi server khởi động lại (`reconcile_stale_video_jobs`).
- Thời gian render kỳ vọng trên RTX 4060 8GB (mang tính tham khảo, đo thử trên
  máy thật để chốt): 720p/4s ~1–2 phút, 1080p/8s có thể 5–15 phút do decode
  VAE ở 1088 chiều cao.
- Nếu OOM ở tier 1080p: giữ `VIDEO_VAE_TILING=True` (mặc định), hoặc hạ client
  xuống 720p; CPU offload đã bật sẵn (`VIDEO_CPU_OFFLOAD=True`).

## 5. Các biến cấu hình mới (.env, không bắt buộc)

| Biến | Mặc định | Ý nghĩa |
|---|---|---|
| `VIDEO_MODEL_DIR` | `models/ltxv-2b-distilled` | Đường dẫn local hoặc HF repo id |
| `VIDEO_UPSCALER_DIR` | `models/ltxv-spatial-upscaler-0.9.8` | Upscaler cho tier 1080p |
| `VIDEO_DEVICE` | `auto` | `cuda` / `cpu` |
| `VIDEO_CPU_OFFLOAD` | `True` | Bật cpu offload (8GB nên giữ True) |
| `VIDEO_VAE_TILING` | `True` | Decode VAE kiểu tiling, chống OOM |
| `VIDEO_STEPS` | `8` | Số bước sampling (distilled = 8) |
| `VIDEO_FPS` | `24` | Phải giữ 24 để 4/6/8s đúng lưới 8n+1 |
| `MMAUDIO_PYTHON` | `""` | Python venv MMAudio; rỗng = câm |
| `MMAUDIO_MODEL` | `small` | small / medium / large |
| `MMAUDIO_TIMEOUT_SECONDS` | `900` | Timeout cho subprocess audio |
