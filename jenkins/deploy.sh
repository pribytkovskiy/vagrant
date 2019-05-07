#!/bin/bash

mvn clean package

echo 'Copy files...'

scp -i ~/.ssh/app1 \
    target/sweater-1.0-SNAPSHOT.jar \
    vagrant@84.0.0.41:/home/tomcat/

echo 'Restart server...'

ssh -i ~/.ssh/app1 vagrant@84.0.0.41<< EOF
pgrep java | xargs kill -9
nohup java -jar /home/tomcat/sweater-1.0-SNAPSHOT.jar > log.txt &
EOF

echo 'Bye'

#backend
git clone https://github.com/pribytkovskiy/bikeChampionship.git
cd /home/vagtrant/bikeChampionship/backend/
mvn clean install
./mvnw install
mvnw spring-boot:run -f ./server/

#front
cd /home/vagtrant/bikeChampionship/frontend/
npm install
npm start