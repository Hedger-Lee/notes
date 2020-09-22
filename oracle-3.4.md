# oracle-3|4

## 统计注意点

进行统计的时候，可以用count(列名)，也可以用count(1)，也可以用count(*)，

count(1)和count(*)，只要这一行，任何一列有数据，就会统计这一行的数量，两种方法是一样的。

count(列名)效率更高。

## 上卷函数`rollup()`

> 专门做最终的汇总统计的

```sql
select deptno,count(1) from emp group by rollup(deptno);
```

先对每个组分别做计算，然后最终对整个表做计算。

## 集合运算

### union all

> 将上下两个语句的结果进行拼接

```sql
select * from emp where sal<1000
union all
select * from emp where sal>3000;
```

### union

> 先将结果拼接，然后去除重复值

```sql
select job from emp where deptno=10
union
select job from emp where deptno=20;

select distinct job from emp where deptno=10 or deptno=20;
```

### intersect

> 取两个计算结果的交集

```sql
select job from emp where deptno=10
intersect
select job from emp where deptno=20;

--取出10和20部门都共有的工作岗位
select distinct job from emp where deptno=20 and job in
(select job from emp where deptno=10);
```

### minus

> 取第一个结果有的但是第二个结果没有的数据

```sql
select job from emp where deptno=20
minus
select job from emp where deptno=10;

select distinct job from emp where deptno=20 and job not in
(select job from emp where deptno=10);
```

```sql
--练习
--查询出emp表和dept表里面，平均工资最高的部门名称和上班地点
--流程：
--1.找出每个部门的平均工资
--2.平均工资里面最高的是多少钱
--3.要知道上面的结果是哪个部门的
--4.找出这个部门的名称和地点

select dname,loc from dept where deptno=
(select deptno from emp group by deptno
having avg(sal)=
(select max(s) from
(select deptno,avg(sal) s from emp group by deptno)));
```

## 逻辑处理

> sql语句的逻辑处理

### nvl()函数

> 专门处理空值的方法，当列的值为空的时候，设置一个默认值

```sql
nvl(列名, 如果列为空时的默认值)
nvl(comm, 0)
```

### nvl2()函数

> 专门处理空值的方法，当列为空或者不为空的时候，都单独设置显示结果

```sql
nvl2(列名, 不为空的处理, 为空的处理)

nvl2(comm, 12*sal+comm, 12*sal)
```

### decode()函数

> 对逻辑进行判断的方法

```sql
decode(列名, 判断条件, 条件为真的处理, 条件为假的处理)

decode(comm, null, '没有设置过奖金', '设置过奖金')

decode(列名, 判断条件1, 条件1为真的结果, 判断条件2, 条件2为真的结果, 所有条件都为假的结果)

decode(comm, null,  '没有设置过奖金', 0 , '没有奖金', '有奖金')

select 
emp.*,decode(job,'CLERK','普通职员','SALESMAN','销售员','MANAGER','经理','ANALYST','分析师','总经理')
from emp;
```

```sql
--练习：
--判断员工有没有上级领导，mgr为空就是没有上级

select emp.*,nvl(to_char(mgr),'没有上级') from emp;
select emp.*,nvl2(mgr,'有上级','没有上级') from emp;
select emp.*,decode(mgr,null,'没有上级','有上级') from emp;
```

### sign()函数

> 对一个数学表达式进行计算

```sql
sign(数字的计算)   
--计算结果为正数则等于1   负数则等于-1  零则等于0
```

#### 使用decode()+sign() 进行范围的逻辑判断

```sql
--如果sign(数字-1000)   
--如果结果=0，说明数字是1000，如果是1，数字大于1000，-1数字则小于1000

select 
sal,decode(sign(sal-2000)+sign(sal-3000),-2,'C',2,'A','B')
 from emp;
```

### 逻辑判断语句

```sql
case ... when ...

case 
  when 条件判断1  then  结果显示
  when 条件判断2  then  结果显示
  ...
  else  结果显示
end
```

```sql
--练习：思考题
--用decode判断，尝试给emp表的工资设置四个等级：
--1000以下的（D）  1000-1999之间的（C） 2000-2999之间的（B）  3000以上的（A）
select emp.*,
       case
         when sal<1000 then 'D'
         when sal>=1000 and sal<2000 then 'C'
         when sal>=2000 and sal<3000 then 'B'
         else 'A'
       end
 from emp;
```

```sql
--练习：创建下面的表和数据

create table chengji(

userid number,

score number,

course varchar2(20)

);

insert into chengji values(1,88,'语文');

insert into chengji values(2,54,'语文');

insert into chengji values(3,38,'语文');

insert into chengji values(4,87,'语文');

insert into chengji values(5,92,'语文');

insert into chengji values(1,75,'数学');

insert into chengji values(2,68,'数学');

insert into chengji values(3,25,'数学');

insert into chengji values(4,87,'数学');

insert into chengji values(5,14,'数学');

commit;

--1.查询出考试表中，及格和不及格的人数

select c,count(1) from

(select chengji.*,

​       case

​         when score<60 then '不及格'

​         else '及格'

​       end c

  from chengji) a

 group by c;
 
 select count(s) 及格, count(1) - count(s) 不及格
  from (select chengji.*,
               case
                 when score >= 60 then
                  1
                 else
                  null
               end s
          from chengji);

--2.查询出考试表中，每个课程中，及格和不及格的人数

select course,c,count(1) from

(select chengji.*,

​       case

​         when score<60 then '不及格'

​         else '及格'

​       end c

  from chengji) a

 group by course,c;
 
 select course, count(s) 及格, count(1) - count(s) 不及格
  from (select chengji.*,
               case
                 when score >= 60 then
                  1
                 else
                  null
               end s
          from chengji)
 group by course;

--3.平均成绩不及格和及格的人数

select c,count(1) from

(select userid,

​       case

​         when s<60 then 'bujige'

​         else 'jige'

​       end c

  from

(select userid,avg(score) s from chengji group by userid))

 group by c;
```

**注意点：关注sql语句执行的顺序，必须已经存在才能使用**



## 伪列

### rowid

> 主要的作用，去除掉表格中的重复数据；加快表格查询的速度

**rowid是什么**：每一行数据，都有存在于oracle数据库里面的唯一编号。

**去重的流程**：

将要去重的数据进行分组，找到每个组最小或者最大的rowid，将除了最小或者最大rowid的行数据都删除掉，剩下的就是去重之后的数据了

```sql
delete from dept where rowid not in

(select min(rowid) from dept group by deptno,dname,loc);
```

### rownum

> 主要的作用，数据的分页查询

**rownum是什么**：根据表的顺序，生成的一组从小到大的序号

```sql
--分页查询的应用，先将rownum那一行固定下来
select * from

(select emp.*,rownum r from emp)

 where r>=5 and r<=10;
```

```sql
--查询公司中工资最高的那个员工的姓名

select ename from

(select emp.* from emp order by sal desc) a

where rownum=1;
```

## 分析函数

> 核心是开窗函数 over()

### 聚合计算(over())

> over(partition by 分组字段 order by 排序字段)  开窗函数
>
> 开窗的作用，在原表中新增一列，用来存放计算结果

```sql
聚合函数()  over()  

select * from

(select emp.*,

​       max(sal) over(partition by deptno) m

  from emp)

 where sal=m;
```

**规律**

#### 只分组不排序

> 显示每个组的组内计算结果

```sql
select emp.*,

​       sum(sal) over(partition by deptno)

 from emp;
```

#### 不分组只排序

> 按照排序的列进行数据的累计运算

```sql
select emp.*,

​       avg(sal) over(order by empno)

 from emp;
```

#### 不分组不排序

> 计算整个表格某列的数据

```sql
select emp.*,

​       sum(sal) over()

 from emp;
```

#### 又分组又排序

> 在每个组内，按照排序的列，进行数据的累计运算

```sql
select emp.*,

​       sum(sal) over(partition by deptno order by hiredate desc)

 from emp;
```

```sql
--练习：查询出每个部门中，工资高于自己所在部门平均工资的员工名字和部门编号
select ename,deptno from
(select emp.*,
       avg(sal) over(partition by deptno) s
  from emp)
 where sal>s;
```

### 排名函数

#### row_number()

> 排名没有并列的数据

```sql
select emp.*,

​       row_number() over(partition by deptno order by sal desc) r

  from emp;
```

#### rank()

> 有并列的名次，并且会跳过占用的名次

```sql
select emp.*,

​       rank() over(partition by deptno order by sal desc) r

  from emp;
```

#### dense_rank()

> 有并列的名次，但是不会跳过占用的名次

```sql
select emp.*,

​       dense_rank() over(partition by deptno order by sal desc) r

  from emp;  
```

```sql
--综合性练习
--练习
create table t1(
tid number,
tname varchar2(5)
);
insert into t1 values(1,'/');
insert into t1 values(2,'A');
insert into t1 values(3,'B');
insert into t1 values(4,'C');
insert into t1 values(5,'/');
insert into t1 values(6,'D');
insert into t1 values(7,'E');
insert into t1 values(8,'/');
insert into t1 values(9,'F');
insert into t1 values(10,'G');
insert into t1 values(11,'H');
commit;
--将在'/'之间的行进行分组，每个区域为一组
select tid,tname,tid-r group_id
from
(select a.*,
       row_number() over(order by tid) r
  from
(select * from t1 where tname!='/') a);
--先选出没有'/'的表，然后使用排名函数row_number()，
--得到对应的排序，再将tid-排名即可得到对应的差值，差值为组名

select tid,tname,group_id
from
(select a.*,
       sum(c) over(order by tid) group_id
   from
(select t1.*,
       case
         when tname='/' then 1 else 0
       end  c
 from t1) a)
 where tname!='/';
--先将有'/'的那一行后面新增一列1，没有的为0，
--使用聚合函数累加效果，求出对应的组名，筛选去除'/'所在的行
```

### 数据平移

> 数据平移：一般在工作中是用来计算数据的同比和环比的

- lag(列名)  将列的数据往下挪一行

- lead(列名)  将列的数据往上挪一行

#### 同比

> 在几个不同周期内，对周期内相同的时间段进行数据的比较

```sql
--同比的数据计算：
select a.y,a.m,(a.amount-b.amount)/b.amount 增长率 from sales a join sales b on a.m=b.m and a.y=b.y+1;

select a.*,(amount-last_y)/last_y 增长率 from
(select sales.*,
       lag(amount) over(partition by m order by y) last_y
  from sales) a
 where last_y is not null;
```



#### 环比

> 在一个时间周期内，对相邻的时间段进行数据比较

```sql
--使用表连接的方法进行数据环比的计算：

select a.y,a.m,(a.amount-b.amount)/b.amount from sales a join sales b on a.m=b.m+1;

--使用lag()进行数据的下移，进行环比的计算

select a.*,(amount-last_m)/last_m from

(select sales.*,

​       lag(amount) over(order by m) last_m

  from sales) a;
```



```sql
create table sales(

y number,

m number,

amount number

);

insert into sales values(2019,1,123.12);

insert into sales values(2019,2,124.55);

insert into sales values(2019,3,126.56);

insert into sales values(2019,4,128.54);

insert into sales values(2019,5,112.89);

insert into sales values(2019,6,123.45);

insert into sales values(2019,7,129.68);

insert into sales values(2019,8,112.32);

insert into sales values(2019,9,119.54);

insert into sales values(2019,10,114.78);

insert into sales values(2019,11,112.32);

insert into sales values(2019,12,110.18);

commit;
```

## 行列转换

> 行展示的数据，转换成列展示的数据

### pivot()

> 使用流程：
>
> 先找出需要的数据，再在privot函数中进行分组聚合函数的操作，显示需要的列

**基本句型**：

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

```sql
--以列的方式展示部门平均工资：
select * from

(select deptno,sal from emp)

pivot(avg(sal) for deptno in (10,20,30));

--以列的方式展示及格和不及格人数：
select * from

(select userid,

​       case when score<60 then '不及格' else '及格' end s

  from chengji)

pivot(count(userid) for s in('及格','不及格'));


--使用case...when和聚合函数实现行转列的效果：
select 
       sum(case when score>=60 then 1 else 0 end) 及格,
       sum(case when score<60 then 1 else 0 end) 不及格 
  from chengji;

--计算emp表中每个部门里面，每个工作岗位的平均工资

select * from

(select deptno,job,sal from emp)

pivot(avg(sal) for job in ('CLERK','SALESMAN','MANAGER','PRESIDENT','ANALYST'));
```

```sql
--练习：
--有三个工资等级，小于2000是C，大于等于2000小于3000是B，大于3000是A，需要查询数据如下：
--A     B     C
--1     X     Y
select * from 
(select case when sal<2000 then 'C'
          when sal>=2000 and sal<3000 then 'B'
            else 'A' end c
  from emp
)pivot(count(c) for c in ('A','B','C'));

select 
       sum(case when sal<2000 then 1 else 0 end) C,
       sum(case when sal>=2000 and sal<3000 then 1 else 0 end) B,
       sum(case when sal>=3000 then 1 else 0 end) A
  from emp;
```

## 临时表

> 表里面的数据不是永久存在的

很大的表格进行表连接查询的时候，将每个表分开进行数据的筛选，将筛选的结果保存到临时表中，最后再对临时表的数据，进行表的连接。为了减少数据筛选和查询时候的数据量。

### 会话级临时表

> 本次登录的过程中，数据一直存在，如果重新登录，数据就消失了

```sql
create  global  temporary  table  临时表的名字(

列名 数据类型

)on  commit  preserve rows;


--创建emp的会话级临时表

create global temporary table tmp_emp(

empno number,

ename varchar2(30),

job varchar2(30),

mgr number,

hiredate date,

sal number,

comm number,

deptno number

)on commit preserve rows;
```

### 事务级临时表

> 操作了事务之后（commit,  rollback），数据就会消失

```sql
create global temporary table 临时表名字(

列名 数据类型

)on commit delete rows;



--创建emp的事务级临时表

create global temporary table tmp_emp_2(

empno number,

ename varchar2(30),

job varchar2(30),

mgr number,

hiredate date,

sal number,

comm number,

deptno number

)on commit delete rows;
```