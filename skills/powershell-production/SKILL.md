---
name: "powershell-production"
description: "Use this skill for production-grade PowerShell automation in enterprise, Windows Server, AD, VMware, OT, and security-sensitive environments."
---

# PowerShell Production

## When to Use This Skill

Use this skill when writing, reviewing, or fixing PowerShell for Windows Server, Active Directory, Group Policy, WSUS, PKI, VMware, OT, security operations, reporting, or team runbooks.

## Do Not Use This Skill When

Do not use this skill to justify quick one-off production scripts with unsafe defaults. If the task is only a short read-only command, keep it simple and still avoid secrets.

## Context

<replace with your name> expects scripts that a junior or medior engineer can read, test, and run safely. Scripts must be clear about scope, privileges, logging, validation, and rollback when they change systems.

## Workflow

1. Discover target systems, permissions, modules, execution context, and network restrictions.
2. Assess production impact and failure modes.
3. Plan parameters, validation, logging, dry-run behavior, and rollback notes.
4. Write the script with safe defaults.
5. Test read-only paths first, then change paths with `-WhatIf` where practical.
6. Validate output and logs.
7. Document usage and handover notes.

## Standards

- Use `[CmdletBinding(SupportsShouldProcess = $true)]` for change-making scripts.
- Use parameter validation such as `[ValidateNotNullOrEmpty()]`, `[ValidateSet()]`, or `[ValidatePattern()]`.
- Set `$ErrorActionPreference = 'Stop'` in scripts that need reliable failure handling.
- Use `try`, `catch`, and `finally` where cleanup or logging matters.
- Do not hardcode credentials, hostnames, domains, tokens, certificate private keys, or internal IP addresses.
- Prefer explicit target input over broad discovery that could affect too many systems.
- Log actions, warnings, failures, and summary results.
- Return meaningful exit behavior for automation contexts.
- Include examples for read-only, `-WhatIf`, and execution modes.
- Note offline or restricted-server requirements.

## Required Output

For scripts, return:

- Script purpose
- Assumptions and prerequisites
- Required permissions
- Script code
- Example usage
- Validation steps
- Rollback or safety notes

## Example Pattern

```powershell
[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$ComputerName
)

$ErrorActionPreference = 'Stop'

try {
    if ($PSCmdlet.ShouldProcess($ComputerName, 'Collect service status')) {
        Get-Service -ComputerName $ComputerName | Sort-Object Status, Name
    }
}
catch {
    Write-Error "Failed to query $ComputerName. $($_.Exception.Message)"
    exit 1
}
```

## Safety Notes

Production PowerShell can create wide blast radius quickly. Start with read-only discovery, avoid broad default targets, and make change-making behavior explicit.
