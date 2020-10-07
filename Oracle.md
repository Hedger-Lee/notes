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

```sql
select * from 表名 where 精确条件;
```

#### 范围筛选

```sql
> =  <  <=  !=
```

#### 逻辑筛选

```sql
and  or  not
```

#### 包含筛选

```sql
in
between ... and ... --左右都是闭区间
```

```sql
select * from emp where sal>=1000 and sal<=3000;  
--等于下面的句子
select * from emp where sal between 1000 and 3000;
```

#### 空值筛选

```sql
is null
is not null
```

### 2.1.2 模糊查询

> like

#### 通配符

```sql
--  %  通配符  表示0-N个任意字符
--  _   通配符  表示1个任意字符
```

#### 转义符

```sql
escape 指定转义符
select * from emp where ename like '%\%%' escape '\';
```

## 2.2 单行函数

### 2.2.1 数字相关

#### 四舍五入

```sql
round(数字, 小数精度)
```

#### 数字截取

```sql
trunc(数字, 小数精度)
```

- 绝对值  `abs(数字)`
- 向下取整  `floor(数字)`

- 向上取整  `ceil(数字)`

- 幂运算      `power(数字, 次方)`

- 取余数运算    `mod(数字, 除数)`

### 2.2.2 字符串相关

#### 截取字符串

```sql
substr(字符串, 开始位置, 连续长度)
```

#### 拼接字符串

```sql
concat(str1, str2)
str1 || str2
```

- 计算字符串的字符个数   `length(字符串)`

- 字符串内容的替换  `replace(字符串, 要被替换的内容，替换后的新内容)`

- 去除左右两边的空格 ` trim()    ltrim()    rtrim()`

- 填充内容  `lpad()   rpad()`

### 2.2.3 时间相关

#### 当前系统时间

```sql
sysdate
```

#### 月份偏移

```sql
add_months(时间, 月的数量)
```

#### 时间间隔

```sql
months_between(时间1, 时间2) --时间1-时间2
```

### 2.2.4 类型转换

#### 转成字符串

```sql
to_char()
--处理时间时
yyyy - 年
mm   - 月
dd   - 日
hh   - 时
mi   - 分
ss   - 秒
day  - 星期几
```

#### 转成数字

```sql
to_number()
```

#### 转成时间

```sql
to_date('时间字符串', '时间字符串的规则')
```

## 2.3 分组聚合排序

### 2.3.1 分组

```sql
group by
```

### 2.3.2 聚合函数

#### 数据统计

```sql
count()
```

#### 求和

```sql
sum()
```

#### 最大值最小值

```sql
max()
min()
```

#### 平均值

```sql
avg()
```

### 排序

```sql
order by
```

## 2.4 SQL语句查询的顺序

```sql
select 列,聚合函数(列)							 5
from 表											1
where 筛选									   2
group by 列										3
having 筛选									   4
order by 列 asc/desc								6

1.先找到表from，从哪个表里面查
2.进行where筛选，分组前的筛选
3.分组group by
4.进行having筛选，分组后的筛选
5.查询需要的内容，列或者聚合函数后的值
6.排序order by
```

## 2.5 多表查询

### 2.5.1 子查询

> 嵌套查询：将一个表格的查询结果，当成另一个表格查询的条件。

#### 子查询中关键字

##### all

> 大于最大的，小于最小的

##### any

> 大于最小的，小于最大的

### 2.5.2 联合查询

#### 内连接

> (inner) join
>
> 可以省略inner，查询两张表符合条件的共同部分

#### 左连接

> left join
>
> 显示两个表格的共同数据，然后显示左边表的数据

#### 右连接

> right join
>
> 显示两个表格的共同数据，然后显示右边表的数据

#### 全连接

> full join
>
> 显示两个表格的共同数据，然后分别显示左边和右边表的数据

#### 连接时and和where的区别

> 使用and时，先进行筛选字再进行表连接
>
> 使用where时，先进行表连接再进行筛选

# 3.结果处理

## 3.1 函数相关

### 3.1.1 统计上卷函数

> rollup()
>
> 专门做最终的汇总统计
>
> 先对每个组分别做计算，然后最终对整个表做计算

## 3.2 集合运算

### 3.2.1 union all

> 将两个查询语句的所有结果进行拼接

### 3.2.2 union

> 先将结果拼接，再去除重复值
>
> 并集

### 3.2.3 intersect

> 取两个查询结果的交集

### 3.2.4 minus

> 取第一个结果有的但是第二个结果没有的数据

## 3.3 逻辑处理

### 3.3.1 空值处理

#### nvl()

> 专门处理空值的方法，当列的值为空的时候，设置一个默认值

```sql
nvl(列名,如果列为空时的默认值)
```

#### nvl2()

> 专门处理空值的方法，当列为空或者不为空的时候，都单独设置显示结果

```sql
nvl2(列名,不为空的处理,为空的处理)
```

### 3.3.2 逻辑判断

#### decode()

> 逻辑判断函数

```sql
decode(列名,判断条件1,条件1为真的结果,判断条件2,条件2为真的结果...,所有条件为假的结果)
```

#### sign()

> 计算一个数学表达式

```sql
sign(数字计算)
计算结果为正数则等于1   负数则等于-1  零则等于0
```

#### decode()+sign()逻辑判断

```sql
如果sign(数字-1000)   
如果结果=0，说明数字是1000，如果是1，数字大于1000，-1数字则小于1000
```

#### case...when...

> 逻辑判断语句

```sql
case 
  when 条件判断1  then  结果显示
  when 条件判断2  then  结果显示
  ...
  else  结果显示
end
```

## 3.4 伪列

### 3.4.1 rowid

> 每一行数据，都有存在于oracle数据库里面的唯一编号。

#### 使用rowid进行去重

> 将要去重的数据进行分组，
>
> 找到每个组最小或者最大的rowid，
>
> 将除了最小或者最大rowid的行数据都删除掉，
>
> 剩下的就是去重之后的数据了

```sql
delete from dept where rowid not in
(select min(rowid) from dept group by deptno,dname,loc);
```

### 3.4.2 rownum

> 根据表的顺序，生成的一组从小到大的序号

#### 使用rownum进行分页查询

```sql
--分页查询的应用，先将rownum那一行固定下来
select * from
(select emp.*,rownum r from emp)
 where r>=5 and r<=10;
```

## 3.5 分析函数

> 核心：开窗函数over()

```sql
over(partition by 分组字段 order by 排序字段)
```

### 3.5.1 聚合计算

> 使用聚合函数加上开窗函数，计算出一列新的数据

### 3.5.2 排名函数

#### row_number()

> 排名不存在相同并列的名次
>
> 即使两个的结果相同，排名也分前后

#### rank()

> 排名存在并列的名次
>
> 当两个结果相同时，名次也相同，然后会下个名次会跳过

#### dense_rank()

> 排名存在并列的名次
>
> 当两个结果相同时，名次也相同，然后会下个名次会继续被使用，不会跳过

### 3.5.3 数据平移

> 将数据向上或者向下挪动一行
>
> lag(列名)  将列的数据往下挪一行
>
> lead(列名)  将列的数据往上挪一行

#### 同比计算

> 在几个不同周期内，对周期内相同的时间段进行数据的比较

```sql
--使用表连接的方法进行数据同比的计算
select a.y,a.m,(a.amount-b.amount)/b.amount 增长率 from sales a join sales b on a.m=b.m and a.y=b.y+1;

--使用lag()进行数据的下移，进行同比的计算
select a.*,(amount-last_y)/last_y 增长率 from
(select sales.*,
       lag(amount) over(partition by m order by y) last_y
  from sales) a
 where last_y is not null;
```

#### 环比计算

> 在一个时间周期内，对相邻的时间段进行数据比较

```sql
--使用表连接的方法进行数据环比的计算
select a.y,a.m,(a.amount-b.amount)/b.amount from sales a join sales b on a.m=b.m+1;

--使用lag()进行数据的下移，进行环比的计算
select a.*,(amount-last_m)/last_m from
(select sales.*,
       lag(amount) over(order by m) last_m
  from sales) a;
```

## 3.6 行列转换

> 行展示的数据，转换成列展示的数据

### pivot()

> 先找出需要的数据，
>
> 再在privot函数中进行分组聚合函数的操作，
>
> 显示需要的列

```sql
select * from 
(select 需要的数据的列 from 原来的表格名)
pivot(
聚合函数(列名) 
    for 
分组的列名 
    in 
(新的列名1,新的列名2...)
);
```

## 3.7 临时表

> 表里面的数据不是永久存在的

```sql
很大的表格进行表连接查询的时候，
将每个表分开进行数据的筛选，
将筛选的结果保存到临时表中，
最后再对临时表的数据，进行表的连接。
为了减少数据筛选和查询时候的数据量。
```

### 3.7.1 会话级临时表

> 本次登录的过程中，数据一直存在，如果重新登录，数据就消失了

```sql
create  global  temporary  table  临时表的名字(
列名 数据类型
)on  commit  preserve rows;
```

### 3.7.2 事务级临时表

> 操作了事务之后（commit,  rollback），数据就会消失

```sql
create global temporary table 临时表名字(
列名 数据类型
)on commit delete rows;
```

# 4.内部存储机制

## 4.1 事务

> 处理数据的最小的功能模块

```sql
begin
	执行语句;
end;
```

### 4.1.1 事务的特征

#### 原子性

## 4.2 锁

## 4.3 表分区

## 4.4 同义词

## 4.5 序列

## 4.6 视图

## 4.7 物化视图

# 5.索引



# 6.数据库优化

# 7.SQL编程基础

# 8.游标

# 9.封装处理

# 10.数据的转移

