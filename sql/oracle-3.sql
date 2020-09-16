--�Ͼ���
select deptno,count(0) from emp group by rollup(deptno);

--��������
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

--��ϰ
--��ѯ��emp���dept�����棬ƽ��������ߵĲ������ƺ��ϰ�ص�
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


--�ж�Ա����û���ϼ�
select emp.*,nvl2(mgr,'���ϼ�','û���ϼ�') ��û���ϼ� from emp; 

select emp.*,decode(mgr,null,'û���ϼ�','���ϼ�') ��û���ϼ� from emp; 

--��ϰ��˼����
--��decode�жϣ����Ը�emp��Ĺ��������ĸ��ȼ���
--1000���µģ�D��  1000-1999֮��ģ�C�� 2000-2999֮��ģ�B��  3000���ϵģ�A��
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
              'A') ���ʵȼ�
  from emp;

--��ϰ����������ı������
create table chengji(
userid number,
score number,
course varchar2(20)
);

insert into chengji values(1,88,'����');
insert into chengji values(2,54,'����');
insert into chengji values(3,38,'����');
insert into chengji values(4,87,'����');
insert into chengji values(5,92,'����');
insert into chengji values(1,75,'��ѧ');
insert into chengji values(2,68,'��ѧ');
insert into chengji values(3,25,'��ѧ');
insert into chengji values(4,87,'��ѧ');
insert into chengji values(5,14,'��ѧ');
commit;

--1.��ѯ�����Ա��У�����Ͳ����������
select * from chengji;

select count(s) ����, count(1) - count(s) ������
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
  when score>=60 then '����'
  else '������'
end s
 from chengji) a
 group by s;
     
--2.��ѯ�����Ա��У�ÿ���γ��У�����Ͳ����������
select course, count(s) ����, count(1) - count(s) ������
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
  when score>=60 then '����'
  else '������'
end s
 from chengji) a
 group by course,s;
 
 
 --α��
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

--��ϰ��
--��ѯ��ÿ�������У����ʸ����Լ����ڲ���ƽ�����ʵ�Ա�����ֺͲ��ű��
select ename,deptno from
(select emp.*,
       avg(sal) over(partition by deptno) s
from emp)
where sal>s
;

--��ϰ
--�ҳ�ÿ��������λ�Ĺ���ǰ���������ǲ��е����
select * from 
(select emp.*,
       dense_rank() over(partition by job order by sal desc) d
from emp) 
where d<=2;


--��ϰ
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
--��ѡ��û��'/'�ı�Ȼ��ʹ����������row_number()��
--�õ���Ӧ�������ٽ�tid-�������ɵõ���Ӧ�Ĳ�ֵ����ֵΪ����

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
--�Ƚ���'/'����һ�к�������һ��1��û�е�Ϊ0��
--ʹ�þۺϺ����ۼ�Ч���������Ӧ��������ɸѡȥ��'/'���ڵ���


--��ϰ��
--1.�г�н����ڲ���ƽ��н�������Ա����Ϣ,Ҫ������ʾ��������
select b.empno,b.ename,b.job,b.mgr,b.hiredate,b.sal,b.comm,b.deptno,dname from dept c join
(select * from 
(select emp.*,
       avg(sal) over(partition by deptno) a
 from emp)
where sal>a) b
on c.deptno=b.deptno;

--2.��ѯ����EMP�е�8������13��֮��ļ�¼��Ȼ�󰴹��ʽ�������
select * from 
(select emp.*,rownum r from emp)
where r>=8 and r<=13
order by sal desc;

--3.��ѯ����EMP�е�8������13��֮�䣬������ߵ�3λԱ����Ա����Ϣ��Ҫ������ʾ��������
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

--4.��ѯ�����ʴ�������������Ա�����ʵ��쵼��Ϣ
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

--5.��ѯÿ�������Լ����ڲ����й�����ռ�ı��������������λС��
select t.*,round(sal/s,2) from 
(select emp.*,
       sum(sal) over(partition by deptno) s
 from emp) t;

--6.��ѯÿ��Ա�����Լ����ڲ��������֮��Ĳ��
select t.*,m-sal
from
(select emp.*,
       max(sal) over(partition by deptno) m
 from emp) t;







 
 
 
 
 
 
 
 
 
 
 
 
 



























