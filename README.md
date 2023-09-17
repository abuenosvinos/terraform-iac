
## Introduction

This project is a terraform practice from the CodelyTV course.

## Requirements

- AWS Account
- Docker
- Make (If you don't have make, you can execute the same commands inside the Makefile)

## AWS

I used `aws sso login` to grant access to AWS, and then I shared my credentials with the container.

## Preparation

`make start`

`make run`

Once this command is executed you will be inside the container to interact with your terraform files.

## Execution

We have dev and prod environments, but in this example we are going to use the dev environment.

```
cd dev/storage
terragrunt init
terragrunt fmt
terragrunt validate
terragrunt plan
terragrunt apply
terragrunt state list
terragrunt destroy
```

https://developer.hashicorp.com/terraform/cli/commands

## Next Steps

- Add GitHub actions to generate the infrastructure at every approved PR

## References

- https://github.com/CodelyTV/terraform-course
- https://pro.codely.com/library/terraform-buenas-practicas-llevando-tu-infraestructura-a-codigo-193451/479241/about/
- https://registry.terraform.io/providers/hashicorp/aws/latest
- https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-sso.html
