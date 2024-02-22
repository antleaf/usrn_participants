## Publish Image for Linux
Do this first (one time):
```bash
docker buildx create --use
```

```bash
docker buildx build --no-cache --platform linux/amd64 --push -t antleaf/usrn_discovery_survey:0.8 .
```

## Replicate data
```bash
litestream replicate data/data.sqlite s3://usrn-survey-sqlite-backups.eu-central-1.linodeobjects.com/_litestream_replicant
```


## Copy data to container
```bash
./copy_csv_to_cluster.zsh
```
