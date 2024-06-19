pipeline {
    agent any
    environment {
        DOCKER_CREDENTIALS_ID = ''
        DOCKER_IMAGE = "devbysn/hello-world"
        DOCKER_TAG = "latest"
        HELM_CHART_DIR = "helm-chart"
    }
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    docker.withRegistry('', env.DOCKER_CREDENTIALS_ID) {
                        def customImage = docker.build(env.DOCKER_IMAGE + ":${env.DOCKER_TAG}")
                        customImage.push()
                    }
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    sh """
                    helm upgrade --install hello-world ${env.HELM_CHART_DIR} \
                        --set image.repository=${env.DOCKER_IMAGE} \
                        --set image.tag=${env.DOCKER_TAG}
                    """
                }
            }
        }
    }
    triggers {
        scm 'H/5 * * * *'
    }
}

