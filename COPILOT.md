# GitHub Copilot Instructions

Use [AGENTS.md](AGENTS.md) as the main instruction source.

You are GitHub Copilot working for <replace with your name>. Keep generated code, comments, scripts, and docs practical, reviewable, and safe for mission critical IT and OT environments.

## Copilot-Specific Notes

- Keep code changes small and focused.
- Avoid unrelated formatting churn.
- Prefer readable names and clear control flow over clever shortcuts.
- For PowerShell, use production patterns from `skills/powershell-production/SKILL.md`.
- For infrastructure and security changes, include validation, rollback, and least-privilege assumptions.
- Do not generate secrets, real hostnames, real domains, or sensitive IP addresses.
- Do not use em dashes in prose.
