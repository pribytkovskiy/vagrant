#!/bin/bash

#git clone https://github.com/pribytkovskiy/bikeChampionship.git
#cd /home/vagtrant/bikeChampionship/backend/
#mvn install
#sh ./mvnw spring-boot:run -f ./server/

echo 'Copy files...'

#backend
scp -i /home/vagtrant/.ssh/app1 \
    /home/vagtrant/bikeChampionship/backend/server/target/surefire/surefirebooter2036138878976016912.jar \
    vagrant@84.0.0.41:/home/tomcat/

echo 'Restart server...'

ssh -i ~/.ssh/app1 vagrant@84.0.0.41<< EOF
pgrep java | xargs kill -9
nohup java -jar /home/tomcat/surefirebooter2036138878976016912.jar > log.txt &
EOF

#front
scp -i /home/vagtrant/.ssh/app1 \
    /home/vagtrant/bikeChampionship/frontend \
    vagrant@84.0.0.41:/home/tomcat/frontend

ssh -i ~/.ssh/app1 vagrant@84.0.0.41<< EOF
cd /home/tomcat/frontend
npm install react-scripts
npm start
EOF

echo 'Bye'

#/var/lib/jenkins/workspace/deploy

#clean package
#Unleash Maven Plugin
#Git plugin
#Deploy to container Plugin
#JDK Parameter Plugin
#openJDK-native-plugin	
#Pipeline Maven Integration Plugin
