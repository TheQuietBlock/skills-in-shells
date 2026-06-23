---
name: "stop-slop"
description: "Use this skill to remove generic AI tone, filler, marketing language, vague advice, and over-polished prose from technical writing."
metadata:
  origin: "Adapted from the original Stop Slop concept by Hardik Pandya."
---

# Stop Slop

## When to Use This Skill

Use this skill when drafting or reviewing agent instructions, skill files, runbooks, SOPs, security notes, PR descriptions, or technical documentation that must sound like <replace with your name>: clear, practical, relaxed, and professional.

## Do Not Use This Skill When

Do not use this skill to strip useful technical detail. Keep the engineering content and remove the filler around it.

## Context

<replace with your name> does not want generic AI wording. The writing should sound like a senior engineer giving useful guidance to another engineer, not like a vendor brochure or template.

## Workflow

1. Find filler, generic AI phrases, dramatic contrasts, vague claims, and marketing language.
2. Replace them with concrete operational language.
3. Keep useful commands, risks, assumptions, and validation steps.
4. Check that the result still sounds human.
5. Remove em dashes.
6. Validate links, unfinished markers, and examples.

## Standards

- Cut throat-clearing such as "it is important to note".
- Replace "leverage" with "use" unless "leverage" is the correct technical word.
- Avoid phrases such as "unlock the power", "rapidly evolving landscape", "seamlessly", and "robust and scalable" unless the text proves the claim.
- Prefer active voice.
- Name the actor, system, risk, and action.
- Avoid vague claims such as "this improves security" without explaining the control.
- Use short paragraphs and practical headings.
- Do not use em dashes.

## Required Output

For a prose cleanup, return:

- What style problems were found
- What changed
- Any technical detail that still needs review
- Validation performed

## Examples

Weak:

```text
It is important to note that this solution seamlessly enhances security.
```

Better:

```text
This change requires LDAPS and rejects clear-text LDAP binds.
```

## Safety Notes

Do not polish away risk. Keep warnings, rollback steps, security constraints, and operational limits visible.
