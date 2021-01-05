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
				sh 'cp /app/Reports/`date +"%y-%m-%d"`.html /var/lib/jenkins/workspace/FEI_PetClinic_Protractorui'
				
			}
		}
		
    	}
	post { 
		success { 
		    sh 'cp /var/lib/jenkins/workspace/FEI_PetClinic_Protractorui/`date +"%y-%m-%d"`.html /var/www/html/'
		    sh 'echo "Your Test execution is done and reports at - http://tnt-aks-automator.eastus.cloudapp.azure.com/`date +"%y-%m-%d"`.html"'
		}
		failure { 
		    echo "Please check logs for more details."
		}
    	}
}
