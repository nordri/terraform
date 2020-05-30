# terraform
Some IaC

## terraform1
IaC for OpenStack

## terraform2
IaC for Docker

## DO
DigitalOcean instance for testing

Set credentials in `credentials` file:

```
export DO_PAT=fee00600126362b...13bc2c875a4c155f8b83ea4
export DO_SSH_FINGERPRINT=22:30:..:bc:81:89:49:b8:f6:19
```

Then you can run

* `./run.sh [ plan | apply ]` to deploy the infrastructure.

You can run

* `./destroy.sh`

When finish.

Ref: https://www.digitalocean.com/community/tutorials/how-to-use-terraform-with-digitalocean