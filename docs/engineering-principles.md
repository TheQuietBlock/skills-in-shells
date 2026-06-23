# Engineering Principles

## Priority Order

1. Safety
2. Stability
3. Security
4. Auditability
5. Reversibility
6. Maintainability
7. Team transferability

## Production Assumption

Assume the work can affect production unless <replace with your name> says it is a lab, demo, or personal test.

## Change Flow

1. Discover with read-only checks.
2. Define scope and assumptions.
3. Assess impact and risk.
4. Plan implementation and rollback.
5. Execute in test, pilot, or maintenance window.
6. Validate with commands and logs.
7. Document the outcome.

## Security Defaults

- Use least privilege.
- Avoid permanent high privilege.
- Protect secrets and private keys.
- Prefer explicit firewall flows.
- Log security-relevant activity.
- Keep certificate validation enabled.
- Use secure credential handling.

## OT Defaults

- Respect Purdue levels and zone boundaries.
- Do not assume internet access.
- Avoid noisy scanning.
- Avoid uncontrolled agent deployment.
- Prefer deterministic data flows.
- Treat availability and operator visibility as critical.

## Documentation Defaults

Write so a junior or medior engineer can execute the work without guessing. Include prerequisites, assumptions, steps, validation, rollback, troubleshooting, security notes, and handover notes.
