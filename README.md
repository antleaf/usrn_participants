## Publish Image for Linux
Do this first (one time):
```bash
docker buildx create --use
```

```bash
docker buildx build --platform linux/amd64 --push -t antleaf/usrn_discovery_survey:0.1 .
```

## Copy data to container

```bash
./copy_csv_to_cluster.zsh
```
