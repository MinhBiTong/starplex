"""Canonical email validator shared by every auth/user Pydantic schema.

Using Pydantic's stock ``EmailStr`` is convenient but its dependency,
``email-validator``, is heavy (it pulls in IDNA + DNS libraries) and
sometimes fails to validate perfectly legitimate addresses on the
local network. More importantly, having the validator defined in
several places makes it easy for a future field to drift from the
canonical rules.

This module exposes a single :class:`EmailStr` that wraps the same
regex we use client-side (``lib/core/validators.dart``). Every schema
that previously imported ``pydantic.EmailStr`` should import from
here instead so the rule lives in one place.

The regex accepts addresses with ``+``, ``.``, ``_``, ``-`` in the
local part, sub-domains, and a 2+ char TLD. We cap total length at
254 characters (RFC 5321).
"""
from __future__ import annotations

import re
from typing import Any

from pydantic import GetCoreSchemaHandler
from pydantic_core import core_schema


_EMAIL_RE = re.compile(
    r"^[A-Za-z0-9._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$"
)
_MAX_LENGTH = 254


class EmailStr(str):
    """Canonical email string used by the AI_Server schemas.

    Validates using the same regex as the Flutter client, so client
    and server agree on what "looks like an email" means. Raises
    ``ValueError`` if the value is not a syntactically valid address.
    """

    @classmethod
    def _validate(cls, value: Any) -> "EmailStr":
        if not isinstance(value, str):
            raise ValueError("email must be a string")
        candidate = value.strip()
        if not candidate or len(candidate) > _MAX_LENGTH:
            raise ValueError("email is not a valid address")
        if not _EMAIL_RE.match(candidate):
            raise ValueError("email is not a valid address")
        return cls(candidate)

    @classmethod
    def __get_pydantic_core_schema__(
        cls, source_type: Any, handler: GetCoreSchemaHandler
    ) -> core_schema.CoreSchema:
        return core_schema.no_info_after_validator_function(
            cls._validate,
            core_schema.str_schema(),
        )
