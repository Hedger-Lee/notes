# Hive

**Hive和RDBMS之间的区别**

|          | Hive               | RDBMS                |
| -------- | ------------------ | -------------------- |
| 存储部分 | HDFS               | 操作系统的文件系统fs |
| 计算部分 | MR                 | Executor             |
| 索引     | 只有一个位图索引   | 有很多丰富的索引     |
| 约束条件 | 没有使用约束       | 有很多索引           |
| 计算延迟 | 高延迟             | 低延迟               |
| 存储大小 | 上TB级上PB级的内容 | 最多上亿行的数据     |
| 语言     | hql                | sql                  |
| 文件大小 | 对小文件不友好     | 数据越小查询越快     |

## hive编写sql语句运行的逻辑

1. DDL语句
   去mysql元数据库中创建数据库对象的基本结构信息
2. DML语句
   - 先去MySQL里面找到表结构以及表所在的HDFS中的位置
   - 根据位置将数据保存在HDFS中去
3. DQL语句
   - 将sql语句翻译成MR语法的模板
   - 去MySQL找表结构，并且找到这个表在HDFS中的位置
   - 去HDFS里面找数据
   - 使用yarn进行资源的调配
   - 运行MR的程序进行数据的计算和结果的整合
   - 将结果显示在hive的界面中

## hive的常见操作

1. 创建数据库
   `create database 数据库名字;`
2. 删除数据库
   `drop database 数据库名字;`
3. 查看现在有哪些数据库
   `show databases;`
4. 进入数据库
   `use 数据库名字;`
5. 查看当前数据库下所有的表
   `show tables;`
6. 查看建表信息
   `show create table 表名;`

## hive开关

> 所有的hive开关都在hive-site.xml文件中

1. 在命令行界面显示当前在哪个数据库
   `set hive.cli.print.current.db=true;`

2. 动态分区的开关

   ```
   set hive.exec.dynamic.partition=true;
   set hive.exec.dynamic.partiton.mode=nonstrict;
   ```

3. 分桶的开关

   ```
   set hive.enforce.bucketing=true;
   ```

4. 查看Hive数据库中表格的压缩格式

   ```
   set mapred.output.compression.type=None/Record/Block;
   ```

5. 打开压缩表格的开关

   ```
   set hive.exec.compress.output=true;
   ```

6. 查看mapjoin的开关有没有打开

   ```
   set hive.auto.convert.join=true;
   ```

   

## hive数据类型

### 数字

- 整数 int
- 单精度小数 float
- 双精度小数 double
- 自定义小数 decimal(总长度, 小数精度)

### 字符串

string

### 日期类型

date

### 集合类型

array

### 映射类型

map

## hive建表

1. 指定字段的分隔符
   `row format delimited fields terminated by ','`
2. 指定集合类型中的分隔符
   `collection items teminated by ','`
3. 指定映射类型中键和值之间的分隔符
   `map keys terminated by '-'`
4. 默认分隔符
   `^A  在vi编辑器中使用ctrl+V+A打印默认分隔符^A`

## 内部表和外部表

1. 内部表

   - 用create table 表名 创建的表格，每个表格都会在hdfs里面自动生成一个文件夹，这个表格在mysql元数据库中可以查询到表的名字和表的位置
   - drop table 表名 表会同时在hdfs和mysql中被删除，数据同时也会被删除
   - 先有表格，然后往表格中添加数据

2. 外部表

   > create external table 表名

   - 先有了数据文件，然后创建一个表格去找这个数据文件
     使用`location '文件在hdfs的文件夹的位置';`把表和数据文件联系起来，让表中存在数据
   - 外部表不会生成新文件夹
   - mysql也会记录外部表的元数据
   - 删除外部表的结构不会删除外部表的数据

3. 使用场景

   - 存储统计和计算结果的表格，用内部表
   - 存储业务信息的表格，内部表和外部表都可以
   - 存储日志和埋点信息，用外部表

## hive的分区和分桶

> 每一个分区都是一个文件夹，上传的文件会放在符合规则的文件夹下面，目的是为了在搜索的时候减少搜索的数据

### hive的分区

> 使用partitioned by(字段 数据类型, ...)指定按照哪个字段来进行分区

1. 静态分区

   - 创建静态分区表

   ```
   create table 表名(
   列名 数据类型
   )partitioned by(新字段 数据类型,...)
   ```

   - 静态分区的分区字段必须是原表中所没有的，在载入数据的添加分区字段的值，按照这个值来进行分区

   - 载入数据

     ```
     load data local inpath '本地文件路径' into table 数据库名字.表格名字 patition(分区字段名=分区字段值,...);
     ```

2. 动态分区

   > 原来已经有了一个表，这个表可能没有分区，但是数据量太大了不方便查询，所以希望给这个表添加分区，使用复制的方式，在复制的过程中，去添加表的分区

   旧表信息：

   ```
   create table stu_old(
   id int,
   name string,
   sex string,
   year string)
   row format delimited fields terminated by ',';
   ```

   分区表信息

   ```
   create table stu_new(
   id int,
   name string,
   year string,
   )partitioned by(旧表中的字段 数据类型)
   row format delimited fields terminated by ',';
   ```

   打开分区表的开关

   ```
   set hive.exec.dynamic.partition=true;
   set hive.exec.dynamic.partition.mode=nonstrict;
   ```

   复制表信息并且添加分区的内容

   在复制的过程中载入分区的信息

   ```
   insert overwrite table stu_new partition(sex) select id,name,year,sex from stu_old;
   ```

3. 静态分区和动态分区的区别

   1. 动态分区的效率比静态分区要低
   2. 静态分区是手动指定的分区值和分区字段
      动态分区的分区值是从另一张表已存在的字段中读取出来的

4. 查看表分区的内容

   ```
   show partitions 表名;
   ```

### hive的分桶

> 使用hive里面的哈希算法，去帮你分配数据的分桶

1. 使用分桶的流程
   1. 打开分桶开关

   ```
   set hive.enforce.bucketing=true;
   ```

   2. 创建分桶表

   ```
   create table 表名(
   列名 数据类型
   )clustered by(表中已有的字段) into buckets
   row format delimited fields terminated by ',';
   
   create table stu_clu(
   id int,
   name string,
   sex string,
   year string
   )clustered by (id) into 4 buckets
   row format delimited fields terminated by ',';
   ```

   3. 准备一个和上表结构相同的临时表
      `create table tmp_stu_clu like stu_clu;`

   4. 将文件的数据映射到临时表

   ```
   hadoop fs -put s1.txt HDFS中路径
   ```

   5. 进行数据的复制，在复制的过程中添加分桶

   ```
   insert overwrite table stu_clu select * from tmp_stu_clu cluster by(id);
   ```

2. 分桶的使用场景
   一般在经常需要表连接的列上面，所以分桶的目的是为了加快表连接的速度
   分桶的数量，在连接的两个表中，桶子数量要么是一样的，要么是整数倍数关系，才能有加快查询速度的效果。

### 分区和分桶的区别

1. 分区是partitioned by，分桶是clustered by
2. 分区字段是表中没有的字段，分桶字段是来自于原表

3. 分区字段在hdfs里面是以文件夹的方式存在的，分桶字段是文件的方式存在的

## hive中的函数

1. concat()
   拼接字符串，但是不会限制拼接数据的数量

   ```
   concat(值,值,...)
   ```

2. concat_ws('分隔符', 字符串, 字符串, ...)
   使用分隔符将一个个的字符串拼接起来

3. rand()
   随机0-1之间的小数

4. 获取当前系统时间

   ```
   select from_unixtime(unix_timestamp);
   select from_unixtime(unix_timestamp,'yyyy-MM-dd HH:mm:ss');
   ```

5. 数据类型的转换
   cast(数据 as 类型)

6. 取数的函数

   ```
   tablesample(bucket 桶的序号 out of 桶的总数 on 分桶的列名)
   ```

## 表格的存储格式

所有的表格，默认的格式是：text

1. text

   ```
   create table s1(
   tid int,
   tname string
   )stored as textfile;
   ```

   特点：

   1. 表格默认的存储格式
   2. 行存储的方式
   3. textfile本身是没有任何压缩的

2. sequencefile

   ```
   create table s2(
   tid int,
   tname string
   )stored as sequencefile;
   ```

   特点：

   1. 表格可以压缩
      压缩格式：None Record BLock
      RECORD是hive中的默认压缩格式，在工作中一般是选择使用BLOCK，BLOCK是一种压缩效率更高的压缩格式。
   2. 行存储的方式

3. rcfile

   ```
   stored as rcfile;
   ```

   特点：

   1. rcfile是Facebook创建的格式
   2. 压缩格式也可以是None Record Block，压缩效率比sequencefile更高
   3. 列存储的格式

4. orcfile

   ```
   stored as orc;
   ```

   特点：

   1. 是rcfile的升级版
   2. 压缩效率比rcfile更好

# HPLSQL

先启动hiveserver2服务

1. 直接在Linux命令行运行hive sql语句

   ```
   hplsql -e "sql语句"
   ```

2. 编辑.sql文件

   ```
   hplsql -f 文件名
   ```

## hplsql的函数

```
create function 函数名字(输入参数 数据类型)
returns 返回的数据类型
begin
  执行语句;
  return 返回值;
end;

使用函数
print 函数名字(值);
```

在begin里面声明变量

```
declare 变量名 数据类型;
declare n3 int;
```

为变量赋值

```
set 变量名=值;
```

游标的使用

```
for 变量名 in (select 语句) loop
    print 变量名.列名;
end loop;
```

## hplsql的存储过程

```
create procedure 过程名字(in 变量名 数据类型, out 变量名 数据类型)
begin
    执行语句;
end;

使用存储过程：
call 过程名(值);
```

***读取的表格字段的数字类型没有办法完成相加，相加结果为空***

***读取的表格数字字段，无法判断和相加***

***整数字段的读取没有问题，只有float和double有问题***

## if判断

```
 if n1>n2 then
    return n1;
  elsif n2>n1 then
    return n2;
  end if;
```

## 跨文件使用函数和存储过程

```
在a文件中编辑函数和存储过程，在b文件中：

include a文件的位置和名字

call a的过程();
print a的函数();
```

## hive的优化部分

### 数据倾斜的优化

**什么时候会发生数据倾斜？**

> 大小表连接、计算列中有空值、使用count(distinct 列名)

**数据倾斜的表现是什么？**

> reduce卡在99%

**怎么避免数据倾斜？**

**发生之后怎么去对数据倾斜的现象进行优化？**

**数据倾斜的表面现象**

> reduce卡在99%，无法结束任务

#### 1.表连接查询  大表 和 小表的连接

##### 第一种方法：mapjoin优化器

查看mapjoin的开关有没有打开：set hive.auto.convert.join=true;

select /*+ mapjoin(res_dept_zx) */ * from res_emp_zx a join res_dept_zx b on a.deptno=b.deptno;

将小表放入到mapjoin里面，通过优化器先把小表全部读入到内存里面。

##### 第二种方法

也可以将大表格拆分成多个小表格，和小表连接，最后进行结果的拼接。

拆分：

```
create table tmp1_emp  like  emp;

insert  overwrite table tmp1_emp select * from emp limit 10000;

create table tmp2_emp  like  emp;

insert  overwrite table tmp2_emp select * from emp limit 10000,10000;
```

拼接：

```
select * from tmp1_emp a join dept b on a.deptno=b.deptno

union all

select * from tmp2_emp a join dept b on a.deptno=b.deptno

union all

select * from tmp3_emp a join dept b on a.deptno=b.deptno;
```

#### 2.null值在查询的时候会产生数据倾斜

concat('null_', rand())

#### 3.count(distinct 字段名)

group by去重然后用count统计

select count(1) from (select a from table group by a);

#### 4.开关上的优化

```
聚合计算优化开关：set hive.map.aggr=true;

负载均衡开关：set hive.groupby.skewindata=true;

设置每一个reduce处理和计算的数据量大小：
set hive.exec.reducers.bytes.per.reducer=xxx;

设置启用的reduce的数量：
set hive.exec.reducers.max=xxx;
```

### 小文件过多的优化

**小文件从哪里来的？**

> 分区分桶会得到很多的小文件；

> 数据源本身就有很多小文件；

> reduce数量过多的时候。

**小文件过多的时候，为什么会影响到服务器性能？**

影响：

> 每一个文件，都需要一个jvm的进程去处理和执行，会造成资源的浪费，影响执行的效率；

> hdfs存储过多小文件，会造成硬盘资源的浪费。

**怎么调整和优化？**

1. 不要使用textfile存储数据

2. 通过开关来调节：

```
控制每个map端拆分数据的最大值大小：每个mapper可以拆分多大的数据
set mapred.max.split.size=xxx;

控制每一个处理数据节点的处理数据大小：每个mapper可以处理多大的数据
set mapred.min.split.size.per.node=xxx;

设置的合并的map端输出的数据：
set hive.merge.mapfiles=true;

设置的合并的reduce端输出的数据：
set hive.merge.mapredfiles=true;

设置合并后的数据的大小：低于该值就会合并
set hive.merge.size.per.task=xxx;

需要被合并的文件大小：低于这个值就需要合并
set hive.merge.smallfiles.avgsize=xxx;
```



外部表和内部表的区别？

什么时候用外部表？

什么时候用内部表？

分区和分桶的区别？

分区有哪些分区的方法？

动态分区和静态分区的区别？

为什么要分桶，分桶的好处是什么？

什么时候才能体现出分桶的效率优势？

表格有哪些不同的存储类型？项目中是用的哪一种？

为什么用上面那一种存储类型？

表格的压缩有哪些类型？怎么去设置表格的压缩？

工作中用的是哪种？为什么用这种？

在hive中的排名怎么使用？

hive的开窗函数有哪些？

获取当前的系统时间用什么方法？

什么时候会发生数据倾斜？

数据倾斜的表现是什么？

怎么避免数据倾斜？

发生之后怎么去对数据倾斜的现象进行优化？

小文件过多的优化怎么做？