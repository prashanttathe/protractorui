pipeline {
	environment {
    		def APP_NAME = "protractorui"
    		def GIT_REPO_NAME = "prashanttathe"
    		def DEPLOY_ENV = "dev"
	}
    	agent any
    	stages {
		stage('Code Checkout') {
			steps {
				sh "if [ -d ${APP_NAME} ]; then rm -rf ${APP_NAME}; fi"
				sh "git clone https://github.com/${GIT_REPO_NAME}/${APP_NAME}.git"
			}
		}
		stage('run protractor code'){
			steps {
				sh "cd ./protractorui"
				sh "cd screenshots/"
				sh "ls"
				sh "pwd"
				sh "npm install"
				sh "npm start"
				sh "npm test"				
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
