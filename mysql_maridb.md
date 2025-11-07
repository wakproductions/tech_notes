# Check Version
`mysqld --version`

# Users

### Logging in
```
shell> mysql -u <user> -p<password> db_name
```


### Looking at the users
```
desc mysql.user;
select host, user from mysql.user\G
SELECT User, Host FROM mysql.user WHERE User = 'humhub';

create  user 'webapp'@'%' identified by '<password>';
CREATE USER 'genexus'@'%' IDENTIFIED BY 'mysql123';
```

# Databases

```
show databases;
use mydatabase;
show tables;
describe <tablename>;
```

Make a database
```
create database mydatabase;
GRANT ALL ON mydatabase.* TO 'your_mysql_name'@'your_client_host';

CREATE DATABASE IF NOT EXISTS echartpro_development;
GRANT ALL ON echartpro_development.* TO 'genexus'@'localhost';
GRANT ALL ON echartpro_development.* TO 'genexus'@'%';
```

See the current database
`select database();`

Dump the schema
`mysqldump -u root -p --no-data dbname > schema.sql`

Load the scema
`mysql -u root -p `
