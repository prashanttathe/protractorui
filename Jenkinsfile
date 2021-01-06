pipeline {
	environment {
    		def APP_NAME = "protractorui"
    		def GIT_REPO_NAME = "prashanttathe"
    		def DEPLOY_ENV = "dev"
	}
    	agent { dockerfile true }
	stages {
		stage('Initialize') {
			steps {
				echo 'Placeholder.'
				//sh 'rm -f /var/lib/jenkins/workspace/FEI_PetClinic_Protractorui/`date +"%Y-%m-%d"`.html'
				sh """
					JOB_NAME=${env.JOB_BASE_NAME}
					rm -f /var/lib/jenkins/workspace/\$JOB_NAME/`date +"%Y-%m-%d"`.html
					cp /app/Reports/`date +"%Y-%m-%d"`.html /var/lib/jenkins/workspace/\$JOB_NAME
				   """
				//sh 'cp /app/Reports/`date +"%Y-%m-%d"`.html /var/lib/jenkins/workspace/${env.BUILD_TAG}'
				
			}
		}
		
    	}
	post { 
		success { 
		    sh 'echo "Your test execution is done and reports will be avaible at - http://tnt-aks-automator.eastus.cloudapp.azure.com/`date +"%Y-%m-%d"`.html" in sometime.'
		}
		failure { 
		    echo "Please check logs for more details."
		}
    	}
}
