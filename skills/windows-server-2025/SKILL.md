---
name: "windows-server-2025"
description: "Use this skill for Windows Server 2025 design, deployment, hardening, troubleshooting, and operations."
---

# Windows Server 2025

## When to Use This Skill

Use this skill for Windows Server 2025 installation, role configuration, hardening, troubleshooting, event log review, services, firewall, certificates, updates, backups, remote management, and operational validation.

## Do Not Use This Skill When

Do not use this skill alone for AD CS, WSUS, Group Policy, OT segmentation, or PowerShell script authoring. Pair it with the matching specialist skill.

## Context

<replace with your name> works with enterprise and mission critical servers. Assume production impact matters. Favor read-only discovery, staged rollout, clear rollback, and documentation a junior or medior engineer can follow.

## Workflow

1. Discover role, owner, zone, OU, GPOs, patch state, services, firewall, certificates, backup, monitoring, and event logs.
2. Assess operational impact and maintenance window needs.
3. Plan changes with backups or exports.
4. Execute in test or pilot first where practical.
5. Validate service health, event logs, firewall profile, certificates, updates, and monitoring.
6. Roll back if success criteria are not met.
7. Document the final state.

## Standards

- Define server role, network zone, OU, GPO scope, IP configuration, DNS registration, time source, backup policy, monitoring, and admin model.
- Do not apply CIS, STIG, or vendor baselines blindly. Check application compatibility, OT compatibility, remote access, and rollback first.
- Prefer WinRM over HTTPS, named admin accounts, JEA, restricted admin groups, and logged remote sessions.
- Avoid broad RDP or WinRM exposure.
- Use ring-based patching: test, pilot, production.
- For restricted networks, document offline update flow, WSUS source, and approval process.

## Required Output

For Windows Server work, return:

- Goal and scope
- Current-state checks
- Change plan
- Validation commands
- Rollback plan
- Event logs or monitoring to review
- Handover notes

## Examples

```powershell
Get-ComputerInfo
Get-WindowsFeature
Get-Service | Sort-Object Status, Name
Get-HotFix | Sort-Object InstalledOn -Descending | Select-Object -First 20
Get-NetFirewallProfile
Get-EventLog -LogName System -Newest 50
w32tm /query /status
gpresult /h C:\Temp\gpresult.html
```

## Safety Notes

Server hardening can block management, break vendor applications, or remove required legacy compatibility. Document the reason, scope, and rollback before changing security, firewall, TLS, service, or update settings.
