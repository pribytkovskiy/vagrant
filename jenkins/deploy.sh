#!/bin/bash

#backend
git clone https://github.com/pribytkovskiy/bikeChampionship.git
cd /home/vagtrant/bikeChampionship/backend/
mvn install
sh ./mvnw spring-boot:run -f ./server/

#front
#cd /home/vagtrant/bikeChampionship/frontend/
#npm install
#npm start

echo 'Copy files...'

scp -i /home/vagtrant/.ssh/app1 \
    /home/vagtrant/bikeChampionship/backend/server/target/surefire/surefirebooter2036138878976016912.jar \
    vagrant@84.0.0.41:/home/tomcat/

echo 'Restart server...'

ssh -i ~/.ssh/app1 vagrant@84.0.0.41<< EOF
pgrep java | xargs kill -9
nohup java -jar /home/tomcat/surefirebooter2036138878976016912.jar > log.txt &
EOF

scp -i /home/vagtrant/.ssh/app1 \
    /home/vagtrant/bikeChampionship/frontend \
    vagrant@84.0.0.41:/home/tomcat/frontend

ssh -i ~/.ssh/app1 vagrant@84.0.0.41<< EOF
cd /home/tomcat/frontend
npm install
npm start
EOF

echo 'Bye'
