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

declare
       v_empno number;
       v_sal number;
       c number;
begin
  v_empno:=&员工编号;
  select count(1) into c from emp where empno=v_empno;
  if c=1 then
    select sal into v_sal from emp where empno=v_empno;
    if v_sal>=700 and v_sal<=1200 then
      dbms_output.put_line(1); 
    elsif v_sal>=1201 and v_sal<=1400 then
      dbms_output.put_line(2);
    elsif v_sal>=1401 and v_sal<=2000 then
      dbms_output.put_line(3);
    elsif v_sal>=2001 and v_sal<=3000 then
      dbms_output.put_line(4);
    elsif v_sal>=3001 and v_sal<=9999 then
      dbms_output.put_line(5);
    end if;
  else
    dbms_output.put_line('员工不存在'); 
  end if;
end;























