# Style Guide

## Voice

Write like a senior engineer helping another engineer get the work done safely.

- Clear
- Relaxed
- Professional
- Practical
- Specific

Do not sound like a vendor brochure, training poster, or generic AI assistant.

## Hard Rules

- Do not use em dashes.
- Do not use filler phrases.
- Do not use marketing language.
- Do not use real secrets, hostnames, internal domains, or sensitive IP addresses.
- Do not bury risk in vague language.

## Prefer

- "Use" instead of "leverage"
- "Check" instead of "ensure" when a command follows
- "Rollback" with a concrete action
- "Validation" with an expected result
- "Assumption" when context is missing

## Avoid

- "In today's rapidly evolving landscape"
- "It is important to note"
- "Unlock the power of"
- "Seamlessly"
- "Robust and scalable" without evidence
- "Best practice" without context

## Good Pattern

```text
Check LDAPS on a domain controller before changing the application binding. If LDAPS fails, validate certificate chain, SAN, EKU, trust, and CRL reachability before changing the application.
```

## Weak Pattern

```text
It is important to note that organizations should leverage robust security practices to enhance authentication.
```
