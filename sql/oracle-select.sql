--select
create table emp as select * from scott.emp;
create table dept as select * from scott.dept;

select * from emp;
--��ȷɸѡ
select * from emp where deptno=10;
--��Χɸѡ
select * from emp where deptno!=10;
select * from emp where sal>3000;
select * from emp where sal>=3000;
--�߼�ɸѡ
select * from emp where not deptno=10;
select * from emp where deptno=20 and sal<1000;
select * from emp where deptno=20 or sal<1000;
--ģ����ѯ
select * from emp where ename like '%LL%';
select * from emp where ename like '%M__';

insert into emp values(8888,'AB%CD','CLERK',7566,date'2020-01-02',3000.00,100.00,30);
select * from emp where ename like '%\%%' escape '\';
select * from emp where ename like '%$%%' escape '$';

--����ɸѡ
select * from emp where empno in (7369,7499,7566,7788);
select * from emp where sal between 1000 and 3000;
--��ֵɸѡ
select * from emp where comm is null;


--��ϰ��
--1.��ѯ��emp���в��ű��Ϊ20��нˮ��2000���ϣ�������2000��������Ա����
--��ʾ���ǵ�Ա���ţ������Լ�нˮ
select empno,ename,sal from emp where deptno=20 and sal>2000;
--2.��ѯ�����н���comm���ֶβ�Ϊ���ҽ����������Ա��������Ϣ
select * from emp where comm is not null and comm!=0;
--3.��ѯ��нˮ��800��2500֮�䣨�����䣩����Ա������Ϣ
select * from emp where sal between 800 and 2500;
--4.��ѯ��SALESMAN  CLERK  MANAGER������������λ������Ա����Ϣ
select * from emp where job in ('CLERK','SALESMAN','MANAGER');
--5.��ѯ���������С�E���ַ�������нˮ��1000���ϣ�������1000��������Ա����Ϣ
select * from emp where ename like '%E%' and sal>1000;

--ȡ����
select emp.*,sal*12 from emp;
select t.*,sal*12 from emp t;
select empno ���,ename ����,sal ���� from emp where deptno=20 and sal>2000;



--���к���
--������أ�
--����ֵ  abs(����)
select abs(-666) from dual;
--��������  round(����, С������)
select round(1.2345,3) from dual;
--���ֽ�ȡ  trunc(����, С������)
select trunc(1.2345,3) from dual;
--����ȡ��  floor(����)
select floor(1.999) from dual;
--����ȡ��  ceil(����)
select ceil(1.001) from dual;
--������      power(����, �η�)
select power(2,3) from dual;
--ȡ��������    mod(����, ����)
select mod(12,3) from dual;

--�ַ���
--��ȡ�ַ���
select substr('abcdefg',2,3) from dual;
--ƴ���ַ���
select concat('���','SQL') from dual;
select '���'||'SQL' from dual;
--�����ַ�����
select length('���') from dual;
--�ַ������ݵ��滻
select replace('abcdefg','a','A') from dual;
--ȥ���ո�
select trim('   hello    ') from dual;
--�������
select lpad('hello',10,'#') from dual;

--ʱ��
--��ǰʱ��
select sysdate from dual;
--�·�Ǩ��
select add_months(date'2020-09-10',-4) from dual;
--ʱ����
select months_between(date'2020-01-08',date'2020-08-07') from dual;

--����ת��
--ת�����ַ���
select to_char(sysdate,'yyyy') from dual;
--ת��������
select to_number('1009') from dual;
--ת����ʱ��
select to_date('2020-10-9','yyyy-mm-dd') from dual;

--��ϰ��
--˼���⣺
--select����һ����Զ����������8���ʱ������
select to_date(concat(to_char(sysdate+1,'yyyy-mm-dd'),' 08:00:00'),'yyyy-mm-dd hh24:mi:ss') from dual;

--��ѯ��emp������ְʱ���������ĵ�Ա��
select * from emp where to_char(hiredate,'day')='������';
--��ѯ����ְʱ�䳬��35���Ա��
select * from emp where months_between(sysdate,hiredate)>12*35;

--��ϰ
select * from dept;
select * from emp;
--�ҳ���ŦԼ�ϰ������Ա��������
select ename from emp where deptno=(select deptno from dept where loc='NEW YORK');
--�ҳ�CLERK�ֱ����ļ�����ͬ�Ĳ��ţ���ѯ���������ƣ�
select dname from dept where deptno in (select deptno from emp where job='CLERK');
select dname from dept where deptno = any(select deptno from emp where job='CLERK');

--��ϰ��
--�ҳ�û��SALESMAN�����λ�Ĳ�������
select dname from dept where deptno in (
select deptno from emp where deptno not in (
select deptno from emp where job='SALESMAN'));

--�ҳ�û��Ա���Ĳ��ű��
select d.deptno from emp e right join dept d on e.deptno=d.deptno where e.deptno is null;

select * from emp e left join dept d on e.deptno=d.deptno where e.deptno=20;
select * from emp e left join dept d on e.deptno=d.deptno and e.deptno=20;

--����;ۺ�
select deptno,count(*),sum(sal),max(sal),min(sal),avg(sal) from emp group by deptno;

--����10��20���ŵ�����
select deptno,count(empno) from emp where deptno!=30 group by deptno;
select deptno,count(empno) from emp group by deptno having deptno!=30;
--����ƽ�����ʸ���2000�Ĳ���
select deptno,avg(sal) from emp group by deptno having avg(sal)>2000;

--��ϰ��
--ͳ��һ�²�ͬ�Ĺ�����λ����ͺ���ߵĹ��ʷֱ��Ƕ��٣�
select job,max(sal),min(sal) from emp group by job;
--ͳ��һ�²�ͬ�Ĺ�����λ����ͺ���߹��ʵĲ�࣬�ֱ��Ƕ��٣�
select job,max(sal),min(sal),max(sal)-min(sal) from emp group by job;
--ͳ��һ�£�ÿ�����ŷֱ��ж����ˣ�Ҫ�������еĲ��š�
select d.deptno,dname,count(e.empno) from emp e right join dept d on e.deptno=d.deptno group by d.deptno,dname;

select * from emp;
delete from emp where empno=8888;



--�κ���ϰ��
--1.��ѯ��emp���У�ÿ����ͬ������ÿ����λ�����нˮ
select deptno,job,min(sal) from emp group by deptno,job;

--2.��ѯ��ÿ��Ա���ϼ��쵼�����֣�mgr���ϼ��쵼��Ա����ţ�
select b.ename Ա����,e.ename �ϼ��쵼�� from 
emp e right join emp b 
on e.empno=b.mgr;

--3.��ѯ��ÿ���������棬нˮ��ߵ�Ա������
select ename,sal,deptno from emp where sal in 
(select max(sal) from emp group by deptno);

select ename from 
emp e join (select deptno,max(sal) max from emp group by deptno) b 
on e.deptno=b.deptno 
where sal=max;

--4.��ѯ�����ʸ���MILLER���Ա��������Ա����Ϣ
select * from emp where sal>(select sal from emp where ename='MILLER');

--5.��ѯ�����ʸ����Լ����ڲ���ƽ�����ʵ�Ա����Ϣ
select * from 
emp e join (select deptno,avg(sal) avg from emp group by deptno) b 
on e.deptno=b.deptno 
where sal>avg;

--6.��ѯ��ͬ��ͬ����ְ��Ա����Ϣ
select e1.* from 
emp e1 join emp e2 
on to_char(e1.hiredate,'yyyy-mm')=to_char(e2.hiredate,'yyyy-mm') 
where e1.empno!=e2.empno; 

select * from emp where to_char(hiredate,'yyyy-mm') in(
select to_char(hiredate,'yyyy-mm') from emp
group by to_char(hiredate,'yyyy-mm')
having count(empno)>1);

--7.��ѯ��������3��Ա���Ĳ��ű��
select deptno,count(empno) from emp group by deptno having count(empno)>=3;

--8.��ѯ����SMITH������ͬ��λ������Ա����Ϣ
select * from emp where job=
(select job from emp where ename='SMITH') and ename!='SMITH';

--9.����ÿ�����ŵ�ƽ�����ʽ��дӸߵ��͵�����ƽ�����ʱ�����λС��
select deptno,trunc(avg(sal),2) avg from emp group by deptno order by avg desc;

--10.��ѯ���н���������棬������ߵ��Ǹ��˵�����
select ename from emp where comm is not null and sal=
(select max(sal) from emp where comm is not null);




