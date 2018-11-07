## Restart Postgres (on Linux core installation via apt)

```
sudo service postgresql restart
```

## Create database

```
createdb -U <user> <dbname>
```

## Show databases

```
wkotzan=# \l
                                                List of databases
               Name               |     Owner      | Encoding |   Collate   |    Ctype    |  Access privileges   
----------------------------------+----------------+----------+-------------+-------------+----------------------
 civis_interview                  | postgres       | UTF8     | en_US.UTF-8 | en_US.UTF-8 | 
 civis_interview_test             | postgres       | UTF8     | en_US.UTF-8 | en_US.UTF-8 | 
 dexteritypm_dev                  | postgres       | UTF8     | en_US.UTF-8 | en_US.UTF-8 | 
 ksm_consulting_sql               | wkotzan        | UTF8     | en_US.UTF-8 | en_US.UTF-8 | 
 postgres                         | wkotzan        | UTF8     | en_US.UTF-8 | en_US.UTF-8 | 
 realez_development               | postgres       | UTF8     | en_US.UTF-8 | en_US.UTF-8 | 
 save_star_trek_fan_films         | postgres       | UTF8     | en_US.UTF-8 | en_US.UTF-8 | 
 save_star_trek_fan_films_test    | postgres       | UTF8     | en_US.UTF-8 | en_US.UTF-8 | 
 snappea                          | postgres       | UTF8     | en_US.UTF-8 | en_US.UTF-8 | 
 stf_eng_dev                      | postgres       | UTF8     | en_US.UTF-8 | en_US.UTF-8 | 
 stock_trend_finder_development   | postgres       | UTF8     | en_US.UTF-8 | en_US.UTF-8 | 
 telnyx_omega_pricing_development | postgres       | UTF8     | en_US.UTF-8 | en_US.UTF-8 | 
 telnyx_omega_pricing_test        | postgres       | UTF8     | en_US.UTF-8 | en_US.UTF-8 | 
 template0                        | wkotzan        | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/wkotzan          +
                                  |                |          |             |             | wkotzan=CTc/wkotzan
 template1                        | wkotzan        | UTF8     | en_US.UTF-8 | en_US.UTF-8 | wkotzan=CTc/wkotzan +
                                  |                |          |             |             | postgres=CTc/wkotzan+
                                  |                |          |             |             | =c/wkotzan
 wakproductions                   | wakproductions | UTF8     | en_US.UTF-8 | en_US.UTF-8 | 
 wkotzan                          | wkotzan        | UTF8     | en_US.UTF-8 | en_US.UTF-8 | 

wkotzan# \c telnyx_omega_pricing_test

```


## Show tables
```
/c database_name
/dt
```

## Moving data directory
```
psql (9.5.7)
Type "help" for help.

ubuntu=# show data_directory;
        data_directory        
------------------------------
 /var/lib/postgresql/9.5/main
(1 row)

ubuntu=# \q
~$ sudo service postgresql stop

```
[We’re going to start the rsync from the postgresql directory in order to mimic the original directory structure in our new location. By creating that postgresql directory within the mount-point directory and retaining ownership by the PostgreSQL user, we can avoid permissions problems for future upgrades. The version directory, 9.5 isn’t strictly necessary since we’ve defined the location explicitly in the postgresql.conf file, but following the project convention certainly won’t hurt, especially if there’s a need in the future to run multiple versions of PostgreSQL.](https://www.digitalocean.com/community/tutorials/how-to-move-a-postgresql-data-directory-to-a-new-location-on-ubuntu-16-04)
```
~$ sudo rsync -av /var/lib/postgresql /pgdata
```
Make the original directory "bak" to avoid confusion
```
~$ sudo mv /var/lib/postgresql/9.5/main /var/lib/postgresql/9.5/main.bak
```
Next change the data_directory setting in `sudo nano /etc/postgresql/9.5/main/postgresql.conf`


## Showing Settings Shortcuts

```
postgres-# SHOW data_directory
/var/lib/postgresql/9.5/main

postgres-# SHOW hba_file
/etc/postgresql/9.5/main/pg_hba.conf
```

### Display query vertically

```
postgres=# \x
Expanded display is on.
postgres=# select * from pg_settings where name='listen_addresses';
name            | listen_addresses
setting         | localhost
unit            | 
category        | Connections and Authentication / Connection Settings
short_desc      | Sets the host name or IP address(es) to listen to.
extra_desc      | 
context         | postmaster
vartype         | string
source          | default
min_val         | 
max_val         | 
enumvals        | 
boot_val        | localhost
reset_val       | localhost
sourcefile      | 
sourceline      | 
pending_restart | f


```


## Data directory
http://stackoverflow.com/questions/1137060/where-does-postgresql-store-the-database
To see where the data directory is, use this query.

```
show data_directory;
```
To see all the run-time parameters, use

```
show all;
```
You can create tablespaces to store database objects in other parts of the filesystem. To see tablespaces, which might not be in that data directory, use this query.

```
SELECT * FROM pg_tablespace;
```

## [Make a user for production](https://www.postgresql.org/message-id/4D958A35.8030501@hogranch.com)

```
$ sudo -u postgres psql

     postgres=> alter user postgres password 'apassword';
     postgres=> create user yerusername;
     postgres=> alter user yerusername password 'somepass';
     postgres=> create database yerusername;
     postgres=> grant all on database momo_scans_prod to momo_scans_prod; 
     postgres=> \q

     $ ...
```

## Importing a table to Rails via COPY trick

[link](https://www.postgresql.org/message-id/5895824A-7DE9-426C-BE09-D81C1F22AFA5%40teksol.info)

```
> However, what if I wanted to assign a default value during import to
> populate the County field? In my dreams it would be something like this
> (which does not work):
> 
> COPY salaries (Town, 'County Name', Supervisor, Salary)
> FROM 'C:\salaries.csv'
> WITH (FORMAT CSV);
> 
> Any ideas?

Import to a temp table, fill in the default value, then copy to the final table, something like this:

CREATE TEMPORARY TABLE salaries_import(LIKE (salaries) );
COPY salaries_import(town, supervisor, salary)
FROM '...',
WITH (format csv);
INSERT salaries(town, country, supervisor, salary)
 SELECT town, 'County Name', supervisor, salary
 FROM salaries_import;

Hope that helps!
François Beausoleil

```

Need to do `ALTER TABLE importtable DROP created_at` to get rid of not null constraint on created_at; 

## First Run

On a clean install you gotta run `createdb` on the terminal after you do `brew install postgresql`
[Source](https://gist.github.com/sgnl/609557ebacd3378f3b72)



## Restore a Database from pg_dump

This will restore from the pg_dump created by a command like the following. `-F d` specifies "directory" format, the `-j 4` means build it with 4 threads.
```
pg_dump -h localhost -F d -j 4 -U master tpg_production -f tpg_production
```
To build a sql file:
```
pg_dump -h localhost -p 5432 -a rics_channels_development > rics_channels_development_20180728.sql
```

```
pg_restore -h localhost -p 5432 -d tpg_development tpg_production_20170814
```


## Copy one database to another

In command line:
```
pg_dump -h localhost -p 5432 -a rics_channels_development | psql rics_adapter_development
```

## More
```
-- show running queries (pre 9.2)
SELECT procpid, age(query_start, clock_timestamp()), usename, current_query 
FROM pg_stat_activity 
WHERE current_query != '<IDLE>' AND current_query NOT ILIKE '%pg_stat_activity%' 
ORDER BY query_start desc;

-- show running queries (9.2)
SELECT pid, age(query_start, clock_timestamp()), usename, query 
FROM pg_stat_activity 
WHERE query != '<IDLE>' AND query NOT ILIKE '%pg_stat_activity%' 
ORDER BY query_start desc;

-- kill running query
SELECT pg_cancel_backend(procpid);

-- kill idle query
SELECT pg_terminate_backend(procpid);

-- vacuum command
VACUUM (VERBOSE, ANALYZE);

-- all database users
select * from pg_stat_activity where current_query not like '<%';

-- all databases and their sizes
select * from pg_user;

-- all tables and their size, with/without indexes
select datname, pg_size_pretty(pg_database_size(datname))
from pg_database
order by pg_database_size(datname) desc;

-- cache hit rates (should not be less than 0.99)
SELECT sum(heap_blks_read) as heap_read, sum(heap_blks_hit)  as heap_hit, (sum(heap_blks_hit) - sum(heap_blks_read)) / sum(heap_blks_hit) as ratio
FROM pg_statio_user_tables;

-- table index usage rates (should not be less than 0.99)
SELECT relname, 100 * idx_scan / (seq_scan + idx_scan) percent_of_times_index_used, n_live_tup rows_in_table
FROM pg_stat_user_tables 
ORDER BY n_live_tup DESC;

-- how many indexes are in cache
SELECT sum(idx_blks_read) as idx_read, sum(idx_blks_hit)  as idx_hit, (sum(idx_blks_hit) - sum(idx_blks_read)) / sum(idx_blks_hit) as ratio
FROM pg_statio_user_indexes;

-- Dump database on remote host to file
$ pg_dump -U username -h hostname databasename > dump.sql

-- Import dump into existing database
$ psql -d newdb -f dump.sql

```