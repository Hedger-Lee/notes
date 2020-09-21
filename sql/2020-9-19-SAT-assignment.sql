select * from emp;
----（1） 查询20部门的所有员工信息。
select * from emp where deptno=20;

----（2） 查询所有工种为CLERK的员工的员工号、员工名和部门号。
select empno,ename,deptno from emp where job='CLERK';

----（3） 查询奖金（COMM）高于工资（SAL）的员工信息。
select * from emp where comm>sal;

----（4） 查询奖金高于工资的20%的员工信息
select * from emp where comm>(sal*0.2);

----（5） 查询10号部门中工种为MANAGER和20部门中工种为CLERK的员工的信息。
select * from emp where deptno=10 and job='MANAGER'
union all
select * from emp where deptno=20 and job='CLERK';

----（6） 查询所有工种不是MANAGER和CLERK的员工信息
select * from emp where job not in('MANAGER','CLERK');

----（7） 查询有奖金的员工的不同工种。
select distinct job from emp where comm is not null;

----（8） 查询所有员工工资与奖金的和。
select 
sum(case when comm is null then sal else sal+comm end) total
 from emp;

----（9） 查询没有奖金或奖金低于100的员工信息。
select * from emp where comm is null or comm<100;

----（10） 查询在每个月上半个月入职的员工信息（15号之前入职）。
select * from emp where to_number(to_char(hiredate,'dd'))<15;

----（11） 查询工龄大于或等于25年的员工信息。
select * from emp where (months_between(sysdate,hiredate)/12)>=25;

----（12） 查询员工信息，要求以首字母大写的方式显示所有员工的姓名。
select empno,substr(ename,1,1)||lower(substr(ename,2)) ename,job,mgr,hiredate,sal,comm,deptno 
from emp;

select empno,replace(ename,substr(ename,2),lower(substr(ename,2))) ename,job,mgr,hiredate,sal,comm,deptno 
from emp;


----（13） 查询员工名正好为6个字符的员工的信息。
select * from emp where length(ename)=6;

----（14） 查询员工名字中不包含字母“Ｓ”的员工。
select * from emp where ename  not like '%S%'; 

----（15） 查询员工姓名的第二字母为“M”的员工信息。
select * from emp where ename like '_M%';

----（16） 查询所有员工姓名的前三个字符。
select substr(ename,1,3) from emp;

----（17） 查询所有员工的姓名，如果包含字母“S”，则用“_”替换。
select replace(ename,'S','_') from emp; 

----（18）查询员工的姓名和入职日期，并按入职日期从先到后进行排序。
select ename,hiredate from emp order by hiredate;

----（19） 显示所有员工的姓名、工种、工资和奖金，按工种降序排序，
select ename,job,sal,comm from emp order by job desc;

----（20） 显示所有员工的姓名、入职的年份和月份,按入职日期所在的月份排序，若月份相同则按入职的年份排序。
select ename,to_char(hiredate,'yyyy') y,to_char(hiredate,'mm') m from emp order by m,y;

----（21） 查询在2月份入职的所有员工信息。
select * from emp where to_number(to_char(hiredate,'mm'))=2;

----（22） 查询所有员工入职以来的工作期限，用“XX年XX月XX日”的形式表示。
select to_char(floor(total/12))||'年'||
to_char(floor(total-floor(total/12)*12))||'月'||
to_char(floor(((total-floor(total/12)*12)-floor(total-floor(total/12)*12))*30))||'日'
from
(select months_between(sysdate,hiredate) total from emp);

----（23） 查询至少有两个员工的部门信息。
select * from dept where deptno in(
select deptno from emp group by deptno having count(1)>=2);

----（24） 查询工资比SMITH员工工资高的所有员工信息。
select * from emp where sal>
(select sal from emp where ename='SMITH');

----（25） 查询所有员工的姓名及其直接上级的姓名。
select e1.ename,e2.ename from emp e1 join emp e2 on e1.mgr=e2.empno;

----（26） 查询入职日期早于其直接上级领导的所有员工信息。
select e1.* from emp e1 join emp e2 on e1.mgr=e2.empno where e1.hiredate<e2.hiredate;

----（27） 查询所有部门及其员工信息，包括那些没有员工的部门。
select * from emp a right join dept b on a.deptno=b.deptno;

----（28） 查询所有员工及其部门信息，包括那些还不属于任何部门的员工。
select * from emp a left join dept b on a.deptno=b.deptno;

----（29） 查询所有工种为CLERK的员工的姓名及其部门名称。
select ename,dname from emp a join dept b on a.deptno=b.deptno where job='CLERK';

----（30） 查询最低工资大于2500的各种工作。
select job from emp group by job having min(sal)>2500;

----（31） 查询平均工资低于2000的部门及其员工信息。
select * from dept a join
(select * from 
(select emp.*,avg(sal) over(partition by deptno) avg_score from emp) where avg_score<2000) b
on a.deptno=b.deptno;

----（32） 查询在SALES部门工作的员工的姓名信息。
select * from emp where deptno=(select deptno from dept where dname='SALES');

----（33） 查询工资高于公司平均工资的所有员工信息。
select * from emp where sal>
(select avg(sal) from emp);

----（34） 查询出与SMITH员工从事相同工作的所有员工信息。
select * from emp where job =
(select job from emp where ename='SMITH');

----（35） 列出工资等于30部门中某个员工的工资的所有员工的姓名和工资。
select ename,sal from emp where sal in(
select sal from emp where deptno=30);

----（36） 查询工资高于30部门工作的所有员工的工资的员工姓名和工资。
select ename,sal from emp where sal>
all(select sal from emp where deptno=30);

----（37） 查询每个部门中的员工数量、平均工资和平均工作年限。
select deptno,count(1),avg(sal),avg(to_number(to_char(sysdate,'yyyy')-to_char(hiredate,'yyyy'))) from emp group by deptno; 

----（38） 查询从事同一种工作但不属于同一部门的员工信息。
select * from emp e1 join emp e2 on e1.job=e2.job and e1.empno!=e2.empno and e1.deptno!=e2.deptno;

----（39） 查询各个部门的详细信息以及部门人数、部门平均工资。
select * from dept a join
(select deptno,count(1),avg(sal) from emp group by deptno) b on a.deptno=b.deptno;

----（40） 查询各种工作的最低工资。
select job,min(sal) from emp group by job;

----（41） 查询各个部门中不同工种的最高工资。
select deptno,job,max(sal) from emp group by deptno,job;

----（42） 查询10号部门员工及其领导的信息。
select * from emp e1 join emp e2 on e1.mgr=e2.empno where e1.deptno=10

----（43） 查询各个部门的人数及平均工资。
select deptno,count(1),avg(sal) from emp group by deptno;

----（44） 查询工资为自己部门平均工资的员工的信息。
select * from 
(select emp.*,avg(sal) over(partition by deptno) avg_sal from emp)
where sal=avg_sal;

----（45） 查询工资高于本部门平均工资的员工的信息。
select * from 
(select emp.*,avg(sal) over(partition by deptno) avg_sal from emp)
where sal>avg_sal;

----（46） 查询工资高于本部门平均工资的员工的信息及其部门的平均工资。
select * from 
(select emp.*,avg(sal) over(partition by deptno) avg_sal from emp)
where sal>avg_sal;

----（47） 查询工资高于20号部门某个员工工资的员工的信息。
select * from emp where sal>
any(select sal from emp where deptno=20) and deptno!=20;

----（48）统计各个工种的员工人数与平均工资。
select job,count(1),avg(sal) from emp group by job;

----（49） 统计每个部门中各工种的人数与平均工资。
select deptno,job,count(1),avg(sal) from emp group by deptno,job;

----（50） 查询其他部门中工资、奖金与30号部门某员工工资、奖金都相同的员工的信息。
select * from emp a join 
(select * from emp where deptno=30) b on a.sal=b.sal and a.comm=b.comm and a.empno!=b.empno;

----（51） 查询部门人数大于5的部门的员工信息。
select * from emp where deptno in(
select deptno from emp group by deptno having count(1)>5);

----（52） 查询所有员工工资都大于1000的部门的信息。
select * from dept where deptno in(
select deptno from emp group by deptno having min(sal)>1000);

----（53） 查询所有员工工资都大于1000的部门的信息及其员工信息。
select * from emp a join dept b on a.deptno=b.deptno where a.deptno in(
select deptno from emp group by deptno having min(sal)>1000);

----（54） 查询所有员工工资都在900～3000之间的部门的信息。
select * from dept where deptno in 
(select deptno from 
(select emp.*,
case when sal>=900 and sal<=3000 then 1 else null end c
 from emp) group by deptno having count(1)=count(c));

----（55） 查询有工资在900～3000之间的员工所在部门的员工信息。
select * from emp where deptno in 
(select deptno from 
(select emp.*,
case when sal>=900 and sal<=3000 then 1 else null end c
 from emp) group by deptno having count(1)=count(c));

----（56） 查询每个员工的领导所在部门的信息。
select * from dept where deptno in
(select b.deptno from emp a join emp b on a.mgr=b.empno);

----（57） 查询人数最多的部门信息。
select * from dept where deptno=
(select deptno from 
(select deptno,count(1) c from emp group by deptno order by c desc) where rownum=1);

----（58） 查询30号部门中工资排序前3名的员工信息。
select * from 
(select * from emp where deptno=30 order by sal desc) where rownum<=3;

----（59） 查询所有员工中工资排序在5到10名之间的员工信息。
select * from 
(select emp.*,row_number() over(order by sal desc) r from emp)
where r>5 and r<10;

----（60） 查询指定年份之间入职的员工信息。(1980-1985)
select * from emp where to_number(to_char(hiredate,'yyyy'))>=1980 and to_number(to_char(hiredate,'yyyy'))<=1985;
