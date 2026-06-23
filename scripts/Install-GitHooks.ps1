<#
.SYNOPSIS
    Installs the custom Git hooks for the repository.
.DESCRIPTION
    Copies hooks from the scripts/git-hooks directory to the .git/hooks directory.
.PARAMETER WhatIf
    Shows what would happen if the command runs without actually copying any files.
.PARAMETER Confirm
    Prompts for confirmation before executing.
#>
[CmdletBinding(SupportsShouldProcess = $true)]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$RepoRoot = Split-Path -Path $PSScriptRoot -Parent
$GitDir = Join-Path -Path $RepoRoot -ChildPath ".git"
$HooksSrcDir = Join-Path -Path $PSScriptRoot -ChildPath "git-hooks"
$HooksDestDir = Join-Path -Path $GitDir -ChildPath "hooks"

Write-Output "Starting Git hook installation..."

# 1. Validation
if (-not (Test-Path -Path $GitDir -PathType Container)) {
    Write-Error "The directory '.git' was not found at $RepoRoot. Is this a Git repository?"
    return
}

if (-not (Test-Path -Path $HooksSrcDir -PathType Container)) {
    Write-Error "Source hook directory not found at $HooksSrcDir"
    return
}

# Ensure destination directory exists
if (-not (Test-Path -Path $HooksDestDir -PathType Container)) {
    if ($PSCmdlet.ShouldProcess($HooksDestDir, "Create Directory")) {
        New-Item -Path $HooksDestDir -ItemType Directory -Force | Out-Null
    }
}

# 2. Installation
$SourceHook = Join-Path -Path $HooksSrcDir -ChildPath "pre-push"
$DestHook = Join-Path -Path $HooksDestDir -ChildPath "pre-push"

if (Test-Path -Path $SourceHook -PathType Leaf) {
    if ($PSCmdlet.ShouldProcess($DestHook, "Copy pre-push hook")) {
        Copy-Item -Path $SourceHook -Destination $DestHook -Force
        Write-Output "Successfully installed pre-push hook."
    }
} else {
    Write-Error "pre-push hook source file not found at $SourceHook"
}

Write-Output "Git hook installation completed."
