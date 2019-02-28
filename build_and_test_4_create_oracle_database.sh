#!/usr/bin/env bash

figlet -f standard "Create Oracle Database"

export REDIS=$(echo `cat ./.redis_dns`)

echo "Build the liquibase.properties file for Liquibase to run against"
redis-cli -h $REDIS get LiquibaseDriver > liquibase.properties
redis-cli -h $REDIS get LiquibaseClasspath >> liquibase.properties
redis-cli -h $REDIS get LiquibaseOracleURL >> liquibase.properties
redis-cli -h $REDIS get LiquibaseOracleDatabaseUsername >> liquibase.properties
redis-cli -h $REDIS get LiquibaseOracleDatabasePassword >> liquibase.properties

echo "Create database schema and load sample data"
liquibase --changeLogFile=src/main/db/changelog.xml update
