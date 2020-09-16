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
ssex char(3) check(ssex='男' or ssex='女'),
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



--新增约束
alter table student_info add constraint pk_stuid primary key(stuid);

alter table student_info add constraint uni_phone unique(phone);

alter table student_info add constraint ck_sname check(sname is not null);

alter table student_info add class_id integer;
alter table student_info add constraint fk_classinfo_classid 
foreign key(class_id) references class_info(cid);

--删除约束
alter table stu_info_3 drop constraint sys_c0011061;




select * from class_info;

insert into class_info values(1001,'一年一班','陈老师');
insert into class_info(cid,cname,teacher) values(1002,'一年二班','李老师');
insert into class_info(cid,cname) values(1003,'一年三班');

update class_info set teacher='周老师' where cid=1001;

delete from class_info where cid=1002;



--练习
create table teacher(
tid integer primary key,
tname varchar2(20) not null
);

insert into teacher values(1,'陈老师');
insert into teacher values(2,'周老师');
insert into teacher values(3,'袁老师');

select * from teacher;

create table course(
coid integer primary key,
cname varchar2(20) not null,
teacher_id integer,
foreign key(teacher_id) references teacher(tid)
);

insert into course values(1,'生物',1);
insert into course(coid,cname) values(2,'体育');
insert into course values(3,'物理',2);

select * from course;

--练习：
--1.新建一个SALGRADE表，表结构和SCOTT.SALGRADE一样，用传统的建表方法；
scott.salgrade
create table salgrade(
grade number,
losal number,
hisal number
);
--2.再新建一个SALGRADE2表，用快速的建表方法，
--把SELECT * FROM SCOTT.SALGRADE 的表结构和数据都复制过来；
create table salgrade2 as select * from scott.salgrade;
select * from salgrade2;
--3.再新建一个SALGRADE3表，用快速的建表方法，
--仅把SELECT * FROM SCOTT.SALGRADE 的表结构复制过来；
create table salgrade3 as select * from scott.salgrade where 1=2;
select * from salgrade3;
--4.删除SALGRADE2表；
drop table salgrade2;
--5.把SALGRADE3表的三个列的列名分别改为A1,A2,A3;
alter table salgrade3 rename column grade to A1;
alter table salgrade3 rename column losal to A2;
alter table salgrade3 rename column hisal to A3;
--6.给SALGRADE3新增一列，列名为A4，类型为NUMBER；
alter table salgrade3 add A4 number;
--7.把SALGRADE3表的A4列改为VARCHAR2(10)类型；
alter table salgrade3 modify A4 varchar2(10);
--8.用INSERT的方法将SCOTT.SALGRADE表的数据复制到SALGRADE表中。
insert into salgrade3(A1,A2,A3) select * from scott.salgrade;


--练习：
--1.用快速建表语句建立EMP2表，表结构和EMP表一致，不需要复制数据；
scott.emp
create table emp2 as select * from scott.emp where 1=2;
--2.给批量插入的方法，把EMP表的数据插入到EMP2表；
insert into emp2 select * from scott.emp;
select * from emp2;
--3.把EMP2表10号部门的员工的奖金，更新为工资的百分之二十；
update emp2 set comm=sal*0.2 where deptno=10;
--4.删除EMP2表岗位为CLERK的员工的信息；
delete from emp2 where job='CLERK';

create table test(
id integer primary key,
money number(4)
);

insert into test values(1,43);

select * from test;

drop table test;
