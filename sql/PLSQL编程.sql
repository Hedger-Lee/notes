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

select * from user_tables where table_name like 'EMP%';


--存储过程
--创建存储过程
create or replace procedure benfen_table
as
  cursor m is select * from user_tables where table_name like 'EMP%';
  s varchar2(500);
begin
  for i in m loop
    s:='create table '||i.table_name||'_'||to_char(sysdate,'yyyymmdd')||' as select * from '||i.table_name;
    execute immediate s;
  end loop;
end;

--赋予建表权限
grant create any table to hedger;

call benfen_table();
select * from user_tables where table_name like 'EMP%';


--自动创建分区
create or replace procedure add_user_part
as
  c number;
  s varchar2(500);
begin
  select count(1) into c from user_tab_partitions where table_name='SALE_INFO'
         and partition_name='D'||to_char(sysdate,'yyyymmdd');
  if c=1 then
    dbms_output.put_line('分区已经存在，不会再创建'); 
  else
    s:='alter table sale_info add partition d'||to_char(sysdate,'yyyymmdd')
              ||' values less than (date'''||to_char(sysdate+1,'yyyy-mm-dd')||''')';
    execute immediate s;
  end if;
end;

call add_user_part();

select * from sale_info;
select * from user_tab_partitions where table_name='SALE_INFO';

--全量更新
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
  update zongbu_amount set update_time=sysdate;
  commit;
end;

select * from beijing_amount;
select * from shenzhen_amount;
select * from zongbu_amount;

call all_sale_amount();

--增量更新
--存在疑问？
create or replace procedure part_sale_amount
as
begin
  merge into zongbu_amount a
    using(select beijing_amount.*,'北京' loc from beijing_amount
                 union all
                 select shenzhen_amount.*,'深圳' loc from shenzhen_amount) b
         on(a.saleid=b.saleid and a.saleman=b.saleman and a.price=b.price and a.saletime=b.saletime)
            when matched then
              update set a.update_time=sysdate
            when not matched then
              insert (a.saleid,a.saleman,a.price,a.saletime,a.loc,a.update_time) 
                     values (b.saleid,b.saleman,b.price,b.saletime,b.loc,sysdate);
end;

call part_sale_amount();

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
  --获取奖金
  v_comm:=v_sal*0.1;
  --当前年月日
  v_hiredate:=to_date(to_char(sysdate,'yyyy-mm-dd'),'yyyy-mm-dd');
  --插入数据
  insert into emp values(v_empno,v_ename,v_job,v_mgr,v_hiredate,v_sal,v_comm,v_deptno);
  commit;
end;
call add_emp('lilei','CLERK',1000,30);
select * from emp;

--函数
create or replace function sum_1(n1 number,n2 number)
return number
as
  n3 number;
begin
  n3:=nvl(n1,0)+nvl(n2,0);
  return n3;
end;

select sum_1(12*sal,comm) from emp;
--对于dbms_random.value()函数存在疑问？
--练习：写一个在最小和最大值之间随机整数的函数
create or replace function int_random(m1 integer,m2 integer)
return integer
as
  n number;
begin
  n:=round(dbms_random.value(m1,m2));--四舍五入，随机1.几到13.几，四舍五入之后可以取到 1-14
  return n;
end;
select int_random(1,14) from dual;

select dbms_random.value(1,14) from dual;

--练习：用函数随机N位长度的英文大小写字母
create or replace function yanzhengma(m integer)
return varchar2
as
  s varchar2(26):='qwertyuiopasdfghjklzxcvbnm';
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
select yanzhengma(4) from dual;

--触发器
create or replace trigger jinzhi_president
before delete on emp
for each row
begin
  if :old.job='PRESIDENT' then
    raise_application_error(-20001,'不能删除老板！');
  end if;
--exception
--  when others then
--    dbms_output.put_line(sqlcode||','||sqlerrm); 
end;
delete from emp where job='PRESIDENT';
select * from emp;

--练习：如果是添加新员工，员工的工资不能超过5000，如果是老员工，员工的每次工资更新不能超过原来工资的20%。
create or replace trigger check_emp_sal
before insert or update on emp
for each row
begin
  if inserting then
    if :new.sal>5000 then
      raise_application_error(-20002,'新员工工资不能超过5000元！');
    end if;
  elsif updating then
    if :new.sal>:old.sal*1.2 then
      raise_application_error(-20003,'老员工工资涨幅不能超过20%！');
    end if;
  end if;
end;
update emp set sal=8000 where empno=7369;
select * from emp;
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
    end if;  
  end if;
end;

--操作状态inserting,updating,deleting的疑问？
--根据这三个来判断操作的类型

--后置触发器
--记录表格变更状态的日志表的后置触发器：
create or replace trigger record_emp_logs
after insert or update or delete on emp
for each row
begin
  if inserting then
    insert into emp_logs values(
           :new.empno,:new.ename,:new.job,:new.mgr,:new.hiredate,:new.sal,:new.comm,:new.deptno,
                ora_login_user,'新增数据',sysdate);
  elsif updating then
    insert into emp_logs values(
           :old.empno,:old.ename,:old.job,:old.mgr,:old.hiredate,:old.sal,:old.comm,:old.deptno,
                ora_login_user,'更新前的数据',sysdate);  
    insert into emp_logs values(
           :new.empno,:new.ename,:new.job,:new.mgr,:new.hiredate,:new.sal,:new.comm,:new.deptno,
                ora_login_user,'更新后的数据',sysdate);
  elsif deleting then
    insert into emp_logs values(
           :old.empno,:old.ename,:old.job,:old.mgr,:old.hiredate,:old.sal,:old.comm,:old.deptno,
                ora_login_user,'删除数据',sysdate);
  end if;
end;
select * from emp_logs;

--表格数据的同步操作：
create or replace trigger update_s_zongbu_amount
after insert or delete or update on shenzhen_amount
for each row
begin
  if inserting then
    insert into zongbu_amount values(
           :new.saleid,:new.saleman,:new.price,:new.saletime,'深圳',sysdate);
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


--包
--创建包规范
create or replace package pkg_emp_dept
as
  --函数的声明
  function dept_avg_sal(v_deptno number) return number;
  --过程的声明
  procedure add_dept(v_deptno number,v_dname varchar2,v_loc varchar2);
end pkg_emp_dept;

--定义包体的内容
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

