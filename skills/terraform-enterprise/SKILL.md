---
name: "terraform-enterprise"
description: "Use this skill for Terraform and Infrastructure as Code in enterprise environments."
---

# Terraform Enterprise

## When to Use This Skill

Use this skill for Terraform modules, environment structure, state, plans, drift checks, least-privilege providers, code review, and production IaC workflows.

## Do Not Use This Skill When

Do not use this skill for ad-hoc manual infrastructure changes unless the goal is to bring the change back under code management.

## Context

<replace with your name> expects infrastructure changes to be reviewable, reversible, environment-separated, and safe for production. Do not assume cloud-first design is acceptable. Terraform may be used for enterprise platforms, private infrastructure, or restricted environments.

## Workflow

1. Discover provider, backend, state, workspaces or environments, modules, variables, secrets handling, and drift.
2. Assess blast radius from the plan.
3. Plan module or environment changes with clear inputs and outputs.
4. Run formatting, validation, and plan.
5. Review the plan before apply.
6. Apply only after approval for production.
7. Document outputs, rollback, and drift follow-up.

## Standards

- Protect state with locking and controlled access.
- Keep environments separated.
- Use modules where they remove real duplication.
- Validate variables.
- Keep secrets out of code, state outputs, examples, and logs.
- Review `terraform plan` before apply.
- Avoid unrelated formatting churn.
- Document manual dependencies and import steps.

## Required Output

For Terraform work, return:

- Scope and target environment
- Backend and state assumptions
- Plan summary
- Risk and blast radius
- Validation performed
- Rollback or recovery approach
- Files changed

## Examples

```bash
terraform fmt -check -recursive
terraform validate
terraform plan -out=tfplan
terraform show -no-color tfplan
```

## Safety Notes

Terraform rollback often means applying a new corrective plan, not simply undoing a command. Treat state, imports, destroys, and provider permissions as production-risk items.
