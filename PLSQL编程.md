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

```sql
if  判断  then
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
  end if; 
end;
```

```sql
if  判断1  then
  执行语句;
elsif  判断2  then
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
  end if; 
end;
```

```sql
if  判断1  then
  执行语句;
elsif  判断2  then
   执行语句;
elsif  判断3 then
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
  elsif n=0 then
    dbms_output.put_line('零'); 
  end if; 
end;
```

```sql
if  判断1  then
  执行语句;
elsif  判断2  then
   执行语句;
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

```





















## 游标处理

### 动态游标

### 静态游标

## 存储过程

## 动态sql语句

## 函数

## 异常处理

## 触发器

## 包