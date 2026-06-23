---
name: "terraform-import-vms"
description: "Use this skill for importing existing Proxmox or VMware vCenter virtual machines into Terraform state without recreating them."
---

# Terraform VM Imports

## When to Use This Skill

Use this skill when existing virtual machines already exist in Proxmox VE or VMware vCenter and need to be brought under Terraform management.

Common cases:

- A Terraform repository was newly cloned and local state is missing.
- Remote state was lost, replaced, or does not include existing VMs.
- Terraform plans to create VMs that already exist.
- Existing Proxmox or vCenter VMs need to be imported into a module or `for_each` resource.
- You need to reconcile Terraform configuration with manually created virtualization inventory.

## Do Not Use This Skill When

Do not use this skill to create new VMs from scratch. Use the normal Terraform module workflow for new builds.

Do not use this skill to force Terraform over unknown production VMs without inventory owner approval, state backup, and a reviewed plan.

## Context

VM imports are state operations with production impact. Importing a VM should not recreate or reboot it, but a wrong resource address, provider ID, lifecycle setting, or follow-up apply can still plan disruptive changes.

Use this skill together with `terraform-enterprise` for state, backend, plan review, and production workflow rules.

## Workflow

1. Discover the platform: Proxmox VE or VMware vCenter.
2. Identify target environment: dev, test, acceptance, production, lab, or OT.
3. Back up or snapshot Terraform state before import.
4. Match each VM to the exact Terraform resource address.
5. Create Terraform 1.5+ `import` blocks or use `terraform import` when import blocks are not practical.
6. Run `terraform fmt`, `terraform validate`, and `terraform plan`.
7. Review the plan for imports, drift, replacements, shutdowns, disk changes, NIC changes, and tag or folder moves.
8. Get explicit human confirmation before `terraform apply` in production.
9. Apply only the reviewed import plan.
10. Run a second plan after import and document remaining drift.

## Standards

- Never run `terraform apply -auto-approve` in production.
- Never run `terraform apply` in production without explicit confirmation after plan review.
- Use a saved plan file for production where practical: `terraform plan -out=tfplan`.
- Confirm the backend, workspace, and target environment before import.
- Back up state before import.
- Import into the correct module path and resource key.
- Do not change VM power state, disks, NICs, firmware, guest ID, folder, cluster, datastore, or tags as part of the import unless that change is separately approved.
- Use `lifecycle.ignore_changes` only for attributes that the platform, provider, or existing build process owns. Document every ignored attribute.
- Keep secrets, provider credentials, vCenter names, Proxmox nodes, VM names, and internal IP addresses out of examples.

## Production Apply Confirmation Rule

For production imports, stop before `terraform apply` and ask for confirmation.

The confirmation must include:

- Target platform: Proxmox VE or VMware vCenter
- Target environment
- Terraform workspace or backend
- Plan file name if used
- Count of resources to import
- Confirmation that the plan shows `0 to destroy`
- Confirmation that no VM replacement, disk replacement, NIC replacement, or power action is planned

Acceptable confirmation wording:

```text
I approve applying this Terraform import plan to production.
```

If confirmation is missing or unclear, do not apply. Continue with plan review and risk notes only.

## Proxmox Import Pattern

Use this pattern for the `Telmate/proxmox` provider or compatible Proxmox provider behavior.

Identify:

- Proxmox node
- VM ID
- Terraform resource address

Example:

```text
Platform: Proxmox VE
Node: proxmox-node01
VM ID: 130
Resource address: proxmox_vm_qemu.vms["example-vm"]
```

Terraform import block:

```hcl
import {
  to = proxmox_vm_qemu.vms["example-vm"]
  id = "proxmox-node01/qemu/130"
}
```

CLI import alternative:

```bash
terraform import 'proxmox_vm_qemu.vms["example-vm"]' 'proxmox-node01/qemu/130'
```

## VMware vCenter Import Pattern

Use this pattern for the HashiCorp `vsphere` provider.

Identify:

- vCenter target
- Datacenter name
- VM folder path
- VM name
- Terraform resource address

The common import ID format for `vsphere_virtual_machine` is the inventory path:

```text
/<datacenter>/vm/<folder>/<vm-name>
```

Example:

```text
Platform: VMware vCenter
Datacenter: DC01
Folder: Workloads/Production
VM name: example-vm
Resource address: vsphere_virtual_machine.vms["example-vm"]
```

Terraform import block:

```hcl
import {
  to = vsphere_virtual_machine.vms["example-vm"]
  id = "/DC01/vm/Workloads/Production/example-vm"
}
```

CLI import alternative:

```bash
terraform import 'vsphere_virtual_machine.vms["example-vm"]' '/DC01/vm/Workloads/Production/example-vm'
```

## Plan Review Checklist

Before apply, confirm:

- Correct backend and workspace are selected.
- State backup exists.
- Resource addresses match the intended VMs.
- Plan shows expected imports.
- Plan shows `0 to destroy`.
- Plan does not show VM replacement.
- Plan does not show disk replacement.
- Plan does not show NIC replacement.
- Plan does not show power state changes.
- Drift is understood and documented.
- Production confirmation has been received if the environment is production.

## Required Output

For VM import work, return:

- Platform: Proxmox VE or VMware vCenter
- Environment and backend or workspace
- State backup approach
- VM inventory table
- Import block or import command examples
- Plan review summary
- Production confirmation status
- Apply decision: approved, blocked, or not requested
- Post-import validation
- Remaining drift and handover notes

## VM Inventory Table

```text
Platform | Environment | VM Name | Provider ID or Path | Terraform Address | Owner | Notes
```

## Validation Commands

```bash
terraform fmt -check -recursive
terraform validate
terraform plan -out=tfplan
terraform show -no-color tfplan
terraform state list
terraform state show '<resource-address>'
terraform plan
```

## Safety Notes

Imports bring existing infrastructure under Terraform control. The dangerous part is often the follow-up apply, not the import itself. Treat every planned replacement, disk change, NIC change, folder move, datastore move, or power action as production-impacting until proven otherwise.
