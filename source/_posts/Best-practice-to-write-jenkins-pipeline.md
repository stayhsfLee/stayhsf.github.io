---
title: Best practice to write jenkins pipeline
date: 2019-11-20 10:04:10
tags: jenkins-pipeline
categories:
- cicd
- jenkins
---

Summary Tips
---

1. use workflow control to make your pipeline much more easy-understanding.
2. use parameters to make you pipeline easy to migrate.
3. use global variables to define your const variables.





Use Parameters to get your pipeline easy to migrate
---

[Jenkins Parameters Syntax](https://jenkins.io/doc/book/pipeline/syntax/#parameters)

```
pipeline{
    parameters {
        string(name: 'PERSON', defaultValue: 'Mr Jenkins', description: 'Who should I say hello to?')

        text(name: 'BIOGRAPHY', defaultValue: '', description: 'Enter some information about the person')

        booleanParam(name: 'TOGGLE', defaultValue: true, description: 'Toggle this value')

        choice(name: 'CHOICE', choices: ['One', 'Two', 'Three'], description: 'Pick something')

        password(name: 'PASSWORD', defaultValue: 'SECRET', description: 'Enter a password')
    }
}
```

---

How to deal with errors
---


    

* Error occurs during executing commands
  
  [Jenkins TRY_CATCH_FINALLY Syntax](https://jenkins.io/doc/book/pipeline/syntax/#flow-control)

    ```
    stage('Example') {
        try {
            sh 'exit 1'
        }
        catch (exc) {
            echo 'Something failed'
            throw
        }
        /***
        finally {
            echo 'finally doing some clean jobs'
        }
        ***/
    }
    ```

* Global Errors Handlers

    use `post` [( Jenkins Post Syntax )](https://jenkins.io/doc/book/pipeline/syntax/#post) to control the global workflow

    ```
    pipeline {
        agent any
        stages {
            stage('Example') {aborted
                steps {
                    echo 'Hello World'
                }
            }
        }
        post { 
            always { 
                echo 'Always say Hello again!'
            }
            unsuccessful {
                echo 'Doing some clean jobs'
            }
            aborted {
                // send some alertsaborted
            }
        }
    }
    ```
----

How to use the `custom workspace` instead of `$HOME/.jenkins/workspace`
---

[Jenkins Customs Workspace Syntax](https://jenkins.io/doc/book/pipeline/syntax/#agent-parameters)
```
agent {
    node {
        label 'my-defined-label'
        customWorkspace '/some/other/path'
    }
}
```

----

How to define your `global variables` to avoid duplicate codes?
---

```
def current_time
pipeline {
    agent any
    stages{
        stage('Initialize the variables') {
            steps {
                script {
                    // initialize with timestamp value
                    current_time=new java.util.Date().getTime()
                }
            }
            steps {
                echo "${current_time}"
            }
        }
    }
}
```

---

How to set your `environment variables`?
---

[Jenkins Environment Variables Syntax](https://jenkins.io/doc/book/pipeline/syntax/#environment)

There are two scopes of environment variables you can specify.

* throughout the pipeline

* take effect only in one stages.stage
```
pipeline {
    agent any
    // throughout the pipeline 
    environment { 
        CC = 'clang'
    }
    stages {
        stage('Example Username/Password') {
            // only in one stage
            environment {
                SERVICE_CREDS = credentials('my-prefined-username-password')
            }
            steps {
                sh 'echo "$SERVICE_CREDS"'
                sh "echo \$SERVICE_CREDS"
            }
        }
    }
}
```

---

Parallel steps
---

[Jenkins Parallel Syntax](https://jenkins.io/doc/book/pipeline/syntax/#environment)

use `parallel` feature in `pipeline.stages.stage`

```
pipeline{
    agent { label 'master' }
    options{
        parallelsAlwaysFailFast()
    }
    stages{
        stage('Build Components Image') {
            // failFast true - function as options.parallelsAlwaysFailFast()
            parallel {
                stage ('Build UI Image'){
                    steps {
                        echo 'build'
                    }
                }
                stage ('Build Webapp Image'){
                    steps {
                        echo 'build'
                    }
                }
            }
        }
    }
}
```
