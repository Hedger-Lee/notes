--上卷函数
select deptno,count(0) from emp group by rollup(deptno);

--集合运算
--union all
select * from emp where sal<1000
union all
select * from emp where sal>3000;

select job from emp where sal<1000 or sal>3000;

--union
select job from emp where deptno=10
union 
select job from emp where deptno=20;

select distinct job from emp where deptno=20 or deptno=10;

--intersect
select job from emp where deptno=10
intersect 
select job from emp where deptno=20;

select distinct job from emp where deptno=20 and job in
(select job from emp where deptno=10);

--minus
select job from emp where deptno=10
minus
select job from emp where deptno=20;

select distinct job from emp where deptno=20 and job not in
(select job from emp where deptno=10);

--练习
--查询出emp表和dept表里面，平均工资最高的部门名称和上班地点
select dname,loc from 
(select * from dept a join 
(select deptno,avg(sal) s from emp group by deptno) b
on a.deptno=b.deptno)
where s=
(select max(s) from dept a join 
(select deptno,avg(sal) s from emp group by deptno) b
on a.deptno=b.deptno);

select dname, loc
  from dept
 where deptno = (select deptno
                   from emp
                  group by deptno
                 having avg(sal) = (select max(s)
                                     from (select deptno, avg(sal) s
                                             from emp
                                            group by deptno)));


--判断员工有没有上级
select emp.*,nvl2(mgr,'有上级','没有上级') 有没有上级 from emp; 

select emp.*,decode(mgr,null,'没有上级','有上级') 有没有上级 from emp; 

--练习：思考题
--用decode判断，尝试给emp表的工资设置四个等级：
--1000以下的（D）  1000-1999之间的（C） 2000-2999之间的（B）  3000以上的（A）
select * from emp;
sign(sal-1000)+sign(sal-2000)+sign(sal-3000)
D:-1-1-1=-3
C:0/1-1-1=-2/-1
B:1+1/0-1=1/0
A:1+1+0/1=2/3
select emp.*,
       decode(sign(sal - 1000) + sign(sal - 2000) + sign(sal - 3000),
              -3,
              'D',
              -2,
              'C',
              -1,
              'C',
              0,
              'B',
              1,
              'B',
              'A') 工资等级
  from emp;

--练习：创建下面的表和数据
create table chengji(
userid number,
score number,
course varchar2(20)
);

insert into chengji values(1,88,'语文');
insert into chengji values(2,54,'语文');
insert into chengji values(3,38,'语文');
insert into chengji values(4,87,'语文');
insert into chengji values(5,92,'语文');
insert into chengji values(1,75,'数学');
insert into chengji values(2,68,'数学');
insert into chengji values(3,25,'数学');
insert into chengji values(4,87,'数学');
insert into chengji values(5,14,'数学');
commit;

--1.查询出考试表中，及格和不及格的人数
select * from chengji;

select count(s) 及格, count(1) - count(s) 不及格
  from (select chengji.*,
               case
                 when score >= 60 then
                  1
                 else
                  null
               end s
          from chengji);

select s,count(1) from
(select chengji.*,
case
  when score>=60 then '及格'
  else '不及格'
end s
 from chengji) a
 group by s;
     
--2.查询出考试表中，每个课程中，及格和不及格的人数
select course, count(s) 及格, count(1) - count(s) 不及格
  from (select chengji.*,
               case
                 when score >= 60 then
                  1
                 else
                  null
               end s
          from chengji)
 group by course;
 
 select course,s,count(1) from
(select chengji.*,
case
  when score>=60 then '及格'
  else '不及格'
end s
 from chengji) a
 group by course,s;
 
 
 --伪列
 --rowid
 select emp.*,rowid from emp;
insert into dept select * from dept;
commit;
select * from dept;
delete from dept where rowid not in
(select min(rowid) from dept group by deptno);

--rownum
select * from 
(select emp.*,rownum r from emp)
where r>=6 and r<=9
;

select emp.*,sum(sal) over(partition by deptno)from emp;

select emp.*,sum(sal) over(order by sal),avg(sal) over(order by sal) from emp;

select emp.*,sum(sal) over() from emp;

select emp.*,sum(sal) over(partition by deptno order by hiredate) from emp;

--练习：
--查询出每个部门中，工资高于自己所在部门平均工资的员工名字和部门编号
select ename,deptno from
(select emp.*,
       avg(sal) over(partition by deptno) s
from emp)
where sal>s
;

--练习
--找出每个工作岗位的工资前两名，考虑并列的情况
select * from 
(select emp.*,
       dense_rank() over(partition by job order by sal desc) d
from emp) 
where d<=2;


--练习
create table t1(
tid number,
tname varchar2(5)
);
insert into t1 values(1,'/');
insert into t1 values(2,'A');
insert into t1 values(3,'B');
insert into t1 values(4,'C');
insert into t1 values(5,'/');
insert into t1 values(6,'D');
insert into t1 values(7,'E');
insert into t1 values(8,'/');
insert into t1 values(9,'F');
insert into t1 values(10,'G');
insert into t1 values(11,'H');
commit;

select tid,tname,tid-r group_id
from
(select a.*,
       row_number() over(order by tid) r
  from
(select * from t1 where tname!='/') a);
--先选出没有'/'的表，然后使用排名函数row_number()，
--得到对应的排序，再将tid-排名即可得到对应的差值，差值为组名

select tid,tname,group_id
from
(select a.*,
       sum(c) over(order by tid) group_id
   from
(select t1.*,
       case
         when tname='/' then 1 else 0
       end  c
 from t1) a)
 where tname!='/';
--先将有'/'的那一行后面新增一列1，没有的为0，
--使用聚合函数累加效果，求出对应的组名，筛选去除'/'所在的行


--练习：
--1.列出薪金高于部门平均薪金的所有员工信息,要额外显示部门名称
select b.empno,b.ename,b.job,b.mgr,b.hiredate,b.sal,b.comm,b.deptno,dname from dept c join
(select * from 
(select emp.*,
       avg(sal) over(partition by deptno) a
 from emp)
where sal>a) b
on c.deptno=b.deptno;

--2.查询出表EMP中第8条到第13条之间的记录，然后按工资降序排列
select * from 
(select emp.*,rownum r from emp)
where r>=8 and r<=13
order by sal desc;

--3.查询出表EMP中第8条到第13条之间，工资最高的3位员工的员工信息，要额外显示部门名称
select b.empno,
       b.ename,
       b.job,
       b.mgr,
       b.hiredate,
       b.sal,
       b.comm,
       b.deptno,
       dname
  from dept c
  join (select *
          from (select a.*, row_number() over(order by sal desc) o
                  from (select *
                          from (select emp.*, rownum r from emp)
                         where r >= 8
                           and r <= 13
                         order by sal desc) a)
         where o <= 3) b
    on c.deptno = b.deptno;

--4.查询出工资大于其下属所有员工工资的领导信息
select * from emp where empno in
(select empno
from
(select a.*,
       case
         when a.sal>b.sal then 1 else null
       end c
 from emp a join emp b on a.empno=b.mgr) t
group by empno having count(1)=count(c));

select * from emp a join emp b on a.empno=b.mgr order by a.empno;

--5.查询每个人在自己所在部门中工资所占的比例，结果保留两位小数
select t.*,round(sal/s,2) from 
(select emp.*,
       sum(sal) over(partition by deptno) s
 from emp) t;

--6.查询每个员工和自己所在部门最大工资之间的差距
select t.*,m-sal
from
(select emp.*,
       max(sal) over(partition by deptno) m
 from emp) t;







 
 
 
 
 
 
 
 
 
 
 
 
 



























