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

#### for循环的游标

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



### 动态游标

### 静态游标

## 存储过程

## 动态sql语句

## 函数

## 异常处理

## 触发器

## 包