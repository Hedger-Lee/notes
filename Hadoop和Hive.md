# Hadoop和Hive

HDFS  存储数据

MapReduce  计算数据

HIVE  编写脚本

Mysql  存储结构

Sqoop  抽取数据

## HDFS

> hadoop里面的分布式的文件系统

1. 查看文件系统的内容
   1.1 使用命令行方式查看

   ```shell
   hadoop fs -ls 文件系统的路径
   ```

   1.2 使用浏览器查看

   ```shell
   http://服务器的ip地址:50070
   ```

2. 上传本地文件到HDFS的服务器中

   ```shell
   hadoop fs -put 本地文件的路径 HDFS文件夹的路径和名字
   hadoop fs -put /usr/temp_file/u1.txt /tmp
   ```

3. 在HDFS目录中创建一个新的文件夹

   ```shell
   hadoop fs -mkdir 路径和文件夹的名字
   hadoop fs -mkdir /tmp/t1008
   ```

4. 在HDFS里面移动文件

   ```shell
   hadoop fs -mv HDFS源文件的名字 HDFS里面目标文件夹的名字
   ```

5. 给HDFS的文件修改权限

   ```shell
   hadoop fs -chmod 权限 文件的位置和名字
   hadoop fs -chmod 777 /tmp/t1008/t01.txt
   ```

6. 复制文件

   ```shell
   hadoop fs -cp HDFS源文件的名字 HDFS里面目标文件夹及文件的名字
   hadoop fs -cp /tmp/t1008/t01.txt
   ```

7. 删除文件

   ```shell
   hadoop  fs  -rm  文件的位置和名字
   hadoop fs -rm /tmp/t1008/t01.txt
   ```

8. 从服务器中下载文件到本地文件夹

   ```shell
   hadoop  fs  -get  HDFS文件的位置和名字  本地目标的文件夹名字
   hadoop fs -get /tmp/t1008/t02.txt /usr/aaa
   ```

HDFS的数据写入和读取：

NameNode：沟通用户和DataNode。

DataNode：管理数据的存储。

SecondaryNameNode：获取每一个DataNode的工作状态，然后将状态告知给NameNode。

1. HDFS的每一份数据都会保存三份

2. HADOOP里面，HDFS，如果是HADOOP 1.x的版本，每一份数据都是拆分成64M一份进行保存，HADOOP 2.x的版本，拆分成128M一份进行保存

3. 写入的过程和步骤：





**HIVE数据库的内容：**

Hive和关系型数据库（RDBMS）之间有什么区别？

存储部分    			HDFS				操作系统的fs

计算部分				MR					executor

索引					只有一个位图索引		有很多丰富的索引

约束条件				没有使用约束			有很多约束条件

计算延迟				高延迟				低延迟

存储内容				上TB上PB级的内容		最多上亿行的数据

语言					hql					sql

文件大小				对小文件不友好		数据越小查询越快

hive使用的窗口：

CLI窗口：命令行窗口

JDBC窗口：客户端窗口，DBeaver...

WEB UI：浏览器窗口

hive编写sql语句运行的逻辑：

如果是DDL语句：

去mysql元数据库中创建数据库对象的基本结构信息

如果是DML语句：

1.先去Mysql里面找表结构以及表所在的Hdfs的位置

2.根据位置将数据保存在hdfs中

如果是DQL语句：

1.将sql语句翻译成mr语法的模板

2.去Mysql找表结构，并且要找到这个表在hdfs里面的位置

3.去hdfs里面找数据

4.使用yarn进行资源的调配

5.运行mr的程序进行数据的计算和结果的整合

6.将结果显示在hive的界面中

hive的常见操作：

创建数据库：

create database 数据库名字;

删除数据库：

drop database 数据库名字;

查看现在有哪些数据库：

show databases;

进入数据库：

use 数据库名字;

查看当前数据库下面所有的表：

show tables;

创建表：

create table [if not exists] 表名(

列名 数据类型,

列名 数据类型,

...);

删除表：

drop table 表名;

查看建表信息：

show create table 表名;

显示当前数据库的名字：

set hive.cli.print.current.db=true;      --在当前窗口中临时生效

所有的开关配置，都在hive-site.xml中，需要永久生效的话，需要去修改配置文件中属性的value值。

表结构、数据类型和内容的映射关系添加：

数据类型：

数字  

整数  int

单精度小数  float

双精度小数  double 

自定义小数  decimal(总长度，小数精度)

字符串  string

日期类型  date     '2020-01-01'    一般日期还是用字符串表示比较多

复杂数据类型：

集合类型，类似于Python中的列表    array

映射类型，类型于python中的字典    map

**表数据添加的实验1：**

1.创建一个表

create table user01(

uid int,

uname string,

age int);

2.在linux里面创建一个文件，文件的内容和表结构一致

1001,lilei,18

1002,han,16

1003,mike,17

1004,tom,20

3.上传文件到表中

hadoop fs -put u1.txt /user/hive/warehouse/practice.db/user01

4.查看表格内容

select * from user01;

5.发现表的内容没有被完整的读取出来

**表数据添加的实验2：**

1.创建一个带有分隔符的表

create table user02(

uid int,

uname string,

age int)

row format delimited fields terminated by ',';

2.在linux里面创建一个文件，文件的内容和表结构一致

1001,lilei,18

1002,han,16

1003,mike,17

1004,tom,20

3.上传文件到表中

hadoop fs -put u1.txt /user/hive/warehouse/practice.db/user02

4.查看表格内容

select * from user02;

5.可以读取文档的数据

**表实验数据3：**

\1. 创建一个带有复杂数据类型的表格：

create table user03(

uid int,

uname string,

addr array)

row format delimited fields terminated by '\t'

collection items terminated by ',';

\2. 在linux创建一个文档

1	lilei	beijing,tianjing,jilin

2	han	shenzhen,guangzhou

3	tom	changsha,wuhan,hangzhou,shanghai

\3. 将文档上传到表格中

hadoop fs -put u2.txt /user/hive/warehouse/practice.db/user03

\4. 查询这个表格

select * from user03;

**表实验数据4：**

\1. 创建一个带有映射类型的表结构

create table user04(

uid int,

uname string,

score map)

row format delimited fields terminated by '\t'

collection items terminated by '#'

map keys terminated by '-';

\2. 在Linux里面创建一个有映射内容的表格

1	lilei	语文-89.3#数学-78.5#英语-68

2	han	语文-88#数学-96.4#英语-74.5

3	tom	语文-56.8#数学-80.5#英语-92

\3. 上传文件到表格

hadoop fs -put u3.txt /user/hive/warehouse/practice.db/user04

\4. 查看表格

表实验数据5：

\1. 创建一个没有分隔符的表格

create table user05(

uid int,

uname string,

age int);

\2. 在Linux中创建一个有默认分隔符的文档

1^Alilei^A18

2^Ahan^A17

3^Atom^A20

4^Alucy^A16

^A     ctrl+v  ctrl_a   这个分隔符叫做\u0001

\3. 上传文档

hadoop fs -put u4.txt /user/hive/warehouse/practice.db/user05

\4. 查看表格



内部表：

1.用create table 表名创建的表格，每个表格都会在hdfs里面自动的生成一个文件夹，这个表格在mysql元数据库中可以查询到表的名字和表的位置

2.drop table 表名，表会同时在hdfs和mysql中被删除，数据也同时被删除

3.先有表格，然后往表格中添加数据

外部表：

1.先已经有了数据文件，然后要创建一个表格去找这个数据

vim e1.txt

1001,lilei,shenzhen,18

1002,han,guangzhou,16

1003,tom,usa,20

创建一个hdfs的文件夹

hadoop fs -mkdir -p /datas/users_info

将文件上传到新文件夹中

hadoop fs -put e1.txt /datas/users_info

2.创建外部表的基本语法：

create external table 表名(

列名 数据类型

)

row format delimited fields terminated by '分隔符'

location '文件所在的hdfs的文件夹位置';

create external table users(

uid int,

uname string,

addr string,

age int)

row format delimited fields terminated by ','

location '/datas/users_info';

3.外部表不会生成新文件夹

4.mysql也会记录外部表的元数据

5.删除外部表的结构不会删除数据

6.内部表一般是存储统计和计算结果的表格，一定会使用内部表；

   存储业务信息的表格，内部和外部表格都可以；

   如果是日志信息和埋点数据，一般都是使用外部表。

**hive的表分区和分区表：每一个分区都是一个文件夹，上传的文件会放在符合规则的文件夹下面，目的是为了在搜索的时候减少搜索的数据**

**静态分区中的单分区：**

1.创建一个静态分区的表格：

create table 表名(

列名 数据类型

)partitioned by(新的字段名 数据类型)

row format delimited fields terminated by ',';

create table stu01(

sid int,

sname string,

sex string,

year string)

partitioned by (addr string)

row format delimited fields terminated by ',';

2.创建一个文件

1,lilei,男,1988

2,han,女,1987

3,tom,男,1990

4,jack,男,1990

5,tim,男,1989

6,lucy,女,1991

3.上传文件到表格中，并且要添加分区的字段信息

在hive的窗口中，输入下面的命令来上传文件：

load data local inpath 'linux文件的位置和名字' into table 数据库名字.表格名字 

partition(分区字段名=分区字段值);

load data local inpath '/root/test/s1.txt' into table practice.stu01 

partition(addr='shenzhen');

**静态分区中的多分区：多分区是父子级关系的分区**

create table stu02(

id int,

name string,

sex string,

year string)

partitioned by (sheng string, shi string, qu string)

row format delimited fields terminated by ',';

上传多分区表格的文件：

load data local inpath '/root/test/s1.txt' into table practice.stu02

partition(sheng='guangdong', shi='shenzhen', qu='baoan');

**动态分区: partition**

**原来已经有了一个表，这个表可能没有分区，但是数据量太大了不方便查询，所以希望给这个表添加分区，使用复制的方式，在复制表的过程中，去添加表的分区。**

1.创建旧表

create table stu_old(

id int,

name string,

sex string,

year string)

row format delimited fields terminated by ',';

2.创建一个新表，根据性别来对旧表进行分区

create table stu_new(

id int,

name string,

year string

)partitioned by (sex string)

row format delimited fields terminated by ',';

3.打开动态分区的开关

set hive.exec.dynamic.partition=true;

set hive.exec.dynamic.partition.mode=nonstrict;

4.复制表信息并且添加分区的内容

insert overwrite table stu_new partition(sex)

select id,name,year,sex from stu_old;

**给外部表创建分区表：**

create external table stu_ex(

sid int,

sname string,

sex string,

year string)

partitioned by (addr string)

row format delimited fields terminated by ','

location '/datas/stu_ex';

load data local inpath '/root/test/s1.txt' into table practice.stu_ex

partition(addr='sz');

**动态分区和静态分区的区别？**

**1.动态分区效率比静态分区要低**

使用静态分区的方法，去复制旧表的数据，并且添加分区结构

create table stu_new_2(

id int,

name string,

year string

)partitioned by (sex string)

row format delimited fields terminated by ',';

使用复制的方式，加上静态分区

insert overwrite table stu_new_2 partition(sex='f')

select id,name,year from stu_old where sex='f';

insert overwrite table stu_new_2 partition(sex='m')

select id,name,year from stu_old where sex='m';

**2.静态分区是手动指定的分区值和分区字段，动态分区的分区值是从另一张表的已存在的字段中读取出来的**

**查看表分区的内容:**

**show partitions 表名;**

**表格数据的分桶：cluster**

**使用hive里面的hash哈希算法，去帮你分配数据的分桶**

\1. 先打开Hive中的分桶开关：

set hive.enforce.bucketing=true;

\2. 创建分桶表

create table 表名(

列名 数据类型

)clustered by (表中已有的字段) into 4 buckets

row format delimited fields terminated by ',';

create table stu_clu(

id int,

name string,

sex string,

year string

)clustered by (id) into 4 buckets

row format delimited fields terminated by ',';

\3. 要准备一个和上表结构相同的临时表

create table tmp_stu_clu like stu_clu;

\4. 将文件的数据映射到临时表

hadoop fs -put s1.txt /user/hive/warehouse/practice.db/tmp_stu_clu

\5. 进行数据的复制，在复制的过程中添加分桶

insert overwrite table stu_clu

select * from tmp_stu_clu cluster by(id);

**一般在经常要表连接的列上面，所以分桶的目的就是为了加快表连接的速度。**

分桶的数量，在连接的两个表中，桶子数量要么是一样的，要么是整数倍数关系，才能有加快查询速度的效果。

分区和分桶的区别？

1.分区是partitioned by ，分桶是clustered by

2.分区字段是表中没有的字段，分桶字段是来自于原表

3.分区字段在hdfs里面是以文件夹的方式存在的，分桶字段是文件的方式存在的

**使用DBeaver连接hive数据库：**

**1.修改hadoop的配置文件core-site.xml，添加红框中的信息**

 ```
<property>
                <name>hadoop.proxyuser.root.hosts</name>
                <value>*</value>
        </property>
        <property>
                <name>hadoop.proxyuser.root.groups</name>
                <value>*</value>
        </property>
 ```

**2.安装DBeaver，创建新连接**

3.在linux服务器中启动hiveserver2的命令

4.在连接列表中右键点击“连接”就可以了

和oracle中不一样的函数：

**concat():不会限制拼接数据的数量**

concat(值，值，值...)

select concat('hello',123,'lilei','&&&&&&','8888');

**concat_ws('分隔符'，字符串，字符串，字符串...)：使用分隔符将字符串连接起来**

select concat('lilei','-',10,'-',2900,'-','CLERK');

select concat_ws('-','lilei','10','2900','cleak');

**rand():随机0-1之间的小数**

**获取当前系统时间：**

**select from_unixtime(unix_timestamp());**

select from_unixtime(unix_timestamp(),'yyyy-MM-dd HH:mm:ss');

**数据类型的转换：**

cast()：将数据转换成另一个类型

cast(数据  as  类型)

**取数的函数：**

tablesample(bucket 桶的序号 out of 桶的总数 on 分桶的列名)

select * from stu_clu tablesample(bucket 1 out of 4 on id);

DDL语句：

**create：**

create  [external]  table  [if  not  exists]  表名(

列名  数据类型

)

partitoned  by (没有的字段名 数据类型)

clustered  by (已有的字段名) into 数量  buckets

row  format  delimited  fields  terminated  by  '分隔符'

collection  items  terminated  by  '分隔符'

map  keys   terminated  by  '分隔符'

[location  'hdfs文件夹的位置'];

复制表的结构：

create  table  表a  like  表b;

**alter：**

表结构的修改

新增列

alter  table  表名  add  columns(列名  数据类型);

alter table stu_old add columns(mobile int);

alter table stu_old add columns(addr string, parents string);

修改列

alter  table  表名  change  旧列名  新列名  新的数据类型；

其它类型可以修改成字符串，但是字符串不能修改成其它类型

alter table stu_old change mobile phone string;

删除列

alter  table  表名  replace  columns(

列名  数据类型

);

重新写一遍表结构，哪一个没写，哪个就被隐藏了

表分区的修改

新增分区

alter  table  表名  add  partition(分区字段名=分区值);

alter table stu01 add partition(addr='qingyuan');

alter table stu02 add partition(sheng='hunan',shi='changsha',qu='yuhua');

删除分区

alter  table  表名  drop   partition(分区字段名=分区值);

alter table stu01 drop partition(addr='shenzhen');

**drop：**

drop  table  表名;

**truncate：**

truncate table 表名;

DML：

**insert：**

insert  into  表名  values(值);

复制数据：

insert  overwrite  table   表名  [partition (分区字段名)]

select  语句;

update和delete是不支持的操作

DQL：

select  *  from  表名;

hive只支持等值的连接查询：

select  *  from  a  join  b  on  a.xx=b.yy;

表格的存储格式：

所有的表格，默认的存储格式是：text

text：

create table s1(

tid int,

tname string

)stored as textfile;

特点：

\1. 表格的默认格式

\2. 行存储的方式

\3. textfile本身是没有任何压缩的

sequenceFile：

create table s2(

tid int,

tname string

)stored as sequencefile;

特点：

\1. 表格可以压缩：None  **Record**  Block

查看Hive数据库中表格的压缩格式：

set  mapred.output.compression.type;

set  mapred.output.compression.type=BLOCK;

RECORD是hive中的默认压缩格式，在工作中一般是选择使用BLOCK，BLOCK是一种压缩效率更高的压缩格式。

\2. 行存储的方式

rcFile：

create table s3(

tid int,

tname string

)stored as rcfile;

特点：

\1. rcfile是facebook创建的格式

\2. 也可以使用None  Record  Block，压缩效率比sequenceFile更高

\3. 列存储的格式

orcFile：

create table s4(

tid int,

tname string

)stored as orc;

特点：

\1. 是rcfile的升级版

\2. 压缩效率比rcfile更好

打开压缩表格的开关：

set  hive.exec.compress.output=true;

**sqoop的命令：**

**1. 查看某个对应数据库下用户所拥有的表格**

sqoop  list-tables  --connect  jdbc:oracle:thin:@oracle服务器所在的电脑的ip地址:1521/oracle数据库名字  --username  oracle数据库的用户名  --password  用户名对应的密码

sqoop list-tables --connect jdbc:oracle:thin:@192.168.2.135:1521/ORCL --username bigdata --password 111111

**2. 将oracle数据库的表格，抽取到hive数据库里面**

**使用sqoop进行数据的全量抽取**

sqoop  import  --hive-import  --connect jdbc:oracle:thin:@192.168.2.135:1521/ORCL --username bigdata --password 111111  --table  oracle里面的一张表的名字  --hive-database  hive里面的一个数据库的名字  --fields-terminated-by '分隔符'  -m 1

-m 1：当oracle要被抽取的表格没有主键的时候，就需要添加这个 -m 1 的选项

sqoop import --hive-import --connect jdbc:oracle:thin:@192.168.2.135:1521/ORCL --username bigdata --password 111111 --table EMP --hive-database practice --fields-terminated-by ',' -m 1

**3. 表格的增量更新**

**3.1 进行表格数据的追加**

A1  -->  hive表A中

A2  -->  hive表A中

A3  -->  hive表A中

....  -->  hive表A中

sqoop  import  --append  --connect  jdbc:oracle:thin:@oracle服务器所在的电脑的ip地址:1521/oracle数据库名字  --username  oracle数据库的用户名  --password  用户名对应的密码  --table  oracle数据库的表名  --target-dir  HDFS系统表格所在的文件夹位置和名字  --fields-terminated-by '分隔符'  -m 1

sqoop import --append --connect jdbc:oracle:thin:@192.168.2.135:1521/ORCL --username bigdata --password 111111 --table EMP_NEW_RE --target-dir /user/hive/warehouse/practice.db/emp --fields-terminated-by ',' -m 1

**3.2 同一个表格新增的内容，追加到hive表中    lastmodified**

sqoop  import  --connect  jdbc:oracle:thin:@oracle服务器所在的电脑的ip地址:1521/oracle数据库名字  --username  oracle数据库的用户名  --password  用户名对应的密码   --table  oracle数据库的表名   --target-dir  HDFS系统表格所在的文件夹位置和名字   --incremental append  --check-column  被检查的oracle中表的列名  --last-value  上一次新增数据的时候的值

A1  -->  hive表A中

A1  -->  hive表A中

sqoop import --connect jdbc:oracle:thin:@192.168.2.135:1521/ORCL --username bigdata --password 111111 --table EMP_NEW_RE --target-dir /user/hive/warehouse/practice.db/emp --incremental append --check-column EMPNO --last-value 1001 -m 1