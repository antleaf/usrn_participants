## Publish Image for Linux
Do this first (one time):
```bash
docker buildx create --use
```

```bash
docker buildx build --platform linux/amd64 --push -t antleaf/usrn_discovery_survey:0.1 .
```

