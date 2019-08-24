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
#### Insert Value
```
INSERT INTO <table_name>(col1, col2)
VALUES (10, 20);

```

#### Warnings
```
SHOW WARNINGS; # say you have varchar of 50, you put more than 50. It will give you a warning saying data truncated
```

#### NULL
```
CREATE TABLE people (
    name VARCHAR(50) NOT NULL,
	age INT NOT NULL
)

```
Since we do not specify default, an int will default to 0, vachar will default to ''

#### Default
```

CREATE TABLE people (
    name VARCHAR(50) DEFAULT 'no value',
	age INT DEFAULT 10
)

```

#### Primary Key
```
CREATE TABLE cats (
    cat_id INT NOT NULL AUTO_INCREMENT,  # just automatically increment id without having to insert
	name VARCHAR(50) NOT NULL DEFAULT 'No name'
	age INT,
	PRIMARY KEY (cat_id)
);
```
### Update
Update some record. Make sure you specify the condition
```
UPDATE <TABLE_NAME> SET <COLUMN_1>='the value', <COLUMN_2>='other value'
WHERE <COLUMN_NAME>='something';
```

### Delete
```
DELETE FROM <TABLE>
WHERE <COLUMN>='something'

```

### Run SQL file
You can run the .sql file from the command line using `source`
Make sure you are running the mysql command line
```
mysql> source my_test.sql;  # don't forget the ;

```

## String functions
#### Concat
```
CONCAT(name1, name2,..)

# so this is what you will do
SELECT CONCAT(first_name, last_name) as fullname FROM <TABLE>;

# even better, use CONCAT_WS
SELECT CONCAT_WS('_', first_name, last_name) from <TABLE>; # get first_name_last_name
```
#### Substring
```
SELECT SUBSTRING(full_name, 1, 4) FROM <TABLE> # give you 1st to 4th chars
# if you only supply one number after the first arg, you actually get that index and the remaining,
```
#### Replace
```
SELECT REPLACE(first_name, 'da', 'la') FROM <TABLE>; # replace da with la

```
#### Reverse
```
SELECT REVERSE(first_name) as reversed_name FROM <TABLE>

```

#### CHAR_LENGTH
```
SELECT CHAR_LENGTH(first_name) len_name FROM <TABLE>;

```
#### UPPER and LOWER
```
SELECT UPPER(first_name) as upper FROM <TABLE>
```

### More refinment
#### Distinct
```
SELECT DISTINCT first_name FROM <TABLE>
```

#### ORDER and Limit 
```
SELECT * FROM <TABLE> ORDER BY <COlUMN> DESC LIMIT 10;
SELECT * FROM <TABLE> ORDER BY <COLUMN> DESC LIMIT 2, 10;  # by default it's ASC (ascending)

```
#### LIKE
```
SELECT * FROM <TABLE> WHERE <COLUMN> LIKE '%something%';
SELECT * FROM <TABLE> WHERE <COLUMN> LIKE 'd_e'
```
## Aggregate Function
```
SELECT COUNT(*) FROM <TABLE>
```
### Group By
```
SELECT COUNT(*) as CNT, name FROM <TABLE> GROUP BY name;

```
#### MAX/MIN, SUM, AVG
```
SELECT MAX(COLUMN) as max_con FROM <TABLE>; # will give you one record for max
# if you want to get the row with all attributes with some col that has max/min value
# you have to do this
SELECT * FROM <TABLE> ORDER BY <COLUMN> LIMIT 1;
# Or
SELECT * FROM <TABLE> WHERE <COLUMN> = (SELECT MAX(COLUMN) FROM <TABLE>) # this is less efficient

# get max for each one of the aggreated 
SELECT col1, col2, max(col3) as max_year FROM <TABLE> GROUP BY col1, col2;
```

## DATA TYPE
- VARCHAR vs CHAR
  - CHAR has fixed length: if you say 5 it has to be 5. If you put only one char it will pad it with 4 spaces. CHAR is faster. If you know it's always going to be certain length then make it CHAR. E.g., currency simbol USD, JPY,..
- INT vs DECIMAL
  - DECIMAL(number_of_total_digits, number_of_digit_after_decimal)
  - if you insert something exceeding the max it will give you something like 9999
    - e.g., for decimal(5, 2) you insert 1000.333 -> you get 999.99 since it's the max for your setting
- Float and doule
  - They are more memory efficient but you can have precision issue at the end ~7 digits ~15 digits
  - efficiency wise Float > Double > Decimal
  - precision wise Decimal > Double > Float
### DATE and TIME and DATETIME
- dealing with date related fields
- DATE has a format like this `yyyy-mm-dd`
#### get now
- CURDATE() -> date
- CURTIME() -> time
- NOW() --> datetime
```
INSERT INTO <TABLE> <DT_COL> VALUES(NOW());
```
#### FORMAT the date related stuff
```
# extract the info from the datetime field
SELECT YEAR(DT_COL) as Y FROM <TABLE>;
SELECT MONTH(DT_COL) as M FROM <TABLE>;
SELECT DAY(DT_COL) as D FROM <TABLE>;
SELECT DAYNAME(DT_COL) as D_NAME FROM <TABLE>; # give you like Monday
SELECT DAYOFYEAR(DT_COL) as D_NAME FROM <TABLE>; # give you like 306

```
- Convert the date format
```
SELECT DATE_FORMAT(dt_col, '%m/%d/%Y') # convert to something like 12/10/2019

```
- DATE ARITHMETIC
```
# show how many days apart
SELECT DATEDIFF(dt_col, now()) as diff FROM <TABLE> # give you the diffs in days

# add days or months to date
SELECT DATE_ADD(dt_col, INTERVAL 1 MONTH) FROM <TABLE>
SELECT dt_col + INTERVAL 1 MONTH FROM TABLE # works the same as above
```

- TIMESTAMP
It's a date field which takes less space than DATETIME
- Good use for auto insert when record is created
- a common use case like this
```
CREATE TABLE my_table(
	name VARCHR(50),
    time_stamp TIMESTAMP DEFAULT NOW() ON UPDATE CURRENT_TIMESTAMP  # on update it will update to current timestamp, CURRENT_TIMESTAMP is same as now()
)
```

## LOGICAL OPERATORS
- Not equal 
  -- you can actually use `!=` or `<>`

- not like
  -- not like '%pattern%' 

- and
  -- you can use either `AND` or `&&`

- or
  -- you can use eithrer `OR` or `||`

- between
  -- `BETWEEN val1 AND val2`  # inlcude the left, exclude the right

- To compare two dates, the best practice is to `CAST` them so you can compare the same thing
```
SELECT * FROM <TABLE> WHERE dt_col BETWEEN CAST('2019-12-31' as DATETIME) AND CAST('2022-12-31' as DATETIME);  

```
- IN
```
SELECT * FROM <TABLE> WHERE col IN ('val1', 'val2', 'val3');
# by the way if you want to say get records filter by even year, rather than using IN, you can:
SELECT * FROM <TABLE> WHERE year_col % 2 =0;
```
## CASE STATEMENT
```
SELECT *, 
	CASE
		WHEN name='something' THEN 'ok' ELSE 'not ok'
	END AS new_col
FROM <TABLE>;

# you can also do multiple cases 
SELECT *, 
	CASE
		WHEN name='something' THEN 'ok'
		WHEN age='some age' THEN 'ok with age' 
		ELSE 'not ok'
	END AS new_col
FROM <TABLE>

# you can also take the column name out 
SELECT *, 
	CASE name
		WHEN 'something' THEN 'ok'
		WHEN 'nothing' THEN 'nok'
		ELSE 'oops'
	END AS new_col
FROM <TABLE>

```
## IF 
You can also use if 
```
SELECT
	*,
	IF(name like '%hsin%', 'maybe Hsin', 'not Hsin') as my_guess
FROM <TABLE);

```

## JOIN
### one to many relationship
```
create table customers (
	id int auto_increment primary key,
	name varchar(50),
	email varchar(50)
);


create table orders (
	order_id int auto_increment primary key,
	prodict_name varchar(50),
	amount int,
	customer_id int,
	FOREIGN KEY(customer_id) REFERENCES customers(id)  # by specifying the foreign key, you can constrain adding record with the key that does not exist in the reference table
		ON DELETE CASCADE  # on delete of the customer id this record will be deleted too
);

```
- Explicit Join
```
SELECT * FROM <TABLE>
JOIN <ANOTHER TABLE> # by defafult it's inner join
ON TABLE.KEY = ANOTHER_TABLE.KEY

# example
select
	first_name,
	last_name,
	ifnull(sum(amount), 0) as total_amt # set value if null
from customers as c
left join orders as o
    on c.id = o.customer_id
group by c.id;
```

## Many to Many
For exmaple, Viewers table and Movies table.
 - One viewer can review many movies, and one movie can be reviewed by many viewers 
 - We will need an inbetween table for reviews which has foreign key to the movies and viewers tables
### instgram schema
Refer to `instgram.sql`

# More SQL thing...
## Keys
- Natural Key/Business Key/Domain Key (are the same thing) VS Artificial Key
  - Naural Key example: First Name, Last Name, Address 
  - Artificial Key: Id, often time the primary key

- Secondary Key
  - candidates that are not selected as primary key are called Secondary Key
    - example: eamil address in the Customer table is secondary key, if customer id is chosen to be primary key
- Simple Key
  - A column that can uniquely identify a row. 
    - example: employee_id in Employees table

- Super Key
  - Any combination of columns that can make uniquely ideitify a single row.
  - A minimum key would be the minimum fields that make a row uniuqe. Id can be a minimum key. Email address can be a mimumn key for a customer table too.
## Referencial Integrity
Multiple tables share a relationship based on data stored in the tables, and that relationship has to remain consistent. 
- example: if you have employee table and salary table where salary table has a foreign key referencing employee(id), when deleting an employee record from the eomployee table you also will want to remove it from the salary table.
- We have done this...using `ON DELETE CASCADE` for a foreign key

## Index
**A type of data structure**, commonly used one is B- tree (it's a binary tree). Essentially it stores values of a particular column in a table. The performance is logarithmic. The B- tree index is sorted
- Hashtable is another way for index. It's fast but there are some queries that hastable cannot help. E.g., finding people > 40 years old.
- Other data structures are like R- tree, bitmap index
- To create an Index
```
CREATE INDEX my_index
ON employee_table (employee_name)
```
- Index takes spaces and have to be maintained with the actual data (values on the index col change will have to be changed on the index). 
- General rule is create index only on the frequently queried column.

## Self Join
A table joins itself.
- This will be more performant thatn creating a subquery
```
# this gives you all the employees who live in the same location as Jess
select * from employee as t1
inner join employee as t2
on t1.id = t2.id
where t1.location = t2.location
and t2.name = "Jess";
```

## Another way to write join
There is another way of writing a join.
```
select * from tb1 join tb2 on tb1.id = tb2.id
# can be also written as 
select * from tb1, tb2 where tb1.id = tb2.id

```
Actually, there is more another way
```
select * from tb1
join tb2
using (customer_id) # when you have the identical column name
```
## Parameterized Query/ Prepared Statements
They mean the same thing. Baiscally like templates of SQL statements.
- use `?` for placeholder for data to be pluuged. 

## Subquery and Derived table
- derived table is type of subquery. It's used after the FROM.
```
select * from (
	select a, b from <TABLE>
) as derived_table  # must give derived table an alias
where derived_table.a = 'something'
```
### Coreleated and Uncorelated subquery
Corelated subqueries cannot be run independently whereas Uncoreleated subqueries can be run independently.

### LIMIT
LIMIT takes two args, if you supply two, first will be index (starting from 0) and second will be the number of records
```
select * from books order by pages desc limit 1, 1 # will give you second highest page num record
```

## Cardinality
It has two different meanings:
- Cardinality in data modeling refers to the relationship of that one table can have with another table, like many to many, one to many...
- Another meaning is simply the number of possible values for a given column. Like Gender column there areonly female and male and therefore the cardinality is two.

## Index Selectivity
Formula = cardinality/ num of records * 100%
- If selectivity of index is low it means the column is not good to be indexed. Like `gender` column

### Clustered Index
- A clustered index determines the order where the rows of a table are stored on disk. 
- A cluster index basically contains the actual table level data in the index itself
- Example: if you create a clustered index on employee_id for Employee table. All of the rows in that table will be phsically sorted by the value of employee_id. This will enhance the speed.
- Another exmaple, you have a Car table that has customer_id. You can make the customer_id clustered index, then what will happen is the sorted customer_id will be stored in desk. If you try to search for all cars belonging to a single owner, the entries are stored right next to each other(which is why it's called clustered) and therefore the query will run much faster. 

## blocks vs pages
blocks are smallest units that can be read from or written to a file. Pages are virtual blocks and they have fixed sizes 4k and 2k are most common.

## Database Transaction
It's basically a concept of "All or nothing". Like your bank transaction, either goes through or fail. No in between. A transaction can contain multiple steps, not just one. Manu new versions RDBMS support transaction but they don't come for free. To describe transaction, remember ACID.
- ACID
  - Atomicity: transaction must remain whole - all or nothing
  - Consistenty: transaction should change the state of database from one consistent state to another
  - Isolation: a transaction should be independent from another that might be running at the same time.
  - Durability: change made by a transaction will not disapear if the database encounters some failure

## Optimizer
So, it goes to the topic how to run your query faster. The `optmizer` will run some statistics and determine the order of running the predicate.
- say you have multiple conditions, the idea is that you always want the predicate that eliminates the higher number of rows to be evaluated first by the optimizer! 
- This is a very important concept when it comes to optimization. So essentially we can have the cost optimizer to look thru the values in the columns and let's say we know that column `sex` has 90% male and 10% female, we will essentially prefer to run this `where sex = female` predicate first so we later can deal with less data.
- This can be applied to other things we are doing - create an optimizer to evaluate by stats

## Bitmap index
- Normally created for a low cardinality column, like `sex` with only `male` and `female`.
- It creates two indexes with bit kind like below. With corresponding bit/row. The first row means first row of the table has the value of female and so on.
------------
male | female
------------
0    |   1
------------
1    |  0 
------------
1    |  0

# More and More
- To find a char in a string, use `INSTR` function
```
SELECT INSTR(fist_name, 'a') FROM <TABLE>  # will return the index of char in the string. This is case insensetive
SELECT INSTR(fist_name, BINARY'a') FROM <TABLE>  # this will be case sensetive
```
- right strip spaces 
```
SELECT RTRIM(fist_name, BINARY'a') FROM <TABLE>  # this will be case sensetive

```

## B-Tree Explaination
To understand B-Tree, we should to understand the following concept

### Disk Structure
- To access something in the disk, you need to know
  - Track # 
  - Sector # 
  - offset (in the block)
- So basically Block = (track, sector), and to reach a particular byte, you need to know there three things.
- each block can store particular number of bytes.
- When you store a table which contains many rows, rows will be stored in different blocks. If each row needs to take 128 bytes, each block can store 512 bytes. Each block can store 4 rows.
  - this means to search something you need to search for the number of blocks.
### Index
- Now, to reduce the number of blocks that you need to go through, we use Index!
- We store Index (which is another table)
- say each row for Index only takes 16 bytes, you will store the Index in less blocks.
- The idea is to store the index with pointer that takes you to the address exactly where the record is stored. It will require less blocks you need to search! 

### Multi-level Index
- Basically the index of an index. When the index becomes big (taking too many blocks), you make aother index which each record pointing to a particular block that contains the records of the origibal index
- you can increase the level of blocks as the data grow

### M-way Serach Tree
- Extended from binary search tree (you have each node that has two children)
- With M-way search Tree, you have multiple keys, say you have 20, 50 as your key. It acts like a range. I.e., 15 will go to the left, 25 will go into the middle, 55, will go to the right.
- It is a **M nodes with M-1 keys** structure.
- You can also think binary search tree as M-way search tree of dgree of 2. (M=2, key = 2-1)
```
# for a 4-way ST, let's say
k1, k2, k3
# you have 4 node pointers
less than k1, between k1 and k2, between k2 and k3, greater than k3
# for each key, you also have a record pointer
key1_np, key2_np, key3_np
```

### B-Tree
Finally, we will talk about B-Tree. 
- B-Tree is basically M-way search tree but with the following condition when it comes to creation of the Tree (yes, there are rules that make it a B-tree)
  - Every node (except for root) has to have m/2 children (to control the heigh of the tree - make it balanced)
  - Root can have minimum two children
  - All leaf at the same level (so it's balanced)
  - Creation process is bottom up
- refer to the (vedio)[https://www.youtube.com/watch?v=aZjYr87r1b8] how insertion is done.
- Basically you have to split (creating new node) and change the structure of the tree as needed for every insertion.
- So, when using B-Tree as Index, you can search something by traversing the tree. Just like M-wayST, each key has record pointer.

### B+ Tree
B+ Tree is basically B-Tree except you don't have record pointers for every key, but all they keysare presnt in the leaf level. All the record pointers for keys will be copied and included in the leaf level.
- This natually forms a linked list (that contains all the keys and record pointers)
