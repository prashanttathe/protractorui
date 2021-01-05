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
				sh 'export dockerid=docker ps -qf \"name=${APP_NAME}\" -f'
				sh 'cp $dockerid/reports:/reports'
			}
		}
		
    	}
	post { 
		success { 
		    echo "Your Test execution is done and reports at - /protractorui/reports/2020-12-18.html"
		}
		failure { 
		    echo "Please check logs for more details."
		}
    	}
}
