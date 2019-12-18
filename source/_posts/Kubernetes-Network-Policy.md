---
title: Kubernetes Network Policy
date: 2019-12-17 15:52:09
tags: kubernetes
categories:
- kubernetes
---

## Responsibility of `Network Policy`

**Control the network traffic flow** between pods and other network endpoints.

---

### Prerequisites

In your kubernetes cluster, the network plugin should support the `Network Policy`.

---

### How does it work ?

`Network Policy` takes effect inside a certain namespace. 

It uses `label-selector` to choose the pods which should 