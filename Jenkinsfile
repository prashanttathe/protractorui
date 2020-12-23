pipeline{
	agent { dockerfile true }
	stages{
		stage("Build"){
			steps {
				sh 'chown -R node /usr/local/lib /usr/local/include /usr/local/share /usr/local/bin'
				sh 'npm install -g protractor'
				sh 'npm install -g cucumber'
				sh 'npm install protractor-beautiful-reporter'
				sh 'webdriver-manager update'
				sh 'npm test'
			}
			
		}
	}
}
