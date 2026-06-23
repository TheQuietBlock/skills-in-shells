# Skills in Shells

> [!IMPORTANT]
> **Setup and Personalization:** Before using this repository with your AI agents, you must personalize the configuration files by replacing the placeholders `<replace with your name>` (and optionally `<replace with your role or job title>`) with your own details throughout the files.
> 
> You can quickly perform this replacement across all files using the following commands:
> 
> **Linux/macOS (bash):**
> ```bash
> # Replace with your name (e.g., "John Doe")
> find . -type f \( -name "*.md" -o -name "*.ps1" -o -name "*.sh" \) | xargs sed -i 's/<replace with your name>/John Doe/g'
> 
> # Replace with your role (e.g., "Systems Engineer")
> find . -type f \( -name "*.md" -o -name "*.ps1" -o -name "*.sh" \) | xargs sed -i 's/<replace with your role or job title>/Systems Engineer/g'
> ```
> 
> **Windows (PowerShell):**
> ```powershell
> # Replace with your name (e.g., "John Doe")
> Get-ChildItem -Recurse -Include *.md,*.ps1,*.sh | ForEach-Object { (Get-Content $_.FullName) -replace '<replace with your name>', 'John Doe' | Set-Content $_.FullName }
> 
> # Replace with your role (e.g., "Systems Engineer")
> Get-ChildItem -Recurse -Include *.md,*.ps1,*.sh | ForEach-Object { (Get-Content $_.FullName) -replace '<replace with your role or job title>', 'Systems Engineer' | Set-Content $_.FullName }
> ```

Reusable AI-agent instructions and skills for personalized, mission critical IT, OT, security, automation, and documentation work.

This repository keeps agent behavior practical and safe for real engineering environments. It is written for work around Windows Server 2025, Active Directory, Group Policy, WSUS, PKI, VMware, Purdue-model segmentation, PowerShell automation, Terraform, and operational documentation for junior and medior engineers.

## Repository Layout

```text
skills-in-shells/
|-- AGENTS.md                 # Main baseline for all agents
|-- ANTIGRAVITY.md            # Antigravity-specific overlay
|-- CLAUDE.md                 # Claude-specific overlay
|-- CODEX.md                  # Codex-specific overlay
|-- COPILOT.md                # GitHub Copilot-specific overlay
|-- GEMINI.md                 # Gemini-specific overlay
|-- docs/
|   |-- engineering-principles.md
|   |-- skill-index.md
|   `-- style-guide.md
|-- skills/
|   |-- active-directory-gpo/
|   |-- ot-purdue-osi/
|   |-- pki-adcs/
|   |-- powershell-production/
|   |-- research-writer/
|   |-- security-engineering/
|   |-- stop-slop/
|   |-- terraform-enterprise/
|   |-- windows-server-2025/
|   `-- wsus/
|-- templates/
|   |-- change-plan.md
|   |-- operational-manual.md
|   |-- powershell-script-header.ps1
|   |-- rollback-plan.md
|   `-- troubleshooting-log.md
`-- scripts/
    |-- Install-GitHooks.ps1
    |-- Test-AiSkillRepository.ps1
    `-- install-hooks.sh
```

## How to Use

Use `AGENTS.md` as the single source of truth for general behavior. Use the tool-specific files as short overlays for Claude, Codex, Copilot, Gemini, or Antigravity.

Load only the skill that fits the task. For example:

- Active Directory, DNS, Kerberos, LDAPS, GPO: `skills/active-directory-gpo/SKILL.md`
- Windows Server 2025 operations: `skills/windows-server-2025/SKILL.md`
- WSUS: `skills/wsus/SKILL.md`
- PKI and AD CS: `skills/pki-adcs/SKILL.md`
- OT and Purdue segmentation: `skills/ot-purdue-osi/SKILL.md`
- Production PowerShell: `skills/powershell-production/SKILL.md`
- Security review: `skills/security-engineering/SKILL.md`
- Runbooks and handover docs: `skills/research-writer/SKILL.md`

## Workspace Setup

For agent tools that discover `.agents` automatically:

```bash
mkdir -p .agents
ln -s ../AGENTS.md .agents/AGENTS.md
ln -s ../skills .agents/skills
```

For tools that expect a named profile, load the matching root file and keep `AGENTS.md` nearby as the main baseline.

## Writing Standard

- Clear, relaxed, professional, and direct.
- No em dashes.
- No generic AI tone.
- No marketing language.
- No fake hostnames, fake secrets, or company-sensitive details.
- Practical enough for production.
- Clear enough for junior and medior engineers.

See [docs/style-guide.md](docs/style-guide.md) and [docs/engineering-principles.md](docs/engineering-principles.md).

## Validation

Run the repository validation script when changing instructions or skills:

```powershell
.\scripts\Test-AiSkillRepository.ps1
```

On Linux, use basic checks if PowerShell is not available:

```bash
find . -name '*.md' -print
rg -n "unfinished marker"
grep -R $'\u2014' .
```

Also check:

- Markdown renders cleanly.
- Internal links resolve.
- Skill names match folder names.
- No unfinished markers are left in published files.
- No accidental secrets are present.
- Root instructions and skill instructions do not conflict.

## Contribution Notes

- Work on a branch.
- Keep changes focused.
- Avoid unrelated formatting churn.
- Update `docs/skill-index.md` when adding or renaming skills.
- Keep `AGENTS.md` global and practical.
- Keep skill files domain-specific.
- Push branches and open a PR instead of pushing directly to `main`.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.