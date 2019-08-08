# SQL
Some notes for SQL
## Install MySQL
- It's too much trouble to go through, so I am using `goorm.io`
So I have everything set up..
```
mysql-ctl start
mysql-ctl stop

mysql-ctl cli # go into the command tool
```

Commands
```
CREATE DATABASE <database_name>;
DROP DATABASE <database_name>;

USE <database_name>; # select the database you want to use
SELECT DATABASE(); # to see what db you are using

```

```
mysql> CREATE TABLE mytable (
    -> name varchar(50),
    -> age int
    -> );

show tables;
show columns from mytable;  #or
DESC mytable;

# drop table
DROP <table_name>
```
