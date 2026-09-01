pipeline {
    agent any

    options {
        skipDefaultCheckout(true)
    }

    environment {
        AWS_REGION = "us-east-1"
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/phanindra61/Infra-Versioning.git'
            }
        }

        stage('Terraform Version') {
            steps {
                sh 'terraform version'
            }
        }

        stage('Terraform Init') {
            steps {
                withAWS(
                    credentials: 'aws-creds',
                    region: "${AWS_REGION}"
                ) {
                    sh 'terraform init -input=false'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                withAWS(
                    credentials: 'aws-creds',
                    region: "${AWS_REGION}"
                ) {
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                withAWS(
                    credentials: 'aws-creds',
                    region: "${AWS_REGION}"
                ) {
                    sh 'terraform plan -input=false -out=tfplan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                withAWS(
                    credentials: 'aws-creds',
                    region: "${AWS_REGION}"
                ) {
                    sh 'terraform apply -input=false -auto-approve tfplan'
                }
            }
        }
    }

    post {
        always {
            archiveArtifacts(
                artifacts: '**/*.tf',
                allowEmptyArchive: true
            )
        }

        success {
            echo 'Terraform deployment completed successfully.'
        }

        failure {
            echo 'Terraform deployment failed. Check the stage logs.'
        }
    }
}
