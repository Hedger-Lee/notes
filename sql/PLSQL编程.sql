declare
  n1 number;
begin
  n1:=10;
  dbms_output.put_line('数字是:'||n1);
end;

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


declare
  ename varchar2(20);
begin
  ename:='&你的名字：';
  dbms_output.put_line(ename);
end;


declare
  ename varchar2(20);
begin
  ename:='&&haha';
  dbms_output.put_line(ename);
end;

declare
  t date;
begin
  t:=to_date('&年'||'-'||'&月'||'-'||'&日','yyyy-mm-dd');
  dbms_output.put_line(t);
end;

--保存查询结果
declare
  v_ename varchar2(20);
  v_job varchar2(20);
begin
  select ename,job into v_ename,v_job from emp where sal=5000;
  dbms_output.put_line(v_ename||','||v_job); 
end;

--引用型变量
declare
  v_ename emp.ename%type;
  v_job emp.job%type;
begin
  select ename,job into v_ename,v_job from emp where sal=5000;
  dbms_output.put_line(v_ename||','||v_job); 
end;

--记录型变量
declare
  v_user emp%rowtype;
begin
  select * into v_user from emp where sal=5000;
  dbms_output.put_line(v_user.ename||','||v_user.sal||','||v_user.job); 
end;

--record复合类型
declare
  type emp_users is record(
       v_empno emp.empno%type,
       v_ename emp.ename%type,
       v_job emp.job%type,
       v_deptno emp.deptno%type
  );
  v_user emp_users;
begin
  select empno,ename,job,deptno into v_user from emp where sal=5000;
  dbms_output.put_line(v_user.v_empno); 
  dbms_output.put_line(v_user.v_ename); 
  dbms_output.put_line(v_user.v_job); 
  dbms_output.put_line(v_user.v_deptno); 
end;

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
  
--练习：
--输入员工的编号，如果不存在这个员工，就打印没有这个人，否则输出这个人的名字；
declare 
  v_empno emp.empno%type;
  v_ename emp.ename%type;
  c number;
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
  v_empno emp.empno%type;
  v_deptno emp.deptno%type;
  c number;
begin
  v_empno:=&员工编号;
  select count(1) into c from emp where empno=v_empno;
  if c=0 then
    dbms_output.put_line('该员工不存在');
  else
    select deptno into v_deptno from emp where empno=v_empno;
    if v_deptno=10 then
       update emp set sal=sal*(1+0.1) where empno=v_empno;
       commit;
    elsif v_deptno=20 then
       update emp set sal=sal*(1+0.2) where empno=v_empno;
       commit;
    elsif v_deptno=30 then
       update emp set sal=sal*(1+0.3) where empno=v_empno;
       commit; 
    end if;  
  end if;
end;

update emp set sal=800 where empno=7369;
select * from emp;


--课后练习：
--在oracle里面有emp表和salgrade表，里面是工资的对应关系，
--输入一个员工的编号，输出打印出这个员工的工资在salgrade表中对应的等级。
select * from scott.salgrade;
select * from scott.emp;
select * from salgrade;
insert into salgrade select * from scott.salgrade;
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

declare
begin
  for i in 1..4 loop
    for j in 1..i loop
      dbms_output.put('*'); 
    end loop;
    dbms_output.put_line(''); 
  end loop;
end;

declare
begin
  for i in 1..9 loop
    for j in 1..i loop
      dbms_output.put(j||'x'||i||'='||i*j||'  '); 
    end loop;
    dbms_output.put_line(''); 
  end loop;
end;


--练习：
--将emp中所有的员工信息查询出来，判断员工是否是manager，
--如果是manager并且还没有设置奖金，就更新奖金为他本人工资的10%，
--改完之后还要打印出修改的是谁（显示名字），以及修改后奖金的结果是多少
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


declare
  m number:=1;
  n number;
begin
  while m<=5 loop
    n:=1;
    while n<=5 loop
      dbms_output.put('*'); 
      n:=n+1;
    end loop;
    dbms_output.put_line(''); 
    m:=m+1;
  end loop;
end;

declare
  m number:=1;
  n number;
begin
  loop
    exit when m>5;
    n:=1;
    loop
      exit when n>5;
      dbms_output.put('*'); 
      n:=n+1;
    end loop;
    dbms_output.put_line(''); 
    m:=m+1;
  end loop;
end;

--练习：假如从现在开始存钱，第一天存1分，第二天存2分，第三天存4分，每天翻倍，需要几天才能存够100W元。
declare
  s number:=0;
  m number:=0.01;
  d number:=0;
begin
  while s<1000000 loop
    s:=s+m;
    m:=m*2;
    d:=d+1;
    dbms_output.put_line(s||','||m||','||d); 
  end loop;
  dbms_output.put_line(d); 
end;

--练习：使用游标查询表格中每一个人的编号和名字，以及这个员工有几个下属
declare
  cursor m_cursor is select a.empno,a.ename,count(b.empno) from emp a left join emp b on a.empno=b.mgr group by a.empno,a.ename;
  type v_users is record(
       v_empno emp.empno%type,
       v_ename emp.ename%type,
       c number
  );
  v_user v_users;
begin
  open m_cursor;
  fetch m_cursor into v_user;
  while m_cursor%found loop
    dbms_output.put_line(v_user.v_empno||','||v_user.v_ename||','||v_user.c);
    fetch m_cursor into v_user;
  end loop;
  close m_cursor;
end;

declare
  cursor m_cursor is select a.empno,a.ename,count(b.empno) from emp a left join emp b on a.empno=b.mgr group by a.empno,a.ename;
  type v_users is record(
       v_empno emp.empno%type,
       v_ename emp.ename%type,
       c number
  );
  v_user v_users;
begin
  open m_cursor;
  loop  
     fetch m_cursor into v_user;
     exit when m_cursor%notfound;
     dbms_output.put_line(v_user.v_empno||','||v_user.v_ename||','||v_user.c); 
  end loop;
  close m_cursor;
end;

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


--练习：
--首先准备一个和emp相同结构的表格，
--使用游标将emp表格中名字里面由S开头或者是A开头的员工，保存到另一个表，
--保存进去之后，奖金为空的用0处理，名字变成只有首字母大写，其余字母小写。
create table emp_2 as select * from scott.emp where 1=2;

declare
  cursor m is select * from emp where ename like 'S%' 
              union all 
              select * from emp where ename like 'A%';
  v_user emp%rowtype;
begin
  open m;
  loop
    fetch m into v_user;
    exit when m%notfound;
    insert into emp_2 values(v_user.empno,initcap(v_user.ename),v_user.job,v_user.mgr,
                                v_user.hiredate,v_user.sal,nvl(v_user.comm,0),v_user.deptno);
    commit;
  end loop;
  close m;
end;

select * from emp_2;
truncate table emp_2;

create table emp_1 as select * from emp where 1=2;
create table emp_3 as select * from emp where 1=2;

declare
  type cursor_t is ref cursor;
  m cursor_t;
  v_user emp%rowtype;
begin
  open m for select * from emp;
  loop
    fetch m into v_user;
    exit when m%notfound;
    case
      when to_number(to_char(v_user.hiredate,'mm'))>=1 
                                and to_number(to_char(v_user.hiredate,'mm'))<=4 then
        insert into emp_1 values(v_user.empno,v_user.ename,v_user.job,v_user.mgr,
                                v_user.hiredate,v_user.sal,v_user.comm,v_user.deptno);
        commit;
      when to_number(to_char(v_user.hiredate,'mm'))>=5 
                                and to_number(to_char(v_user.hiredate,'mm'))<=8 then
        insert into emp_2 values(v_user.empno,v_user.ename,v_user.job,v_user.mgr,
                                v_user.hiredate,v_user.sal,v_user.comm,v_user.deptno);
        commit;
      when to_number(to_char(v_user.hiredate,'mm'))>=9 
                                and to_number(to_char(v_user.hiredate,'mm'))<=12 then
        insert into emp_3 values(v_user.empno,v_user.ename,v_user.job,v_user.mgr,
                                v_user.hiredate,v_user.sal,v_user.comm,v_user.deptno);
        commit;
      end case;
  end loop;
  close m;
end;

select * from emp_1;
select * from emp_2;
select * from emp_3;
truncate table emp_1;
truncate table emp_2;
truncate table emp_3;


declare
begin
  update emp set sal=sal+100 where deptno=10;
  if sql%found then
    dbms_output.put_line(sql%rowcount); 
  else
    dbms_output.put_line('没有找到数据');
  end if; 
  
  update emp set sal=sal+100 where deptno=20;
  if sql%found then
    dbms_output.put_line(sql%rowcount); 
  else
    dbms_output.put_line('没有找到数据');
  end if; 
end;

select * from emp;

declare
  type cursor_t is ref cursor;
  m_cursor cursor_t;
  v_user emp%rowtype;
  v_deptno number;
begin
  v_deptno:=&部门编号;
  open m_cursor for select * from emp where deptno=v_deptno;
  loop
    fetch m_cursor into v_user;
    exit when m_cursor%notfound;
    dbms_output.put_line(v_user.empno||v_user.ename); 
  end loop;
  close m_cursor;
end;

--练习：
--在select * from user_tables;里面找到所有的emp开头的表，备份一份，备份表的名字是：原表名_20200923
--例如emp_info表备份为   emp_info_20200923
select table_name from user_tables where table_name like 'EMP%'

declare
  cursor m is select table_name from user_tables where table_name like 'EMP%';
begin
  for i in m loop
    execute immediate 
            'create table '||concat(i.table_name||'_',to_char(sysdate,'yyyymmdd'))||' as select * from '||i.table_name;
  end loop; 
end;

--删除掉所有今天的备份表
declare
  cursor m is select table_name from user_tables where table_name like '%\_'||to_char(sysdate,'yyyymmdd') escape '\';
begin
  for i in m loop
    execute immediate 'drop table '||i.table_name;
  end loop; 
end;
analyzed
select * from user_tables where table_name like 'EMP%';

















