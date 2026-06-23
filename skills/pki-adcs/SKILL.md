---
name: "pki-adcs"
description: "Use this skill for PKI, AD CS, offline Root CA, Enterprise Sub CA, certificate templates, CRL, AIA, LDAPS, and certificate lifecycle work."
---

# PKI and AD CS

## When to Use This Skill

Use this skill for Microsoft AD CS, offline Root CA, Enterprise Sub CA, certificate templates, CRL and AIA, OCSP, LDAPS, server authentication certificates, trust distribution, renewal procedures, private key protection, and certificate troubleshooting.

## Do Not Use This Skill When

Do not use this skill for generic TLS advice without certificate lifecycle or trust-chain work. Pair it with `security-engineering`, `active-directory-gpo`, or `windows-server-2025` when needed.

## Context

<replace with your name> needs PKI guidance that protects availability and trust. Certificate changes can break authentication, management access, application integration, and OT vendor systems. Keep rollover and rollback explicit.

## Workflow

1. Discover CA hierarchy, templates, issued certificates, CRL and AIA locations, OCSP, trust distribution, and consumers.
2. Assess expiration, key protection, EKU, SAN, enrollment permissions, revocation reachability, and dependency risk.
3. Plan issuance, renewal, publication, and rollback.
4. Execute in test or pilot scope where possible.
5. Validate chain, EKU, SAN, private key, revocation, and consuming application behavior.
6. Roll back by restoring prior binding, template, trust, or certificate where possible.
7. Document lifecycle ownership and renewal dates.

## Standards

- Keep the Root CA offline unless a documented CA operation requires it.
- Protect CA private keys and document who can access them.
- Use Enterprise Sub CA for domain-integrated issuance where appropriate.
- Use templates with clear purpose, EKU, subject handling, enrollment permissions, and renewal behavior.
- Validate CRL and AIA reachability from every consuming zone.
- For LDAPS, validate domain controller certificates for Server Authentication EKU, SAN, chain trust, private key access, and revocation.
- Plan renewals before expiration and document service bindings.

## Required Output

For PKI work, return:

- CA hierarchy or trust path
- Certificate purpose and consumers
- Template or issuance plan
- Validation commands
- Renewal and rollback plan
- Risk notes
- Handover notes

## Examples

```powershell
certutil -config "CAHOST\CA-NAME" -ping
certutil -urlfetch -verify .\certificate.cer
certutil -dump .\certificate.cer
Get-ChildItem Cert:\LocalMachine\My
Test-NetConnection dc01.example.local -Port 636
```

## Safety Notes

Certificate shortcuts create long-lived operational risk. Do not disable validation to work around trust failures. Fix the chain, name, EKU, revocation, or binding problem.
