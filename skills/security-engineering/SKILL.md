---
name: "security-engineering"
description: "Use this skill for enterprise security design, hardening, review, risk analysis, and operational security."
---

# Security Engineering

## When to Use This Skill

Use this skill for hardening, risk analysis, threat modeling, security review, identity design, network exposure review, logging, TLS, secrets handling, operational security, and remediation planning.

## Do Not Use This Skill When

Do not use this skill to produce vague fear-based findings. Pair it with the technical domain skill when reviewing AD, PKI, WSUS, Windows Server, OT, PowerShell, or Terraform.

## Context

<replace with your name> needs security advice that operations teams can implement. Be specific about threat, evidence, likelihood, impact, mitigation, residual risk, and owner. Keep the tone factual.

## Workflow

1. Discover assets, trust boundaries, identities, exposed services, data sensitivity, and logs.
2. Assess threat, impact, likelihood, exploit path, and operational constraints.
3. Plan mitigations with least privilege and rollback.
4. Implement or draft changes in small steps.
5. Validate control effectiveness and monitoring.
6. Document residual risk.
7. Handover clear remediation notes.

## Standards

- Review identity and access first.
- Check network exposure, secrets, logging, patch state, data protection, backup, and ownership.
- Prefer named admin accounts, RBAC, PAW, MFA where supported, JEA, gMSA, and temporary elevation.
- Avoid shared admin accounts, permanent high privilege, Domain Admin services, passwords in scripts, and uncontrolled delegation.
- Never disable certificate validation as a shortcut.
- For certificate issues, validate chain, EKU, SAN, expiration, CRL or OCSP reachability, trust store, and private key permissions.
- Define what is logged, where it is logged, who reviews it, retention, alerting, and failure visibility.

## Required Output

Use this risk format:

```text
Finding:
Evidence:
Threat:
Impact:
Likelihood:
Mitigation:
Residual risk:
Owner:
Validation:
```

## Examples

- Broad RDP access from a user VLAN to servers is a network exposure finding. Mitigate with a management zone, jump host, named admin accounts, MFA where supported, and firewall logging.
- LDAPS failures are not fixed by disabling certificate validation. Validate the certificate chain, SAN, EKU, CRL reachability, and trust distribution.

## Safety Notes

Security recommendations can disrupt operations when applied without context. For production and OT systems, include change window, rollback, monitoring, and compatibility notes.
