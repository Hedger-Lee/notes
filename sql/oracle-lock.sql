update emp set sal=sal+100 where empno=7369;

--1.�ڱ�v$locked_object�в�ѯ�Ƿ�������������������������Ӧ�Ķ���id object_id ������id session_id
select * from v$locked_object; --object_id=74609,session_id=9

--2.�������Ķ���id object_id �ڱ�dba_objects�в�ѯ���ľ�����Ϣ�����Կ�����ס�ı���
select * from dba_objects where object_id=74609;

--3.������������id session_id �ڱ�v$session�в�ѯ�����û��ĵ�¼���к�serial#
select * from v$session where sid=9; --serial#=2065

--4.���� session_id,serial# ɾ����Ӧ������Ϣ
alter system kill session '9,2065';

--�����
create table emp_more as select * from emp;
--���140W������
begin
       for i in 1..100000 loop
         insert into emp_more select * from scott.emp;
         commit;
       end loop;
end;

--��ӷ�Χ������
create table emp_range(
empno number,
ename varchar2(30),
job varchar2(30),
mgr number,
hiredate date,
sal number,
comm number,
deptno number
)partition by range(sal)
(
    partition sal01 values less than(2000),
    partition sal02 values less than(3000),
    partition sal03 values less than(maxvalue)
);

insert into emp_range select * from emp_more;

select * from emp_more where sal=3000;
select * from emp_range where sal=3000;

--�����б������
create table emp_list(
empno number,
ename varchar2(30),
job varchar2(30),
mgr number,
hiredate date,
sal number,
comm number,
deptno number
)partition by list(deptno)
(
partition sal10 values(10),
partition sal20 values(20),
partition sal30 values(30)
);

insert into emp_list select * from emp_more;

select * from emp_more where deptno=10;
select * from emp_list where deptno=10;

--����ɢ�з�����
create table emp_hash(
empno number,
ename varchar2(30),
job varchar2(30),
mgr number,
hiredate date,
sal number,
comm number,
deptno number
)partition by hash(ename) partitions 4;

insert into emp_hash select * from emp_more;

select * from emp_more where ename='SMITH';
select * from emp_hash where ename='SMITH';

--������Ϸ�����
create table emp_complex(
empno number,
ename varchar2(30),
job varchar2(30),
mgr number,
hiredate date,
sal number,
comm number,
deptno number
)partition by list(deptno)
subpartition by range(sal)
(
partition sal10 values(10)
(
subpartition sal2000_10 values less than(2000),
subpartition sal3000_10 values less than(3000),
subpartition salmax_10 values less than(maxvalue)
),
partition sal20 values(20)
(
subpartition sal2000_20 values less than(2000),
subpartition sal3000_20 values less than(3000),
subpartition salmax_20 values less than(maxvalue)
),
partition sal30 values(30)
(
subpartition sal2000_30 values less than(2000),
subpartition sal3000_30 values less than(3000),
subpartition salmax_30 values less than(maxvalue)
)
);

insert into emp_complex select * from emp_more;

select * from emp_more where deptno=10 and sal=5000;
select * from emp_complex where deptno=10 and sal=5000;


update emp set sal=sal+100 where empno=7369;

--1.�ڱ�v$locked_object�в�ѯ�Ƿ�������������������������Ӧ�Ķ���id object_id ������id session_id
select * from v$locked_object; --object_id=74609,session_id=9

--2.�������Ķ���id object_id �ڱ�dba_objects�в�ѯ���ľ�����Ϣ�����Կ�����ס�ı���
select * from dba_objects where object_id=74609;

--3.������������id session_id �ڱ�v$session�в�ѯ�����û��ĵ�¼���к�serial#
select * from v$session where sid=9; --serial#=2065

--4.���� session_id,serial# ɾ����Ӧ������Ϣ
alter system kill session '9,2065';

--�����
create table emp_more as select * from emp;
--���140W������
begin
       for i in 1..100000 loop
         insert into emp_more select * from scott.emp;
         commit;
       end loop;
end;

--��ӷ�Χ������
create table emp_range(
empno number,
ename varchar2(30),
job varchar2(30),
mgr number,
hiredate date,
sal number,
comm number,
deptno number
)partition by range(sal)
(
    partition sal01 values less than(2000),
    partition sal02 values less than(3000),
    partition sal03 values less than(maxvalue)
);

insert into emp_range select * from emp_more;

select * from emp_more where sal=3000;
select * from emp_range where sal=3000;

--�����б������
create table emp_list(
empno number,
ename varchar2(30),
job varchar2(30),
mgr number,
hiredate date,
sal number,
comm number,
deptno number
)partition by list(deptno)
(
partition sal10 values(10),
partition sal20 values(20),
partition sal30 values(30)
);

insert into emp_list select * from emp_more;

select * from emp_more where deptno=10;
select * from emp_list where deptno=10;

--����ɢ�з�����
create table emp_hash(
empno number,
ename varchar2(30),
job varchar2(30),
mgr number,
hiredate date,
sal number,
comm number,
deptno number
)partition by hash(ename) partitions 4;

insert into emp_hash select * from emp_more;

select * from emp_more where ename='SMITH';
select * from emp_hash where ename='SMITH';

--������Ϸ�����
create table emp_complex(
empno number,
ename varchar2(30),
job varchar2(30),
mgr number,
hiredate date,
sal number,
comm number,
deptno number
)partition by list(deptno)
subpartition by range(sal)
(
partition sal10 values(10)
(
subpartition sal2000_10 values less than(2000),
subpartition sal3000_10 values less than(3000),
subpartition salmax_10 values less than(maxvalue)
),
partition sal20 values(20)
(
subpartition sal2000_20 values less than(2000),
subpartition sal3000_20 values less than(3000),
subpartition salmax_20 values less than(maxvalue)
),
partition sal30 values(30)
(
subpartition sal2000_30 values less than(2000),
subpartition sal3000_30 values less than(3000),
subpartition salmax_30 values less than(maxvalue)
)
);

insert into emp_complex select * from emp_more;

select * from emp_more where deptno=10 and sal=5000;
select * from emp_complex where deptno=10 and sal=5000;








--9��17�ſκ���ϰ�⣺
--�����������ű�ѧ����  �ɼ���  ��ʦ��  �γ̱�Ȼ������������ݣ�������ɺ������ϰ
--ѧ����
create table students(
sno varchar2(10) primary key,
sname varchar2(20),
sage number(2),
ssex varchar2(5)
);
select * from degree;
alter table teacher rename teacher2;
--��ʦ��
create table teacher(
tno varchar2(10) primary key,
tname varchar2(20)
);
--�γ̱�
create table course(
cno varchar2(10),
cname varchar2(20),
tno varchar2(20)
);
--�ɼ���
create table degree(
sno varchar2(10),
cno varchar2(10),
score number(4,2)
);
/*******��ʼ��ѧ���������******/
insert into students values ('s001','����',23,'��');
insert into students values ('s002','����',23,'��');
insert into students values ('s003','����',25,'��');
insert into students values ('s004','����',20,'Ů');
insert into students values ('s005','����',20,'Ů');
insert into students values ('s006','�',21,'��');
insert into students values ('s007','����',21,'��');
insert into students values ('s008','����',21,'Ů');
insert into students values ('s009','������',23,'Ů');
insert into students values ('s010','����',22,'Ů');
insert into students values ('s011','����',21,'Ů');
commit;
/******************��ʼ����ʦ��***********************/
insert into teacher values ('t001', '����');
insert into teacher values ('t002', '����');
insert into teacher values ('t003', '������');
commit;
/***************��ʼ���γ̱�****************************/
insert into course values ('c001','J2SE','t002');
insert into course values ('c002','Java Web','t002');
insert into course values ('c003','SSH','t001');
insert into course values ('c004','Oracle','t001');
insert into course values ('c005','SQL SERVER 2005','t003');
insert into course values ('c006','C#','t003');
insert into course values ('c007','JavaScript','t002');
insert into course values ('c008','DIV+CSS','t001');
insert into course values ('c009','PHP','t003');
insert into course values ('c010','EJB3.0','t002');
commit;
/***************��ʼ���ɼ���***********************/
insert into degree values ('s001','c001',78.9);
insert into degree values ('s002','c001',80.9);
insert into degree values ('s003','c001',81.9);
insert into degree values ('s004','c001',60.9);
insert into degree values ('s001','c002',82.9);
insert into degree values ('s002','c002',72.9);
insert into degree values ('s003','c002',81.9);
insert into degree values ('s001','c003','59');
commit;








select * from students;

select * from course;
select * from degree;

--SQL��ϰ�⣺
--1.��ѯ������Ů������
select ssex,count(1) from students group by ssex;

select * from 
(select ssex from students)
pivot(count(ssex) for ssex in ('��','Ů'));

--2.��ѯ�ա��š���ѧ������
select * from students where sname like '��%';

--3.��ѯ�ա���������ʦ�ĸ���
select * from teacher;
select count(1) from teacher where tname like '��%';

--4.��ѯѡ�˿γ̵�ѧ������
select count(1) from 
(select distinct sno from degree);

select 

--5.��ѯ��ѧ�����Լ���Ŀγ̣������γ̺ŴӴ�С����
select * from degree;
select c.* from course c join
(select distinct cno from degree where score>=60 order by cno desc) b
on c.cno=b.cno;

--6.��ѯ���Ƴɼ���ߺ���͵ķ֣���������ʽ��ʾ���γ�ID����߷֣���ͷ�
select distinct cno,
       max(score) over(partition by cno) ��߷�,
       min(score) over(partition by cno) ��ͷ�
 from degree;

--7.��ѯ��ͬ�γ�ƽ���ִӸߵ�����ʾ��Ҫ��ʾ�ڿ���ʦ
select a.*,tname from teacher t join
(select c.*,avg_score from course c join
(select distinct cno,
       avg(score) over(partition by cno) avg_score
 from degree) b 
on c.cno=b.cno) a on t.tno=a.tno order by avg_score desc;

--8.��ѯ����ѧ����ѡ�����
select * from course c join
(select s.*,cno,score from students s join degree d on s.sno=d.sno) b
on c.cno=b.cno;

--9.��ѯ��c001�� �γ̳ɼ���80 �����ϵ�ѧ����ѧ�ź�����
select * from students s join
(select * from degree where cno='c001' and score>80) a
on s.sno=a.sno;

--10.��ѯ��c001���γ̷���С��80��ͬѧѧ�ź���������������������
select * from students s join
(select * from degree where cno='c001' and score<80) a
on s.sno=a.sno order by score desc;

--11.��ѯ�γ�����Ϊ��SSH�����ҷ�������60 ��ѧ�������ͷ���
select sname,score from students s join
(select * from course c join degree d on c.cno=d.cno where cname='SSH') a
on s.sno=a.sno;

--12.��ѯ����ͬѧ��ѧ�š�������ѡ�������ܳɼ�
select sname,a.* from students s join
(select distinct sno,
       count(1) over(partition by sno) ѡ����,
       sum(score) over(partition by sno) �ܳɼ�
 from degree) a
on s.sno=a.sno;

--13.��ѯÿ�ſγ̱�ѡ�޵�ѧ����
select distinct cno,
       count(1) over(partition by cno) ѧ����
 from degree;

--14.��ѯ����ѡ�����ſγ̵�ѧ��ѧ�ź�����
select s.sno,sname from students s join
(select * from 
(select distinct sno,
       count(1) over(partition by sno) n
 from degree)
where n>=2) a on s.sno=a.sno;

--15.��ѯ��ֻѡ����һ�ſγ̵�ѧ��ѧ�ź�����
select s.sno,sname from students s join
(select * from 
(select distinct sno,
       count(1) over(partition by sno) n
 from degree)
where n=1) a on s.sno=a.sno;

--16.��ѯƽ���ɼ�����85 ��ͬѧ��ѧ�š�������ƽ���ɼ�
select s.sno,sname,avg_score from students s join
(select distinct sno,
       avg(score) over(partition by sno) avg_score       
 from degree) a on s.sno=a.sno where avg_score>85;

--17.��ѯ���пγ̳ɼ�С��80 �ֵ�ͬѧ��ѧ�š�����
select distinct s.sno,sname from students s join
(select * from degree where score<80) a on s.sno=a.sno;

--18.��ѯ�κ�һ�ſγ̳ɼ���80 �����ϵ�ѧ�����������γ����ƺͷ���
select sname,cname,score from course c join
(select distinct * from students s join
(select * from degree where score>80) a on s.sno=a.sno) b 
on c.cno=b.cno;

--19.��ѯһ�����ϲ�����γ̵�ͬѧ��ѧ�ż���ƽ���ɼ�
select sno,avg_score from 
(select degree.*,
       avg(score) over(partition by sno) avg_score,
       count(1) over(partition by sno) c
 from degree where score<60) where c>1;

--20.��ѯ���Ƴɼ�ǰ�����ļ�¼:(�����ǳɼ��������)
select * from 
(select degree.*,
       row_number() over(partition by cno order by score desc) r
 from degree)
where r<=3;

--21.��ѯÿ�Ź��γɼ���õ�ǰ����(���� )
select * from 
(select degree.*,
       rank() over(partition by cno order by score desc) r
 from degree)
where r<=2;

--22.��ѯ1998�������ѧ������ 
select * from students where (to_char(sysdate,'yyyy')-1998)=sage;

--23.��ѯͬ��ͬ��ѧ����������ͳ��ͬ������
select s1.*,
count(1) over(partition by s1.sname)
from students s1 join students s2 on s1.sname=s2.sname and s1.sno!=s2.sno;

--24.��ѯ��ͬ�γ̳ɼ���ͬ��ѧ����ѧ�š��γ̺š�ѧ���ɼ�
select d1.* from degree d1 join degree d2 on d1.score=d2.score and d1.cno!=d2.cno;

--25.��ѯû��ѧȫ���пε�ͬѧ��ѧ�š�����
select distinct * from 
(select s.*,
count(1) over(partition by s.sno) c
 from degree d right join students s on d.sno=s.sno)
where c<(select count(1) from course);

drop table sale_info;

--���������������ķ�����
create table sale_info(
saleid number,
salename varchar2(20),
saletime date
)partition by range(saletime)
(
           partition TIME20200916 values less than(date'2020-09-16'),
           partition TIME20200917 values less than(date'2020-09-17')
);
--���������������ķ�����
create table sale_info(
saleid number,
salename varchar2(20),
saletime date
)partition by range(saletime)
(
           partition TIME20200916 values less than(date'2020-09-16'),
           partition TIME20200917 values less than(date'2020-09-17'),
           partition TIME20200918 values less than(date'2020-09-18')
);
--�������ĸ������ķ�����
create table sale_info(
saleid number,
salename varchar2(20),
saletime date
)partition by range(saletime)
(
           partition TIME20200916 values less than(date'2020-09-16'),
           partition TIME20200917 values less than(date'2020-09-17'),
           partition TIME20200918 values less than(date'2020-09-18'),
           partition TIME20200919 values less than(date'2020-09-19')
);

--�ϲ������������������⣿��
alter table sale_info merge partitions TIME20200916,TIME20200917,TIME20200918
into partition month09;

select * from user_tab_partitions where table_name='SALE_INFO';
--����·���
alter table sale_info add partition values less than(date'2020-09-18');
--����������
alter table sale_info rename partition SYS_P41 to TIME20200918;
--�ϲ���������
alter table sale_info merge partitions TIME20200916,TIME20200917
into partition month09;
alter table sale_info merge partitions MONTH09,TIME20200918
into partition month09_02;

alter table sale_info rename partition MONTH09_02 to MONTH09;

alter table sale_info rename partition SYS_P43 to MONTH09;
alter table sale_info rename partition SYS_P42 to MONTH09;


--��ַ���
alter table sale_info split partition MONTH09 at(date'2020-09-16');

alter table sale_info split partition SYS_P43 at(date'2020-09-17') into (partition time20200917,partition time20200918);
alter table sale_info rename partition SYS_P42 to TIME20200916;

select * from user_tab_partitions where table_name='SALE_INFO';

--ɾ������
alter table sale_info drop partition TIME20200916;
alter table sale_info drop partition TIME20200917;
alter table sale_info drop partition TIME20200918;


--����ͬ���
create public synonym sal for emp;
select * from sal;
--ɾ��ͬ���
drop public synonym sal;

--����
create sequence seq;
select seq.nextval from dual;
select seq.currval from dual;
drop sequence seq;

create sequence seq
start with 100
maxvalue 110
minvalue 90
increment by 2
cycle
cache 10;

select seq.nextval from dual;


--��ͼ
create or replace view max_dname as
(select dname from dept where deptno=
(select deptno from 
(select deptno,count(1) c from emp group by deptno order by c desc)
where rownum=1))
with read only;

select * from max_dname;

--�ﻯ��ͼ
create materialized view male_20_stu
refresh on commit
as (select * from students where ssex='��' and sage>20);
select * from male_20_stu;

create materialized view female_20_stu
refresh on demand
start with sysdate
next to_date(concat(to_char(sysdate+1,'yyyy-mm-dd'),' 8:00:00'),'yyyy-mm-dd hh24:mi:ss')
as (select * from students where ssex='Ů' and sage>20);

select * from female_20_stu;
update students set sage=25 where sno='s008';

begin
  dbms_mview.refresh(
       LIST=>'FEMALE_20_STU',
       METHOD=>'COMPLETE',
       PARALLELISM=>4
  );
end;























