# Skills in Shells

Reusable AI-agent instructions and skills for mission critical IT, OT, security, automation, and documentation work.

Use the shared baseline with the agent overlay and domain skill that fit the task. The instructions prioritize safety, availability, least privilege, validation, and rollback.

## Quick Start

1. Clone this repository.
2. Personalize the root instruction files and your chosen skills. Replace `<replace with your name>` and `<replace with your role or job title>` with your details. Keep public copies generic.
3. Load [AGENTS.md](AGENTS.md), the matching agent overlay, and only the skills needed for the task.
4. Run the repository checks after editing:

   ```powershell
   .\scripts\Test-AiSkillRepository.ps1
   ```

## Repository Layout

```text
skills-in-shells/
|-- AGENTS.md                 # Shared engineering baseline
|-- ANTIGRAVITY.md            # Agent overlays
|-- CLAUDE.md
|-- CODEX.md
|-- COPILOT.md
|-- GEMINI.md
|-- .agents/                  # Discovery links to the baseline and skills
|-- docs/                     # Skill index, style guide, engineering principles
|-- skills/                   # Domain skills and their supporting resources
|-- templates/                # Change, operation, rollback, and troubleshooting templates
`-- scripts/                  # Repository validation and optional Git hooks
```

## Skills

See the [complete skill index](docs/skill-index.md) for links, scope, and common pairings.

| Area | Skills |
| :--- | :--- |
| Windows infrastructure | `active-directory-gpo`, `windows-server-2025`, `wsus`, `pki-adcs` |
| OT and network analysis | `ot-purdue-osi`, `wireshark` |
| Automation and IaC | `powershell-production`, `terraform-enterprise`, `terraform-import-vms` |
| Security | `security-engineering` |
| Writing and review | `stop-slop`, `zero-slop` |

Most skills need only their `SKILL.md`. Zero Slop also needs its bundled scripts, references, pattern data, and regression corpus. Its local helpers require Python 3; its optional remote services are separate from local checks.

## Agent Setup

Use [AGENTS.md](AGENTS.md) as the shared baseline. Load the appropriate overlay for [Claude](CLAUDE.md), [Codex](CODEX.md), [Copilot](COPILOT.md), [Gemini](GEMINI.md), or [Antigravity](ANTIGRAVITY.md).

The `.agents/` entries are Git symlinks. On Linux and macOS they resolve to the shared baseline and skill directory automatically. On Windows, a checkout without symlink support may expose them as small text files containing their targets. In that case, load the root baseline and `skills/` directly, or clone with symlink support enabled when your Windows permissions allow it.

Agent discovery varies by tool. These overlays are files to load explicitly unless your tool is configured to discover them.

## Templates

- [Change plan](templates/change-plan.md)
- [Operational manual](templates/operational-manual.md)
- [Rollback plan](templates/rollback-plan.md)
- [Troubleshooting log](templates/troubleshooting-log.md)
- [PowerShell script header](templates/powershell-script-header.ps1)

Copy a template into the target project and fill in its scope, prerequisites, commands, expected outcomes, and rollback steps.

## Validation

```powershell
.\scripts\Test-AiSkillRepository.ps1
```

The read-only validator checks required files, skill names and descriptions, skill-index coverage, local Markdown link targets, JSON data, and PowerShell syntax. It returns a nonzero exit code when a check fails. Windows PowerShell 5.1 or PowerShell 7 is required.

Personalization placeholders and blank template fields are intentional. Third-party writing examples and references retain their original wording, including phrases that local writing guidance would reject in new prose.

Review technical accuracy, rendered Markdown, and sensitive content separately. Structural checks do not prove that operational instructions are safe for a particular environment.

## GitHub Hygiene

Commit instructions, skills, supporting scripts, references, regression fixtures, templates, licenses, and documentation. Keep dependency lock files and sanitized configuration examples when they are needed for reproducible use.

The [`.gitignore`](.gitignore) excludes local editor settings, caches, environments, build output, logs, private keys, Terraform state and saved plans, and packet captures. Review Terraform variable examples before sharing them.

Ignore rules do not remove files already tracked by Git. Check `git status --short` and review the staged diff before committing. Keep local personalization and real operational data out of the public repository.

## Contributing

1. Work on a branch and keep changes focused.
2. Update [docs/skill-index.md](docs/skill-index.md) when adding or renaming skills.
3. Run validation and review the diff.
4. Push the branch and open a pull request.

Follow the [style guide](docs/style-guide.md) and [engineering principles](docs/engineering-principles.md).

Optional hooks block direct pushes to `main`. Install them with `./scripts/Install-GitHooks.ps1` on Windows or `bash scripts/install-hooks.sh` on Linux and macOS. The installers replace an existing `pre-push` hook, so review and back it up first.

## License

Repository-authored material is licensed under the [MIT License](LICENSE). Imported skills retain their license and attribution metadata: Wireshark declares Apache-2.0, and Zero Slop declares MIT. Stop Slop includes its own [license](skills/stop-slop/LICENSE).
