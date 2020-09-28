# PLSQL编程

如果一个查询的结果是定时查询出来的，那么就使用代码块；

一些固定的操作，就使用代码块；

复杂的sql语句，使用代码块。

## 匿名块

> 就是一个没有名字的代码块，临时运行的sql语句代码块

基本格式：

```sql
declare
  变量的声明部分;
begin
  执行的逻辑部分;
end;
```

### 输出函数

> `dbms_output.put_line();`

```sql
declare

  n1 number;  --声明了一个变量n1，n1是一个数字类型

begin

  n1:=10;  --将10的数字赋值给n1这个变量保存起来

  dbms_output.put_line('数字是'||n1);    --以行为单位进行换行输出

  n1:=20;  --重新赋值20给n1变量

  dbms_output.put_line('数字是'||n1);

end;
```

### 输入函数

> 变量的输入：  `变量:=&提示信息;`

#### 数字的输入

```sql
declare

  n1 number;

  n2 number;

  n3 number;

begin

  n1:=&数字1是;

  n2:=&数字2是;

  n3:=n1+n2;

  dbms_output.put_line(n3);

end;
```

**注意点**：提示语不能一样，否则会当成一个输入框。

#### 字符串的输入

> 需要在输入的提示左右加上单引号

```sql
declare

  ename varchar2(20);

begin

  ename:='&你的名字';

  dbms_output.put_line('Hello! '||ename);

end;
```

**注意点**：特殊符号，打印两个相当于转义，打印特殊符号本身。

```sql
declare
  ename varchar2(20);
begin
  ename:='&&haha';
  dbms_output.put_line(ename);
end;
```

### 保存查询的结果

> 结果只有刚好一个内容，才能运行，多于1个或者没有数据都会报错

```sql
declare

  v_ename varchar2(20);

  v_job varchar2(20);

begin

  select ename,job into v_ename,v_job from emp where sal=5000;

  dbms_output.put_line(v_ename||','||v_job);

end;
```

### 引用型变量

`变量名  表名.列名%type;`

```sql
declare

  v_ename emp.ename%type;

  v_job emp.job%type;

begin

  select ename,job into v_ename,v_job from emp where sal=5000;

  dbms_output.put_line(v_ename||','||v_job);

end;
```

### 记录型变量  

`变量名  表名%rowtype;`

```sql
declare

  v_user emp%rowtype;

begin

  select * into v_user from emp where ename='SMITH';

  dbms_output.put_line(v_user.empno||','||v_user.sal||','||v_user.job); 

end;
```

### record复合类型

> **将一个表中需要反复用到的列，放在一起，定义成一个新的数据类型**

```sql
type 复合类型名字 is record(
   小变量名字 数据类型,
   ...
);
变量名  复合类型名字;
```

```sql
declare

  type emp_users is record(    --自己定义一种新的数据类型，这个数据类型包含了四个不同的字段

   v_empno emp.empno%type,

   v_ename emp.ename%type,

   v_job emp.job%type,

   v_deptno emp.deptno%type

  );

  v_user emp_users;  --将自己定义的数据类型，声明给一个变量

begin

  select empno,ename,job,deptno into v_user from emp where sal=5000;

  dbms_output.put_line(v_user.v_empno);

  dbms_output.put_line(v_user.v_ename);

  dbms_output.put_line(v_user.v_job);

  dbms_output.put_line(v_user.v_deptno);    

end;
```

```sql
--练习：
--用匿名块实现，输入一个部门编号，输出这个部门中工资最高和工资最低的人的名字和工资信息。
declare
  v_deptno emp.deptno%type;
  type emp_users is record(
       v_ename emp.ename%type,
       v_sal emp.sal%type
  );
  v_user_max emp_users;
  v_user_min emp_users;
begin
  v_deptno:=&请输入部门编号;
  select ename,sal into v_user_max from
  (select emp.*,max(sal) over() m1 from emp where deptno=v_deptno) where sal=m1 and rownum=1;
  select ename,sal into v_user_min from
  (select emp.*,min(sal) over() m1 from emp where deptno=v_deptno) where sal=m1 and rownum=1;
  dbms_output.put_line('最高工资'||v_user_max.v_sal||','||v_user_max.v_ename); 
  dbms_output.put_line('最高工资'||v_user_min.v_sal||','||v_user_min.v_ename); 
end;



declare
  v_ename1 varchar2(20);
  v_ename2 varchar2(20);
  v_sal1 number;
  v_sal2 number;
  v_deptno number;
begin
  v_deptno:=&部门编号;  

  select ename,sal into v_ename1,v_sal1 from
(select emp.*,
       max(sal) over() m1
  from emp where deptno=v_deptno)
 where sal=m1 and rownum=1;
 
  select ename,sal into v_ename2,v_sal2 from
(select emp.*,
       min(sal) over() m1
  from emp where deptno=v_deptno)
 where sal=m1 and rownum=1; 

 dbms_output.put_line('最高的工资'||v_sal1||','||v_ename1); 
 dbms_output.put_line('最低的工资'||v_sal2||','||v_ename2); 
end;
```

### 逻辑判断和分支

#### if

```sql
if  判断1  then
  执行语句;
elsif  判断2  then
   执行语句;
···
else
   执行语句;
end if;
```

```sql
declare
  n number;
begin
  n:=&数字;
  if n>0 then
    dbms_output.put_line('正数');
  elsif n<0 then
    dbms_output.put_line('负数'); 
  else
    dbms_output.put_line('零'); 
  end if; 
end;
```

if开头  中间可以有很多的elsif  else做最后一个判断  end if结束

if和elsif都需要加上判断  else表示剩余的所有逻辑

```sql
declare
  money number;
begin
  money:=&剩下的钱;
  if money<=5 then
    dbms_output.put_line('小笼包'); 
  elsif money<=10 then
    dbms_output.put_line('炒粉');
  elsif money<=15 then
    dbms_output.put_line('黄焖鸡');
  elsif money<=20 then
    dbms_output.put_line('隆江猪脚饭');
  else
    dbms_output.put_line('火锅');
  end if;   
end;
```

```sql
--练习：
--输入员工的编号，如果不存在这个员工，就打印没有这个人，否则输出这个人的名字；
declare
  v_empno number;
  c number;
  v_ename varchar2(20);
begin
  v_empno:=&员工编号;
  select count(1) into c from emp where empno=v_empno;
  if c=0 then
    dbms_output.put_line('没有这个人'); 
  else
    select ename into v_ename from emp where empno=v_empno;
    dbms_output.put_line(v_ename);
  end if; 
end;

--输入员工的编号，如果员工是10号部门，涨薪10%，如果是20号部门，涨薪20%，30号部门涨薪30%。
declare
       v_empno number;
       v_sal number;
       c number;
       v_grade number;
begin
  v_empno:=&员工编号;
  select count(1) into c from emp where empno=v_empno;
  if c=1 then
    select sal into v_sal from emp where empno=v_empno;
    select grade into v_grade from salgrade where v_sal>=losal and v_sal<=hisal;
    dbms_output.put_line(v_grade); 
  else
    dbms_output.put_line('员工不存在'); 
  end if;
end;
```

#### case when

```sql
declare
begin
  case 
    when xxx then 执行语句;
    when xxx then 执行语句;
    ...
    else  执行语句;
  end case;
end;
```

```sql
declare
  v_sno varchar2(10);
  v_score number;
begin
  v_sno:='&学号';
  select avg(score) into v_score from degree where sno=v_sno;
  case
    when v_score<60 then dbms_output.put_line('不及格');
    else dbms_output.put_line('及格');  
  end case;
end;

--用case when判断emp表中某个用户编号是否存在
declare
  v_empno emp.empno%type;
  c number;
begin
  v_empno:=&员工编号;
  select count(1) into c from emp where empno=v_empno;
  case
    when c=0 then dbms_output.put_line('该用户不存在'); 
    else
      dbms_output.put_line('用户存在');
  end case; 
end;
```

### 循环

#### for语法

```sql
for 新的变量名字 in 范围 loop
    执行语句;
end loop;
```

```sql
declare
begin
  for i in 1..10 loop
    dbms_output.put_line(i); 
  end loop;
end;

--累计求和：
declare
  s number;
begin
  s:=0;
  for i in 1..10 loop
    s:=s+i;  
  end loop;
  dbms_output.put_line(s); 
end;

--计算100以内所有奇数的和
declare
  s number;
begin
  s:=0;
  for i in 1..100 loop
    if mod(i,2)!=0 then
      s:=s+i;
    end if;
  end loop;
  dbms_output.put_line(s); 
end;

--9x9乘法表
declare
begin
  for i in 1..9 loop
    for j in 1..i loop
      dbms_output.put(j||'x'||i||'='||i*j||'  '); 
    end loop;
    dbms_output.put_line(''); 
  end loop;
end;
```

```sql
--练习：
--将emp中所有的员工信息查询出来，判断员工是否是manager，
--如果是manager并且还没有设置奖金，就更新奖金为他本人工资的10%，
--改完之后还要打印出修改的是谁（显示名字），以及修改后奖金的结果是多少
--全表循环
declare
  type v_users is record(
       v_ename emp.ename%type,
       v_job emp.job%type,
       v_comm emp.comm%type 
  );
  v_user v_users;
  c number;
begin
  select count(1) into c from emp;
  for i in 1..c loop
    select ename,job,comm into v_user from (select emp.*,rownum r from emp) where r=i;
    if v_user.v_job='MANAGER' and v_user.v_comm is null then
        update emp set comm=sal*0.1 where ename=v_user.v_ename;
        commit;
        select comm into v_user.v_comm from emp where ename=v_user.v_ename;
        dbms_output.put_line('名字：'||v_user.v_ename||',奖金：'||v_user.v_comm); 
    end if;
  end loop; 
end;

--先筛选再循环
declare
  c number;
  v_ename varchar2(20);
  v_sal number;
  v_job varchar2(20);
begin
  select count(1) into c from emp where job='MANAGER' and comm is null;
  for i in 1..c loop
    select ename,sal,job into v_ename,v_sal,v_job from
    (select emp.*,rownum r from emp where job='MANAGER' and comm is null)
    where r=1;
    update emp set comm=sal*0.1 where ename=v_ename;
    dbms_output.put_line(v_ename||','||v_sal*0.1); 
  end loop;
end;
```

#### while

> while循环的语法：当判断为真的时候进入循环，判断为假跳出循环

```sql
while 判断是否在循环范围内 loop
    执行语句;
end loop;
```

```sql
declare
  n number;
begin
  n:=10;
  while n>=1 loop
    dbms_output.put_line(n); 
    n:=n-3;
  end loop;
end;
```

#### loop

> loop循环的语法：当判断为假的时候跳出循环

```sql
loop
    exit when 判断什么时候退出循环；
    执行语句;
end loop;
```

```sql
declare
  n number;
begin
  n:=10;
  loop 
    exit when n<1;
    dbms_output.put_line(n);
    n:=n-3;
  end loop;
end;
```

#### 循环中的三个关键字

##### exit

> 跳出循环，不要循环了，一个关键字只能控制离它最近的一个循环

- return：跳出整个正在运行的程序

##### continue

跳过本次循环，直接开始下一次的循环

##### goto

使用goto语句跳到定义标签的位置

```sql
goto 标签名
<<标签名>>
```

#### 将select查询的结果当成for循环的范围

```sql
declare
begin
  for i in (select * from emp where job='MANAGER' and comm is null) loop
    update emp set comm=i.sal*0.1 where empno=i.empno;
    commit; 
    dbms_output.put_line(i.ename||','||i.sal*0.1); 
  end loop;
end;
```

## 游标处理

> 将一个查询语句的结果保存在一个游标的变量中，然后以行为单位去查看游标保存的表格结果。

根据游标的内容定义和声明的位置：

1. 在声明的同时赋值，就是静态游标，在begin里面赋值，就是动态游标
2. 如果有对游标的操作步骤，那么就是显性游标，否则就是隐性游标

### 静态游标

#### 显性游标

**显性游标的操作步骤**：

1. 定义和声明游标
   cursor 游标名字 is select语句;
2. 打开游标
   open 游标名字;
3. 获取游标的内容
   fetch 游标名字 into 行变量中;
4. 关闭游标
   close 游标名字;

**使用while循环操作游标**

```sql
declare
  --定义和声明游标
  cursor m_cursor is select * from emp;
  v_user emp%rowtype;
begin
  --打开这个游标
  open m_cursor;
  --获取游标的内容
  fetch m_cursor into v_user;
  while m_cursor%found loop
    dbms_output.put_line(v_user.empno||','||v_user.ename);
    fetch m_cursor into v_user;
  end loop;
  --关闭游标
  close m_cursor;  
end;
```

**使用loop循环操作游标**

```sql
declare
  cursor m_cursor is select * from emp where deptno=30;
  v_user emp%rowtype;
begin
  open m_cursor;
  loop
    fetch m_cursor into v_user;
    exit when m_cursor%notfound;
    dbms_output.put_line(v_user.empno||','||v_user.ename);
  end loop;
  close m_cursor;
end;
```

```sql
--练习
--1.使用代码块制造一个1-100的数字表格
create table numbers(
    n number
  );
declare
begin
  for i in 1..100 loop
    insert into numbers values(i);
  end loop;
  commit;
end;
select * from numbers;
--2.使用游标将这个表里面所有相加等于88的两个数字查询出来
declare
  cursor m_cursor is select * from numbers a join numbers b on a.n+b.n=88 where a.n<88/2;
  type v_tnum is record(
    a number,
    b number
  );
  v_num v_tnum;
begin
  open m_cursor;
  loop
    fetch m_cursor into v_num;
    exit when m_cursor%notfound;
    dbms_output.put_line(v_num.a||','||v_num.b); 
  end loop;
  close m_cursor;
end;
--
declare
  cursor m1 is select * from numbers;
  cursor m2 is select * from numbers;
  n1 number;
  n2 number;
begin
  open m1;
  loop
    fetch m1 into n1;
    exit when m1%notfound;
    open m2;
    loop
      fetch m2 into n2;
      exit when m2%notfound;
      if n1+n2=88 then
        dbms_output.put_line(n1||','||n2); 
      end if;
    end loop;
    close m2;
    if n1=43 then
      exit;
    end if;
  end loop;
  close m1;
end;
```

##### for循环的游标

```sql
declare
  cursor m_cursor is select * from emp;
begin
  for i in m_cursor loop
    dbms_output.put_line(i.empno); 
  end loop;
end;

declare
begin
  for i in (select * from emp) loop
    dbms_output.put_line(i.empno); 
  end loop;
end;
```

#### 隐形游标

> 代码发生了一个DML操作，查看这次操作影响的数据有多少
> `游标%rowcount`
>
> **查看最近的那条sql语句所影响的行数**

```sql
declare
begin
  update emp set sal=sal+100 where sal<500;
  if sql%found then
    dbms_output.put_line(sql%rowcount); 
  else
    dbms_output.put_line('没有找到数据');
  end if; 
end;
```

### 动态游标

> 在begin执行的时候才指定运行的内容，
> 不用在声明的时候就指定可以节省内存消耗，可以反复使用，在close之后可以重新open指定新的语句

```sql
declare
  --动态游标的关键字 ref
  --声明动态游标的类型
  type cursor_t is ref cursor;
  --声明一个游标
  m_cursor cursor_t;
  --定义一个变量用来存放游标的内容
  v_user emp%rowtype;
begin
  --打开游标同时指定游标要去运行的sql语句
  open m_cursor for select * from emp;
  --sql语句可以动态筛选，比如：
  --select * from emp where deptno=v_deptno;
  
  --循环的抓取游标的数据
  loop
    fetch m_cursor into v_user;
    exit when m_cursor%notfound;
    dbms_output.put_line(v_user.empno||v_user.ename); 
  end loop;
  --关闭游标
  close m_cursor;
end;
```

```sql
--练习：
--准备三个emp同结构的表格1,2,3，拆分原来emp的数据
--将1-4月入职、5-8月、9-12月分别存储到三个不同的表格中
create table emp_1 as select * from scott.emp where 1=2;
create table emp_2 as select * from scott.emp where 1=2;
create table emp_3 as select * from scott.emp where 1=2;

declare
  cursor m is select * from emp;
begin
  for i in m loop
    if to_number(to_char(i.hiredate,'mm')) between 1 and 4 then
      insert into emp_1 values( i.empno,i.ename,i.job,i.mgr,i.hiredate,i.sal,i.comm,i.deptno
      );
      commit;
    elsif to_number(to_char(i.hiredate,'mm')) between 5 and 8 then
      insert into emp_2 values(    i.empno,i.ename,i.job,i.mgr,i.hiredate,i.sal,i.comm,i.deptno
      );
      commit;
    else
      insert into emp_3 values( i.empno,i.ename,i.job,i.mgr,i.hiredate,i.sal,i.comm,i.deptno
      );  
      commit;
    end if;
  end loop;
end;
```

## 动态sql语句

> 因为在代码块里面只能直接使用DQL和DML语句
>
> `execute immediate 'sql语句';`

```sql
declare
  tn varchar2(20);
begin
  tn:='&表名';
  execute immediate 'truncate table '||tn;
end;
```

```sql
--练习：
--在select * from user_tables;里面找到所有的emp开头的表，备份一份，备份表的名字是：原表名_20200923
--例如emp_info表备份为   emp_info_20200923
declare
   cursor m is select table_name from user_tables where table_name like 'EMP%';
   s varchar2(500);
begin
   for i in m loop
       s:='create table '||i.table_name||'_'||to_char(sysdate,'yyyymmdd')||
       ' as select * from '||i.table_name;
       execute immediate s; 
   end loop;
end;

--练习：删除掉所有今天的备份表    xxx_20200923
declare
  cursor m is select table_name from user_tables 
              where table_name like '%\_'||to_char(sysdate,'yyyymmdd') escape '\';
begin
  for i in m loop
      execute immediate 'drop table '||i.table_name;
  end loop;
end;
```

## 存储过程

> 一个有名字的代码块  procedure

```sql
create procedure 过程名
as
  声明部分;
begin
  执行语句;
end;
```

```sql
--创建存储过程
create or replace procedure beifen_table
as
  cursor m is select * from user_tables where table_name like 'EMP%';
  s varchar2(500);
begin
  for i in m loop
     s:='create table '||i.table_name||'_'||to_char(sysdate,'yyyymmdd')||
        ' as select * from '||i.table_name;
     execute immediate s; 
  end loop;
end;
```

### 建表权限

```sql
--在存储过程里面创建表，需要下面这个特殊的权限
grant create any table to bigdata;

--运行存储过程里面的代码
call beifen_table();
```

### 存储过程的传入和传出参数

> 存储过程包含了传入的参数  in  和传出的参数  out

```sql
create or replace procedure beifen_u_table(tn in varchar2)
as
begin
  execute immediate 
  'create table '||tn||'_'||to_char(sysdate,'yyyymmdd')||' as select * from '||tn;
end;
--只有传入参数，直接使用call调用即可
--传入参数的in可以省略，默认为传入参数
call beifen_u_table('EMP_1');
```

```sql
--如果存储过程里面有输出的Out参数，就需要用declare匿名块去运行
--创建存储过程
create or replace procedure sum_(n1 in number,n2 in number,s1 out number,s2 out number)
as
begin
  s1:=n1+n2;
  s2:=n1-n2;
end;

--运行存储过程需要declare匿名块
declare
  a number;
  b number;
begin
  sum_(20,15,a,b);
  dbms_output.put_line(a);
  dbms_output.put_line(b);  
end;
```

### 自动创建分区

```sql
--使用存储过程自动创建分区表中的分区
create or replace procedure add_user_part
as
  c number;
  s varchar2(500);
begin
  select count(1) into c from user_tab_partitions where table_name='USER_PART'
  and partition_name='D'||to_char(sysdate,'yyyymmdd');
  if c=1 then
    dbms_output.put_line('分区已经存在，不会再创建');
  else
    s:='alter table user_part add partition d'||to_char(sysdate,'yyyymmdd')||
    ' values less than (date'''||to_char(sysdate+1,'yyyy-mm-dd')||''')';
    execute immediate s;
  end if;
end;

call add_user_part();
```

## 异常处理

### 1.系统预定义异常(21种)

- 返回行数太多的异常  too_many_rows
- 数字类型转换错误  invalid_number
- 除数为0错误  zero_divide
- 游标还没有打开就进行抓取   invalid_cursor
- 游标重复打开   cursor_already_open
- 值操作的错误  value_error

```sql
create or replace procedure pro_t
as
  v_ename varchar2(20);
  s number;
  m varchar2(500);
begin    
  select ename into v_ename from emp where deptno=20;
exception
  when others then
    s:=sqlcode;
    m:=sqlerrm;
    insert into error_logs values('pro_t',sysdate,s,m);
end;

call pro_t();
```

```sql
--创建一个错误日志表格
create table error_logs(
pro_name varchar2(100),
operte_time date,
sql_code varchar2(20),
sql_message varchar2(500)
);
```

### 2.系统非预定义异常  

> 系统中有定义错误的编码，但是这个错误是没有名字的
> 名字需要自己在初始化错误的时候去定义它

> 如果需要单独处理非预定义的错误，就需要给错误编码设置名称

```sql
--声明部分
错误名字  exception;
pragma exception_init(错误名字, 错误编码);
--异常处理部分
exception
  when 错误名字 then
      错误的处理;
```

```sql
create or replace procedure pro_t2
as
  --声明一个存储错误的变量
  fo_error exception;
  --初始化这个错误，把名字和错误代码绑定在一起
  pragma exception_init(fo_error,-2291);
begin
  update scott.emp set deptno=50 where ename='SMITH';
  commit;
exception
  when fo_error then
    dbms_output.put_line('主表中没有这个部门'); 
end;
```

如果是统一的处理各种错误和异常(`when others then`)，就不需要去初始化名字。

### 3.自定义异常 

> 不是语法的错误，这是自己指定的逻辑上禁止的部分

```sql
create or replace procedure pro_t3(v_empno number,v_sal number)
as
begin
  if v_sal>5000 then
    raise_application_error(-20888,'不能超过5000');  --20000   20999
  else
    update emp set sal=v_sal where empno=v_empno;
    commit;
  end if;
end;

call pro_t3(7369,5002);
```

```sql
--将存储过程运行中的错误保存到错误日志表中

--准备一个错误日志表
create table record_errors(
pro_name varchar2(50),
pro_time date,
sql_text varchar2(500),
sql_code number,
sql_error varchar2(500)
);

--编写一个存储过程，将里面出现的错误记录下来
create or replace procedure pro_update_dept
as
  s varchar2(500);
  c number;
  m varchar2(500);
begin
  for v_deptno in 40..60 loop
      s:='update scott.emp set deptno='||v_deptno||' where empno=7369';
      execute immediate s;
      commit;
  end loop;

exception
  when others then
    c:=sqlcode;
    m:=sqlerrm;
    insert into record_errors values(
    'pro_update_dept',sysdate,s,c,m
    );
    commit;
end;
```

## 表格更新

### 1.全量更新

```sql
--全量更新表格  将表格的内容全部删除，重新添加所有的数据
create table beijing_amount(
saleid number,
saleman varchar2(20),
price number,
saletime date
);

create table shenzhen_amount(
saleid number,
saleman varchar2(20),
price number,
saletime date
);

create table zongbu_amount(
saleid number,
saleman varchar2(20),
price number,
saletime date,
loc varchar2(40),
update_time date
);

insert into beijing_amount values(1001,'lilei',1000.5,date'2020-9-21');
insert into beijing_amount values(1002,'hanmeimei',756,date'2020-9-22');
insert into shenzhen_amount values(3001,'lucy',866,date'2020-9-22');
insert into shenzhen_amount values(3002,'toly',1200.8,date'2020-9-22');

create or replace procedure all_sale_amount
as
begin
  execute immediate 'truncate table zongbu_amount';
  insert into zongbu_amount(saleid,saleman,price,saletime) select * from beijing_amount;
  update zongbu_amount set loc='北京';
  update zongbu_amount set update_time=sysdate;
  commit;
  insert into zongbu_amount(saleid,saleman,price,saletime) select * from shenzhen_amount;
  update zongbu_amount set loc='深圳' where loc is null;
  update zongbu_amount set update_time=sysdate where update_time is null;
  commit;  
end;

call all_sale_amount();
```

### 表格内容的对比

```sql
对比表格内容的句式：merge into
基本语法：
merge into 目标表名字 a 
using (select 语句) b
on (a.列1=b.列1 and a.列2=b.列2 ...)
when matched then
  update 语句
when not matched then
  insert 语句; 
```

### 2.增量更新

> on  条件满足，那么说明已经存在该条数据，只需要更新即可
>
> 不满足说明，该条数据不存在，需要插入数据

```sql
--增量更新表格数据  只更新新出现的数据
create or replace procedure part_sale_amout
as
begin
  merge into zongbu_amount a 
  using (select beijing_amount.*,'北京' loc from beijing_amount union all 
         select shenzhen_amount.*,'深圳' loc from shenzhen_amount) b
  on (a.saleid=b.saleid and a.saleman=b.saleman and a.price=b.price and a.saletime=b.saletime)
  when matched then
    update set 
      a.update_time=sysdate
  when not matched then
    insert (a.saleid,a.saleman,a.price,a.saletime,a.loc,a.update_time) 
    values (b.saleid,b.saleman,b.price,b.saletime,b.loc,sysdate);
end;

call part_sale_amout();
```

```sql
--练习：编写一个新增用户的存储过程，过程有4个输入参数，分别是姓名、工作岗位、工资、部门编号，其余的数据都是自动生成的，
--例如：员工编号是上一个用户编号+1，mgr上级领导编号是同部门的MANAGER编号，奖金是工资的10%，入职时间是现在时间的年月日。

create or replace procedure add_emp(v_ename varchar2,v_job varchar2,v_sal number,v_deptno number)
as
  v_empno number;
  v_mgr number;
  v_comm emp.comm%type;
  v_hiredate date;
begin
  --获取编号
  select max(empno) into v_empno from emp;
  v_empno:=v_empno+1;
  --获取mgr
  select empno into v_mgr from emp where job='MANAGER' and deptno=v_deptno;
  --奖金
  v_comm:=v_sal*0.1;
  --当前的年月日
  v_hiredate:=to_date(to_char(sysdate,'yyyy-mm-dd'),'yyyy-mm-dd');
  --插入数据
  insert into emp values(v_empno,v_ename,v_job,v_mgr,v_hiredate,v_sal,v_comm,v_deptno);
  commit;
end;

call add_emp('lilei','CLERK',1000,30);
```

## 函数

> 函数：将计算的过程封装起来，这个过程中的代码就是函数了  function
>
> 1. 函数一定有输入参数
> 2. 函数一定有return出去的返回值
> 3. 函数是放在sql语句中去进行使用的
> 4. 函数中不能去修改表的内容和表的结构，不能执行dml和ddl语句
> 5. 游标在函数中没有什么意义，因为一个函数只能return一次，没有办法为每一行单独的返回结果

```sql
create or replace function 函数名字(参数 数据类型)
return 返回值的数据类型
as
  声明部分;
begin
  执行部分;
end;
```

```sql
create or replace function sum_1(n1 number,n2 number)
return number
as
  n3 number;
begin
  n3:=nvl(n1,0)+nvl(n2,0);
  return n3;
end;

select sum_1(12*sal,comm) from emp;
```

```sql
--练习：写一个在最小和最大值之间随机整数的函数
create or replace function int_random(m1 integer,m2 integer)
return integer
as
  n number;
begin
  n:=round(dbms_random.value(m1,m2));
  return n;
end;

--练习：用函数随机N位长度的英文大小写字母
create or replace function yanzhengma(m integer)
return varchar2
as
  s varchar2(26):='qwertyuioplkjhgfdsazxcvbnm';
  n varchar2(4);
  yzm varchar2(4000);
begin
  for i in 1..m loop
    n:=substr(s,round(dbms_random.value(1,26)),1);
    if dbms_random.value(1,10)>5 then
      n:=upper(n);
    end if;
    yzm:=concat(yzm,n);
  end loop;
  return yzm;
end;
```

### 随机函数的用法

`dbms_random.value(a,b)`



## 触发器

> 触发器：当表格的数据或者结构发生了变化，触发另外的一个数据库的操作  trigger
>
> 1. 实时变更和同步表格的数据
> 2. 对表格的变更进行日志的记录
> 3. 用触发器禁止用户的某些操作
>
> 触发器的大类型：前置触发器   后置触发器

```sql
create or replace trigger 触发器名字
before|after  insert or update or delete on 表名
for each row
begin
  触发的执行语句;
end;
```

### 前置触发器

> 前置触发器：在操作表格之后，检查操作的数据是否合法

```sql
create or replace trigger jinzhi_president
before delete on emp
for each row
begin
  if :old.job='PRESIDENT' then
    raise_application_error(-20001,'不能删除老板！');
  end if;
end;
```

```sql
--练习：如果是添加新员工，员工的工资不能超过5000，如果是老员工，员工的每次工资更新不能超过原来工资的20%。
create or replace trigger check_emp_sal
before insert or update on emp
for each row
begin
  if inserting then
    if :new.sal>5000 then
      raise_application_error(-20002,'新员工不能超过5000元！');
    end if;
  elsif updating then
    if :new.sal>:old.sal*1.2 then
      raise_application_error(-20003,'老员工涨幅不能超过20%！');
    end if;
  end if;
end;

--练习：设置不同时间段对EMP表的禁止操作，星期一三五不能更新，星期二四六不能删除，星期天不能添加新数据。
create or replace trigger check_emp_day
before insert or update or delete on emp
for each row
begin
  if inserting then
    if to_char(sysdate,'day')='星期日' then
      raise_application_error(-20000,'星期天不能新增数据');
    end if;
  elsif updating then
    if to_char(sysdate,'day') in('星期一','星期三','星期五') then
      raise_application_error(-20001,'奇数天不能更新数据');
    end if;  
  elsif deleting then
    if to_char(sysdate,'day') in('星期二','星期四','星期六') then
      raise_application_error(-20002,'偶数天不能删除数据');
    end if;  end if;
end;
```

### 后置触发器

> 后置触发器：同步表格的数据；日志表内容的新增

```sql
--记录表格变更状态的日志表的后置触发器：
create or replace trigger record_emp_logs
after insert or update or delete on emp
for each row
begin
  if inserting then
    insert into emp_logs values(
 :new.empno,:new.ename,:new.job,:new.mgr,:new.hiredate,:new.sal,:new.comm,:new.deptno,
    ora_login_user,'新增数据',sysdate
    );
  elsif updating then
    insert into emp_logs values(
    :old.empno,:old.ename,:old.job,:old.mgr,:old.hiredate,:old.sal,:old.comm,:old.deptno,
    ora_login_user,'更新前的数据',sysdate
    );  
    insert into emp_logs values(
 :new.empno,:new.ename,:new.job,:new.mgr,:new.hiredate,:new.sal,:new.comm,:new.deptno,
    ora_login_user,'更新后的数据',sysdate
    );
  elsif deleting then
    insert into emp_logs values(
    :old.empno,:old.ename,:old.job,:old.mgr,:old.hiredate,:old.sal,:old.comm,:old.deptno,
    ora_login_user,'删除数据',sysdate
    );
  end if;
end;
```

```sql
--表格数据的同步操作：
create or replace trigger update_s_zongbu_amount
after insert or delete or update on shenzhen_amount
for each row
begin
  if inserting then
    insert into zongbu_amount values(
    :new.saleid,:new.saleman,:new.price,:new.saletime,'深圳',sysdate
    );
  elsif updating then
    update zongbu_amount set saleid=:new.saleid,saleman=:new.saleman,
    price=:new.price,saletime=:new.saletime
    where saleid=:old.saleid and price=:old.price
    and saletime=:old.saletime and saleman=:old.saleman;
  elsif deleting then
    delete from zongbu_amount where saleid=:old.saleid and price=:old.price
    and saletime=:old.saletime;
  end if;
end;
```

### 缓慢变化维，拉链表

> 拉链表：记录了表格每一行数据每一次前后变更状态的表格
> 拉链表中用来记录变更状态的列，叫做缓慢变化维
> 缓慢变化维有三种记录方法：
>
> 1. 直接Update，这样最简洁但是体现不出变化的状态
> 2. 以列的方式记录最近的变更状态
> 3. 以行的方式记录每一次前后变更的状态

```sql
--先有一个拉链表的表结构
create table teachers_lalian(
tno varchar2(20),
tname varchar2(20),
start_time date,
end_time date,
status char(1)
);
```

```sql
--用触发器填充拉链表的内容
create or replace trigger t_lalian
after insert or update or delete on teachers
for each row
begin
  if inserting then
    insert into teachers_lalian values(
    :new.tno,:new.tname,sysdate,date'9999-12-31',0
    );
  elsif updating then
    update teachers_lalian set end_time=sysdate,status=1
    where tno=:old.tno and status=0;
    insert into teachers_lalian values(
    :new.tno,:new.tname,sysdate,date'9999-12-31',0
    );
  elsif deleting then
    update teachers_lalian set end_time=sysdate,status=1
    where tno=:old.tno and status=0;
    insert into teachers_lalian values(
    :old.tno,:old.tname,sysdate,sysdate,2
    );
  end if;
end;
```

```sql
--练习：有语文表和数学表，将两个表的分数求出平均分，然后记录在汇总表里面。
create table chinese_score(
stuid number,
course varchar2(20),
score number
);

create table math_score(
stuid number,
course varchar2(20),
score number
);

create table stu_score(
stuid number,
avg_score number
);

create or replace trigger avg_score
after insert or update or delete on chinese_score
for each row
declare
  c number;
  v_score number;
  s number;
  v_stuid number;
begin
  if inserting then
    select count(1) into c from math_score where stuid=:new.stuid;
    if c=0 then
      v_score:=:new.score/2;
    else
      select score into s from math_score where stuid=:new.stuid;
      v_score:=(:new.score+s)/2;
    end if;
  elsif updating then
    select count(1) into c from math_score where stuid=:old.stuid;
    if c=0 then
      v_score:=:new.score/2;
    else
      select score into s from math_score where stuid=:old.stuid;
      v_score:=(:new.score+s)/2;
    end if;  
  elsif deleting then
    select count(1) into c from math_score where stuid=:old.stuid;
    if c=0 then
      v_score:=0;
    else
      select score into s from math_score where stuid=:old.stuid;
      v_score:=s/2;
    end if;
  end if;

  select count(1) into c from stu_score where stuid=:new.stuid or stuid=:old.stuid;
  if c=0 then
    insert into stu_score values(:new.stuid,v_score);
  else
    update stu_score set avg_score=v_score where stuid=:old.stuid or stuid=:new.stuid;
  end if;

end;
```

```sql
--使用触发器去监控表结构的修改   DDL
create table emp_ddl_logs(
operate_time date,  --操作时间
object_type varchar2(50),   --操作对象的类型  
operate_user varchar2(50),  --谁在操作
operation varchar2(50),  --什么样的操作
object_name varchar2(50)  --对象的名字
);

create or replace trigger tri_emp_ddl
after ddl on database
begin
  if ora_dict_obj_name='EMP' then   
    insert into emp_ddl_logs values(
    sysdate,ora_dict_obj_type,ora_login_user,ora_sysevent,ora_dict_obj_name
    );   
  end if;
end;
```

## 包

> 包：用来统一管理某个模块下面的所有的存储过程、函数、变量等信息。

> 先创建包规范，根据规范创建包体
> 包规范：声明和定义一个包有什么大概的结构
>
> ```sql
> create or replace package 包名
> as
>   变量 数据类型:=值;
>   procedure 过程名(输入参数 in 数据类型,输出参数 out 数据类型);
>   function 函数名(输入参数 数据类型) return 返回的数据类型;
> end 包名;
> ```
>
> 

```sql
create or replace package pkg_emp_dept
as
  --函数的声明
  function dept_avg_sal(v_deptno number) return number;
  --过程的声明
  procedure add_dept(v_deptno number,v_dname varchar2,v_loc varchar2);
end pkg_emp_dept;
```

> 包体：定义包里面每一个代码块的具体内容，包体的名字和包规范需要一致
>
> ```sql
> create or replace package body 包名
> as
>   procedure 过程名(输入参数 in 数据类型,输出参数 out 数据类型)
>   as
>       声明部分
>   begin
>       执行部分
>   end;
> 
>   function 函数名(输入参数 数据类型) return 返回的数据类型;
>   as
>       声明部分
>   begin
>       执行部分
>   end;
> 
> end 包名;
> ```

```sql
定义包体的内容
create or replace package pkg_emp_dept
as
  --函数的声明
  function dept_avg_sal(v_deptno number) return number;
  --过程的声明
  procedure add_dept(v_deptno number,v_dname varchar2,v_loc varchar2);
end pkg_emp_dept;

create or replace package body pkg_emp_dept
as
  --函数的声明
  function dept_avg_sal(v_deptno number) return number
  as
    avg_sal number;
  begin
    select avg(sal) into avg_sal from emp where deptno=v_deptno;
    if avg_sal is not null then
      return avg_sal;
    else
      return 0;
    end if;
  end;

  --过程的声明
  procedure add_dept(v_deptno number,v_dname varchar2,v_loc varchar2)
  as
    c number;
  begin
    select count(1) into c from dept where deptno=v_deptno;
    if c=0 then
      insert into dept values(v_deptno,v_dname,v_loc);
      commit;
    else
      raise_application_error(-20000,'部门已经存在');
    end if;
  end;
end pkg_emp_dept;
```

```sql
--练习：
--函数练习：
--创建一个自定义函数，函数的作用是，输入一个字符串，和输入一个单个字符，返回这个字符在字符串中的位置（有多个时只返回第一个），没有存在则返回-1
create or replace function findstr(str varchar2,s varchar2)
return number
as
begin
  for i in 1..length(str) loop
    if substr(str,i,1)=s then
      return i;
    end if;
  end loop;
  return -1;
end;

select findstr('helloworld','a') from dual;

--存储过程练习：
--有一个保存部门每月工资总和的表格
create table dept_sum_sal(
deptno number,
sum_sal number
);
--使用merge into对比更新的方式，运行过程时同步dept_sum_sal的数据
create or replace procedure get_dept_sum
as
begin
  merge into dept_sum_sal a
  using (select deptno,sum(sal) sum_sal from emp group by deptno) b
  on (a.deptno=b.deptno)
  when matched then
    update set
      a.sum_sal=b.sum_sal
  when not matched then
    insert (a.deptno,a.sum_sal)
    values (b.deptno,b.sum_sal);
  commit;
end;

call add_emp2('LILY','CLERK',600,30);
call get_dept_sum();

--包的练习：
--将上面两个练习的内容，使用包进行保存。
create or replace package pro_func_emp
as
  function findstr(str varchar2,s varchar2) return number;
  procedure get_dept_sum;
end pro_func_emp;

create or replace package body pro_func_emp
as
  function findstr(str varchar2,s varchar2) return number
  as
  begin
  for i in 1..length(str) loop
    if substr(str,i,1)=s then
      return i;
    end if;
  end loop;
  return -1;  
  end;

  procedure get_dept_sum
  as
  begin
  merge into dept_sum_sal a
  using (select deptno,sum(sal) sum_sal from emp group by deptno) b
  on (a.deptno=b.deptno)
  when matched then
    update set
      a.sum_sal=b.sum_sal
  when not matched then
    insert (a.deptno,a.sum_sal)
    values (b.deptno,b.sum_sal);
  commit;  
  end;
end pro_func_emp;
```

### with as语句

```sql
with 别名 as (select 查询语句)
select 查询别名里面的语句; 
```

```sql
--查询每个部门里面工资排第一的员工信息，包含所在的部门名称
with a as
(select emp.*,
       row_number() over(partition by deptno order by sal desc) r
  from emp)
select b.*,dname from (select * from a where r=1) b join dept c on b.deptno=c.deptno;

--练习：
--使用with as语句，查询出每个部门里面工资高于自己所在部门平均工资的员工姓名和所在部门编号
with avg_sal as (select deptno,avg(sal) s from emp group by deptno)
select ename,emp.deptno from avg_sal join emp on avg_sal.deptno=emp.deptno
where emp.sal>avg_sal.s;


create table min_record(
tid number,
tname varchar2(10));
insert into min_record values(1,'a');
insert into min_record values(2,'b');
insert into min_record values(3,'b');
insert into min_record values(6,'b');
insert into min_record values(8,'c');
insert into min_record values(3,'a');
insert into min_record values(3,'c');
insert into min_record values(5,'c');
commit;

--答案：
delete from min_record where rowid in
(select rowid from
(select min_record.*,
       row_number() over(partition by tname order by tid) r
  from min_record)
 where r!=1);
```

```sql
上图笔试第15题：
create table r(
c1 date,
c2 number
);
insert into r values(date'2005-1-1',1);
insert into r values(date'2005-1-1',3);
insert into r values(date'2005-1-2',5);
commit;
答案：
select nvl(to_char(c1,'yyyy-mm-dd'),'合并'),sum(c2) from r group by rollup(c1);

上图笔试第16题：
CREATE TABLE NBA (TEAM VARCHAR2(20),Y NUMBER(4));
INSERT INTO NBA VALUES('活塞',1990);
INSERT INTO NBA VALUES('公牛',1991);
INSERT INTO NBA VALUES('公牛',1992);
INSERT INTO NBA VALUES('公牛',1993);
INSERT INTO NBA VALUES('火箭',1994);
INSERT INTO NBA VALUES('火箭',1995);
INSERT INTO NBA VALUES('公牛',1996);
INSERT INTO NBA VALUES('公牛',1997);
INSERT INTO NBA VALUES('公牛',1998);
INSERT INTO NBA VALUES('马刺',1999);
INSERT INTO NBA VALUES('湖人',2000);
INSERT INTO NBA VALUES('湖人',2001);
INSERT INTO NBA VALUES('湖人',2002);
INSERT INTO NBA VALUES('马刺',2003);
INSERT INTO NBA VALUES('活塞',2004);
INSERT INTO NBA VALUES('马刺',2005);
INSERT INTO NBA VALUES('热火',2006);
INSERT INTO NBA VALUES('马刺',2007);
INSERT INTO NBA VALUES('凯尔特人',2008);
INSERT INTO NBA VALUES('湖人',2009);
INSERT INTO NBA VALUES('湖人',2010);
COMMIT;
答案：
select team,min(y) b,max(y) e from
(select nba.*,
       y-(row_number() over(partition by team order by y)) r
  from nba) a
 group by team,r
 having count(1)>1
 order by b asc;
```

## 跨数据库获取数据

> 在oracle里面，跨数据库获取数据，使用数据库链接

```sql
create public database link 数据库链接名字
connect to 对方的用户名 identified by "对方的密码"
using '对方数据库的TNS信息';
```

```sql
create public database link teacher_link
connect to bigdata identified by "111111"
using '(DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = WIN-1QHBNJOO802)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = orcl)
    )
  )';
  
select * from 表名@链接名;
```



```sql
个人贷款项目需要的6个表格：
--银行分行信息表
create table bank_info(
  bank_id number primary key, --银行id
  bank_addr varchar2(100)  --银行所在城市
);

--客户信息表
create table customer_info(
  cus_id number primary key,   --客户id
  cus_name varchar2(20),       --客户名字
  cus_type varchar2(50),         --证件类型
  cus_number varchar2(50)    --证件号码
);

--客户余额表
create table balance_info(
  bal_id varchar2(50) primary key,  --借据号
  contract_id varchar2(50),         --合同编号
  petition_id varchar2(50),         --申请编号 
  loan_amount number(11,2),   --贷款金额
  loan_balance number(11,2),  --贷款余额
  overdue number              --逾期天数
);

--客户贷款合同表
create table contract_info(
  contract_id varchar2(50) primary key,    --合同编号
  petition_id varchar2(50),   --申请编号
  cus_id number,                --客户id
  amount number,              --授信金额
  amount_date date            --授信日期
);

--客户贷款申请表
create table petition_info(
  petition_id varchar2(50) primary key,       --申请编号
  petition_date date,         --申请日期
  product varchar2(50),       --产品名称
  status char(1),             --申请状态
  stat_mod_date date,         --状态最新变更日期
  cus_id number,              --客户编号
  bank_id number           --银行编号
);

--贷款类型
create table product_type(
 tid number,                   --贷款类型编号
 tname varchar2(20)       --贷款类型名称
);

创建一个表格，存储的是
20-29
30-39
40-49
其他
四个不同年龄段申请最多的贷款类型、和平均申请的贷款金额。
create or replace procedure pro_all_agerange
as
begin
  execute immediate 'truncate table age_range_info';
  insert into age_range_info 
  select a.age_range,tname,avg_amount from
(select distinct age_range,tname from
(select e.*,
       max(pro_num) over(partition by age_range) m
  from
(select age_range,tname,
       count(1) over(partition by age_range,tname) pro_num
  from
(select a.*,
       case 
         when age between 20 and 29 then '[20-29]'
         when age between 30 and 39 then '[30-39]'
         when age between 40 and 49 then '[40-49]'
         else 'others'
       end age_range 
  from
(select cus_id,floor(months_between(sysdate,to_date(substr(cus_number,7,8),'yyyymmdd'))/12) age 
  from customer_info) a) c
join petition_info a on c.cus_id=a.cus_id
join product_type b on a.product=b.tid) e)
 where pro_num=m) a

join

(select age_range,round(avg(amount),2) avg_amount
  from
(select * from
(select a.*,
       case 
         when age between 20 and 29 then '[20-29]'
         when age between 30 and 39 then '[30-39]'
         when age between 40 and 49 then '[40-49]'
         else 'others'
       end age_range 
  from
(select cus_id,floor(months_between(sysdate,to_date(substr(cus_number,7,8),'yyyymmdd'))/12) age 
  from customer_info) a) a
  join contract_info b on a.cus_id=b.cus_id) c
  group by age_range) b
  on a.age_range=b.age_range;

  commit;
end;

select * from age_range_info;
call pro_all_agerange();

写出两个存储过程，一个是全量更新这个表格的存储过程，
还有一个是使用merge into更新表格的存储过程。
create or replace procedure pro_merge_agerange
as
begin
  merge into age_range_info a
  using (select a.age_range,tname,avg_amount from
(select distinct age_range,tname from
(select e.*,
       max(pro_num) over(partition by age_range) m
  from
(select age_range,tname,
       count(1) over(partition by age_range,tname) pro_num
  from
(select a.*,
       case 
         when age between 20 and 29 then '[20-29]'
         when age between 30 and 39 then '[30-39]'
         when age between 40 and 49 then '[40-49]'
         else 'others'
       end age_range 
  from
(select cus_id,floor(months_between(sysdate,to_date(substr(cus_number,7,8),'yyyymmdd'))/12) age 
  from customer_info) a) c
join petition_info a on c.cus_id=a.cus_id
join product_type b on a.product=b.tid) e)
 where pro_num=m) a

join

(select age_range,round(avg(amount),2) avg_amount
  from
(select * from
(select a.*,
       case 
         when age between 20 and 29 then '[20-29]'
         when age between 30 and 39 then '[30-39]'
         when age between 40 and 49 then '[40-49]'
         else 'others'
       end age_range 
  from
(select cus_id,floor(months_between(sysdate,to_date(substr(cus_number,7,8),'yyyymmdd'))/12) age 
  from customer_info) a) a
  join contract_info b on a.cus_id=b.cus_id) c
  group by age_range) b
  on a.age_range=b.age_range) b

  on (a.age_range=b.age_range)
  when matched then
    update set
    a.tname=b.tname,
    a.avg_amount=b.avg_amount
  when not matched then
    insert (a.age_range,a.tname,a.avg_amount) 
    values (b.age_range,b.tname,b.avg_amount);
  commit;
end;


年龄段  贷款类型的名字  平均申请贷款金额，保留两位小数
select a.age_range,tname,avg_amount from
(select distinct age_range,tname from
(select e.*,
       max(pro_num) over(partition by age_range) m
  from
(select age_range,tname,
       count(1) over(partition by age_range,tname) pro_num
  from
(select a.*,
       case 
         when age between 20 and 29 then '[20-29]'
         when age between 30 and 39 then '[30-39]'
         when age between 40 and 49 then '[40-49]'
         else 'others'
       end age_range 
  from
(select cus_id,floor(months_between(sysdate,to_date(substr(cus_number,7,8),'yyyymmdd'))/12) age 
  from customer_info) a) c
join petition_info a on c.cus_id=a.cus_id
join product_type b on a.product=b.tid) e)
 where pro_num=m) a

join

(select age_range,round(avg(amount),2) avg_amount
  from
(select * from
(select a.*,
       case 
         when age between 20 and 29 then '[20-29]'
         when age between 30 and 39 then '[30-39]'
         when age between 40 and 49 then '[40-49]'
         else 'others'
       end age_range 
  from
(select cus_id,floor(months_between(sysdate,to_date(substr(cus_number,7,8),'yyyymmdd'))/12) age 
  from customer_info) a) a
  join contract_info b on a.cus_id=b.cus_id) c
  group by age_range) b
  on a.age_range=b.age_range;
```



```sql
统计出下面的数据：
每个银行的网点（银行分行），贷款平均审核通过时间，审核通过率，总贷款金额，未还款金额，坏账比例(逾期超过180天算坏账)，
将银行id（number）,贷款平均审核通过时间(number)，审核通过率(number)，总贷款金额(number)，未还款金额(number)，坏账比例(number)写入到一张维度表中

bank_balance_info_t	银行分行贷款维度表				
银行网点id	贷款平均通过时间(天)	审核通过率	总贷款金额(实际)	未还款金额	
坏账比例(超过180天没有还款的金额总数/所有的未还款总数)
create table bank_balance_info_t(
bank_id number,
avg_day number,
tongguolv number,
loan_amount number,
loan_balance number,
bad_pert number
);

create or replace procedure pro_all_bank
as
begin
  execute immediate 'truncate table bank_balance_info_t';
  insert into bank_balance_info_t
    select distinct a.bank_id,avg_day,tongguolv,zongshu,weihuan,round(yuqi,2) from
    --贷款平均通过时间(天)
    (select bank_id,ceil(avg(d)) avg_day from
    (select bank_id,(stat_mod_date-petition_date) d from petition_info where status=1)
     group by bank_id) a
    join
    --审核通过率
    (select * from
    (select bank_id,
           round((sum(status) over(partition by bank_id))/(count(1) over(partition by bank_id)),2) tongguolv
      from petition_info)
     group by bank_id,tongguolv) b
     on a.bank_id=b.bank_id
    join
    --总贷款金额(实际)	未还款金额	
    (select a.bank_id,zongshu,weihuan,huai/weihuan yuqi from
    (select a.*,
           sum(loan_amount) over(partition by bank_id) zongshu,
           sum(loan_balance) over(partition by bank_id) weihuan
      from
    (select * from balance_info a join petition_info b on a.petition_id=b.petition_id) a) a

join
--坏账比例(超过180天没有还款的金额总数/所有的未还款总数)
(select bank_id,sum(loan_balance) huai from balance_info a join petition_info b on a.petition_id=b.petition_id
where overdue>180
group by bank_id) b
on a.bank_id=b.bank_id ) c
on c.bank_id=a.bank_id
order by a.bank_id;
commit;

end;

select * from bank_balance_info_t;
call pro_all_bank();


```

```sql
create table tb(
t date,
c varchar2(10),
d varchar2(10)
);

insert into tb values(date'2010-01-01','8%','10%');
insert into tb values(date'2011-01-01','5%','7%');
insert into tb values(date'2012-01-01','5%','7%');
insert into tb values(date'2012-10-31','5%','6%');
insert into tb values(date'2013-01-01','5%','6%');
insert into tb values(date'2013-03-31','8%','9%');
insert into tb values(date'2013-09-01','8%','10%');
insert into tb values(date'2014-01-01','8%','9%');
insert into tb values(date'2015-01-01','6%','9%');
commit;
答案：
with a as(
select * from tb where rowid in
(select min(rowid) from
(select t,c,d,t3-t2 zu
  from
(select tb.*,
       row_number() over(partition by c,d order by t) t2,
       row_number() over(order by t) t3
  from tb) a) b
 group by c,d,zu) order by t)

select decode(t,date'2010-01-01',date'0001-01-01',t) t,
       nvl(lead(t) over(order by t)-1,date'9999-12-31') t2,
       c,d
  from a;

update students_3 set gender=case when gender='M' then '0'
                                  when gender='F' then '1'  end;
select gender,count(1) from students_3 where birthday>date'1995-5-1'    
group by gender;  

create table chengji2(
xingming varchar2(20),
xueke varchar2(20),
fenshu number
); 

insert into chengji2 values('zhangsan','yuwen',81);
insert into chengji2 values('zhangsan','shuxue',75);
insert into chengji2 values('lisi','yuwen',76);
insert into chengji2 values('lisi','shuxue',90);
insert into chengji2 values('wangwu','yuwen',81);
insert into chengji2 values('wangwu','shuxue',100);

select xingming from chengji2 group by xingming
having min(fenshu)>80;

select * from
(select chengji2.*,
       avg(fenshu) over(partition by xueke) a
  from chengji2)
 where fenshu>a;

select * from chengji2
pivot(max(fenshu) for xueke in('yuwen','shuxue'));

select * from
(select xingming,
       lag(yuwen) over(partition by xingming order by rownum) yuwen,
       shuxue
  from
(select xingming,
       case when xueke='yuwen' then fenshu end yuwen,
       case when xueke='shuxue' then fenshu end shuxue
  from chengji2))
 where yuwen is not null;

-------------------------------------

select distinct tname from xuesheng a join xuanke b on a.xuehao=b.xuehao
join kecheng c on c.kehao=b.kehao
where xingming like 'wang%'
order by tname;

select keming,count(b.kehao) from kecheng a join xuanke b on a.kehao=b.kehao
group by keming having count(b.kehao)=(
select count(1) from xuesheng
);

select a.xingming,count(b.kehao) from xuesheng a 
join xuanke b on a.xuehao=b.xuehao
group by a.xuehao,a.xingming
having count(b.kehao)<4;

select a.xingming from xuesheng a 
join xuanke b on a.xuehao=b.xuehao
group by a.xuehao,a.xingming
having count(b.kehao)<3
intersect
select xingming from xuesheng where xingming not in
(select a.xingming from xuesheng a join xuanke b on a.xuehao=b.xuehao
join kecheng c on c.kehao=b.kehao
where tname='刘老师');

-------------------------------------------------

select * from t_stu where s_age between 18 and 20 and s_sex='女' or s_sex is null
order by s_age desc;

select c_name,s_name,s_sex,s_money||'元' from t_stu a join t_class b on a.c_id=b.c_id
order by c_id,s_name;

select c_name,count(1) from t_stu a join t_class b on a.c_id=b.c_id
group by c_name having count(1)>=2
order by count(1) desc;

select s_sex,count(1) from
(select s_id,nvl(s_sex,'男') s_sex from t_stu)

group by s_sex;

select n1,n2 from
(select b.*,
       row_number() over(partition by c order by n1) r
  from
(select n1,n2,c1*c2 c from
(select a.*,
       case when n1='a' then 2 
            when n1='b' then 3
            when n1='c' then 4
            when n1='d' then 5 end c1,
       case when n2='a' then 2 
            when n2='b' then 3
            when n2='c' then 4
            when n2='d' then 5 end c2
  from
(select a.name n1,b.name n2 from team a join team b on 1=1 and a.name!=b.name) a)) b)
 where r=1;


```

## 数据库的导入和导出

> 数据库的导入和导出：dmp格式（plsql工具里面的exp.exe工具）和sql格式

```sql
select * from emp where sal>all(
--找出工资最高的人所在的部门的平均工资
(select avg(sal) from emp where deptno=
(select deptno from
(select emp.*,
       max(sal) over() ma
  from emp )
 where sal=ma)),
----找出工资最低的人所在的部门的平均工资
(select avg(sal) from emp where deptno=
(select deptno from
(select emp.*,
       min(sal) over() mi
  from emp )
 where sal=mi)),
--找出最高和最低的两个人所在的部门的平均工资
(select avg(sal) from emp where deptno=
(select deptno from
(select emp.*,
       max(sal) over() ma
  from emp )
 where sal=ma)
 or deptno=
(select deptno from
(select emp.*,
       min(sal) over() mi
  from emp )
 where sal=mi)));
```

### 冷备份

> 冷备份：将数据库关闭之后，对数据库里面的数据文件、控制文件等进行备份

1. 在cmd窗口输入sqlplus进行数据库的命令行模式

2. 输入 system/as sysdba，输入密码

3. 获取数据文件（DBF）、控制文件（CTL）在电脑上的位置

   ```sql
   select name from v$datafile;
   位置   C:\APP\ZX\ORADATA\ORCL\
   select name from v$controlfile;
   位置   C:\APP\ZX\ORADATA\ORCL\
   ```

4. 以DBA的身份连接和关闭数据库
   conn/as sysdba;
   shutdown normal;

5. 将所有的数据文件、控制文件复制一份保存在硬盘的其他位置
   copy   C:\APP\ZX\ORADATA\ORCL\*.dbf   C:\bak_dbf
   copy   C:\APP\ZX\ORADATA\ORCL\*.ctl    C:\bak_ctl

### 热备份

> 热备份：在数据库正在运行的时候，对数据进行备份，采用archive log mode方式进行备份

1. 查看数据库是否是archive log的模式
   archive log list;
2. 修改数据库为归档模式
   先关闭数据库：shutdown immediate
   启动数据库：startup mount
   alter database archivelog;
3. 打开数据库
   alter database open;
4. 打开归档的开关
   alter system set log_archive_start=true scope=spfile;
5. 数据的备份位置

### 冷热的优缺点

冷备份：

- 优点--备份和恢复比较迅速，维护成本低

- 缺点--需要关闭服务器，只能备份某个时间点的数据

热备份：

- 优点--理论上可以直接回溯到服务器上一秒的数据，备份更加精确
- 缺点--需要占用更多的服务器资源，需要很大的空间去存储归档文件

