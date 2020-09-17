update emp set sal=sal+100 where empno=7369;

--1.在表v$locked_object中查询是否存在锁，如果存在锁，查出其对应的对象id object_id 和序列id session_id
select * from v$locked_object; --object_id=74609,session_id=9

--2.根据锁的对象id object_id 在表dba_objects中查询锁的具体信息，可以看到锁住的表名
select * from dba_objects where object_id=74609;

--3.根据锁的序列id session_id 在表v$session中查询上锁用户的登录序列号serial#
select * from v$session where sid=9; --serial#=2065

--4.根据 session_id,serial# 删除对应的锁信息
alter system kill session '9,2065';

--表分区
create table emp_more as select * from emp;
--添加140W条数据
begin
       for i in 1..100000 loop
         insert into emp_more select * from scott.emp;
         commit;
       end loop;
end;

--添加范围分区表
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

--创建列表分区表
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

--创建散列分区表
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

--创建组合分区表
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

--1.在表v$locked_object中查询是否存在锁，如果存在锁，查出其对应的对象id object_id 和序列id session_id
select * from v$locked_object; --object_id=74609,session_id=9

--2.根据锁的对象id object_id 在表dba_objects中查询锁的具体信息，可以看到锁住的表名
select * from dba_objects where object_id=74609;

--3.根据锁的序列id session_id 在表v$session中查询上锁用户的登录序列号serial#
select * from v$session where sid=9; --serial#=2065

--4.根据 session_id,serial# 删除对应的锁信息
alter system kill session '9,2065';

--表分区
create table emp_more as select * from emp;
--添加140W条数据
begin
       for i in 1..100000 loop
         insert into emp_more select * from scott.emp;
         commit;
       end loop;
end;

--添加范围分区表
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

--创建列表分区表
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

--创建散列分区表
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

--创建组合分区表
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








--9月17号课后练习题：
--创建下面四张表：学生表  成绩表  老师表  课程表，然后导入下面的数据，并且完成后面的练习
--学生表
create table students(
sno varchar2(10) primary key,
sname varchar2(20),
sage number(2),
ssex varchar2(5)
);
select * from degree;
alter table teacher rename teacher2;
--老师表
create table teacher(
tno varchar2(10) primary key,
tname varchar2(20)
);
--课程表
create table course(
cno varchar2(10),
cname varchar2(20),
tno varchar2(20)
);
--成绩表
create table degree(
sno varchar2(10),
cno varchar2(10),
score number(4,2)
);
/*******初始化学生表的数据******/
insert into students values ('s001','张三',23,'男');
insert into students values ('s002','李四',23,'男');
insert into students values ('s003','吴鹏',25,'男');
insert into students values ('s004','琴沁',20,'女');
insert into students values ('s005','王丽',20,'女');
insert into students values ('s006','李波',21,'男');
insert into students values ('s007','刘玉',21,'男');
insert into students values ('s008','萧蓉',21,'女');
insert into students values ('s009','陈萧晓',23,'女');
insert into students values ('s010','陈美',22,'女');
insert into students values ('s011','王丽',21,'女');
commit;
/******************初始化教师表***********************/
insert into teacher values ('t001', '刘阳');
insert into teacher values ('t002', '谌燕');
insert into teacher values ('t003', '胡明星');
commit;
/***************初始化课程表****************************/
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
/***************初始化成绩表***********************/
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

--SQL练习题：
--1.查询男生、女生人数
select ssex,count(1) from students group by ssex;

select * from 
(select ssex from students)
pivot(count(ssex) for ssex in ('男','女'));

--2.查询姓“张”的学生名单
select * from students where sname like '张%';

--3.查询姓“刘”的老师的个数
select * from teacher;
select tname,count(1) from teacher where tname like '刘%' group by tname;

--4.查询选了课程的学生人数
select count(1) from 
(select distinct sno from degree) ;

--5.查询有学生考试及格的课程，并按课程号从大到小排列
select * from degree;
select c.* from course c join
(select distinct cno from degree where score>=60 order by cno desc) b
on c.cno=b.cno;

--6.查询各科成绩最高和最低的分：以如下形式显示：课程ID，最高分，最低分
select distinct cno,
       max(score) over(partition by cno) 最高分,
       min(score) over(partition by cno) 最低分
 from degree;

--7.查询不同课程平均分从高到低显示，要显示授课老师
select a.*,tname from teacher t join
(select c.*,avg_score from course c join
(select distinct cno,
       avg(score) over(partition by cno) avg_score
 from degree) b 
on c.cno=b.cno) a on t.tno=a.tno order by avg_score desc;

--8.查询所有学生的选课情况
select * from course c join
(select s.*,cno,score from students s join degree d on s.sno=d.sno) b
on c.cno=b.cno;

--9.查询“c001” 课程成绩在80 分以上的学生的学号和姓名
select * from students s join
(select * from degree where cno='c001' and score>80) a
on s.sno=a.sno;

--10.查询“c001”课程分数小于80的同学学号和姓名，按分数降序排列
select * from students s join
(select * from degree where cno='c001' and score<80) a
on s.sno=a.sno order by score desc;

--11.查询课程名称为“SSH”，且分数低于60 的学生姓名和分数
select sname,score from students s join
(select * from course c join degree d on c.cno=d.cno where cname='SSH') a
on s.sno=a.sno;

--12.查询所有同学的学号、姓名、选课数、总成绩
select sname,a.* from students s join
(select distinct sno,
       count(1) over(partition by sno) 选课数,
       sum(score) over(partition by sno) 总成绩
 from degree) a
on s.sno=a.sno;

--13.查询每门课程被选修的学生数
select distinct cno,
       count(1) over(partition by cno) 学生数
 from degree;

--14.查询至少选修两门课程的学生学号和姓名
select s.sno,sname from students s join
(select * from 
(select distinct sno,
       count(1) over(partition by sno) n
 from degree)
where n>=2) a on s.sno=a.sno;

--15.查询出只选修了一门课程的学生学号和姓名
select s.sno,sname from students s join
(select * from 
(select distinct sno,
       count(1) over(partition by sno) n
 from degree)
where n=1) a on s.sno=a.sno;

--16.查询平均成绩大于85 的同学的学号、姓名和平均成绩
select s.sno,sname,avg_score from students s join
(select distinct sno,
       avg(score) over(partition by sno) avg_score       
 from degree) a on s.sno=a.sno where avg_score>85;

--17.查询所有课程成绩小于80 分的同学的学号、姓名
select distinct s.sno,sname from students s join
(select * from degree where score<80) a on s.sno=a.sno;

--18.查询任何一门课程成绩在80 分以上的学生的姓名、课程名称和分数
select sname,cname,score from course c join
(select distinct * from students s join
(select * from degree where score>80) a on s.sno=a.sno) b 
on c.cno=b.cno;

--19.查询一门以上不及格课程的同学的学号及其平均成绩
select sno,avg_score from 
(select degree.*,
       avg(score) over(partition by sno) avg_score,
       count(1) over(partition by sno) c
 from degree where score<60) where c>1;

--20.查询各科成绩前三名的记录:(不考虑成绩并列情况)
select * from 
(select degree.*,
       row_number() over(partition by cno order by score desc) r
 from degree)
where r<=3;

--21.查询每门功课成绩最好的前两名(并列 )
select * from 
(select degree.*,
       rank() over(partition by cno order by score desc) r
 from degree)
where r<=2;

--22.查询1998年出生的学生名单 
select * from students where (to_char(sysdate,'yyyy')-1998)=sage;

--23.查询同名同姓学生名单，并统计同名人数
select s1.*,
count(1) over(partition by s1.sname)
from students s1 join students s2 on s1.sname=s2.sname and s1.sno!=s2.sno;

--24.查询不同课程成绩相同的学生的学号、课程号、学生成绩
select d1.* from degree d1 join degree d2 on d1.score=d2.score and d1.cno!=d2.cno;

--25.查询没有学全所有课的同学的学号、姓名
select distinct * from 
(select s.*,
count(1) over(partition by s.sno) c
 from degree d right join students s on d.sno=s.sno)
where c<(select count(1) from course);












