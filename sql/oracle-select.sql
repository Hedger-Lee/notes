--select
create table emp as select * from scott.emp;
create table dept as select * from scott.dept;

select * from emp;
--精确筛选
select * from emp where deptno=10;
--范围筛选
select * from emp where deptno!=10;
select * from emp where sal>3000;
select * from emp where sal>=3000;
--逻辑筛选
select * from emp where not deptno=10;
select * from emp where deptno=20 and sal<1000;
select * from emp where deptno=20 or sal<1000;
--模糊查询
select * from emp where ename like '%LL%';
select * from emp where ename like '%M__';

insert into emp values(8888,'AB%CD','CLERK',7566,date'2020-01-02',3000.00,100.00,30);
select * from emp where ename like '%\%%' escape '\';
select * from emp where ename like '%$%%' escape '$';

--包含筛选
select * from emp where empno in (7369,7499,7566,7788);
select * from emp where sal between 1000 and 3000;
--空值筛选
select * from emp where comm is null;


--练习：
--1.查询出emp表中部门编号为20，薪水在2000以上（不包括2000）的所有员工，
--显示他们的员工号，姓名以及薪水
select empno,ename,sal from emp where deptno=20 and sal>2000;
--2.查询出所有奖金（comm）字段不为空且金额不等于零的人员的所有信息
select * from emp where comm is not null and comm!=0;
--3.查询出薪水在800到2500之间（闭区间）所有员工的信息
select * from emp where sal between 800 and 2500;
--4.查询出SALESMAN  CLERK  MANAGER这三个工作岗位的所有员工信息
select * from emp where job in ('CLERK','SALESMAN','MANAGER');
--5.查询出名字中有“E”字符，并且薪水在1000以上（不包括1000）的所有员工信息
select * from emp where ename like '%E%' and sal>1000;

--取别名
select emp.*,sal*12 from emp;
select t.*,sal*12 from emp t;
select empno 编号,ename 姓名,sal 工资 from emp where deptno=20 and sal>2000;



--单行函数
--数字相关：
--绝对值  abs(数字)
select abs(-666) from dual;
--四舍五入  round(数字, 小数精度)
select round(1.2345,3) from dual;
--数字截取  trunc(数字, 小数精度)
select trunc(1.2345,3) from dual;
--向下取整  floor(数字)
select floor(1.999) from dual;
--向上取整  ceil(数字)
select ceil(1.001) from dual;
--幂运算      power(数字, 次方)
select power(2,3) from dual;
--取余数运算    mod(数字, 除数)
select mod(12,3) from dual;

--字符串
--截取字符串
select substr('abcdefg',2,3) from dual;
--拼接字符串
select concat('你好','SQL') from dual;
select '你好'||'SQL' from dual;
--计算字符个数
select length('你好') from dual;
--字符串内容的替换
select replace('abcdefg','a','A') from dual;
--去除空格
select trim('   hello    ') from dual;
--填充内容
select lpad('hello',10,'#') from dual;

--时间
--当前时间
select sysdate from dual;
--月份迁移
select add_months(date'2020-09-10',-4) from dual;
--时间间隔
select months_between(date'2020-01-08',date'2020-08-07') from dual;

--类型转换
--转换成字符串
select to_char(sysdate,'yyyy') from dual;
--转换成数字
select to_number('1009') from dual;
--转换成时间
select to_date('2020-10-9','yyyy-mm-dd') from dual;

--练习：
--思考题：
--select出来一个永远是明天早上8点的时间内容
select to_date(concat(to_char(sysdate+1,'yyyy-mm-dd'),' 08:00:00'),'yyyy-mm-dd hh24:mi:ss') from dual;

--查询出emp表中入职时间是星期四的员工
select * from emp where to_char(hiredate,'day')='星期四';
--查询出入职时间超过35年的员工
select * from emp where months_between(sysdate,hiredate)>12*35;

--练习
select * from dept;
select * from emp;
--找出在纽约上班的所有员工的名字
select ename from emp where deptno=(select deptno from dept where loc='NEW YORK');
--找出CLERK分别在哪几个不同的部门（查询出部门名称）
select dname from dept where deptno in (select deptno from emp where job='CLERK');
select dname from dept where deptno = any(select deptno from emp where job='CLERK');

--练习：
--找出没有SALESMAN这个岗位的部门名称
select dname from dept where deptno in (
select deptno from emp where deptno not in (
select deptno from emp where job='SALESMAN'));

--找出没有员工的部门编号
select d.deptno from emp e right join dept d on e.deptno=d.deptno where e.deptno is null;

select * from emp e left join dept d on e.deptno=d.deptno where e.deptno=20;
select * from emp e left join dept d on e.deptno=d.deptno and e.deptno=20;

--分组和聚合
select deptno,count(*),sum(sal),max(sal),min(sal),avg(sal) from emp group by deptno;

--计算10和20部门的人数
select deptno,count(empno) from emp where deptno!=30 group by deptno;
select deptno,count(empno) from emp group by deptno having deptno!=30;
--计算平均工资高于2000的部门
select deptno,avg(sal) from emp group by deptno having avg(sal)>2000;

--练习：
--统计一下不同的工作岗位，最低和最高的工资分别是多少？
select job,max(sal),min(sal) from emp group by job;
--统计一下不同的工作岗位，最低和最高工资的差距，分别是多少？
select job,max(sal),min(sal),max(sal)-min(sal) from emp group by job;
--统计一下，每个部门分别有多少人？要包括所有的部门。
select d.deptno,dname,count(e.empno) from emp e right join dept d on e.deptno=d.deptno group by d.deptno,dname;

select * from emp;
delete from emp where empno=8888;



--课后练习：
--1.查询出emp表中，每个不同部门中每个岗位的最低薪水
select deptno,job,min(sal) from emp group by deptno,job;

--2.查询出每个员工上级领导的名字（mgr是上级领导的员工编号）
select b.ename 员工名,e.ename 上级领导名 from 
emp e right join emp b 
on e.empno=b.mgr;

--3.查询出每个部门里面，薪水最高的员工姓名
select ename,sal,deptno from emp where sal in 
(select max(sal) from emp group by deptno);

select ename from 
emp e join (select deptno,max(sal) max from emp group by deptno) b 
on e.deptno=b.deptno 
where sal=max;

--4.查询出工资高于MILLER这个员工的其他员工信息
select * from emp where sal>(select sal from emp where ename='MILLER');

--5.查询出工资高于自己所在部门平均工资的员工信息
select * from 
emp e join (select deptno,avg(sal) avg from emp group by deptno) b 
on e.deptno=b.deptno 
where sal>avg;

--6.查询出同年同月入职的员工信息
select e1.* from 
emp e1 join emp e2 
on to_char(e1.hiredate,'yyyy-mm')=to_char(e2.hiredate,'yyyy-mm') 
where e1.empno!=e2.empno; 

select * from emp where to_char(hiredate,'yyyy-mm') in(
select to_char(hiredate,'yyyy-mm') from emp
group by to_char(hiredate,'yyyy-mm')
having count(empno)>1);

--7.查询出至少有3个员工的部门编号
select deptno,count(empno) from emp group by deptno having count(empno)>=3;

--8.查询出和SMITH从事相同岗位的其他员工信息
select * from emp where job=
(select job from emp where ename='SMITH') and ename!='SMITH';

--9.按照每个部门的平均工资进行从高到低的排序，平均工资保留两位小数
select deptno,trunc(avg(sal),2) avg from emp group by deptno order by avg desc;

--10.查询出有奖金的人里面，工资最高的那个人的名字
select ename from emp where comm is not null and sal=
(select max(sal) from emp where comm is not null);




