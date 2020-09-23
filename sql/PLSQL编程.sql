declare
  n1 number;
begin
  n1:=10;
  dbms_output.put_line('������:'||n1);
end;

declare 
  n1 number;
  n2 number;
  n3 number;
begin
  n1:=&����1��;
  n2:=&����2��;
  n3:=n1+n2;
  dbms_output.put_line(n3);
end;

declare 
  n1 number;
  n2 number;
  n3 number;
begin
  n1:=&����1��;
  n2:=&����2��;
  n3:=n1+n2;
  dbms_output.put_line(n3);
end;


declare
  ename varchar2(20);
begin
  ename:='&������֣�';
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
  t:=to_date('&��'||'-'||'&��'||'-'||'&��','yyyy-mm-dd');
  dbms_output.put_line(t);
end;

--�����ѯ���
declare
  v_ename varchar2(20);
  v_job varchar2(20);
begin
  select ename,job into v_ename,v_job from emp where sal=5000;
  dbms_output.put_line(v_ename||','||v_job); 
end;

--�����ͱ���
declare
  v_ename emp.ename%type;
  v_job emp.job%type;
begin
  select ename,job into v_ename,v_job from emp where sal=5000;
  dbms_output.put_line(v_ename||','||v_job); 
end;

--��¼�ͱ���
declare
  v_user emp%rowtype;
begin
  select * into v_user from emp where sal=5000;
  dbms_output.put_line(v_user.ename||','||v_user.sal||','||v_user.job); 
end;

--record��������
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

--��ϰ��
--��������ʵ�֣�����һ�����ű�ţ������������й�����ߺ͹�����͵��˵����ֺ͹�����Ϣ��
declare
  v_deptno emp.deptno%type;
  type emp_users is record(
       v_ename emp.ename%type,
       v_sal emp.sal%type
  );
  v_user_max emp_users;
  v_user_min emp_users;
begin
  v_deptno:=&�����벿�ű��;
  select ename,sal into v_user_max from
  (select emp.*,max(sal) over() m1 from emp where deptno=v_deptno) where sal=m1 and rownum=1;
  select ename,sal into v_user_min from
  (select emp.*,min(sal) over() m1 from emp where deptno=v_deptno) where sal=m1 and rownum=1;
  dbms_output.put_line('��߹���'||v_user_max.v_sal||','||v_user_max.v_ename); 
  dbms_output.put_line('��߹���'||v_user_min.v_sal||','||v_user_min.v_ename); 
end;
  
--��ϰ��
--����Ա���ı�ţ�������������Ա�����ʹ�ӡû������ˣ������������˵����֣�
declare 
  v_empno emp.empno%type;
  v_ename emp.ename%type;
  c number;
begin
  v_empno:=&Ա�����;
  select count(1) into c from emp where empno=v_empno;
  if c=0 then
    dbms_output.put_line('û�������'); 
  else
    select ename into v_ename from emp where empno=v_empno;
    dbms_output.put_line(v_ename);
  end if;
end;

--����Ա���ı�ţ����Ա����10�Ų��ţ���н10%�������20�Ų��ţ���н20%��30�Ų�����н30%��
declare 
  v_empno emp.empno%type;
  v_deptno emp.deptno%type;
  c number;
begin
  v_empno:=&Ա�����;
  select count(1) into c from emp where empno=v_empno;
  if c=0 then
    dbms_output.put_line('��Ա��������');
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


--�κ���ϰ��
--��oracle������emp���salgrade�������ǹ��ʵĶ�Ӧ��ϵ��
--����һ��Ա���ı�ţ������ӡ�����Ա���Ĺ�����salgrade���ж�Ӧ�ĵȼ���
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
  v_empno:=&Ա�����;
  select count(1) into c from emp where empno=v_empno;
  if c=1 then
    select sal into v_sal from emp where empno=v_empno;
    select grade into v_grade from salgrade where v_sal>=losal and v_sal<=hisal;
    dbms_output.put_line(v_grade); 
  else
    dbms_output.put_line('Ա��������'); 
  end if;
end;


--��case when�ж�emp����ĳ���û�����Ƿ����
declare
  v_empno emp.empno%type;
  c number;
begin
  v_empno:=&Ա�����;
  select count(1) into c from emp where empno=v_empno;
  case
    when c=0 then dbms_output.put_line('���û�������'); 
    else
      dbms_output.put_line('�û�����');
  end case; 
end;

--����100�������������ĺ�
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


--��ϰ��
--��emp�����е�Ա����Ϣ��ѯ�������ж�Ա���Ƿ���manager��
--�����manager���һ�û�����ý��𣬾͸��½���Ϊ�����˹��ʵ�10%��
--����֮��Ҫ��ӡ���޸ĵ���˭����ʾ���֣����Լ��޸ĺ󽱽�Ľ���Ƕ���
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
        dbms_output.put_line('���֣�'||v_user.v_ename||',����'||v_user.v_comm); 
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

--��ϰ����������ڿ�ʼ��Ǯ����һ���1�֣��ڶ����2�֣��������4�֣�ÿ�췭������Ҫ������ܴ湻100WԪ��
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

--��ϰ��ʹ���α��ѯ�����ÿһ���˵ı�ź����֣��Լ����Ա���м�������
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

--��ϰ
--1.ʹ�ô��������һ��1-100�����ֱ��
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
--2.ʹ���α꽫���������������ӵ���88���������ֲ�ѯ����
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


--��ϰ��
--����׼��һ����emp��ͬ�ṹ�ı��
--ʹ���α꽫emp���������������S��ͷ������A��ͷ��Ա�������浽��һ����
--�����ȥ֮�󣬽���Ϊ�յ���0�������ֱ��ֻ������ĸ��д��������ĸСд��
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
    dbms_output.put_line('û���ҵ�����');
  end if; 
  
  update emp set sal=sal+100 where deptno=20;
  if sql%found then
    dbms_output.put_line(sql%rowcount); 
  else
    dbms_output.put_line('û���ҵ�����');
  end if; 
end;

select * from emp;

declare
  type cursor_t is ref cursor;
  m_cursor cursor_t;
  v_user emp%rowtype;
  v_deptno number;
begin
  v_deptno:=&���ű��;
  open m_cursor for select * from emp where deptno=v_deptno;
  loop
    fetch m_cursor into v_user;
    exit when m_cursor%notfound;
    dbms_output.put_line(v_user.empno||v_user.ename); 
  end loop;
  close m_cursor;
end;

--��ϰ��
--��select * from user_tables;�����ҵ����е�emp��ͷ�ı�����һ�ݣ����ݱ�������ǣ�ԭ����_20200923
--����emp_info����Ϊ   emp_info_20200923
select table_name from user_tables where table_name like 'EMP%'

declare
  cursor m is select table_name from user_tables where table_name like 'EMP%';
begin
  for i in m loop
    execute immediate 
            'create table '||concat(i.table_name||'_',to_char(sysdate,'yyyymmdd'))||' as select * from '||i.table_name;
  end loop; 
end;

--ɾ�������н���ı��ݱ�
declare
  cursor m is select table_name from user_tables where table_name like '%\_'||to_char(sysdate,'yyyymmdd') escape '\';
begin
  for i in m loop
    execute immediate 'drop table '||i.table_name;
  end loop; 
end;
analyzed
select * from user_tables where table_name like 'EMP%';

















