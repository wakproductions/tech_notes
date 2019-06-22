## Credentials

Default configuration file is `~/.aws/credentials` and `~/.aws/config`

An alternative config file can be specified with envar `AWS_CONFIG_FILE`.

credentials file format:
```
[default]
aws_access_key_id=AKIAIOSFODNN7EXAMPLE
aws_secret_access_key=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
```

config file format:
```
[default]
region=us-west-2
output=json
```

To edit these files:
`$ aws configure set <credential_name> <value> --profile <profile_name>`

To use for one-time:
`AWS_ACCESS_KEY_ID=abcd <command>`