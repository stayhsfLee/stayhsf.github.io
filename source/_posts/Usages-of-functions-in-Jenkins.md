---
title: Usages of functions in Jenkins
date: 2019-08-21 15:22:25
tags: jenkins
categories:
- cicd
- jenkins
---

## 1. use shell output as the function result

```groovy
script{
    LOCALIP = sh (
        script: 'hostname -i',
        returnStdout: true
    ).trim()
}
```




