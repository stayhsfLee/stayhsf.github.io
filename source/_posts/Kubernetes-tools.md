---
title: Kubernetes essential tools
date: 2021-03-12 13:26:10
tags: kubernetes-tools
categories:
- kubernetes
- tools
---

## minikube

`Github link`: [https://github.com/kubernetes/minikube](https://github.com/kubernetes/minikube)

`Minikube` is `the single-node version of kubernetes` which will help you easily delpoy kubernetes alike cluster in your own personal computer.

You can click [here](https://minikube.sigs.k8s.io/docs/start/) for guidence of how to set up minikube.

If you want to get access to your `minikube` cluster from the internet instead of your LAN(local area network), you can click [here](/blog/kubernetes/minikube/minikube-introduction) for guidence.

## kubectx & kubens

`Github link`: [https://github.com/ahmetb/kubectx](https://github.com/ahmetb/kubectx)

`Installation Guidence`: [https://github.com/ahmetb/kubectx#installation](https://github.com/ahmetb/kubectx#installation)

This tool help you switch from different (kubernetes context)[https://kubernetes.io/docs/concepts/configuration/organize-cluster-access-kubeconfig/#context] and namespaces.

[Install fzf](https://github.com/junegunn/fzf) to enable interactive mode.

**Use it with `kubecm.**

## kubecm

`Github link`: [https://github.com/sunny0826/kubecm](https://github.com/sunny0826/kubecm)

I recommend that store all the kubernetes config in one folder, maybe `~/.kube/configs`. And use this tool to help you mrege all this config files in to one config file `~/.kube/config`.

Add this script in `~/.bashrc` or `~/.zshrc`

```
rm -f ~/.kube/config
touch ~/.kube/config
kubecm merge -f ~/.kube/configs -c &>> /dev/null
```

you can replace `~` with `your abosulute user home path`.

**Tips**:

1. The filename of each kube config file under folder `~/.kube/configs` should have the same name with the context in its file.

## kube_ps1

`Github link`: [https://github.com/jonmosco/kube-ps1](https://github.com/jonmosco/kube-ps1)

Add the current Kubernetes context and namespace configured on kubectl to your Bash/Zsh prompt strings.

## kubefwd

`Github link`: [https://github.com/txn2/kubefwd](https://github.com/txn2/kubefwd)

THis tool helps you get access to your `kubernets service` from your own browser without extra proxy.