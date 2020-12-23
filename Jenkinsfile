pipeline{
	agent { dockerfile true }
	stages{
		stage("Build"){
			steps {
				sh 'npm install -g protractor'
				sh 'npm install -g cucumber'
				sh 'npm install protractor-beautiful-reporter'
				sh 'webdriver-manager update'
				sh 'npm test'
			}
			
		}
	}
}
