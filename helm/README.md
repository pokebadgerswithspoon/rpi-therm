# Helm

Helm chart of thermometer

## Prerequisites

Generate keys for JWT
- `publickey.pem`

## Operation

### Check
```shell
helm install --debug --dry-run therm ./
```

### Install

With refresh of images
```shell
helm install therm ./ --set image.pullPolicy=Always 
```

Without
```shell
helm install therm ./
```

### Uninstall
```shell
helm uninstall therm
```