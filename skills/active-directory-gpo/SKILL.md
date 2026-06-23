---
name: "active-directory-gpo"
description: "Use this skill for Active Directory, domain controllers, DNS, Kerberos, LDAP, LDAPS, Group Policy, OU design, delegation, and Windows identity operations."
---

# Active Directory and Group Policy

## When to Use This Skill

Use this skill for Active Directory design, domain controller operations, OU layout, delegation, DNS dependencies, Kerberos, LDAP, LDAPS, SYSVOL, NETLOGON, Group Policy, security filtering, WMI filters, and authentication troubleshooting.

## Do Not Use This Skill When

Do not use this skill as the main guide for certificate authority design, WSUS operations, or general Windows Server hardening. Use `pki-adcs`, `wsus`, or `windows-server-2025` with this skill when those areas are part of the work.

## Context

<replace with your name> expects AD work to be replication-aware, reversible, and safe for production. Do not assume Domain Admin rights. Prefer delegated rights, named admin accounts, pilot OUs, backups, and clear validation.

## Workflow

1. Discover domain, forest, site, DNS, replication, time sync, and GPO scope.
2. Assess blast radius, privilege requirements, replication impact, and rollback options.
3. Plan the change with a pilot OU or narrow target first.
4. Execute with exports or backups in place.
5. Validate replication, authentication, policy application, and event logs.
6. Roll back if validation fails.
7. Document the result for the operations team.

## Standards

- Check `dcdiag`, `repadmin`, DNS, FSMO roles, time sync, SYSVOL, and NETLOGON before broad changes.
- Back up GPOs before editing or replacing them.
- Test new or changed GPOs on a pilot OU before production links.
- Document scope, inheritance, enforced links, block inheritance, security filtering, WMI filters, and ADMX Central Store dependencies.
- Validate LDAPS with certificate chain, EKU, SAN, trust, and CRL reachability.
- Avoid using Domain Admin for routine service accounts or script execution.

## Required Output

For AD or GPO work, return:

- Goal and scope
- Assumptions
- Required privileges
- Read-only discovery checks
- Implementation plan
- Validation commands
- Rollback plan
- Risks and handover notes

## Examples

```powershell
dcdiag /v
repadmin /replsummary
netdom query fsmo
w32tm /query /status
Get-GPOReport -All -ReportType Html -Path C:\Temp\GPO-Report.html
gpresult /h C:\Temp\gpresult.html
```

## Safety Notes

AD changes can break authentication, name resolution, logon performance, and policy processing. Treat domain controller, DNS, time, SYSVOL, and GPO changes as production-impacting unless <replace with your name> states otherwise.
