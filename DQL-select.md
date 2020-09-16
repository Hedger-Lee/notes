# DQL-select

> 数据查询语句
>
> 基本句型：`select * from 表名;`

挑选部分列：

```sql
select 列名,列名... from 表名;
select empno,ename,sal from emp;
```

## 1.筛选行

### 1.1 精确筛选

```sql
select * from 表名 where 精确条件;
select * from emp where deptno=10;
```

### 1.2 范围筛选

> `> =  <  <=  !=`

```sql
select * from emp where deptno!=10;
select * from emp where sal>3000;
select * from emp where sal>=3000;
```

### 1.3 逻辑筛选

> and  or  not

```sql
select * from emp where not deptno=10;
select * from emp where deptno=20 and sal<1000;    
--同时符合and左右两边的条件才显示结果
select * from emp where deptno=20 or sal<1000;   
--只要or左右两边符合其中一个，就显示结果
```

**注意点：and 优先级高于 or ，and先运行or后运行**

### 1.4 模糊查询

> like

```sql
select * from emp where ename like '%LL%';

--  %  通配符  表示0-N个任意字符
--  _   通配符  表示1个任意字符
select * from emp where ename like '%M__';

--查询名字中带有%号的名字
select * from emp where ename like '%\%%' escape '\';
 escape '\'      --告诉oracle  反斜杠现在是转义符
 
 escape 指定转义符
 
like '%\%%'    --使用\ 将后面紧跟着的%，变成普通的%字符，而不是作为通配符存在
```

### 1.5 包含筛选

> in                 between  ... and ...

```sql
select * from emp where empno in (7369,7499,7566,7788);
select * from emp where sal>=1000 and sal<=3000;  
--等于下面的句子
select * from emp where sal between 1000 and 3000;
```

### 1.6 空值筛选

> is null           is not null

```sql
select * from emp where comm is null;
select * from emp where comm is not null;
```



## 2.别名

> 列的位置可以计算和取别名，表名也可以单独取别名

```sql
select emp.*,sal*12 year_sal from emp;

select t.*,sal*12 year_sal from emp t;

select empno 编号,ename 姓名,sal 工资 from emp where deptno=20 and sal>2000;
```

## 3.单行函数

> 函数的概念：可以反复运行的功能单一的固定代码

### 3.1数字相关

- 绝对值  `abs(数字)`

- **四舍五入  `round(数字, 小数精度)`**

- **数字截取  `trunc(数字, 小数精度)`**

- 向下取整  `floor(数字)`

- 向上取整  `ceil(数字)`

- 幂运算      `power(数字, 次方)`

- 取余数运算    `mod(数字, 除数)`

### 3.2字符串相关

- **截取字符串  `substr(字符串, 开始位置, 连续长度)`**

```sql
--获取emp表中，每个员工名字的首字母
select substr(ename,1,1),ename from emp;

--获取emp表中，每个员工名字的最后一个字母
select substr(ename,-1),ename from emp;

--连续长度不写，就是取值到最后一个
```

- **拼接字符串  `concat(str1, str2)`**

```sql
select ename,concat(concat('部门是:',deptno),'!') from emp;

--可以用 || 去替代concat()函数
select ename, '部门是:'||deptno||'!'  from emp;
```

- 计算字符串的字符个数   `length(字符串)`

- 字符串内容的替换  `replace(字符串, 要被替换的内容，替换后的新内容)`

- 去除左右两边的空格 ` trim()    ltrim()    rtrim()`

- 填充内容  `lpad()   rpad()`

### 3.3时间相关

- `sysdate `  当前的系统时间 

  ```sql
   select sysdate-2 from dual;
  ```

- **月份的偏移   `add_months(时间，月的数量)`**

```sql
select add_months(date'2020-9-1',-4) from dual;
```

- 时间的间隔   `months_between(时间1,时间2)`，前面减去后面

```sql
select months_between(date'2020-9-10',date'2020-4-1') from dual;
```

### 3.4类型转换

- **转换成字符串  `to_char()`**

> to_char() 去处理时间，目的是为了提取出时间里面的部分数据，例如年月日

```sql
select to_char(sysdate,'yyyy') from dual; --年

select to_char(sysdate,'mm') from dual; --月

select to_char(sysdate,'dd') from dual; --日
 
select to_char(sysdate,'hh') from dual; --时

select to_char(sysdate,'mi') from dual; --分

select to_char(sysdate,'ss') from dual; --秒

select to_char(sysdate,'day') from dual; --星期几
```

- 转换成数字  `to_number()`

- **转换成时间  `to_date()`**

```sql
select to_date('2019/8/3 14:09:18','yyyy/mm/dd hh24:mi:ss') from dual;
```

## 4.数据的排序

```sql
order by 列名 排序方法

--升序  asc
--降序  desc

select * from emp order by sal asc;
select * from emp order by sal desc;

--同时给多个列进行排序：
select * from emp order by deptno asc,sal desc;
```



## 5.多表查询

### 5.1子查询

> 嵌套查询：将一个表格的查询结果，当成另一个表格查询的条件。

**基本流程**：

1. 找出两个相关表的共同点
2. 找出题目中列出的条件
3. 找出题目中要查询的目的

```sql
--查询出SMITH的上班地点
select loc from dept where deptno=(select deptno from emp where ename='SMITH');

--练习：
--找出在NEW YORK上班的所有员工的名字
select ename from emp where deptno=(
select deptno from dept where loc='NEW YORK');

--查询出比20号部门所有人工资都高的其他员工信息  all
select * from emp where sal>
all(select sal from emp where deptno=20);

--查询出比10号部门任何一个人工资都高的其他员工信息  any
select * from emp where sal>
any(select sal from emp where deptno=10);

--找出CLERK分别在哪几个不同的部门（查询出部门名称）
select dname from dept where deptno in (select deptno from emp where job='CLERK');
```

**使用在子查询中的关键字**：

- `all`：大于最大的，小于最小的
- `any`：大于最小的，小于最大的

### 5.2联合查询

#### 5.2.1笛卡尔乘积

```sql
select * from emp,dept where emp.deptno=dept.deptno;
```

#### 5.2.2内连接

> ```sql
> --联合查询更加常见的语法：
> select * from A join B on A.xxx=B.yyy;
> select * from emp join dept on emp.deptno=dept.deptno;
> ```

> (inner) join  查询出两张表符合条件的共同部分：内连接，inner可以省略

#### 5.2.3左连接

> 显示两个表格的共同数据，然后显示左边表的数据  left join

```sql
select * from emp left join dept on emp.deptno=dept.deptno;
```

#### 5.2.4右连接

> 显示两个表格的共同数据，然后显示右边表的数据  right join

```sql
select * from emp right join dept on emp.deptno=dept.deptno;
```

#### 5.2.5全连接

> 显示两个表格的共同数据，然后分别显示左边和右边表的数据  full join

```sql
select * from emp full join dept on emp.deptno=dept.deptno;
```

```sql
--练习
--找出没有SALESMAN这个岗位的部门名称
select dname from dept where deptno in (
select deptno from emp where deptno not in (
select deptno from emp where job='SALESMAN'));

--找出没有员工的部门编号
select d.deptno from emp e right join dept d on e.deptno=d.deptno where e.deptno is null;
```

#### 5.2.6左右连接时and和where的区别

```sql
select * from emp a left join dept b on a.deptno=b.deptno where a.deptno=20;
--使用where时，先进行表连接，再进行筛选
```

![](C:\Users\Administrator.USER-20200615OM\AppData\Roaming\Typora\typora-user-images\image-20200915170821465.png)

```sql
select * from emp a left join dept b on a.deptno=b.deptno and a.deptno=20;
--使用and时，先进行筛选，再进行表连接
```

![](C:\Users\Administrator.USER-20200615OM\AppData\Roaming\Typora\typora-user-images\image-20200915170742079.png)

## 6.分组和聚合函数

### 6.1分组

> group by 

```sql
select deptno from emp group by deptno;
```

### 6.2聚合函数

> 分组后跟着使用，如果不分组，那就将整个表当做一组，进行聚合函数的运算

#### 6.2.1统计数据

> count()

#### 6.2.2求和		

> sum()

#### 6.2.3求最大值	

> max()

#### 6.2.4求最小值	

> min()

#### 6.2.5求平均值	

> avg()

```sql
select deptno,count(empno),sum(sal),max(sal),min(sal),avg(sal) from emp group by deptno;
```

```sql
--练习
--计算10和20部门的人数
--先筛选再分组，使用where
select deptno,count(empno) from emp where deptno!=30 group by deptno;
--先分组再筛选，使用having
select deptno,count(empno) from emp group by deptno having deptno!=30;

--计算平均工资高于2000的部门有哪些
--先计算出每个组的结果，然后对计算结果进行筛选。
select deptno,avg(sal) from emp group by deptno having avg(sal)>2000;
```

```sql
--练习：
--统计一下不同的工作岗位，最低和最高的工资分别是多少？
select job,max(sal),min(sal) from emp group by job;
--统计一下不同的工作岗位，最低和最高工资的差距，分别是多少？
select job,max(sal),min(sal),max(sal)-min(sal) from emp group by job;
--统计一下，每个部门分别有多少人？要包括所有的部门。
select d.deptno,dname,count(e.empno) from emp e right join dept d on e.deptno=d.deptno group by d.deptno,dname;
```

## 7.语句查询顺序

```sql
select 列,聚合函数(列)							 5
from 表											1
where 筛选									   2
group by 列										3
having 筛选									    4
order by 列 asc/desc								6

1.先找到表from，从哪个表里面查
2.进行where筛选，分组前的筛选
3.分组group by
4.进行having筛选，分组后的筛选
5.查询需要的内容，列或者聚合函数后的值
6.排序order by
```



**涉及到的sql语句**：

```sql
--select
create table emp as select * from scott.emp;
create table dept as select * from scott.dept;

select * from emp;
--精确筛选
select * from emp where deptno=10;
--范围筛选
select * from emp where deptno!=10;
select * from emp where sal>3000;
select * from emp where sal>=3000;
--逻辑筛选
select * from emp where not deptno=10;
select * from emp where deptno=20 and sal<1000;
select * from emp where deptno=20 or sal<1000;
--模糊查询
select * from emp where ename like '%LL%';
select * from emp where ename like '%M__';

insert into emp values(8888,'AB%CD','CLERK',7566,date'2020-01-02',3000.00,100.00,30);
select * from emp where ename like '%\%%' escape '\';
select * from emp where ename like '%$%%' escape '$';

--包含筛选
select * from emp where empno in (7369,7499,7566,7788);
select * from emp where sal between 1000 and 3000;
--空值筛选
select * from emp where comm is null;


--练习：
--1.查询出emp表中部门编号为20，薪水在2000以上（不包括2000）的所有员工，
--显示他们的员工号，姓名以及薪水
select empno,ename,sal from emp where deptno=20 and sal>2000;
--2.查询出所有奖金（comm）字段不为空且金额不等于零的人员的所有信息
select * from emp where comm is not null and comm!=0;
--3.查询出薪水在800到2500之间（闭区间）所有员工的信息
select * from emp where sal between 800 and 2500;
--4.查询出SALESMAN  CLERK  MANAGER这三个工作岗位的所有员工信息
select * from emp where job in ('CLERK','SALESMAN','MANAGER');
--5.查询出名字中有“E”字符，并且薪水在1000以上（不包括1000）的所有员工信息
select * from emp where ename like '%E%' and sal>1000;

--取别名
select emp.*,sal*12 from emp;
select t.*,sal*12 from emp t;
select empno 编号,ename 姓名,sal 工资 from emp where deptno=20 and sal>2000;



--单行函数
--数字相关：
--绝对值  abs(数字)
select abs(-666) from dual;
--四舍五入  round(数字, 小数精度)
select round(1.2345,3) from dual;
--数字截取  trunc(数字, 小数精度)
select trunc(1.2345,3) from dual;
--向下取整  floor(数字)
select floor(1.999) from dual;
--向上取整  ceil(数字)
select ceil(1.001) from dual;
--幂运算      power(数字, 次方)
select power(2,3) from dual;
--取余数运算    mod(数字, 除数)
select mod(12,3) from dual;

--字符串
--截取字符串
select substr('abcdefg',2,3) from dual;
--拼接字符串
select concat('你好','SQL') from dual;
select '你好'||'SQL' from dual;
--计算字符个数
select length('你好') from dual;
--字符串内容的替换
select replace('abcdefg','a','A') from dual;
--去除空格
select trim('   hello    ') from dual;
--填充内容
select lpad('hello',10,'#') from dual;

--时间
--当前时间
select sysdate from dual;
--月份迁移
select add_months(date'2020-09-10',-4) from dual;
--时间间隔
select months_between(date'2020-01-08',date'2020-08-07') from dual;

--类型转换
--转换成字符串
select to_char(sysdate,'yyyy') from dual;
--转换成数字
select to_number('1009') from dual;
--转换成时间
select to_date('2020-10-9','yyyy-mm-dd') from dual;

--练习：
--思考题：
--select出来一个永远是明天早上8点的时间内容
select to_date(concat(to_char(sysdate+1,'yyyy-mm-dd'),' 08:00:00'),'yyyy-mm-dd hh24:mi:ss') from dual;

--查询出emp表中入职时间是星期四的员工
select * from emp where to_char(hiredate,'day')='星期四';
--查询出入职时间超过35年的员工
select * from emp where months_between(sysdate,hiredate)>12*35;

--练习
select * from dept;
select * from emp;
--找出在纽约上班的所有员工的名字
select ename from emp where deptno=(select deptno from dept where loc='NEW YORK');
--找出CLERK分别在哪几个不同的部门（查询出部门名称）
select dname from dept where deptno in (select deptno from emp where job='CLERK');
select dname from dept where deptno = any(select deptno from emp where job='CLERK');

--练习：
--找出没有SALESMAN这个岗位的部门名称
select dname from dept where deptno in (
select deptno from emp where deptno not in (
select deptno from emp where job='SALESMAN'));

--找出没有员工的部门编号
select d.deptno from emp e right join dept d on e.deptno=d.deptno where e.deptno is null;

select * from emp e left join dept d on e.deptno=d.deptno where e.deptno=20;
select * from emp e left join dept d on e.deptno=d.deptno and e.deptno=20;

--分组和聚合
select deptno,count(*),sum(sal),max(sal),min(sal),avg(sal) from emp group by deptno;

--计算10和20部门的人数
select deptno,count(empno) from emp where deptno!=30 group by deptno;
select deptno,count(empno) from emp group by deptno having deptno!=30;
--计算平均工资高于2000的部门
select deptno,avg(sal) from emp group by deptno having avg(sal)>2000;

--练习：
--统计一下不同的工作岗位，最低和最高的工资分别是多少？
select job,max(sal),min(sal) from emp group by job;
--统计一下不同的工作岗位，最低和最高工资的差距，分别是多少？
select job,max(sal),min(sal),max(sal)-min(sal) from emp group by job;
--统计一下，每个部门分别有多少人？要包括所有的部门。
select d.deptno,dname,count(e.empno) from emp e right join dept d on e.deptno=d.deptno group by d.deptno,dname;

select * from emp;
delete from emp where empno=8888;

--课后练习：
--1.查询出emp表中，每个不同部门中每个岗位的最低薪水
select deptno,job,min(sal) from emp group by deptno,job;

--2.查询出每个员工上级领导的名字（mgr是上级领导的员工编号）
select b.ename 员工名,e.ename 上级领导名 from 
emp e right join emp b 
on e.empno=b.mgr;

--3.查询出每个部门里面，薪水最高的员工姓名
select ename,sal,deptno from emp where sal in 
(select max(sal) from emp group by deptno);

select ename from 
emp e join (select deptno,max(sal) max from emp group by deptno) b 
on e.deptno=b.deptno 
where sal=max;

--4.查询出工资高于MILLER这个员工的其他员工信息
select * from emp where sal>(select sal from emp where ename='MILLER');

--5.查询出工资高于自己所在部门平均工资的员工信息
select * from 
emp e join (select deptno,avg(sal) avg from emp group by deptno) b 
on e.deptno=b.deptno 
where sal>avg;

--6.查询出同年同月入职的员工信息
select e1.* from 
emp e1 join emp e2 
on to_char(e1.hiredate,'yyyy-mm')=to_char(e2.hiredate,'yyyy-mm') 
where e1.empno!=e2.empno; 

select * from emp where to_char(hiredate,'yyyy-mm') in(
select to_char(hiredate,'yyyy-mm') from emp
group by to_char(hiredate,'yyyy-mm')
having count(empno)>1);

--7.查询出至少有3个员工的部门编号
select deptno,count(empno) from emp group by deptno having count(empno)>=3;

--8.查询出和SMITH从事相同岗位的其他员工信息
select * from emp where job=
(select job from emp where ename='SMITH') and ename!='SMITH';

--9.按照每个部门的平均工资进行从高到低的排序，平均工资保留两位小数
select deptno,trunc(avg(sal),2) avg from emp group by deptno order by avg desc;

--10.查询出有奖金的人里面，工资最高的那个人的名字
select ename from emp where comm is not null and sal=
(select max(sal) from emp where comm is not null);


```

