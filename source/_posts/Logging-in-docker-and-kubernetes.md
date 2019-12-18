---
layout: posts
title: Logging in docker and kubernetes
date: 2019-12-18 17:41:35
tags: kubernetes
categories:
- kubernetes
---


# Related Containers

1. [Docker Logging](https://docs.docker.com/config/containers/logging/)
2. [Kubernetes Logging](https://kubernetes.io/docs/concepts/cluster-administration/logging/)

## Docker

### 1. Get docker output file path using `docker inspect`

```
docker inspect --format='{{.LogPath}}' ${container_id}
```
