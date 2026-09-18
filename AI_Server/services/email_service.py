"""SMTP-backed transactional email for the auth flow.

Two messages are supported today:

  * **welcome** – sent after `/auth/register` succeeds so the new user
    has a tangible receipt of their account and the same branding they
    saw during sign-up.
  * **password reset** – sent in response to `/auth/forgot-password`
    carrying the deep link the user clicks to land directly on the
    reset screen.

Both messages share the REEL dark "aurora" email frame extracted from
``reel-email-reset-password.html``: table-based bulletproof layout, a
gradient brand mark, a glass card on ``#06070b`` and the mono footer —
so every inbox (Gmail, Outlook, Apple Mail) renders the same design.

The service is deliberately *fail-soft*: a misconfigured SMTP server
must not break registration or login. We log the failure and let the
caller surface a generic success message, mirroring how
production-grade auth systems behave (Stripe, GitHub, etc.). Users
should never see "email failed to send" — that leaks infrastructure
state. The token, however, is **never** echoed back in the HTTP
response when the email path is exercised: the only way to recover it
is through the inbox, which is the whole point of the flow.
"""
from __future__ import annotations

import html
import logging
import smtplib
from dataclasses import dataclass
from email.message import EmailMessage
from typing import Optional

from config import settings

log = logging.getLogger(__name__)


@dataclass
class EmailResult:
    success: bool
    detail: Optional[str] = None


def _build_message(
    to: str,
    subject: str,
    html_body: str,
    text_body: str,
) -> EmailMessage:
    msg = EmailMessage()
    msg["Subject"] = subject
    msg["From"] = settings.EMAIL_FROM or settings.SMTP_USER
    msg["To"] = to
    msg.set_content(text_body, subtype="plain")
    msg.add_alternative(html_body, subtype="html")
    return msg


def _send_raw(msg: EmailMessage) -> EmailResult:
    """Open a single SMTP session and deliver ``msg``.

    Kept separate from [send_welcome_email]/[send_password_reset_email]
    so the public API stays declarative and we can unit-test the SMTP
    transport path in isolation.
    """
    if not settings.SMTP_USER or not settings.SMTP_PASSWORD:
        # Fail soft — we don't want a missing email config to deny
        # sign-ups in environments where email is just not configured
        # (local dev). Log loudly so ops notices.
        log.warning(
            "SMTP_USER/SMTP_PASSWORD not configured; skipping email to %s",
            msg["To"],
        )
        return EmailResult(success=False, detail="smtp-not-configured")

    try:
        with smtplib.SMTP(settings.SMTP_HOST, settings.SMTP_PORT, timeout=15) as smtp:
            smtp.starttls()
            smtp.login(settings.SMTP_USER, settings.SMTP_PASSWORD)
            smtp.send_message(msg)
        return EmailResult(success=True)
    except (smtplib.SMTPException, OSError) as exc:
        log.warning("SMTP delivery to %s failed: %s", msg["To"], exc)
        return EmailResult(success=False, detail=str(exc))


# ---------------------------------------------------------------------------
# Shared REEL email frame (from reel-email-reset-password.html)
# ---------------------------------------------------------------------------

_MSO_HEAD = """<!--[if mso]>
<noscript>
<xml>
<o:OfficeDocumentSettings>
<o:PixelsPerInch>96</o:PixelsPerInch>
</xml>
</noscript>
<style>
  table, td { font-family: Arial, Helvetica, sans-serif !important; }
</style>
<![endif]-->
<link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@600;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet" type="text/css">
<style>
  body, table, td, a { -webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; }
  table, td { mso-table-lspace:0pt; mso-table-rspace:0pt; }
  img { -ms-interpolation-mode:bicubic; border:0; outline:none; text-decoration:none; display:block; }
  body { margin:0; padding:0; width:100% !important; background-color:#ffffff; }
  a { color:#6fa3ff; }

  @media screen and (max-width:600px){
    .email-container{ width:100% !important; }
    .fluid-pad{ padding-left:22px !important; padding-right:22px !important; }
    .card-pad{ padding:26px 22px !important; }
    .h1-size{ font-size:21px !important; }
  }
</style>"""


def _email_frame(
    *,
    preheader: str,
    eyebrow: str,
    title: str,
    body_html: str,
) -> str:
    """Wrap ``body_html`` in the REEL dark aurora email skeleton.

    Everything outside ``body_html`` — the hidden preheader, the gradient
    brand header, the hairline rule, the glass card and the footer — is
    copied verbatim from the approved mockup so the design survives
    Outlook's table quirks (bulletproof buttons, mso fixes).
    """
    safe_preheader = html.escape(preheader)
    safe_eyebrow = html.escape(eyebrow)
    safe_title = html.escape(title)
    return f"""<!DOCTYPE html>
<html lang="vi" xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="color-scheme" content="dark">
<meta name="supported-color-schemes" content="dark">
{_MSO_HEAD}
</head>
<body style="margin:0; padding:0; background-color:#ffffff;">

<!-- Preheader (hidden preview text shown in inbox list) -->
<div style="display:none; max-height:0; overflow:hidden; opacity:0; mso-hide:all;">
  {safe_preheader}
</div>
<div style="display:none; max-height:0; overflow:hidden;">&#8199;&#8199;&#8199;&#8199;&#8199;&#8199;&#8199;&#8199;&#8199;&#8199;&#8199;&#8199;&#8199;&#8199;&#8199;&#8199;&#8199;&#8199;&#8199;&#8199;&#8199;&#8199;&#8199;&#8199;&#8199;</div>

<table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color:#ffffff;">
<tr>
<td align="center" style="padding:36px 16px;">

  <table role="presentation" class="email-container" width="600" cellpadding="0" cellspacing="0" border="0" style="width:600px; max-width:600px;">

    <!-- Logo header -->
    <tr>
      <td align="center" style="padding-bottom:26px;">
        <table role="presentation" cellpadding="0" cellspacing="0" border="0">
          <tr>
            <td valign="middle" style="padding-inline-end:9px;">
              <table role="presentation" cellpadding="0" cellspacing="0" border="0" width="26" height="26" style="width:26px; height:26px; background-color:#3d7cff; background-image:linear-gradient(135deg,#3d7cff,#8b7bff 55%,#ff9466); border-radius:8px;">
                <tr><td width="26" height="26" style="width:26px; height:26px;">&nbsp;</td></tr>
              </table>
            </td>
            <td valign="middle">
              <span style="font-family:'Space Grotesk',Arial,sans-serif; font-weight:700; font-size:18px; letter-spacing:.5px; color:#f1f3f8;">REEL</span>
            </td>
          </tr>
        </table>
      </td>
    </tr>

    <!-- Gradient rule -->
    <tr>
      <td align="center" style="padding-bottom:28px;">
        <table role="presentation" cellpadding="0" cellspacing="0" border="0" width="110" height="2" style="width:110px; height:2px; background-color:#3d7cff; background-image:linear-gradient(90deg,#3d7cff,#8b7bff,#ff9466); border-radius:2px;">
          <tr><td width="110" height="2" style="width:110px; height:2px; line-height:2px; font-size:1px;">&nbsp;</td></tr>
        </table>
      </td>
    </tr>

    <!-- Card -->
    <tr>
      <td style="background-color:#12131f; border:1px solid #23242f; border-radius:20px;">
        <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0">
          <tr>
            <td class="card-pad" style="padding:40px 40px 36px;">

              <!-- eyebrow -->
              <table role="presentation" cellpadding="0" cellspacing="0" border="0" align="center" style="margin:0 auto 20px;">
                <tr>
                  <td style="background-color:#171827; border:1px solid #262738; border-radius:999px; padding:7px 16px;">
                    <span style="font-family:'JetBrains Mono',Consolas,monospace; font-size:10px; letter-spacing:2px; text-transform:uppercase; color:#8b93a6;">{safe_eyebrow}</span>
                  </td>
                </tr>
              </table>

              <h1 class="h1-size" style="margin:0 0 16px; text-align:center; font-family:'Space Grotesk',Arial,sans-serif; font-weight:600; font-size:24px; line-height:1.3; color:#f1f3f8;">
                {safe_title}
              </h1>

{body_html}

            </td>
          </tr>
        </table>
      </td>
    </tr>

    <!-- Footer -->
    <tr>
      <td align="center" style="padding:28px 20px 10px;">
        <p style="margin:0 0 6px; font-family:Arial,Helvetica,sans-serif; font-size:11.5px; letter-spacing:1px; text-transform:uppercase; color:#524d5c;">
          REEL — developed in the dark. one frame at a time.
        </p>
        <p style="margin:0 0 14px; font-family:Arial,Helvetica,sans-serif; font-size:12px; color:#6b7182;">
          Cần trợ giúp? Liên hệ <a href="mailto:support@reel.studio" style="color:#6fa3ff; text-decoration:underline;">support@reel.studio</a>
        </p>
        <p style="margin:0; font-family:Arial,Helvetica,sans-serif; font-size:11px; color:#454854;">
          © 2026 REEL Studio.
        </p>
      </td>
    </tr>

  </table>

</td>
</tr>
</table>

</body>
</html>
"""


def _cta_button(link: str, label: str) -> str:
    """Bulletproof gradient CTA — a real table cell background so the
    gradient survives Outlook while the anchor stays tappable."""
    safe_label = html.escape(label)
    return f"""              <table role="presentation" cellpadding="0" cellspacing="0" border="0" align="center" style="margin:0 auto 26px;">
                <tr>
                  <td align="center" style="border-radius:13px; background-color:#3d7cff; background-image:linear-gradient(120deg,#3d7cff,#8b7bff 55%,#ff9466);">
                    <a href="{link}" target="_blank" style="display:inline-block; padding:15px 36px; font-family:Arial,Helvetica,sans-serif; font-size:15px; font-weight:700; color:#06070f; text-decoration:none; border-radius:13px;">{safe_label}</a>
                  </td>
                </tr>
              </table>"""


def send_welcome_email(to_email: str, full_name: Optional[str]) -> EmailResult:
    """Welcome email sent immediately after a successful registration.

    Reuses the reset-password frame so both transactional emails share
    the exact REEL branding from the approved mockup.
    """
    name = (full_name or "").strip() or "bạn"
    safe_name = html.escape(name)
    studio_link = f"{settings.FRONTEND_URL}/"
    subject = "Chào mừng đến với REEL — studio AI của bạn đã sẵn sàng"

    text_body = (
        f"Chào {name},\n\n"
        "Chào mừng bạn đến với REEL — tài khoản của bạn đã được kích hoạt "
        "và 10 credit đầu tiên đã có trong ví.\n\n"
        f"Truy cập studio và bắt đầu tạo khung hình đầu tiên: {studio_link}\n\n"
        "— The REEL team"
    )

    body_html = f"""              <p style="margin:0 0 8px; text-align:center; font-family:Arial,Helvetica,sans-serif; font-size:15px; line-height:1.6; color:#c7ccd9;">
                Chào {safe_name},
              </p>
              <p style="margin:0 0 28px; text-align:center; font-family:Arial,Helvetica,sans-serif; font-size:15px; line-height:1.6; color:#8b93a6;">
                Tài khoản REEL của bạn đã được kích hoạt và 10 credit đầu tiên đã có trong ví. Nhấn nút bên dưới để mở studio và bắt đầu tạo khung hình đầu tiên.
              </p>

{_cta_button(studio_link, "Mở studio REEL")}

              <!-- divider -->
              <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" style="margin-bottom:24px;">
                <tr><td style="border-top:1px solid #23242f; font-size:1px; line-height:1px;">&nbsp;</td></tr>
              </table>

              <!-- security note -->
              <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color:#171827; border:1px solid #262738; border-radius:14px;">
                <tr>
                  <td style="padding:16px 18px; font-family:Arial,Helvetica,sans-serif; font-size:12.5px; line-height:1.6; color:#8b93a6;">
                    💡 Credit được dùng cho mỗi lượt dựng — bạn có thể nạp thêm bất cứ lúc nào trong trang Gói &amp; Thanh toán.
                  </td>
                </tr>
              </table>"""

    html_body = _email_frame(
        preheader="Tài khoản REEL của bạn đã hoạt động — 10 credit đã sẵn sàng trong ví.",
        eyebrow="Chào mừng đến với REEL",
        title="Tài khoản của bạn đã sẵn sàng",
        body_html=body_html,
    )
    return _send_raw(_build_message(to_email, subject, html_body, text_body))


def send_password_reset_email(
    to_email: str,
    raw_token: str,
    full_name: Optional[str] = None,
) -> EmailResult:
    """Password reset email.

    The ``raw_token`` is the un-hashed value stored as part of the
    PasswordResetTokens row only via its SHA-256 — the raw form is
    emailed exactly once and is the only thing the client needs to
    POST to /auth/reset-password.

    The layout mirrors ``reel-email-reset-password.html`` one-to-one:
    eyebrow pill, greeting, gradient CTA, expiry note, fallback link and
    the lock-icon security note.
    """
    name = (full_name or "").strip() or "bạn"
    safe_name = html.escape(name)
    reset_link = f"{settings.FRONTEND_URL}/auth/reset?token={html.escape(raw_token)}"
    subject = "Đặt lại mật khẩu REEL"

    text_body = (
        f"Chào {name},\n\n"
        "Chúng tôi nhận được yêu cầu đặt lại mật khẩu cho tài khoản REEL "
        "gắn với địa chỉ email này. Nhấn liên kết bên dưới trong 30 phút "
        "để tạo mật khẩu mới:\n\n"
        f"{reset_link}\n\n"
        "Nếu bạn không yêu cầu đặt lại mật khẩu, bạn có thể bỏ qua email "
        "này một cách an toàn — mật khẩu hiện tại của bạn sẽ không bị thay đổi.\n\n"
        "— The REEL team"
    )

    body_html = f"""              <p style="margin:0 0 8px; text-align:center; font-family:Arial,Helvetica,sans-serif; font-size:15px; line-height:1.6; color:#c7ccd9;">
                Chào {safe_name},
              </p>
              <p style="margin:0 0 28px; text-align:center; font-family:Arial,Helvetica,sans-serif; font-size:15px; line-height:1.6; color:#8b93a6;">
                Chúng tôi nhận được yêu cầu đặt lại mật khẩu cho tài khoản REEL gắn với địa chỉ email này. Nhấn nút bên dưới để tạo mật khẩu mới.
              </p>

{_cta_button(reset_link, "Đặt lại mật khẩu")}

              <p style="margin:0 0 28px; text-align:center; font-family:Arial,Helvetica,sans-serif; font-size:12.5px; line-height:1.6; color:#6b7182;">
                Liên kết này sẽ hết hạn sau <strong style="color:#8b93a6;">30 phút</strong> kể từ khi email được gửi.
              </p>

              <!-- divider -->
              <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" style="margin-bottom:24px;">
                <tr><td style="border-top:1px solid #23242f; font-size:1px; line-height:1px;">&nbsp;</td></tr>
              </table>

              <p style="margin:0 0 8px; font-family:Arial,Helvetica,sans-serif; font-size:12.5px; line-height:1.6; color:#6b7182;">
                Nếu nút phía trên không hoạt động, sao chép và dán liên kết sau vào trình duyệt của bạn:
              </p>
              <p style="margin:0 0 26px; font-family:Consolas,Monaco,monospace; font-size:12px; line-height:1.6; word-break:break-all;">
                <a href="{reset_link}" target="_blank" style="color:#6fa3ff; text-decoration:underline;">{reset_link}</a>
              </p>

              <!-- security note -->
              <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color:#171827; border:1px solid #262738; border-radius:14px;">
                <tr>
                  <td style="padding:16px 18px; font-family:Arial,Helvetica,sans-serif; font-size:12.5px; line-height:1.6; color:#8b93a6;">
                    🔒 Nếu bạn không yêu cầu đặt lại mật khẩu, bạn có thể bỏ qua email này một cách an toàn — mật khẩu hiện tại của bạn sẽ không bị thay đổi.
                  </td>
                </tr>
              </table>"""

    html_body = _email_frame(
        preheader="Liên kết đặt lại mật khẩu REEL của bạn có hiệu lực trong 30 phút.",
        eyebrow="Yêu cầu đặt lại mật khẩu",
        title="Đặt lại mật khẩu của bạn",
        body_html=body_html,
    )
    return _send_raw(_build_message(to_email, subject, html_body, text_body))
