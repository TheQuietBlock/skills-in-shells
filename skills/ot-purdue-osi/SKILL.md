---
name: "ot-purdue-osi"
description: "Use this skill for OT, ICS, Purdue model, OSI model, network segmentation, firewall flows, and mission critical environments."
---

# OT, Purdue, and OSI

## When to Use This Skill

Use this skill for OT, ICS, OT, ICS, industrial, or mission critical, Purdue-model segmentation, firewall rules, jump hosts, industrial DMZ design, vendor access, small VLANs, control-zone troubleshooting, and OSI-layer analysis.

## Do Not Use This Skill When

Do not use this skill for normal enterprise IT changes unless OT boundaries, segmented networks, control systems, or availability risk are involved.

## Context

The named user treats OT availability and safety as primary constraints. Assume restricted connectivity, change windows, vendor dependencies, small VLANs, and strict firewall policy. Do not assume internet access or cloud services.

## Workflow

1. Discover Purdue level, source zone, destination zone, assets, owner, protocol, port, direction, and business purpose.
2. Assess safety, availability, cyber risk, vendor dependency, and failure mode.
3. Plan deterministic flows through jump hosts, brokers, or an industrial DMZ where practical.
4. Execute during an approved change window.
5. Validate connectivity, logs, monitoring, and application behavior.
6. Roll back if control impact or monitoring gaps appear.
7. Document flows and ownership.

## Standards

- Respect Purdue levels 0, 1, 2, 3, 3.5, 4, and 5.
- Never flatten IT and OT boundaries.
- Prefer deny by default and explicit allow rules.
- Prefer jump hosts, industrial DMZ, brokered access, read-only replication, time-bound vendor access, and passive monitoring.
- Avoid broad any-any rules, noisy scanning, uncontrolled agents, direct enterprise-to-control access, and auto-updating tools in control zones.
- For `/26` and `/29` VLANs, document gateway, reserved addresses, firewall interface, DNS, NTP, monitoring, and owner.
- Troubleshoot by OSI layer when connectivity issues are unclear.

## Required Output

For OT or segmentation work, return:

- Purdue levels and zones involved
- Data flow table
- Firewall rule table
- Operational risk
- Change window and rollback notes
- Validation checks
- Logging and monitoring location
- Handover notes

## Examples

```text
Source Zone | Source IP | Destination Zone | Destination IP | Protocol | Port | Purpose | Logging | Owner
Level 3     | 10.0.3.10 | Level 3.5        | 10.0.35.20     | TCP      | 443  | Historian API polling | Allow log | OT Ops
```

## Safety Notes

Avoid changes that can affect control loops, operator visibility, vendor support, or emergency response. If the blast radius is unclear, stop at discovery and document the unknowns.
