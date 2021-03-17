---
title: Minikube introduction
date: 2021-03-12 14:56:10
tags: minikube
categories:
- kubernetes
- minikube
---

`Github link`: [https://github.com/kubernetes/minikube](https://github.com/kubernetes/minikube)


`Minikube` is `the single-node version of kubernetes` which will help you easily delpoy kubernetes alike cluster in your own personal computer.

You can use `kubectl` command to do the same thing as you are operating a kubernetes cluster.

## Mini kube installation

You can click [here](https://minikube.sigs.k8s.io/docs/start/) for guidence of how to set up minikube.

## How to get access to your minikube cluster from internet outside from your LAN

In default, you can only visit your minikube cluster in the machine where you delpoy minikube(use command `minikube start`) casued by `private docker port exposure` by `minikube docker` as you can see from below.

```
containerId   kicbase/stable:v0.0.18          "/usr/local/bin/entr…"   23 hours ago   Up 23 hours   127.0.0.1:49202->22/tcp, 127.0.0.1:49201->2376/tcp, 127.0.0.1:49200->5000/tcp, 127.0.0.1:49203->8443/tcp, 127.0.0.1:49198->8443/tcp, 127.0.0.1:49199->32443/tcp   minikube
```

All ports are only visited by local network `127.0.0.1`.

So you have to tell `minikube` to expose these ports as you wish.

You can use `minikube start --help` for more information to check how to expose these ports. You can find more details from this [Pull Request](https://github.com/kubernetes/minikube/pull/9404).

Step 1
---

Use the command below:

```
minikube start --ports=10000(you can change the port as you want):8443 --apiserver-names=${your_fixed_ip_address_or_your_domain_address} --base-image="kicbase/stable:v0.0.18" --mount=false --mount-string="/usr/local/minikube-files:/host-mount-files"
```

`--ports`: tell minikube which port you want to map to machine port.

`--apiserver-name`: provide this information to let minikube add this into its credential file.

`--base-image`: in default, minikube will pull the image from gcr.io. If you can't visit gcr.io, use this argument topull image from docker.io.

`--mount=true --mount-string="/usr/local/minikube-files:/host-mount-files"`: Mount host path into minikube docker(but i did not see the related mount option in `docker inspect`), then you can use `volumnMount(hostpath option)` to get access to your file in your local machine folder `/usr/local/minikube-files`.

Step 2
---

To get the `kube config` file in minikube cluster.

Minikube usually merge all the config files in to onefile `~/.kube/config` and use context to differ from diffrent minikube cluster. My method only works for only having one cluster.

Copy the config file to your personal computer and merge it with `~/.kube/config`.[Check using `kubecm` for merging configs](/blog/kubernetes/tools/kubernetes-tools).

Step 3
---

Copy three credential files in minikube located machine to your personal computer.

```
scp username@192.168.1.2:~/.minikube/ca.crt ~/.kube/minikube
scp username@192.168.1.2:~/.minikube/profiles/minikube/client.crt ~/.kube/minikube
scp username@192.168.1.2:~/.minikube/profiles/minikube/client.key ~/.kube/minikube
```

Step 4
---

Modify the copyed kube config file.

1. Modify `clusters[0]/cluster/server`(yaml structure path). Replace the hostname part with the value you used in `Step 1` in `--apiserver-names` argument.
2. Modify `clusters[0]/cluster/certificate-authority`(yaml structure path). Replace the value with the credential path you used in `Step 3` -> `~/.kube/minikube/ca.crt`.
3. Modify `users[0]/user/client-certificate`(yaml structure path). Replace the value with the credential path you used in `Step 3` -> `~/.kube/minikube/client.crt`.
4. Modify `users[0]/user/client-key`(yaml structure path). Replace the value with the credential path you used in `Step 3` -> `~/.kube/minikube/client.key`.

Step 5
---

Use `kubectl` to visit your `minikube clster`