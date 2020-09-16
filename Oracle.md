# Oracle

> RDBMS:关系型数据库

## SQL

### 1.分类

- DCL：数据控制语句

  - grant 授权
  - revoke 回收权限

- DDL：数据定义语句

  - create 创建
  - alter 修改表结构
  - drop 删除表中的数据和结构，删除后不能回滚
  - rename 修改表名或列名
  - truncate 删除表中的数据不删除表结构，删除后不能回滚，效率比delete要高

- DQL：数据查询语句

  - select 查询

- DML：数据操纵语句

  - insert 插入
  - update 更新
  - delete 删除(删除数据不删除表结构，删除后可以回滚)

- TCL：事务控制语句

  - savepoint 保存点

  - rollback 回滚

  - commit 提交

### 2.角色

- 超级管理员 sys

- 普通管理员 system

- 普通账号

#### 2.1创建用户

```SQL
create user 用户名 identified by 密码;

create user hedger identified by 123456;
```

#### 2.2赋予权限

```SQL
grant 权限 to 用户;
grant connect,resource,dba to hegder;
```

- connect：连接和登录数据库

- resource：写代码

- dba：管理数据库

### 3.数据类型

#### 3.1数字

##### 3.1.1 integer

> 整数

##### 3.1.2 number

> 整数或小数

###### 3.1.2.1 整数

> 当不指定小数部分时，为整数

###### 3.1.2.2 小数

```SQL
number(总长度,小数部分长度)
number(4,2) 
```

#### 3.2字符串

##### 3.2.1定长字符串

> 此类型的最大长度是2000

```sql
char(长度)
```

应用场景：身份证号，手机号。。。

##### 3.2.2不定长字符串

> 此类型的最大长度为4000

```sql
varchar(最大长度)
```

应用场景：邮箱，地址，备注，评价。。。

#### 3.3日期时间

```sql
date

--插入日期格式
date'2020-09-14'
to_date('2014-02-14','yyyy-mm-dd')
to_date('2014-02-14 20:47:00','yyyy-mm-dd hh24:mi:ss')
```

#### 3.4大文件格式

> 最大可以存储4GB大小的文件

##### 3.4.1 CLOB

> 文字信息的大文件格式

应用场景：存储文本信息

##### 3.4.2 BLOB

> 二进制文件的大文件格式

应用场景：存储图片，视频，音乐。。。

### 4.约束条件

#### 4.1 主键约束

> 唯一存在的而且不能为空，一个表格只能有一个主键

```sql
primary key
```

#### 4.2 唯一约束

> 可以为空不能重复

```sql
unique
```

#### 4.3 非空约束

> 不能为空可以重复

```sql
not null
```

#### 4.4 检查约束

> 限制了输入的范围

```sql
check

--示例
create table stu_info_2(
stuid integer primary key,
sname varchar2(12) not null,
mobile char(11) unique,
ssex char(3) check(ssex='男' or ssex='女'),
study_time date,
stu_height number(4,2) check(stu_height>=0.8 and stu_height<=2.5)
);
```

#### 4.5 外键约束

> A表的某一列的数据，必须来自于B表中主键的数据

```sql
foreign key

--示例
create table class_info(
cid integer primary key,
cname varchar2(20) not null,
teacher varchar2(20)
);

create table stu_info_3(
stuid integer primary key,
sname varchar2(20) not null,
class_id integer,
mobile char(11) unique,
foreign key(class_id) references class_info(cid)
);
```

### 5.修改 alter

#### 5.1修改表结构

##### 5.1.1新增一列

```sql
alter table 表名 add 列名 数据类型 约束条件;
alter table stu_info add addr varchar2(100) not null;
```

##### 5.1.2删除一列

```sql
alter table 表名 drop column 列名;
alter table stu_info drop column addr;
```

##### 5.1.3修改列的属性

```sql
alter table 表名 modify 列名 数据类型 约束条件;
alter table stu_info modify mobile integer;
```

##### 5.1.4重命名列

```sql
alter table rename column 原列名 to 新列名;
alter table stu_info rename column mobile to phone;
```

##### 5.1.5修改表名

```sql
alter table 表名 rename 新表名;
alter table stu_info rename student_info;
```

#### 5.2修改约束条件

##### 5.2.1新增约束

###### 5.2.1.1新增主键约束 

```sql
alter table 表名 add constraint pk_列名 primary key(列名);
alter table student_info add constraint pk_stuid primary key(stuid);
```

###### 5.2.1.2新增唯一约束

```sql
alter table 表名 add constraint uni_列名 unique(列名);
alter table student_info add constraint uni_phone unique(phone);
```

###### 5.2.1.3新增非空/检查约束

```sql
alter table 表名 add constraint ck_列名 check(条件);
alter table student_info add constraint ck_sname check(sname is not null);
alter table student_info add constraint ck_ssex check(ssex='男' or ssex='女');
```

###### 5.2.1.4新增外键约束

```sql
alter table 表名 add constraint fk_另一个表名_列名 foreign key(列名) references 另一个表名(主键列名);
alter table student_info add constraint fk_classinfo_classid foreign key(class_id) references class_info(cid);
```

##### 5.2.2删除约束

```sql
alter table 表名 drop constraint 约束名;
alter table student_info drop constraint sys_c0011063;
```

### 6.DML三条语句

> DML的数据操作，一定是需要commit提交数据，或者是rollback回滚数据。

#### 6.1 insert

```sql
insert into 表名 values(值1,值2...);
insert into class_info values(1001,'一年一班','陈老师');

insert into 表名(列名1,列名2...) values(值1,值2...);
insert into class_info(cid,cname) values(1004,'一年四班');
```

#### 6.2 update

```sql
update 表名 set 列名=新值 where 列名=旧值;
update class_info set teacher='周老师' where cid=1001;
--用where进行行数据的筛选，用set去重新设置这个列的内容
```

#### 6.3 delete

```sql
delete from 表名;             --删除整个表格的数据
delete from student_info;

delete from 表名 where 列名=值;      --删除对应的行的数据
delete from class_info where cid=1002;
```

### 7.批量处理

#### 7.1 create进行复制

##### 7.1.1 复制表结构和表数据

```sql
create table 表名a as select * from 另一个表b;
create table course_2 as select * from course;
```

##### 7.1.2 只复制表结构

```sql
create table course_4 as select * from course where 1=2;
--where 后面接一个值为false的式子
```

#### 7.2 insert复制表数据

```sql
--当表已经存在的时候，往已经存在的表，复制其他表的数据：
insert into 表名a select * from 另一个表b;
insert into teacher2 select * from teacher;
```

### 8.清空表的两种方法

- delete from 表名;
- truncate 表名;

#### delete和truncate的区别

```
1.delete是DML语句，可以提交和回滚操作
  truncate是DDL语句，不能回滚数据
2.delete在删除时可以筛选数据，truncate只能针对整个表删除数据
3.truncate在删除大表很多数据的时候，效率比delete要快
4.delete是以行为单位进行删除，一行一行的删，
  truncate是针对表结构层次的数据删除
```



**涉及SQL语句**：

```SQl
create user hedger identified by 123456;

grant connect,resource,dba to hedger;

create table stu_info(
stuid integer,
sname varchar2(12),
mobile char(11),
ssex char(3),
study_time date,
stu_height number(4,2)
);

alter table stu_info add addr varchar(100) not null;

alter table stu_info drop column addr;

alter table stu_info modify mobile integer;

alter table stu_info rename column mobile to phone;

alter table stu_info rename to student_info;

create table stu_info_2(
stuid integer primary key,
sname varchar2(12) not null,
mobile char(11) unique,
ssex char(3) check(ssex='男' or ssex='女'),
study_time date,
stu_height number(4,2) check(stu_height>=0.8 and stu_height<=2.5)
);


create table class_info(
cid integer primary key,
cname varchar2(20) not null,
teacher varchar2(20)
);

create table stu_info_3(
stuid integer primary key,
sname varchar2(20) not null,
class_id integer,
mobile char(11) unique,
foreign key(class_id) references class_info(cid)
);



--新增约束
alter table student_info add constraint pk_stuid primary key(stuid);

alter table student_info add constraint uni_phone unique(phone);

alter table student_info add constraint ck_sname check(sname is not null);

alter table student_info add class_id integer;
alter table student_info add constraint fk_classinfo_classid 
foreign key(class_id) references class_info(cid);

--删除约束
alter table stu_info_3 drop constraint sys_c0011061;




--练习：
--新建两张表，并且往表中添加数据
--老师表teacher
--tid	tname
--1	陈老师
--2	周老师
--3	袁老师
--tid是整数（主键），tname是不定长字符串（非空）

--课程表course
--coid	cname	teacher_id
--1	生物		1
--2	体育		
--3	物理		2
--coid是整数（主键），cname是不定长字符串（非空），teacher_id是整数，teacher_id是tid列的外键。
select * from class_info;

insert into class_info values(1001,'一年一班','陈老师');
insert into class_info(cid,cname,teacher) values(1002,'一年二班','李老师');
insert into class_info(cid,cname) values(1003,'一年三班');

update class_info set teacher='周老师' where cid=1001;

delete from class_info where cid=1002;



--练习
create table teacher(
tid integer primary key,
tname varchar2(20) not null
);

insert into teacher values(1,'陈老师');
insert into teacher values(2,'周老师');
insert into teacher values(3,'袁老师');

select * from teacher;

create table course(
coid integer primary key,
cname varchar2(20) not null,
teacher_id integer,
foreign key(teacher_id) references teacher(tid)
);

insert into course values(1,'生物',1);
insert into course(coid,cname) values(2,'体育');
insert into course values(3,'物理',2);

select * from course;

--练习：
--1.新建一个SALGRADE表，表结构和SCOTT.SALGRADE一样，用传统的建表方法；
scott.salgrade
create table salgrade(
grade number,
losal number,
hisal number
);
--2.再新建一个SALGRADE2表，用快速的建表方法，
--把SELECT * FROM SCOTT.SALGRADE 的表结构和数据都复制过来；
create table salgrade2 as select * from scott.salgrade;
select * from salgrade2;
--3.再新建一个SALGRADE3表，用快速的建表方法，
--仅把SELECT * FROM SCOTT.SALGRADE 的表结构复制过来；
create table salgrade3 as select * from scott.salgrade where 1=2;
select * from salgrade3;
--4.删除SALGRADE2表；
drop table salgrade2;
--5.把SALGRADE3表的三个列的列名分别改为A1,A2,A3;
alter table salgrade3 rename column grade to A1;
alter table salgrade3 rename column losal to A2;
alter table salgrade3 rename column hisal to A3;
--6.给SALGRADE3新增一列，列名为A4，类型为NUMBER；
alter table salgrade3 add A4 number;
--7.把SALGRADE3表的A4列改为VARCHAR2(10)类型；
alter table salgrade3 modify A4 varchar2(10);
--8.用INSERT的方法将SCOTT.SALGRADE表的数据复制到SALGRADE表中。
insert into salgrade3(A1,A2,A3) select * from scott.salgrade;


--练习：
--1.用快速建表语句建立EMP2表，表结构和EMP表一致，不需要复制数据；
scott.emp
create table emp2 as select * from scott.emp where 1=2;
--2.给批量插入的方法，把EMP表的数据插入到EMP2表；
insert into emp2 select * from scott.emp;
select * from emp2;
--3.把EMP2表10号部门的员工的奖金，更新为工资的百分之二十；
update emp2 set comm=sal*0.2 where deptno=10;
--4.删除EMP2表岗位为CLERK的员工的信息；
delete from emp2 where job='CLERK';
```

