def TEST_PATH = "csharp/unit-testing"

pipeline {
    agent {
        docker { 
            image "mcr.microsoft.com/dotnet/sdk:7.0"
            args "-u root:root"
        }
    }
    
    parameters {
        string(name: "BRANCH_NAME", defaultValue: "main", description: "Branch to build.")
        booleanParam(name: "PUBLISH", defaultValue: true, description: "Push test results to Jenkins.")
    }

    stages {
        stage("Setup") {
            steps {
                sh "apt update && apt install -y zip"
            }
        }

        stage("Checkout") {
            steps {
                git branch: "${params.BRANCH_NAME}", url: "https://github.com/dotnet/samples.git"
            }
        }
        
        stage("Build") {
            steps {
                dir("${TEST_PATH}") {
                    sh "dotnet build"
                }
            }
        }
        
        stage("Tests") {
            parallel {
                stage("Test: MSTest.Project") {
                    steps {
                        dir("${TEST_PATH}/MSTest.Project") {
                            sh "dotnet test"
                        }
                    }
                }
                stage("Test: NUnit.TestProject") {
                    steps {
                        dir("${TEST_PATH}/NUnit.TestProject") {
                            sh "dotnet test"
                        }
                    }
                }
                stage("Test: XUnit.TestProject") {
                    steps {
                        dir("${TEST_PATH}/XUnit.TestProject") {
                            sh "dotnet test"
                        }
                    }
                }
            }
        }

        stage("Publish") {
            when {
                expression { return params.PUBLISH }
            }
            steps {
                dir("${TEST_PATH}") {
                    sh "dotnet publish -o results"
                    sh "zip -r output.zip results"
                    archiveArtifacts artifacts: "output.zip", allowEmptyArchive: false
                }
            }
        }
    }
}
