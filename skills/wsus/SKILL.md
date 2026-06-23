---
name: "wsus"
description: "Use this skill for WSUS design, SSL, client policy, approvals, reporting, offline update flows, and troubleshooting."
---

# WSUS

## When to Use This Skill

Use this skill for WSUS server design, upstream and downstream topology, SSL configuration, client Group Policy, approvals, reporting, IIS health, content directories, Windows Update troubleshooting, and restricted-network patching.

## Do Not Use This Skill When

Do not use this skill for general Windows patch advice without WSUS involvement. Use `windows-server-2025` for server patching strategy and this skill for WSUS-specific details.

## Context

<replace with your name> may run WSUS in segmented or restricted networks. Do not assume direct internet access. Keep update flow, approval process, reporting, rollback, and client targeting clear.

## Workflow

1. Discover WSUS role, upstream source, downstream servers, SSL state, ports, content path, products, classifications, languages, and client targeting.
2. Assess storage, IIS health, sync failures, database health, and client reporting.
3. Plan approvals, rings, maintenance windows, and rollback.
4. Execute changes in a pilot group first.
5. Validate client detection, download, install, reboot behavior, and reporting.
6. Roll back approvals or policy if failures occur.
7. Document the patch state and open issues.

## Standards

- Use SSL for WSUS where required by policy or network design, and validate certificate trust.
- Document ports, firewall flows, upstream source, downstream mode, and proxy requirements.
- Validate Group Policy settings for intranet update service, client-side targeting, automatic updates, and restart behavior.
- Check IIS application pools, content directory free space, synchronization status, and Windows Update logs.
- Use pilot groups before broad approvals.
- For offline environments, document export, import, media handling, and approval ownership.

## Required Output

For WSUS work, return:

- WSUS topology and scope
- Client policy assumptions
- Change plan
- Validation commands
- Rollback plan
- Known risks
- Handover notes

## Examples

```powershell
Get-Service WsusService, W3SVC
Get-Website
Get-ChildItem C:\Windows\SoftwareDistribution\ReportingEvents.log
gpresult /h C:\Temp\gpresult.html
UsoClient StartScan
Get-WindowsUpdateLog
```

## Safety Notes

Bad WSUS approvals or restart policy can create service outages. Treat approvals, deadlines, supersedence cleanup, and reboot behavior as production-impacting changes.
