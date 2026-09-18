# HANDOFF — Chuyển đổi giao diện 10 trang HTML mockup sang Flutter

> File này là bản bàn giao cho phiên làm việc mới. Đọc kỹ một lần rồi làm tiếp từ checklist "CÒN LẠI".
> Ngày cập nhật: 17/09/2026 (cuối phiên verify + fix Manga + Profile)

## 1. Mục tiêu tổng (lời người dùng gốc)

> "Chuyển đổi 10 file HTML sang Flutter, Flutter phải giống toàn bộ từ giao diện hệ thống, hiệu ứng. Các trang của Flutter phải giống hệt từng trang HTML đó."

10 file HTML nguồn chân lý (thư mục gốc Project4, KHÔNG sửa nữa trừ khi người dùng yêu cầu):
`reel-home-redesign.html`, `reel-login.html`, `reel-register.html`, `reel-reset-password.html`,
`reel-terms.html`, `reel-pricing.html`, `reel-library.html`, `reel-profile.html`,
`reel-user-profile.html`, `reel-admin.html`.

App Flutter đích: `Client/ai_app` (Flutter 3.47.4, web build đã chạy được).

## 2. ĐÃ LÀM (xong + đã verify)

### Giai đoạn trước (Nhóm A + B — xong)
- Toàn bộ 10 trang HTML đồng bộ nội dung; coi HTML là chuẩn.
- Home Flutter: hero + tools bar + 4 thẻ ghim + dialog 20 công cụ; Ảnh/Video gọi API thật; 18 công cụ còn lại = panel preview + toast "sắp ra mắt".
- Library: ghim, lọc, tìm, chọn nhiều, xoá hàng loạt; l10n concept "tác phẩm/credits"; Anime→Animated khi POST.

### Giai đoạn replica + verify (các phiên trước + phiên 17/09)
- **Auth, Pricing, Home panels, Admin, Library**: đã dựng và ĐÃ VERIFY trực quan web 1280×800 (chi tiết dưới).
- **Panel Giọng nói**: 4 voice card (Minh/Hà/Ông Tùng/Mai), chip tốc độ + định dạng, waveform — khớp mockup. ✅ VERIFIED.
- **Panel Manga Studio**: ĐÃ FIX bug thật — `Flexible` nằm trực tiếp trong `Wrap` (home_studio.dart, hàng nút "Tạo trang này") ném "Incorrect use of ParentDataWidget" → ErrorWidget release = khối xám. Đổi sang `ConstrainedBox(maxWidth: 270)`. Sau fix panel render đủ 3 cột + bubble "Sấm ở Wano…" + fx + batch bar "⚡ Tạo tất cả trang còn thiếu (5 trang · ≈ 30 CR)". ✅ VERIFIED.
- **Library sau đăng nhập**: ✅ VERIFIED — sidebar (Tất cả 18/Đã ghim 4/Collections/Thùng rác), "Dự án đang làm" (MANGA 66%, SÁCH 50%), grid, bulk bar. Lưu ý: đôi khi thân Library/home hiển thị KHỐI XÁM trên web build release trong IAB guest — đó là glitch khung hình đầu của webview (tự hết khi resize viewport hoặc vào lại), KHÔNG phải lỗi code (debug + profile build render sạch, không exception).
- **Admin**: ✅ VERIFIED với `sample.admin@reel.studio / Admin@123` — 7 mục sidebar (badge 14 ở Hàng đợi), view Hàng đợi (5 job: đang chạy/hàng đợi/lỗi hoàn CR), view Công cụ AI (toggle, Game/Agent mặc định tắt).
- **Profile = reel-profile.html**: ✅ VERIFIED + tinh chỉnh phiên 17/09: "Tạo gần đây" 4 thumb (`.take(4)`), thêm hàng bytype chips (🖼️ Ảnh 56 / 🎞️ Video 12 / 🎙️ Âm thanh 18 / 📖 Trang manga 8 / 🧊 3D & Bản đồ 2), tag THÀNH CÔNG/SUCCESS xanh cho payment status=completed. Widget `_byTypeChip` thêm trong profile_screen.dart.
- **flutter analyze SẠCH, 10/10 test pass, build web OK** sau mọi thay đổi.

### QUYẾT ĐỊNH CỦA USER (17/09)
- **reel-user-profile.html: BỎ** — user xác nhận "bỏ không làm, tôi cần là file reel-profile". Không dựng màn hồ sơ user công khai.

## 3. CÒN LẠI (tuỳ chọn, làm khi user yêu cầu)

1. **Hiệu ứng aurora/orb**: nền động đã có (`ReelBackdrop` + parallax chuột ở home). Muốn giống keyframes 30s của HTML thì chỉnh `_AuroraPainter` trong `lib/widgets/flagship_ui.dart`.
2. **(Tuỳ chọn)** Dịch 9 ngôn ngữ còn lại (de/es/fr/it/ja/ko/pt/ru/zh — 44 key fallback EN) hoặc bỏ bớt ngôn ngữ trong `LocaleController.supported`.
3. Commit git: phiên 17/09 chưa commit (để user tự quyết). Các file đổi: `lib/screens/home/home_studio.dart`, `lib/screens/profile_screen.dart`, `HANDOFF.md`.

## 4. QUY TRÌNH BUILD / VERIFY CHUẨN

```bash
cd Client/ai_app
flutter gen-l10n        # sau khi sửa ARB
flutter analyze         # phải: No issues found
flutter test            # phải: 10/10 pass
flutter build web
cd build/web && python -m http.server 8735   # mở http://127.0.0.1:8735
# Backend: cd AI_Server && uvicorn main.app:app --reload  (MySQL cần nạp Project4.sql + sample_data.sql)
# Tài khoản mẫu: sample.admin@reel.studio / Admin@123 · sample.user@reel.studio / User@123
```

## 5. QUY ƯỚC & CẠM BẪY (quan trọng)

- **l10n**: text UI nằm trong `lib/l10n/app_en.arb` (template) + `app_vi.arb`; sửa xong PHẢI `flutter gen-l10n`. Nội dung tĩnh mockup dùng helper `_t(context, vi, en)` (home_studio, pricing) — chấp nhận được.
- **ARB trùng key = thảm hoạ**: sau khi sửa ARB chạy check duplicate (script python trong git history / đoạn regex đếm key).
- **Backend style Literal**: chỉ Cinematic/Documentary/Studio/Animated. Chip "Anime" map → "Animated" khi POST.
- **Không dùng heredoc bash dài trên Windows** (ENAMETOOLONG): ghi file bằng công cụ Write rồi splice bằng python ngắn.
- **Part files**: home = `home_screen.dart` + parts (`home/home_chrome`, `home_generator`, `home_studio`, `tool_catalog`); auth = `auth_screen.dart` + parts trong `auth/`; admin = `admin_dashboard_screen.dart` + parts (`dashboard_*.dart`, `views/*.dart`).
- **Admin palette** = `AdminColors`; dùng `_mistText/_smokeText/_mutedText` consts cục bộ trong `queue_tools_views.dart`.
- **API thật có sẵn**: auth, `/generate/image|video|history|usage`, `/credits/transactions`, `/payments/*`, admin endpoints. KHÔNG có: TTS/music/manga/3D (panel chỉ preview + toast).
- **KHÔNG đặt `Flexible`/`Expanded` làm con trực tiếp của `Wrap`** — Flutter ném "Incorrect use of ParentDataWidget"; bản release chỉ hiện khối xám (ErrorWidget) rất dễ nhầm với lỗi render. Khi thấy khối xám: chạy `flutter run -d web-server --web-port <p>` (debug), thao tác lại, đọc exception trong console/stdout.
- **Verify bằng browser automation (IAB)**: Flutter web = canvas, DOM snapshot trống; dùng `tab.cua.click(x,y)` + `tab.screenshot()`. Click ĐẦU TIÊN sau khi app boot thường bị nuốt — bấm 2 lần. Mô hình phân tích ảnh có thể bịa chi tiết chữ — tin code cho nội dung, ảnh chỉ để khẳng định layout.
- Test widget dùng locale EN mặc định; link Text.rich phải `find.textContaining`.
- Người dùng nói tiếng Việt — trả lời tiếng Việt.

## 6. TRẠNG THÁI PHIÊN 17/09 (để debug nếu cần)

- Server tĩnh bản release: `http://127.0.0.1:8735` (python http.server trong `Client/ai_app/build/web`, tiến trình nền của ZCode session cũ — có thể đã tắt, khởi động lại bằng lệnh ở mục 4).
- Backend AI_Server port 8000 + MySQL 3306 chạy sẵn ngoài ZCode.
- IAB browser của ZCode có thể còn tab 8735 mở.
