pipeline{
	agent { dockerfile true }
	stages{
		stage("Build"){
			steps {
				sh 'npm install -g protractor'
				sh 'npm install -g cucumber'
				sh 'npm install protractor-beautiful-reporter'
				sh 'webdriver-manager update'
				sh 'protractor conf.js --chromeDriver="$CHROME_DRIVER" --browser=chrome --capabilities.chromeOptions.args="headless" --capabilities.chromeOptions.args="no-sandbox"'
			}
			
		}
	}
}
