pipeline{
	agent { dockerfile true }
	stages{
		stage("Build"){
			steps {
				sh 'pwd'
				sh 'ls -lh'				
				sh 'npm install'
				sh 'npm install cucumber'
				sh 'npm install protractor-beautiful-reporter'
				sh 'cd node_modules/.bin/'
				sh 'pwd'
				sh 'ls -lh'
				sh 'webdriver-manager update'
				sh 'npm test'
			}
			
		}
	}
}
