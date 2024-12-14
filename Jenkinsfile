pipeline {
   agent {label 'build-node'}
   tools {
     maven "Maven3"  
   }
   environment {
        //scannerHome = tool "sonar_scanner"
               //This can be nexus 3 or Nexus 2
        NEXUS_VERSION= "nexus"
        //This can be http or https
        NEXUS_PROTOCOL= "http"
        //Where your Nexus is running
        NEXUS_URL= "http://nexus.sri.devapp.com:8081"
        // Repository Name where we will upload the artifacts
        NEXUS_REPOSITORY= "sridevapp-mvn-repo"
        // Jenkins credentials id to authenticate to Nexus OSS
        NEXUS_CREDENTIAL_ID= "nexus_creds"
        REGISTRY_URL="nexus.sri.devapp.com:7777"
        REPO_NAME="sri-devapp-repo"
        IMAGE_NAME="sri-devapp-backend"
        IMAGE_TAG="latest"
        
   }

    stages {
        // stage('Git Checkout') {
        //     steps {
        //     script{
        //         git 'https://github.com/devopsodia/sri-devapp-backend.git'  
        //         }  
        //     }
        // }
        stage ('Maven Goal'){
            steps {
            script{
            sh "mvn clean install package"
            } 
        }    
        }
    //     stage('Static code Analisys'){
    //         steps {
    //         script{
    //             def mvn = tool 'Maven3';
    //             withSonarQubeEnv() {
    //                 sh "${mvn}/bin/mvn clean verify sonar:sonar -Dsonar.projectKey=sridevapp-backendapp"
    //             }
    //         }
    //     }    
            
    // }
        stage ('Deploying Artifact'){
            steps {
            script{
            sh "mvn deploy"
            }
        }
    }
        stage('Login to Nexus Repo') {
            steps {
            script {
                sh "docker login -u admin -p admin ${REGISTRY_URL}"
            }
        }
    }
	// Building Docker images
        stage('Building image') {
            steps{
            script {
                dockerImage = docker.build "${IMAGE_NAME}:${IMAGE_TAG}"
            }
        }
    }
    	stage('Pushing to Nexus') {
		    steps{
		    script {
                sh "docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${REGISTRY_URL}/${IMAGE_NAME}:$IMAGE_TAG"
                sh "docker push ${REGISTRY_URL}/${IMAGE_NAME}:$IMAGE_TAG"
			}
		  }
		}
   }
}