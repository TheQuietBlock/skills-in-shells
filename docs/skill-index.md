# Skill Index

Use one skill when one skill is enough. Combine skills only when the task crosses domains.

| Skill | Use For |
| :--- | :--- |
| [active-directory-gpo](../skills/active-directory-gpo/SKILL.md) | AD, domain controllers, DNS, Kerberos, LDAP, LDAPS, GPO, OU design, delegation |
| [ot-purdue-osi](../skills/ot-purdue-osi/SKILL.md) | OT, ICS, Purdue model, segmentation, firewall flows, small VLANs |
| [pki-adcs](../skills/pki-adcs/SKILL.md) | AD CS, Root CA, Sub CA, templates, CRL, AIA, LDAPS certificates |
| [powershell-production](../skills/powershell-production/SKILL.md) | Production PowerShell scripts, reviews, and automation standards |
| [security-engineering](../skills/security-engineering/SKILL.md) | Security review, hardening, risk analysis, remediation planning |
| [stop-slop](../skills/stop-slop/SKILL.md) | Removing generic AI tone and filler from prose |
| [terraform-enterprise](../skills/terraform-enterprise/SKILL.md) | Terraform modules, state, plans, environment structure |
| [terraform-import-vms](../skills/terraform-import-vms/SKILL.md) | Importing existing Proxmox or VMware VMs into Terraform state |
| [windows-server-2025](../skills/windows-server-2025/SKILL.md) | Windows Server 2025 deployment, operations, hardening, troubleshooting |
| [wireshark](../skills/wireshark/SKILL.md) | Packet captures, protocol analysis, TLS troubleshooting, PCAP inspection |
| [wsus](../skills/wsus/SKILL.md) | WSUS topology, SSL, client policy, approvals, reporting, troubleshooting |
| [zero-slop](../skills/zero-slop/SKILL.md) | Prose editing, local writing checks, and optional audience review |

## Common Pairings

- AD CS and LDAPS: `pki-adcs` plus `active-directory-gpo`
- WSUS on Windows Server: `wsus` plus `windows-server-2025`
- OT firewall change: `ot-purdue-osi` plus `security-engineering`
- Production script for AD: `powershell-production` plus `active-directory-gpo`
- VM import: `terraform-import-vms` plus `terraform-enterprise`
- OT packet analysis: `wireshark` plus `ot-purdue-osi`
- Runbook for server hardening: `windows-server-2025` plus `security-engineering`, using the [operational manual template](../templates/operational-manual.md)

## Supporting Files

Most skills are self-contained. Zero Slop also uses its `scripts/`, `references/`, and `data/` folders. Keep these with `SKILL.md`, including the corpus used for regression checks.

Use `stop-slop` for concise technical prose cleanup. Use `zero-slop` when local scoring tools or an audience review are needed. Load the smallest useful set.
