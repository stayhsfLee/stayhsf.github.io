---
layout: posts
title: Shell Operation Manual
date: 2019-04-17 16:40:48
tags: shell
categories:
- shell
---


## 1. Print Line Number

```shell
awk '{ print FNR " " $0 }'
















```

## 2. Use `awk` to get successive digits in one line

```
echo 'asd1923aa' | awk 'match($0, /[[:digit:]]+/) {print substr($0, RSTART, RLENGTH)}'
```


## 3. Replace text between certain lines

* shell script
```shell
def replaceTextBetweenLines(textmarkOfUpperLine, textmarkOfBottomLine, toBeReplacedTest, replacement, filepath) {
    upperLineNumber=$(awk '{ print FNR " " $0 }' $filepath | grep "$textmarkOfUpperLine:" | awk '{print $1}')
    bottomLineNumber=$(awk '{ print FNR " " $0 }' $filepath | grep "$blobStorageCredential" | awk '{print $1}')

    sed "$upperLineNumber,$bottomLineNumber s#$toBeReplacedTest#$replacement#g" -i $filepath
}

def replaceTextBetweenLines(textmarkOfUpperLine, textmarkOfMiddleLine, textmarkOfBottomLine, toBeReplacedTest, replacement, filepath) {
    upperLineNumber=$(awk '{ print FNR " " $0 }' $filepath | grep "$textmarkOfUpperLine:" | awk '{print $1}')
    bottomLineNumber=$(awk '{ print FNR " " $0 }' $filepath | grep "$blobStorageCredential" | awk '{print $1}')

    sed "$upperLineNumber,$bottomLineNumber s#$toBeReplacedTest#$replacement#g" -i $filepath

    middleLineNumber=$(sed -n "$upperLineNumber,$bottomLineNumber p" $filepath | awk '{ print FNR " " $0 }' | grep $textmarkOfMiddleLine | awk '{ print $1 }')
    upperLineNumber=$((upperLineNumber + middleLineNumber))

    sed "$upperLineNumber,$bottomLineNumber s#$toBeReplacedTest#$replacement#g" -i $filepath
}
```

2. jenkinsfile
```groovy
def replaceTextBetweenLines(textmarkOfUpperLine, textmarkOfBottomLine, toBeReplacedTest, replacement, filepath) {
    script {
        upperLineNumber = sh (
            script: "awk '{ print FNR " " \$0 }' ${filepath} | grep \"${textmarkOfUpperLine}:\" | awk '{print \$1}'",
            returnStdout: true
        ).trim()
        bottomLineNumber = sh (
            script: "awk '{ print FNR " " \$0 }' ${filepath} | grep \"${textmarkOfBottomLine}:\" | awk '{print \$1}'",
            returnStdout: true
        ).trim()

        sh "sed '${upperLineNumber},${bottomLineNumber} s#${toBeReplacedTest}#${replacement}#g' -i ${filepath}"
    }
}

def replaceTextBetweenLines(textmarkOfUpperLine, textmarkOfMiddleLine, textmarkOfBottomLine, toBeReplacedTest, replacement, filepath) {
    script {
        upperLineNumber = sh (
            script: "awk '{ print FNR " " \$0 }' ${filepath} | grep \"${textmarkOfUpperLine}:\" | awk '{print \$1}'",
            returnStdout: true
        ).trim()
        bottomLineNumber = sh (
            script: "awk '{ print FNR " " \$0 }' ${filepath} | grep \"${textmarkOfBottomLine}:\" | awk '{print \$1}'",
            returnStdout: true
        ).trim()

        middleLineNumber = sh (
            script: "sed -n '${upperLineNumber},${bottomLineNumber} p' ${filepath} | awk '{ print FNR \" \" \$0 }' | grep ${textmarkOfMiddleLine} | awk '{ print \$1 }'",
            returnStdout: true
        ).trim()

        upperLineNumber = sh (
            script: "$((${upperLineNumber} + ${middleLineNumber}))",
            returnStdout: true
        ).trim()

        sh "sed '${upperLineNumber},${bottomLineNumber} s#${toBeReplacedTest}#${replacement}#g' -i ${filepath}"
    }
}
```