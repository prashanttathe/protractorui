pipeline {	
    	agent { dockerfile true }
	environment {
        HOME = '.'
    	}
	stages {	    
		stage("BUild") {
			steps {
				sh 'pwd'
				sh 'chmod -R 777 ./'
				sh 'ls -lh'
				sh 'npm install'
				sh 'npm install -g cucumber'
				sh 'npm install protractor-beautiful-reporter'
				sh 'webdriver-manager update'
				sh 'npm test'
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
