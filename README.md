# terraform-module-deployment

This repository is a small deployment repository that consumes an external VPC
module. It demonstrates how to reference a module that lives in a separate Git
repository (not a monorepo) and documents recommended practices for consuming
versioned Terraform modules.

**Using the external VPC module**

Reference the module by pointing to the Git URL and the subdirectory, and pin
to a tag for reproducible deployments:

```hcl
module "vpc" {
	source = "git::https://github.com/janchel/terraform-module-source.git//modules/vpc?ref=v1.0.0"

	name = var.name
	cidr = var.cidr
	azs  = var.azs
}
```

For local development you can switch the source to the local path:

```hcl
module "vpc" {
	source = "./modules/vpc"
	name   = var.name
	cidr   = var.cidr
}
```

**Why use a separate module repository (vs. a monorepo)?**

- Clear ownership and release cadence for the module.
- Consumers can pin stable releases (git tags) and avoid accidental changes.
- Smaller, focused repo makes review and CI faster for module changes.
- Reuse the same module across many deployment repos without duplicating code.

**Advantages of pinning to git tags**

- Reproducibility: `?ref=v1.0.0` guarantees the same module code is used.
- Safe upgrades: consumers opt into upgrades by updating the `ref`.
- Traceability: tags give a clear changelog / release boundary.

**Best practices / recommendations**

- Always pin `source` with a tag or commit hash in production.
- Commit a `.terraform.lock.hcl` in consumers to lock provider versions.
- Use CI to run `terraform fmt`, `terraform validate`, and optional `terraform init`/`plan` for PRs.
- Publish annotated git tags for module releases (e.g. `v1.2.0`) and document breaking changes.
- For local development of the module, temporarily use `./modules/vpc` and revert to a tagged `source` before merging.
- Consider publishing to the Terraform Registry for discoverability if the module is public and broadly useful.

**Use cases**

- Small deployment repos that assemble environment infrastructure using shared modules.
- Teams that want deterministic infrastructure and controlled module upgrades.
- Environments where module authors and consumers are different teams with separate lifecycles.

**Files**

- See `main.tf`, `provider.tf`, `variables.tf`, and `outputs.tf` for an example consumer configuration.

---