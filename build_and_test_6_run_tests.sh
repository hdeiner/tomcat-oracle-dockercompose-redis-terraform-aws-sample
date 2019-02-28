#!/usr/bin/env bash

figlet -f standard "Run Tests"

export TOMCAT=$(echo `cat ./.tomcat_dns`)
export REDIS=$(echo `cat ./.redis_dns`)

echo Smoke test
echo "curl -s http://$TOMCAT:8080/passwordAPI/passwordDB"
curl -s http://$TOMCAT:8080/passwordAPI/passwordDB
curl -s http://$TOMCAT:8080/passwordAPI/passwordDB > temp
if grep -q "RESULT_SET" temp
then
    echo "SMOKE TEST SUCCESS"
    figlet -f slant "Smoke Test Success"

    echo "Configuring test application to point to Tomcat endpoint"
    redis-cli -h $REDIS get TomcatURL > rest_webservice.properties

    echo "Run integration tests"
    mvn -q verify failsafe:integration-test
else
    echo "SMOKE TEST FAILURE!!!"
    figlet -f slant "Smoke Test Failure"
fi
rm temp