# 1.SQL基础

## 1.1 SQL语句分类

### 1.1.1 DCL

> 数据控制语句，跟用户权限相关

#### grant

```sql
--权限赋予
grant 权限 to 用户;

--权限：
connection:连接和登录数据库
resource:代码编写
dba:管理员权限
```

- revoke

### 1.1.2 DDL

> 数据定义语句，基本格式`关键字 table 表名 操作`

#### create

###### 创建用户

```sql
create user 用户名 identified by 密码;
```

#### drop

###### 删除表格

```sql
drop table 表名;
```

#### alter

```sql
alter table 表名 对应操作
```

##### 修改表结构

###### 新增一列

```sql
alter table 表名 add 列名 数据类型 约束条件;
```

###### 删除一列

```sql
alter table 表名 drop column 列名;
```

###### 修改列属性

```sql
alter table 表名 modify 列名 数据类型 约束条件;
```

###### 重命名列

```sql
alter table 表名 rename column 原列名 to 新列名;
```

###### 修改表名

```sql
alter table 表名 rename 新表名;
```

##### 修改约束条件

###### 新增约束

```sql
alter table 表名 add constraint 约束名 约束类型(字段);
--检查约束
alter table 表名 add constraint 约束名 check(条件);
--外键约束
alter table 表名 add constraint 约束名 foreign key(字段) references 另一个表名(主键列名);
```

###### 删除约束

```sql
alter table 表名 drop constraint 约束名;
```

- rename

#### truncate

###### 清空表数据

```sql
truncate table 表名
```

### 1.1.3 DML

> 数据操纵语句，对数据库进行增删改

#### insert

```sql
--插入
insert into 表 values(字段);
```

#### update

```sql
--更新
update 表 set 字段=新值;
```

#### delete

```sql
--删除
delete from 表 where 筛选条件;
```

### 1.1.4 DQL

> 数据查询语句，查询数据

#### select

```sql
select 聚合函数(字段) from 表名 where 筛选 group by 分组字段 order by 排序字段;
```

### 1.1.5 TCL

> 事务控制语句

- savepoint
- commit
- rollback

## 1.2 SQL数据类型

### 1.2.1 数字类型

#### Integer

> 只能表示整数

#### number

> 可以表示整数和小数

### 1.2.2 字符串类型

#### char

> 定长字符串，最大长度2000

#### varchar2

> 不定长字符串，最大长度4000

### 1.2.3 时间日期

#### date

### 1.2.4 大文件格式

> 最大可以存储4GB大小的文件

#### CLOB

> 存储文本信息

#### BLOB

> 存储二进制信息

## 1.3 约束

### 1.3.1 主键约束

#### primary key

> 唯一存在的而且不能为空，一个表格只能有一个主键

### 1.3.2 唯一约束

#### unique

> 可以为空不能重复

### 1.3.3 非空约束

#### not null

> 不能为空可以重复

### 1.3.4 检查约束

#### check

> 限制了输入的范围

### 1.3.5 外键约束

#### foreign key

> A表的某一列的数据，必须来自于B表中主键的数据

## 1.4 批量处理

### 1.4.1 create表复制

#### 复制表结构和表数据

```sql
create table 表名 a as select * from 另一个表b;
```

#### 只复制表结构

```sql
create table course_4 as select * from course where 1=2;
--where 后面接一个值为false的式子
```

### 1.4.2 insert表复制

```sql
insert into 表名a select * from 另一个表b;
```

## 1.5 delete和truncate的区别

```sql
1.delete是DML语句，可以提交和回滚操作
  truncate是DDL语句，不能回滚数据
2.delete在删除时可以筛选数据，truncate只能针   对整个表删除数据
3.truncate在删除大表很多数据的时候，效率比     delete要快
4.delete是以行为单位进行删除，一行一行的删，
  truncate是针对表结构层次的数据删除
```

# 2.查询相关

## 2.1 筛选

### 2.1.1 where筛选

#### 精确筛选

#### 范围筛选

#### 逻辑筛选

# 3.结果处理

## 3.1 函数相关

## 3.2 逻辑处理

# 4.内部存储机制

# 5.索引

# 6.数据库优化

# 7.SQL编程基础

# 8.游标

# 9.封装处理

# 10.数据的转移

