# Terraform FSx for Lustre

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


## Architecture

![diagram](assets/fsx-lustre-workshop-environment-architecture.png)


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


## Inputs

| Name                                     | Description                                                                                | Type     | Default         | Required |
|------------------------------------------|--------------------------------------------------------------------------------------------|----------|-----------------|:--------:|
| name                                     | Common name for all resources.                                                             | `string` | `fsx-example`   |    no    |
| region                                   | The region to deploy the resources.                                                        | `string` | `""`            |   yes    |
| fsx_s3_import_path                       | The s3 bucket to use to back your fsx filesystem. Defaults to NASA's Nex open data bucket. | `string` | `s3://nasanex`  |    no    |
| fsx_storage_capacity                     | Storage capacity of file system in increments of 3600 GiBs.                                | `number` | `7200`          |    no    |
| alarm_notification_email_address         | The email address to send FSX storage alarms/alerts to.                                    | `string` | `""`            |   yes    |
| enable_low_storage_capacity_alarm        | Whether to enable the 'Low free storage capacity alarm'?                                   | `bool`   | `true`          |    no    |
| low_free_data_storage_capacity_threshold | Low free data storage capacity threshold (Bytes).                                          | `string` | `7100000000000` |    no    |
| instance_type                            | The instance type to use for the fsx instance.                                             | `string` | `c5.4xlarge`    |    no    |
| ec2_key_pair                             | The EC2 key pair to use for ssh connections.                                               | `string` | `""`            |   yes    |


## Outputs

| Name                         | Description                                                                                       |
|------------------------------|---------------------------------------------------------------------------------------------------|
| ec2_sec_grp_id               | The security group id for the compute security group.                                             |
| file_system_sec_grp_id       | The security group id for the compute security group.                                             |
| file_system_id               | The id of the FSx filesystem.                                                                     |
| ec2_instance_id              | The id of the ec2 instance used for mounting/testing the FSx filesyem.                            |
| ec2_instance_public_dns_name | The DNS name of the ec2 instance used for mounting/testing the FSx filesyem.                      |
| ami_id                       | The id of the AMI used to create the ec2 instance. Changes depending on region and other factors. |
