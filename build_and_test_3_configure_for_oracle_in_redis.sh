#!/usr/bin/env bash

figlet -f standard "Configure for Oracle in Redis"

# there is obvious dupication in the oracle url, username, and password that should
# be refactored - this is an example only
# for references to things running on this machine, you will see a lot of $(hostname)
# for references from the Tomcat container to the Oracle container, you will see oracle.  When the comtainers are on different machines, a DNS reference will be needed.
echo "Setup Oracle configurations in redis"

export REDIS=$(echo `cat ./.redis_dns`)
export ORACLE=$(echo `cat ./.oracle_dns`)

redis-cli -h $REDIS set LiquibaseDriver "driver: oracle.jdbc.driver.OracleDriver"
redis-cli -h $REDIS set LiquibaseClasspath "classpath: lib/ojdbc8.jar"
redis-cli -h $REDIS set LiquibaseOracleURL "url: jdbc:oracle:thin:@"$ORACLE":1521:xe"
redis-cli -h $REDIS set LiquibaseOracleDatabaseUsername "username: system"
redis-cli -h $REDIS set LiquibaseOracleDatabasePassword "password: oracle"

redis-cli -h $REDIS set OracaleConfigURL "url=jdbc:oracle:thin:@"$ORACLE":1521/xe"
redis-cli -h $REDIS set OraclConfigUser "user=system"
redis-cli -h $REDIS set OracleConfigPassword "password=oracle"

