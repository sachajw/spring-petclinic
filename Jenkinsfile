pipeline {
    agent {
        label 'jenkins-jenkins-agent'
    }
    environment {
        DOCKERREPO = 'quay.io/pangarabbit/ortelius-spring-petclinic'
        IMAGE_TAG = "${env.BUILD_NUMBER}-${env.GIT_COMMIT.substring(0, 7)}"
        SAFE_DIR = "${env.WORKSPACE}"
        DISCORD_WEBHOOK = credentials('pangarabbit-discord-jenkins')
        DEFAULT_CONTAINER = 'bbdefault'
        PYTHON_CONTAINER = 'python39'
        MAVEN_CONTAINER = 'maven39'
        KANIKO_CONTAINER = 'kaniko'
    }

    stages {
        stage('Git Checkout') {
            steps {
                container("${DEFAULT_CONTAINER}") {
                    withCredentials([string(credentialsId: 'gh-sachajw-walle-secret-text', variable: 'GITHUB_PAT')]) {
                        sh "git config --global --add safe.directory ${env.WORKSPACE} && git clone https://${GITHUB_PAT}@github.com/sachajw/ortelius-jenkins-demo-app.git"
                    }
                }
            }
        }

        stage('Surefire Report') {
            steps {
                echo 'Generating Ortelius Report'
                container("${DEFAULT_CONTAINER}") {
                    sh '''
                        apt update -y && apt install openjdk-17-jdk -y
                        echo 'export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64' >> ~/.bashrc
                        source ~/.bashrc
                        ./mvnw clean install site surefire-report:report
                        tree
                    '''
                }
            }
        }
    }
}
