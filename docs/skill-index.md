# Skill Index

Use one skill when one skill is enough. Combine skills only when the task crosses domains.

| Skill | Use For |
| :--- | :--- |
| [active-directory-gpo](../skills/active-directory-gpo/SKILL.md) | AD, domain controllers, DNS, Kerberos, LDAP, LDAPS, GPO, OU design, delegation |
| [focused-fix](../skills/focused-fix/SKILL.md) | Multi-file or multi-component debugging and repair |
| [ot-purdue-osi](../skills/ot-purdue-osi/SKILL.md) | OT, ICS, Purdue model, segmentation, firewall flows, small VLANs |
| [pki-adcs](../skills/pki-adcs/SKILL.md) | AD CS, Root CA, Sub CA, templates, CRL, AIA, LDAPS certificates |
| [powershell-production](../skills/powershell-production/SKILL.md) | Production PowerShell scripts, reviews, and automation standards |
| [research-writer](../skills/research-writer/SKILL.md) | Runbooks, SOPs, implementation plans, handover docs |
| [security-engineering](../skills/security-engineering/SKILL.md) | Security review, hardening, risk analysis, remediation planning |
| [stop-slop](../skills/stop-slop/SKILL.md) | Removing generic AI tone and filler from prose |
| [terraform-enterprise](../skills/terraform-enterprise/SKILL.md) | Terraform modules, state, plans, environment structure |
| [windows-server-2025](../skills/windows-server-2025/SKILL.md) | Windows Server 2025 deployment, operations, hardening, troubleshooting |
| [wsus](../skills/wsus/SKILL.md) | WSUS topology, SSL, client policy, approvals, reporting, troubleshooting |

## Common Pairings

- AD CS and LDAPS: `pki-adcs` plus `active-directory-gpo`
- WSUS on Windows Server: `wsus` plus `windows-server-2025`
- OT firewall change: `ot-purdue-osi` plus `security-engineering`
- Production script for AD: `powershell-production` plus `active-directory-gpo`
- Runbook for server hardening: `research-writer` plus `windows-server-2025` plus `security-engineering`
