<#
.SYNOPSIS
    Short description of what the script does.

.DESCRIPTION
    Explain the operational purpose, target systems, and safety behavior.

.PARAMETER ExampleParameter
    Describe the parameter and acceptable values.

.EXAMPLE
    .\Script.ps1 -ExampleParameter "SERVER01" -WhatIf

.NOTES
    Author: <replace with your name>'s engineering standard
    Requirements: Document required modules, roles, or privileges here.
    Safety: Use -WhatIf for change-making actions where supported.
#>

[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$ExampleParameter
)

$ErrorActionPreference = 'Stop'

try {
    if ($PSCmdlet.ShouldProcess($ExampleParameter, 'Describe action')) {
        Write-Verbose "Running action for $ExampleParameter"
    }
}
catch {
    Write-Error "Operation failed. $($_.Exception.Message)"
    exit 1
}
