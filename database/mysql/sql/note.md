# Database
## subquery
### 标量(单一值)
SELECT * FROM article WHERE uid = (SELECT uid FROM user WHERE status=1 ORDER BY uid DESC LIMIT 1)
### N行一列
#### IN
SELECT * FROM article WHERE uid IN(SELECT uid FROM user WHERE status=1)
#### ANY
SELECT s1 FROM table1 WHERE s1 > ANY (SELECT s2 FROM table2)
#### ALL
SELECT s1 FROM table1 WHERE s1 > ALL (SELECT s2 FROM table2)
### N列一行
SELECT * FROM table1 WHERE (1,2) = (SELECT column1, column2 FROM table2)
SELECT * FROM article WHERE (title,content,uid) = (SELECT title,content,uid FROM blog WHERE bid=2)
### N行N列(表)
SELECT * FROM article WHERE (title,content,uid) IN (SELECT title,content,uid FROM blog)
### From子句子查询
SELECT ... FROM (subquery) AS name
### EXIST
SELECT * FROM article WHERE EXISTS (SELECT * FROM user WHERE article.uid = user.uid)

## join 拼接表
### left join 
### right join
### inner join
#
## avg(), max(), min(), count()
## Union
UNION 用于把来自多个 SELECT 语句的结果组合到一个结果集合, 自带去重
union all 不过滤重复数据


## limit 
mysql> SELECT * FROM table LIMIT 5,10;
mysql> SELECT * FROM table LIMIT 95,-1;

## view database info
show create database test;
## create db
create database test charset utf8;


# Procedure
## create procedure
mysql> delimiter //
mysql> create procedure show_all_user (OUT number INT) begin select count(*) from user into number; end//
mysql> delimiter ;
mysql> call show_all_user(@number);

## remove procedure
mysql> Drop procedure <name>;

# Function
## create function
create function hello(s char(20)) returns char(50) deterministic return concat('hello ', s, '!');
## function return type
Deterministic functions always return the same result any time they are called with a specific set of input values.
Nondeterministic functions may return different results each time they are called with a specific set of input values.
## use function
select hello('world');

## remove function
Drop function <name>

## alter function
alter function <name>

# Useful Commands
mysql> select now();
mysql> show full columns from <table>;
mysql> select user();
mysql> select version();
mysql> show plugins;
mysql> status; # show information about connected socket etc;
mysql> select user()|schema()
mysql> select floor(1.23), ceil(1.23), round(1.6666, 2),  
mysql> select 5 div 2;  5 / 2;
mysql> select 5 mod 2; mod(5, 2);

mysql> select ifnull(<exp1>, <exp2>);

# Tips
## disable auto-reconnect
variable lost with connection
mysql --skip-reconnect

## safe update
mysql --safe-updates

## PS1
shell> export MYSQL_PS1="(\u@\h) [\d]> "

# Trigger 
## create trigger
mysql> create table account (acct_num INT, amount DECIMAL(10, 2));
mysql> create trigger ins_sum BEFORE INSERT ON acount
->      FOR EACH ROW set @sum = @sum + NEW.amount;

mysql> set @sum = 0 ;
mysql> INSERT INTO account VALUES(137,14.98),(141,1937.50),(97,-100.00); 
mysql> SELECT @sum AS 'Total amount inserted';

# Event Scheduler
## enable or disable event scheduler thread;
mysql> set global event_scheduler = ON;

## create event
CREATE DEFINER=`admin`@`%` EVENT `Event_t_log`
    ON SCHEDULE EVERY 1 DAY STARTS '2014-10-08 00:00:01' ON COMPLETION NOT PRESERVE ENABLE
    DO 
        CALL sp_t_log();

CREATE EVENT myevent
    ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 HOUR
    DO
      UPDATE myschema.mytable SET mycol = mycol + 1;

## grant priviledges;
mysql> grant event on myschema.* to jon@localhost;
//The EVENT privilege has global or schema-level scope.

## enable or disable one event
mysql> Alter event <name> disable/enable;

## view event
mysql> show events;

# View
## create view
create view <name> as select * from test;
## show view
show create view <name>
## show all views
select * from views where TABLE_SCHEMA regexp 'test'\G


# Prepare statement (since mysql5.5)
mysql> prepare stmt from 'select sqrt(pow(?, 2) + pow(?, 2)) as mm';
mysql> set @a = 4;
mysql> set @b = 3;
mysql> execute stmt using @a, @b;

# Declare
should be in a compound statement{ begin...end}
declare variable type [default Value]


# Flow control


select count( distinct user_id ) from T_USER_CHARGE where create_ts > DATE('2015-11-10') and create_ts < DATE('2015-11-11');

select count(*) from T_USER where  not isnull(device_type);


# transaction
mysql> start transcation [with consistent snapshot];
mysql> savepoint <p1>;
mysql> rollback [to <p1>]
mysql> release savepoint <p1>;
mysql> commit;


# change metadata
mysql>  alter table gg add primary key (id);

Data definition language, a set of SQL statements for manipulating the database itself rather than individual table rows
Data control language, a set of SQL statements for managing privileges. In MySQL, consists of the GRANT and REVOKE statements. 
Data manipulation language, a set of SQL statements for performing insert, update, and delete operations. 

A procedure is invoked using a CALL statement (see Section 13.2.1, “CALL Syntax”), and can only pass back values using output variables. A function can be called from inside a statement just like any other function (that is, by invoking the function's name), and can return a scalar value.
A stored procedure or function is associated with a particular database
When a database is dropped, all stored routines associated with it are dropped as well.


Within the trigger body, the OLD and NEW keywords enable you to access columns in the rows affected by a trigger. OLD and NEW are MySQL extensions to triggers; they are not case sensitive.

A column named with OLD is read only. You can refer to it (if you have the SELECT privilege), but not modify it

MySQL Events are tasks that run according to a schedule. Therefore, we sometimes refer to them as scheduled events

User variables are written as @var_name, where the variable name var_name consists of alphanumeric characters, “.”, “_”, and “$”. A user variable name can contain other characters if you quote it as a string or identifier (for example, @'my-var', @"my-var", or @`my-var`).

User-defined variables are session-specific. A user variable defined by one client cannot be seen or used by other clients
All variables for a given client session are automatically freed when that client exits.

User variable names are not case sensitive.
For SET, either = or := can be used as the assignment operator.

You can also assign a value to a user variable in statements other than SET. In this case, the assignment operator must be := and not = because the latter is treated as the comparison operator = in non-SET statements:

The DECLARE statement is used to define various items local to a program:


To deallocate a prepared statement produced with PREPARE, use a DEALLOCATE PREPARE statement that refers to the prepared statement name. Attempting to execute a prepared statement after deallocating it results in an error.

keyword return is only used in Function not procedure

keyword are case insensitive
can be used as calculator
enter multiple-statement on a single line, seperate with semicolon;
multi-line statement;
\c cancel the query
interpreter has 6 prompot type
text-file   \N (NULL),  column seperate by \t
mysql> LOAD DATA LOCAL INFILE '/path/pet.txt' INTO TABLE pet  LINES TERMINATED BY '\r\n';
Mac with '\r'; must have local file capability enabled
String comparisons normally are case-insensitive
AND and OR may be mixed
NULL is a special value that cannot be compared using the usual comparison operators.
where death IS NOT NULL
mysql> select month(date_add(curdate(), interval 1 month));
0 or NULL means false and anything else means true. The default truth value from a boolean operation is 1
it is entirely possible to insert a zero or empty string into a NOT NULL column
To find names containing exactly five characters, use five instances of the “_” pattern character
If you really want to force a REGEXP comparison to be case sensitive, use the BINARY keyword to make one of the strings a binary string.
SELECT * FROM pet WHERE name REGEXP '^.....$'; (match five characters)
SELECT * FROM pet WHERE name REGEXP '^.{5}$';

 Number of animals per combination of species and sex:
mysql> SELECT species, sex, COUNT(*) FROM pet GROUP BY species, sex;
If you want to get the interactive output format in batch mode, use mysql -t. To echo to the output the commands that are executed, use mysql -vvv.

SELECT MAX(article) AS article FROM shop;
SELECT article, dealer, price FROM   shop WHERE  price=(SELECT MAX(price) FROM shop);
SELECT article, MAX(price) AS price
FROM   shop
GROUP BY article;

 ALTER TABLE tbl AUTO_INCREMENT = 100;

 general query log file default name is host_name.log.

running multiple instances on one machine

Server SQL modes define what SQL syntax MySQL should support and what kind of data validation checks it should perform. This makes it easier to use MySQL in different environments and to use MySQL together with other database servers

The Thread Pool plugin provides an alternative thread-handling model designed to reduce overhead and improve performance.

If the value of a user variable is selected in a result set, it is returned to the client as a string.
If you refer to a variable that has not been initialized, it has a value of NULL and a type of string.
the order of evaluation for expressions involving user variables is undefined.
the default result type of a variable is based on its type at the start of the statement

A prepared statement is specific to the session in which it was created
If you terminate a session without deallocating a previously prepared statement, the server deallocates it automatically.


## Mysql 5.7.9
mysqld --initialize[-insecure]
random-password-file=$HOME/.mysql_secure or in /var/log/mysqld.log


mysql> set password for 'root'@'localhost'  =  Password('bbbb');
mysql> alter user 'root'@'localhost' identified by 'hehe';
mysql> LOCK TABLES t1 READ;

# 差集
mysql> select user from nn where user not in (select user from mysql.user) ;

character-set-server=utf8
max_prepared_stmt_count=0 (disable prepare statement function)

### Mysql NDB cluster 
#
#
# JSON datatype
JSON columns cannot have a default value.
JSON columns cannot be indexed

You can use SELECT ... INTO with user-defined variables. 
The same syntax can also be used inside stored routines using cursors and local variable

ALTER TABLE tbl_name MODIFY COLUMN col_name BIGINT;
RENAME TABLE tbl_name TO new_tbl_name, tbl_name2 TO new_tbl_name2;






sql 对大小写不敏感

TRIM(字串): 将所有字串起头或结尾的空白移除
LTRIM(字串): 将所有字串起头的空白移除.
RTRIM(字串): 将所有字串结尾的空白移除.

表,列,行,数据类型,Null,
主键primary key,可以有多个主键,Unique,Not Null

engine=innodb|memory|myisam|aria
Datatype:
1.string:
char:fixed-length 1-256 characters
enum:up to 64K string
text:max size 64K text 
mediumtext:max size 16K text;
longtext:up to 4G text;
tinytext:up to 255 byte;
set:up to 64 strings;
varchar:same as char
2.number
bit:1-64 byte
int:
bigint:
mediumint:
Real:4-byte floating values;
float:single-precision floating point 
double:double-precision floating point
decimal:可变精度浮点数
3.boolean:0 or 1
smallint:0-32767
tinyint:-128 127 or 256
4.data and time 
date:YYY-MM-DD
datetime:combination of date and time
time:HH-MM-SS
year:
5.binary datatype
blob:max length 64k
mediumblob:max length 16MB
longblob:max length 4GB
tinyblob:max length 256 bytes;


通配符: *  % _
REGEXP: . * + ? \\ | [123] [a-z] {n} {n,} {n,m}
fully qualified name;
注释:-- ,#
mariadb>\. filename 在交互模式下运行脚本

从show status输出的表查找信息
use database;
show tables;
describe table|show columns from table;

show status;show variables;
show create database mysql;show create table user;show grants
show errors;show warnings;

select column1,column2... from table;select * from table;
select distinct  :唯一的
select column1 from table limit 5;默认第一行为row0
select column1 from table limit 5,5;从第6行开始的持续5行
select column1 from table order by column1 desc;
select column1 from table where column2='sth'
select column1 from table where column2 between A and B
select column1 from table where column2 IS NULL
select column1 from table where column2='A' and|or column3='B'
select columns from table where column1 IN (start,end) | NOT IN
select columns from table where column1 like 'jet%'
select columns from table where column1 REGEXP 'string'
like 后跟的规则不加通配符的话表示完全匹配


1.text manipulation function
rtrim() ltrim() trim() upper() lower() left() length() locate() soundex()
substring() 
2.date and time manipulation funciton
adddate() addtime() curdate() curtime() date() datediff() date_add()
date_format() day() dayofweek() hour() minute() month() now() second() time()
year()
3.numeric manipulation funcitons
abs() cos() exp() mod() pi() rand() sin() sqrt() tan()
4.aggregate functions 集合,聚集
avg() count() max() min() sum()


data grouping
select id,count(*) from table group by id;


subquery


left join ;right join ;inner join

combined query: union

full-text search 
boolean-text search  

--------------------------------------
Insert:
full-insert,partial-insert,multiple-insert,insert a result of a query;
partial-insert 表的列必须允许NULL或者有默认值,否则不能部分插入
多插入insert into table values (1,2,3,4),(5,6,7,8)
将查询结果插入表,insert into table1 (column1,column2....)
select column1,column2... from table2
---------------------------------------
update
update table set column1='A' where column2='B'

------------------
delete
delete from table where column1='A'
一定以主键为选择标准,删之前可以用select看一下

mariaDB无法undo

auto_increment  相当于一个会变化的默认值,可不手动赋值

create table Table (
id int(8),name varchar(24) NOT NULL,
quality int(8) NOT NULL DEFAULT 1,
PRIMARY KEY (id));

DEFAULT 不能为函数,只能为常量->数字或字符串

在支持事物管理的引擎下创建的表,创建外键才有意义
a table using one engine cannot have a foreign key referring to a
table that uses another engine

------------------------
alter table :update the defination of table

Alter Table table Add column3 varchar(20)
Alter Table table Drop Column column1;
Alter 添加 Foreign Key
-----------------------------
Drop Table table; 与 Delete * from table的区别
------------------------
Rename Table table1 TO table1_backup,table2 TO table2_backup;

-----------------------
create index [type] on table(column)
---------------------
VIEW :其实只是一个query command,返回一个虚拟的表
new view 不能与table或其他view重名
Create View name;
Show Create View name;显示创建view的语句
Drop View name;
Create OR Replace View name;更新一个view

create view ST AS select Concat(RTrim(vend_name),'(',RTrim(vend_country),')')
AS vend_title From vendors Order By vend_name;
------------------------------
Stored Procedure

create procedure pro()
BEGEIN
select columns as name from table;
END;
delimiter //   声明界定符,delimiter ; 恢复默认
---------------
cursor
Declare name Cursor For select column from table;
open name;close name;
---------------
Trigger

trigger of Insert Delete Update
-----------
transaction : could only be used for Insert Delete Update
Transaction processing is used to maintain database integrity by ensuring that
batches of MariaDB SQL operations execute completely or not at all

MariaDB SQL statements are usually executed and written directly to the data-
base tables. This is known as an implicit commit—the commit (write or save)
operation happens automatically.
Within a transaction block, however, commits do not occur implicitly. To
force an explicit commit, the COMMIT statement is used

savepoint name;rollback to name;


set autocommite=0
----------------------
create user name;
drop user name;
Rename User name To another
Show Grants For name;
Set Password For name=Password('1234')
Set Password=Password("some");修改用户自己的密码
-------------------------
DataBase Maintaince

Analyze Table table;
Check Table table;

Diagnose startup problems;
Review Log Files;
------------------------
Improving performance

show processlist;Kill ID;

------------------
store engine
1.Innodb:支持事务处理,不支持full-text searching
2.Memory 等价于MyISAM,但数据存储在内存中,速度快,适合操作临时产生的表
3.MyISAM:支持full-text searching,性能高,但不支持事务处理
4.ARIA:支持事务处理,支持full-text searching,支持灾难恢复

不同的表可以有不同的存储引擎,但有外键的表必须存储引擎相同

show engine;查看支持的引擎
show table status like 'user';

---------------------------
mysqlbinlog --start-datetime='2015-06-05 00:00:00' --stop-datetime='2015-06-05 17:50:00' mysql-bin.000002
mysqlbinlog --start-position=764322 --stop-position=765150 mysql-bin.000002
------------------------
auto_increment_increment (默认间隔值)
auto_increment_offset   (默认起始值)
create table tb() AUTO_INCREMENT=100 (指定起始值)




## String function
substring_index(username, '@', 1)


## Multi Left Join
```



CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `user_info` (
  `id` int(11) NOT NULL,
  `uid` int(11) DEFAULT NULL,
  `location` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `content` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;



select * from user as a inner join article as b on (a.id = b.uid);

select user.name, article.content, user_info.location from user left join article on (user.id = article.uid) left join user_info on (user.id = user_info.id)

```
