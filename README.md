# terraform-fsx-lustre

[FSx]: https://aws.amazon.com/fsx/lustre/
[terraform]: https://www.terraform.io/downloads
[hashicorp/aws]: https://registry.terraform.io/providers/hashicorp/aws
[hashicorp/cloudinit]: https://registry.terraform.io/providers/hashicorp/cloudinit


Sets up an EC2 instance and mounts an [FSx] Lustre filesystem backed by a NASA public data S3 bucket


## Requirements

| Name                  | Version |
|-----------------------|---------|
| [terraform]           | ~> 1.2  |
| [hashicorp/aws]       | ~> 4.x  |
| [hashicorp/cloudinit] | ~> 2.x  |


## Usage

**note**
Amend the state backend bucket value in [versions.tf](versions.tf), line 15 to your own state bucket

Initialise [terraform]
```shell
terraform init
```

Run a plan to test
```shell
terraform plan -var-file=vars/<VARS FILE>.tfvars
```

Deploy
```shell
terraform apply -var-file=vars/<VARS FILE>.tfvars
```

