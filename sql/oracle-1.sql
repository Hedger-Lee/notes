create user hedger identified by 123456;

grant connect,resource,dba to hedger;

create table stu_info(
stuid integer,
sname varchar2(12),
mobile char(11),
ssex char(3),
study_time date,
stu_height number(4,2)
);

alter table stu_info add addr varchar(100) not null;

alter table stu_info drop column addr;

alter table stu_info modify mobile integer;

alter table stu_info rename column mobile to phone;

alter table stu_info rename to student_info;

create table stu_info_2(
stuid integer primary key,
sname varchar2(12) not null,
mobile char(11) unique,
ssex char(3) check(ssex='��' or ssex='Ů'),
study_time date,
stu_height number(4,2) check(stu_height>=0.8 and stu_height<=2.5)
);


create table class_info(
cid integer primary key,
cname varchar2(20) not null,
teacher varchar2(20)
);

create table stu_info_3(
stuid integer primary key,
sname varchar2(20) not null,
class_id integer,
mobile char(11) unique,
foreign key(class_id) references class_info(cid)
);



--����Լ��
alter table student_info add constraint pk_stuid primary key(stuid);

alter table student_info add constraint uni_phone unique(phone);

alter table student_info add constraint ck_sname check(sname is not null);

alter table student_info add class_id integer;
alter table student_info add constraint fk_classinfo_classid 
foreign key(class_id) references class_info(cid);

--ɾ��Լ��
alter table stu_info_3 drop constraint sys_c0011061;




select * from class_info;

insert into class_info values(1001,'һ��һ��','����ʦ');
insert into class_info(cid,cname,teacher) values(1002,'һ�����','����ʦ');
insert into class_info(cid,cname) values(1003,'һ������');

update class_info set teacher='����ʦ' where cid=1001;

delete from class_info where cid=1002;



--��ϰ
create table teacher(
tid integer primary key,
tname varchar2(20) not null
);

insert into teacher values(1,'����ʦ');
insert into teacher values(2,'����ʦ');
insert into teacher values(3,'Ԭ��ʦ');

select * from teacher;

create table course(
coid integer primary key,
cname varchar2(20) not null,
teacher_id integer,
foreign key(teacher_id) references teacher(tid)
);

insert into course values(1,'����',1);
insert into course(coid,cname) values(2,'����');
insert into course values(3,'����',2);

select * from course;

--��ϰ��
--1.�½�һ��SALGRADE����ṹ��SCOTT.SALGRADEһ�����ô�ͳ�Ľ�������
scott.salgrade
create table salgrade(
grade number,
losal number,
hisal number
);
--2.���½�һ��SALGRADE2���ÿ��ٵĽ�������
--��SELECT * FROM SCOTT.SALGRADE �ı�ṹ�����ݶ����ƹ�����
create table salgrade2 as select * from scott.salgrade;
select * from salgrade2;
--3.���½�һ��SALGRADE3���ÿ��ٵĽ�������
--����SELECT * FROM SCOTT.SALGRADE �ı�ṹ���ƹ�����
create table salgrade3 as select * from scott.salgrade where 1=2;
select * from salgrade3;
--4.ɾ��SALGRADE2��
drop table salgrade2;
--5.��SALGRADE3��������е������ֱ��ΪA1,A2,A3;
alter table salgrade3 rename column grade to A1;
alter table salgrade3 rename column losal to A2;
alter table salgrade3 rename column hisal to A3;
--6.��SALGRADE3����һ�У�����ΪA4������ΪNUMBER��
alter table salgrade3 add A4 number;
--7.��SALGRADE3���A4�и�ΪVARCHAR2(10)���ͣ�
alter table salgrade3 modify A4 varchar2(10);
--8.��INSERT�ķ�����SCOTT.SALGRADE������ݸ��Ƶ�SALGRADE���С�
insert into salgrade3(A1,A2,A3) select * from scott.salgrade;


--��ϰ��
--1.�ÿ��ٽ�����佨��EMP2����ṹ��EMP��һ�£�����Ҫ�������ݣ�
scott.emp
create table emp2 as select * from scott.emp where 1=2;
--2.����������ķ�������EMP������ݲ��뵽EMP2��
insert into emp2 select * from scott.emp;
select * from emp2;
--3.��EMP2��10�Ų��ŵ�Ա���Ľ��𣬸���Ϊ���ʵİٷ�֮��ʮ��
update emp2 set comm=sal*0.2 where deptno=10;
--4.ɾ��EMP2���λΪCLERK��Ա������Ϣ��
delete from emp2 where job='CLERK';

create table test(
id integer primary key,
money number(4)
);

insert into test values(1,43);

select * from test;

drop table test;
