pipeline {
	environment {
    		def APP_NAME = "protractorui"
    		def GIT_REPO_NAME = "prashanttathe"
    		def DEPLOY_ENV = "dev"
	}
    	agent { dockerfile true }
	stages {
		stage('test copying files') {
			steps {
				//echo 'Placeholder.'
				checkout scm
        			def customImage = docker.build("docker-image:${env.BUILD_ID}", "-f ./apache/Dockerfile .")
				customImage.inside('-v $WORKSPACE:/output -u root') {            			
            										sh """
            										ls /output
            										touch /tmp/test.html && ls /tmp
            										cp /tmp/test.html /output
            										"""
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
