# Pact broker CLI

This repo contains the source for the following image:

| Name                               | Tag      | Size   |
| ---------------------------------- | -------- | ------ |
| `hmcts.azurecr.io/pact-broker-cli` | `latest` | 54.5MB |

## Usage

This image can be used to run the `pact-broker` client. E.g.:

```shell
$ docker run hmcts.azurecr.io/pact-broker-cli can-i-deploy -a ... -b ... -l
```

Here is the full [documentation of this client](https://github.com/pact-foundation/pact_broker-client).

## Local dev

### Pull image

You will need to be authenticated to pull those images from ACR:

```shell
$ az acr login --subscription <subscription ID> --name hmcts
```

### Build image

Alternatively you can build them locally using the following command:

```shell
$ make build
```

---

Other commands are available. Use the following one to list them:

```shell
$ make help
```
