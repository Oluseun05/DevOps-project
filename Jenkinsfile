pipeline {
    agent any

    environment {
        // Update WEBAPP_NAME after running: terraform output webapp_name
        WEBAPP_NAME    = ''
        RESOURCE_GROUP = 'myapp-rg'
        DOTNET_CLI_HOME = '/tmp'
        HOME            = '/tmp'
    }

    parameters {
        string(
            name: 'WEBAPP_NAME_PARAM',
            defaultValue: '',
            description: 'Azure Web App name (from: terraform output webapp_name)'
        )
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Restore') {
            steps {
                sh 'dotnet restore src/DevOpsProject/DevOpsProject.csproj'
            }
        }

        stage('Build') {
            steps {
                sh 'dotnet build src/DevOpsProject/DevOpsProject.csproj --configuration Release --no-restore'
            }
        }

        stage('Test') {
            steps {
                sh 'dotnet test src/DevOpsProject.Tests/DevOpsProject.Tests.csproj --no-restore --verbosity normal'
            }
        }

        stage('Publish') {
            steps {
                sh 'dotnet publish src/DevOpsProject/DevOpsProject.csproj --configuration Release --no-restore --output ./publish'
                sh 'cd publish && zip -r ../app.zip . && cd ..'
            }
        }

        stage('Deploy to Azure') {
            steps {
                withCredentials([azureServicePrincipal('azure-service-principal')]) {
                    sh '''
                        az login --service-principal \
                            --username "$AZURE_CLIENT_ID" \
                            --password "$AZURE_CLIENT_SECRET" \
                            --tenant "$AZURE_TENANT_ID"

                        DEPLOY_NAME="${WEBAPP_NAME_PARAM:-$WEBAPP_NAME}"

                        az webapp deploy \
                            --resource-group "$RESOURCE_GROUP" \
                            --name "$DEPLOY_NAME" \
                            --src-path app.zip \
                            --type zip

                        az logout
                    '''
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
        success {
            echo 'Deployment successful!'
        }
        failure {
            echo 'Pipeline failed — check logs above.'
        }
    }
}
