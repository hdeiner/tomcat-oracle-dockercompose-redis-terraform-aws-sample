This project demonstrates a way to build and test on AWS between an Oracle database and a Tomcat application incorporating Redis to hold configuration information.

We add the complexity of how to distribute secrets and configuration to the deployed application as well. 

This project explores a "halfway" solution to configuration of endpoints and configuration in general.  We could redesign our applications to make redis querries as they run to get what they need.  However, many applications already use "property" files.  We will build the property files from redis-cli queries, construct the property files, and put them into the containers which are calling upon them.  Again, this is not THE solution, but an easy to follow example to get you started thinking about how redis can be used.

```bash
./build_and_test_1_instanciate_and_provision_redis.sh
```
1. Use terraform to create an appropriate AWS EC2 instance.
2. Terraform provisioning will create the actual redis server.  

```bash
./build_and_test_2_instanciate_and_provision_oracle.sh
```
1. Use terraform to create an appropriate AWS EC2 instance.
2. Terraform provisioning will create the actual redis server.  

```bash
./build_and_test_3_configure_for_oracle_in_redis.sh
```
1. Build configuration that will be used to create properties file for the local machine to use Liquibase against the database.
2. Build configuration that will be used to create properties file for the Tomcat machine to use the database.

```bash
./build_and_test_4_create_oracle_database.sh
```
1. Use terraform to create an appropriate AWS EC2 istance.
2. Build the Liquibase properties file from redis configuration information.
3. Run Liquibase locally and create the database for testing.

```bash
./build_and_test_5_instanciate_and_provision_tomcat_server.sh
```
1. Compile the war that we want to test on Tomcat.
2. Build the oracleConfig.properties file used by our war from redis configuration information. 
3. Use terraform to create an appropriate AWS EC2 instance.
4. Terraform provisioning will create the actual tomcat server and deploy the application and configuration to point to the Oracle database.  

```bash
./build_and_test_6_run_tests.sh
```
1. Run a smoke test to make sure everything is wired together correctly.
2. Build the rest_webservice.properties file used by our Cucumber tests from redis configuration information. 
3. Run the tests (Cucumber for Java used).

```bash
./build_and_test_7_teardown.sh
```
1. Use terraform to destroy the tomcat, oracle, and redis infrastructure.
2. Delete the temporary files we created during the run that facilitated the integration of components.
