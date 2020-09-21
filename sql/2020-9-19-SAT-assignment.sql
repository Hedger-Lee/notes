select * from emp;
----��1�� ��ѯ20���ŵ�����Ա����Ϣ��
select * from emp where deptno=20;

----��2�� ��ѯ���й���ΪCLERK��Ա����Ա���š�Ա�����Ͳ��źš�
select empno,ename,deptno from emp where job='CLERK';

----��3�� ��ѯ����COMM�����ڹ��ʣ�SAL����Ա����Ϣ��
select * from emp where comm>sal;

----��4�� ��ѯ������ڹ��ʵ�20%��Ա����Ϣ
select * from emp where comm>(sal*0.2);

----��5�� ��ѯ10�Ų����й���ΪMANAGER��20�����й���ΪCLERK��Ա������Ϣ��
select * from emp where deptno=10 and job='MANAGER'
union all
select * from emp where deptno=20 and job='CLERK';

----��6�� ��ѯ���й��ֲ���MANAGER��CLERK��Ա����Ϣ
select * from emp where job not in('MANAGER','CLERK');

----��7�� ��ѯ�н����Ա���Ĳ�ͬ���֡�
select distinct job from emp where comm is not null;

----��8�� ��ѯ����Ա�������뽱��ĺ͡�
select 
sum(case when comm is null then sal else sal+comm end) total
 from emp;

----��9�� ��ѯû�н���򽱽����100��Ա����Ϣ��
select * from emp where comm is null or comm<100;

----��10�� ��ѯ��ÿ�����ϰ������ְ��Ա����Ϣ��15��֮ǰ��ְ����
select * from emp where to_number(to_char(hiredate,'dd'))<15;

----��11�� ��ѯ������ڻ����25���Ա����Ϣ��
select * from emp where (months_between(sysdate,hiredate)/12)>=25;

----��12�� ��ѯԱ����Ϣ��Ҫ��������ĸ��д�ķ�ʽ��ʾ����Ա����������
select empno,substr(ename,1,1)||lower(substr(ename,2)) ename,job,mgr,hiredate,sal,comm,deptno 
from emp;

select empno,replace(ename,substr(ename,2),lower(substr(ename,2))) ename,job,mgr,hiredate,sal,comm,deptno 
from emp;


----��13�� ��ѯԱ��������Ϊ6���ַ���Ա������Ϣ��
select * from emp where length(ename)=6;

----��14�� ��ѯԱ�������в�������ĸ���ӡ���Ա����
select * from emp where ename  not like '%S%'; 

----��15�� ��ѯԱ�������ĵڶ���ĸΪ��M����Ա����Ϣ��
select * from emp where ename like '_M%';

----��16�� ��ѯ����Ա��������ǰ�����ַ���
select substr(ename,1,3) from emp;

----��17�� ��ѯ����Ա�������������������ĸ��S�������á�_���滻��
select replace(ename,'S','_') from emp; 

----��18����ѯԱ������������ְ���ڣ�������ְ���ڴ��ȵ����������
select ename,hiredate from emp order by hiredate;

----��19�� ��ʾ����Ա�������������֡����ʺͽ��𣬰����ֽ�������
select ename,job,sal,comm from emp order by job desc;

----��20�� ��ʾ����Ա������������ְ����ݺ��·�,����ְ�������ڵ��·��������·���ͬ����ְ���������
select ename,to_char(hiredate,'yyyy') y,to_char(hiredate,'mm') m from emp order by m,y;

----��21�� ��ѯ��2�·���ְ������Ա����Ϣ��
select * from emp where to_number(to_char(hiredate,'mm'))=2;

----��22�� ��ѯ����Ա����ְ�����Ĺ������ޣ��á�XX��XX��XX�ա�����ʽ��ʾ��
select to_char(floor(total/12))||'��'||
to_char(floor(total-floor(total/12)*12))||'��'||
to_char(floor(((total-floor(total/12)*12)-floor(total-floor(total/12)*12))*30))||'��'
from
(select months_between(sysdate,hiredate) total from emp);

----��23�� ��ѯ����������Ա���Ĳ�����Ϣ��
select * from dept where deptno in(
select deptno from emp group by deptno having count(1)>=2);

----��24�� ��ѯ���ʱ�SMITHԱ�����ʸߵ�����Ա����Ϣ��
select * from emp where sal>
(select sal from emp where ename='SMITH');

----��25�� ��ѯ����Ա������������ֱ���ϼ���������
select e1.ename,e2.ename from emp e1 join emp e2 on e1.mgr=e2.empno;

----��26�� ��ѯ��ְ����������ֱ���ϼ��쵼������Ա����Ϣ��
select e1.* from emp e1 join emp e2 on e1.mgr=e2.empno where e1.hiredate<e2.hiredate;

----��27�� ��ѯ���в��ż���Ա����Ϣ��������Щû��Ա���Ĳ��š�
select * from emp a right join dept b on a.deptno=b.deptno;

----��28�� ��ѯ����Ա�����䲿����Ϣ��������Щ���������κβ��ŵ�Ա����
select * from emp a left join dept b on a.deptno=b.deptno;

----��29�� ��ѯ���й���ΪCLERK��Ա�����������䲿�����ơ�
select ename,dname from emp a join dept b on a.deptno=b.deptno where job='CLERK';

----��30�� ��ѯ��͹��ʴ���2500�ĸ��ֹ�����
select job from emp group by job having min(sal)>2500;

----��31�� ��ѯƽ�����ʵ���2000�Ĳ��ż���Ա����Ϣ��
select * from dept a join
(select * from 
(select emp.*,avg(sal) over(partition by deptno) avg_score from emp) where avg_score<2000) b
on a.deptno=b.deptno;

----��32�� ��ѯ��SALES���Ź�����Ա����������Ϣ��
select * from emp where deptno=(select deptno from dept where dname='SALES');

----��33�� ��ѯ���ʸ��ڹ�˾ƽ�����ʵ�����Ա����Ϣ��
select * from emp where sal>
(select avg(sal) from emp);

----��34�� ��ѯ����SMITHԱ��������ͬ����������Ա����Ϣ��
select * from emp where job =
(select job from emp where ename='SMITH');

----��35�� �г����ʵ���30������ĳ��Ա���Ĺ��ʵ�����Ա���������͹��ʡ�
select ename,sal from emp where sal in(
select sal from emp where deptno=30);

----��36�� ��ѯ���ʸ���30���Ź���������Ա���Ĺ��ʵ�Ա�������͹��ʡ�
select ename,sal from emp where sal>
all(select sal from emp where deptno=30);

----��37�� ��ѯÿ�������е�Ա��������ƽ�����ʺ�ƽ���������ޡ�
select deptno,count(1),avg(sal),avg(to_number(to_char(sysdate,'yyyy')-to_char(hiredate,'yyyy'))) from emp group by deptno; 

----��38�� ��ѯ����ͬһ�ֹ�����������ͬһ���ŵ�Ա����Ϣ��
select * from emp e1 join emp e2 on e1.job=e2.job and e1.empno!=e2.empno and e1.deptno!=e2.deptno;

----��39�� ��ѯ�������ŵ���ϸ��Ϣ�Լ���������������ƽ�����ʡ�
select * from dept a join
(select deptno,count(1),avg(sal) from emp group by deptno) b on a.deptno=b.deptno;

----��40�� ��ѯ���ֹ�������͹��ʡ�
select job,min(sal) from emp group by job;

----��41�� ��ѯ���������в�ͬ���ֵ���߹��ʡ�
select deptno,job,max(sal) from emp group by deptno,job;

----��42�� ��ѯ10�Ų���Ա�������쵼����Ϣ��
select * from emp e1 join emp e2 on e1.mgr=e2.empno where e1.deptno=10

----��43�� ��ѯ�������ŵ�������ƽ�����ʡ�
select deptno,count(1),avg(sal) from emp group by deptno;

----��44�� ��ѯ����Ϊ�Լ�����ƽ�����ʵ�Ա������Ϣ��
select * from 
(select emp.*,avg(sal) over(partition by deptno) avg_sal from emp)
where sal=avg_sal;

----��45�� ��ѯ���ʸ��ڱ�����ƽ�����ʵ�Ա������Ϣ��
select * from 
(select emp.*,avg(sal) over(partition by deptno) avg_sal from emp)
where sal>avg_sal;

----��46�� ��ѯ���ʸ��ڱ�����ƽ�����ʵ�Ա������Ϣ���䲿�ŵ�ƽ�����ʡ�
select * from 
(select emp.*,avg(sal) over(partition by deptno) avg_sal from emp)
where sal>avg_sal;

----��47�� ��ѯ���ʸ���20�Ų���ĳ��Ա�����ʵ�Ա������Ϣ��
select * from emp where sal>
any(select sal from emp where deptno=20) and deptno!=20;

----��48��ͳ�Ƹ������ֵ�Ա��������ƽ�����ʡ�
select job,count(1),avg(sal) from emp group by job;

----��49�� ͳ��ÿ�������и����ֵ�������ƽ�����ʡ�
select deptno,job,count(1),avg(sal) from emp group by deptno,job;

----��50�� ��ѯ���������й��ʡ�������30�Ų���ĳԱ�����ʡ�������ͬ��Ա������Ϣ��
select * from emp a join 
(select * from emp where deptno=30) b on a.sal=b.sal and a.comm=b.comm and a.empno!=b.empno;

----��51�� ��ѯ������������5�Ĳ��ŵ�Ա����Ϣ��
select * from emp where deptno in(
select deptno from emp group by deptno having count(1)>5);

----��52�� ��ѯ����Ա�����ʶ�����1000�Ĳ��ŵ���Ϣ��
select * from dept where deptno in(
select deptno from emp group by deptno having min(sal)>1000);

----��53�� ��ѯ����Ա�����ʶ�����1000�Ĳ��ŵ���Ϣ����Ա����Ϣ��
select * from emp a join dept b on a.deptno=b.deptno where a.deptno in(
select deptno from emp group by deptno having min(sal)>1000);

----��54�� ��ѯ����Ա�����ʶ���900��3000֮��Ĳ��ŵ���Ϣ��
select * from dept where deptno in 
(select deptno from 
(select emp.*,
case when sal>=900 and sal<=3000 then 1 else null end c
 from emp) group by deptno having count(1)=count(c));

----��55�� ��ѯ�й�����900��3000֮���Ա�����ڲ��ŵ�Ա����Ϣ��
select * from emp where deptno in 
(select deptno from 
(select emp.*,
case when sal>=900 and sal<=3000 then 1 else null end c
 from emp) group by deptno having count(1)=count(c));

----��56�� ��ѯÿ��Ա�����쵼���ڲ��ŵ���Ϣ��
select * from dept where deptno in
(select b.deptno from emp a join emp b on a.mgr=b.empno);

----��57�� ��ѯ�������Ĳ�����Ϣ��
select * from dept where deptno=
(select deptno from 
(select deptno,count(1) c from emp group by deptno order by c desc) where rownum=1);

----��58�� ��ѯ30�Ų����й�������ǰ3����Ա����Ϣ��
select * from 
(select * from emp where deptno=30 order by sal desc) where rownum<=3;

----��59�� ��ѯ����Ա���й���������5��10��֮���Ա����Ϣ��
select * from 
(select emp.*,row_number() over(order by sal desc) r from emp)
where r>5 and r<10;

----��60�� ��ѯָ�����֮����ְ��Ա����Ϣ��(1980-1985)
select * from emp where to_number(to_char(hiredate,'yyyy'))>=1980 and to_number(to_char(hiredate,'yyyy'))<=1985;
