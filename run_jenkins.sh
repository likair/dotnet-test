#!/bin/bash

if [ -f "jenkins.war" ]; then
	export JENKINS_HOME=jenkins
	java -jar jenkins.war --enable-future-java
else
	curl --location --output jenkins.war http://mirrors.jenkins.io/war-stable/latest/jenkins.war

	echo "Jenkins has been downloaded. Next steps:
1. Run this script again to start Jenkins.
2. Go to http://localhost:8080/ and enter the administrator password outputted by the script.
3. Install the suggested set of plugins. This will take several minutes.
4. Create an account or just keep using the default administrator password."
fi
