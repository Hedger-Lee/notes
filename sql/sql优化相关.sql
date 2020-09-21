select * from emp where job=(select job from emp where ename='SMITH');

select * from emp a join dept b on a.deptno=b.deptno;

create table emp_i as select * from scott.emp where 1=2;
create index idx_i_deptno on emp_i(deptno);
drop index idx_i_ename;
insert into emp_i select * from scott.emp;
select * from emp_i;

create table dept_i as select * from scott.dept where 1=2;
create index idx_di_deptno on dept_i(deptno);
insert into dept_i select * from scott.dept;
select * from dept_i;

select * from emp_i a join dept_i b on a.deptno=b.deptno;
