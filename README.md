<<<<<<< HEAD
# Reel — AI Film & Photo Studio

A full-stack AI image generation platform with role-based admin console,
credit-based billing, Stripe payments, and a flagship Flutter web/mobile
experience.

## Structure

- `Client/ai_app/` — Flutter app (Reel UI, admin console, localization).
- `AI_Server/` — FastAPI backend with SDXL-Lightning + TranslateGemma,
  MySQL persistence, Stripe integration, and rate limiting.
- `Project4.sql` — canonical database schema.
- `sample_data.sql` — development seed data.
- `docs/` — operational guides (Stripe callbacks, rate limiting).

## Quick start

See `docs/` for setup details. The Flutter client expects the FastAPI
backend on `http://127.0.0.1:8000` (or `http://10.0.2.2:8000` on Android
emulator). Localization covers 11 languages via Flutter `gen-l10n`.
=======
# starplex
>>>>>>> 4678e0174279f0101bcbeac3d4e6ed73b246c738
