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

create 'webapp'@'%' identified by '<password>';
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
```

See the current database
`select database();`

Dump the schema
`mysqldump -u root -p --no-data dbname > schema.sql`

Load the scema
`mysql -u root -p `
