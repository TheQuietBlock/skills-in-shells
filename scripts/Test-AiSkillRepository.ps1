<#
.SYNOPSIS
    Checks repository structure, skill metadata, local links, and source syntax.
.PARAMETER RepositoryPath
    Repository to validate. Defaults to the parent of this script directory.
.EXAMPLE
    .\scripts\Test-AiSkillRepository.ps1
#>
[CmdletBinding()]
param(
    [ValidateNotNullOrEmpty()]
    [string]$RepositoryPath = (Split-Path -Path $PSScriptRoot -Parent)
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$RepoRoot = (Resolve-Path -LiteralPath $RepositoryPath).Path
$Failures = [System.Collections.Generic.List[string]]::new()
$RequiredFiles = @(
    'AGENTS.md', 'ANTIGRAVITY.md', 'CLAUDE.md', 'CODEX.md', 'COPILOT.md',
    'GEMINI.md', 'README.md', 'LICENSE', '.gitignore',
    'docs/skill-index.md', 'docs/style-guide.md', 'docs/engineering-principles.md',
    'templates/change-plan.md', 'templates/operational-manual.md',
    'templates/rollback-plan.md', 'templates/troubleshooting-log.md',
    'templates/powershell-script-header.ps1', 'scripts/Test-AiSkillRepository.ps1',
    'scripts/Install-GitHooks.ps1', 'scripts/install-hooks.sh', 'scripts/git-hooks/pre-push'
)

foreach ($RelativePath in $RequiredFiles) {
    $FilePath = Join-Path -Path $RepoRoot -ChildPath $RelativePath
    if (-not (Test-Path -LiteralPath $FilePath -PathType Leaf)) {
        $Failures.Add("Missing required file: $RelativePath")
    }
    elseif ((Get-Item -LiteralPath $FilePath).Length -eq 0) {
        $Failures.Add("Empty required file: $RelativePath")
    }
}

# Git's inventory includes new skills and avoids traversing discovery symlinks.
$RelativePaths = @(git -C $RepoRoot ls-files --cached --others --exclude-standard)
if ($LASTEXITCODE -ne 0) {
    throw "Cannot list repository files with Git at $RepoRoot."
}
$RelativePaths = @($RelativePaths | Sort-Object -Unique)

$SkillsPath = Join-Path -Path $RepoRoot -ChildPath 'skills'
$SkillFolders = @(Get-ChildItem -LiteralPath $SkillsPath -Directory | Sort-Object Name)
if ($SkillFolders.Count -eq 0) {
    $Failures.Add('No skill folders found.')
}
$IndexPath = Join-Path -Path $RepoRoot -ChildPath 'docs/skill-index.md'
$SkillIndex = if (Test-Path -LiteralPath $IndexPath -PathType Leaf) {
    Get-Content -LiteralPath $IndexPath -Raw -Encoding UTF8
} else { '' }

foreach ($Folder in $SkillFolders) {
    $SkillPath = Join-Path -Path $Folder.FullName -ChildPath 'SKILL.md'
    if (-not (Test-Path -LiteralPath $SkillPath -PathType Leaf)) {
        $Failures.Add("Missing SKILL.md: $($Folder.Name)")
        continue
    }

    $SkillText = Get-Content -LiteralPath $SkillPath -Raw -Encoding UTF8
    $Frontmatter = [regex]::Match($SkillText, '\A---\r?\n(?<body>.*?)\r?\n---(?:\r?\n|\z)', 'Singleline')
    if (-not $Frontmatter.Success) {
        $Failures.Add("Missing YAML frontmatter: $($Folder.Name)")
        continue
    }

    $Metadata = $Frontmatter.Groups['body'].Value
    $Name = [regex]::Match($Metadata, '(?m)^name:\s*["'']?(?<name>[a-z0-9-]+)["'']?\s*$')
    if (-not $Name.Success -or $Name.Groups['name'].Value -ne $Folder.Name -or $Folder.Name.Length -gt 64) {
        $Failures.Add("Skill name must match its folder and contain at most 64 characters: $($Folder.Name)")
    }

    $Description = [regex]::Match($Metadata, '(?m)^description:[ \t]*(?<text>[^\r\n]+)')
    if (-not $Description.Success -or $Description.Groups['text'].Value.Trim() -in @('""', "''")) {
        $Failures.Add("Missing skill description: $($Folder.Name)")
    }
    elseif ($Description.Groups['text'].Value.Trim() -in @('>', '>-', '>+', '|', '|-', '|+')) {
        if ($Metadata -notmatch '(?m)^description:[^\r\n]*\r?\n[ \t]+\S') {
            $Failures.Add("Empty multiline skill description: $($Folder.Name)")
        }
    }

    if (-not $SkillIndex.Contains("../skills/$($Folder.Name)/SKILL.md")) {
        $Failures.Add("Skill not listed in docs/skill-index.md: $($Folder.Name)")
    }
}

foreach ($RelativePath in $RelativePaths) {
    $FilePath = Join-Path -Path $RepoRoot -ChildPath $RelativePath
    if (-not (Test-Path -LiteralPath $FilePath -PathType Leaf)) {
        $Failures.Add("Tracked file missing from working tree: $RelativePath")
        continue
    }

    switch ([System.IO.Path]::GetExtension($RelativePath)) {
        '.md' {
            $Markdown = Get-Content -LiteralPath $FilePath -Raw -Encoding UTF8
            if ([string]::IsNullOrWhiteSpace($Markdown)) {
                $Failures.Add("Empty Markdown file: $RelativePath")
                continue
            }
            # Examples inside code fences and inline code are not live links.
            $Prose = [regex]::Replace($Markdown, '(?ms)^ {0,3}(`{3,}|~{3,})[^\r\n]*\r?\n.*?^ {0,3}\1[ \t]*\r?$', '')
            $Prose = [regex]::Replace($Prose, '`[^`\r\n]+`', '')
            $Links = [regex]::Matches($Prose, '\[[^\]\r\n]*\]\(<?(?<target>[^\s)>]+)>?(?:\s+"[^"]*")?\)')
            foreach ($Link in $Links) {
                $Target = $Link.Groups['target'].Value
                if ($Target -match '^(?:[a-z][a-z0-9+.-]*:|#|//)') {
                    continue
                }
                $Target = [Uri]::UnescapeDataString(($Target -split '[#?]', 2)[0])
                $LinkPath = Join-Path -Path (Split-Path -Path $FilePath -Parent) -ChildPath $Target
                if (-not (Test-Path -LiteralPath $LinkPath)) {
                    $Failures.Add("Broken local link in ${RelativePath}: $Target")
                }
            }
        }
        '.json' {
            try {
                Get-Content -LiteralPath $FilePath -Raw -Encoding UTF8 | ConvertFrom-Json | Out-Null
            }
            catch {
                $Failures.Add("Invalid JSON in ${RelativePath}: $($_.Exception.Message)")
            }
        }
        '.ps1' {
            $Tokens = $null
            $ParseErrors = $null
            [System.Management.Automation.Language.Parser]::ParseFile($FilePath, [ref]$Tokens, [ref]$ParseErrors) | Out-Null
            foreach ($ParseError in $ParseErrors) {
                $Failures.Add("PowerShell syntax error in ${RelativePath}: $($ParseError.Message)")
            }
        }
    }
}

if ($Failures.Count -gt 0) {
    foreach ($Failure in $Failures) {
        Write-Output "FAIL: $Failure"
    }
    Write-Output "Validation failed with $($Failures.Count) issue(s)."
    exit 1
}

Write-Output "Validation passed: $($SkillFolders.Count) skills and $($RelativePaths.Count) repository files checked."
exit 0
