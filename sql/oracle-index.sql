create table emp_idx as select * from scott.emp where 1=2;

--������������
alter table emp_idx add constraint pk_empno primary key(empno);
--ɾ����������
alter table emp_idx drop constraint pk_empno;

--����Ψһ����
--ͨ��ΨһԼ������
alter table emp_idx add constraint uni_ename unique(ename);
alter table emp_idx drop constraint uni_ename;
--��������Ψһ����
create unique index emp_ename on emp_idx(ename);
drop index emp_ename;

--������ͨ����
create index idx_ename on emp_idx(ename);
drop index idx_ename;

--�����������
create index idx_ename_dept_sal on emp_idx(ename,deptno,sal);
drop index idx_ename_dept_sal;

--������������
create index idx_hiredate on emp_idx(to_char(hiredate,'yyyy'));
drop index idx_hiredate;

--����λͼ����
create bitmap index bit_idx_job on emp_idx(job);
drop index bit_idx_job;

select * from user_indexes where table_name='EMP_IDX';

select * from students;
select * from teacher;
select * from course;
select * from degree;
25.��ѯû��ѧȫ���пε�ͬѧ��ѧ�š�����
select a.sno, sname
  from students a
  left join (select sno, count(cno) c from degree group by sno) b
    on a.sno = b.sno
 where c < (select count(1) from course)
    or c is null;

26.��ѯȫ��ѧ����ѡ�޵Ŀγ̵Ŀγ̺źͿγ���
select a.cno,cname from course a left join 
(select cno,count(1) c from degree group by cno) b
on a.cno=b.cno where c=(select count(1) from students);

27.��ѯѡ�ޡ����ࡱ��ʦ���ڿγ̵�ѧ���У�ÿ�ſγ̳ɼ���ߵ�ѧ����������ɼ�
select c.sno, sname, score
  from students c
  join (select sno, cname, score
          from (select a.*,
                       cname,
                       max(score) over(partition by b.cno) max_score
                  from degree a
                  join (select cno, cname
                         from course
                        where tno =
                              (select tno from teacher where tname = '����')) b
                    on a.cno = b.cno)
         where score = max_score) d
    on c.sno = d.sno;

28.��ѯûѧ�������ࡱ��ʦ���ڵ���һ�ſγ̵�ѧ������ 

select sname from students a left join
(select * from degree where cno  in
(select cno from course where tno=
(select tno from teacher where tname='����'))) b on a.sno=b.sno where b.sno is null;
          
29.��ѯѧ�������ࡱ��ʦ���̵����пε�ͬѧ��ѧ�š�����
select sno, sname
  from students
 where sno in (select sno
                 from (select a.*, b.*, count(1) over(partition by sno) c2
                         from degree a
                        right join (select course.*,
                                          count(1) over(partition by tno) c
                                     from course
                                    where tno = (select tno
                                                   from teacher
                                                  where tname = '����')) b
                           on a.cno = b.cno)
                where c = c2);

30.��ѯѧ����c001������Ҳѧ����š�c002���γ̵�����ͬѧ��ѧ�š�����
select sno,sname from students where sno in
(select a.sno from
(select * from degree where cno='c001') a join 
(select * from degree where cno='c002') b on a.sno=b.sno);
   
31.��ѯ��c001���γ̱ȡ�c002���γ̳ɼ��ߵ�����ͬѧ��ѧ�š�����
select sno,sname from students where sno in
(select a.sno from
(select * from degree where cno='c001') a join 
(select * from degree where cno='c002') b on a.sno=b.sno
and a.score>b.score);



select * from degree;

32.��ѯ������һ�ſ���ѧ��Ϊ��s001����ͬѧ��ѧ��ͬ��ͬѧ��ѧ�ź����� 
select sno,sname from students where sno in(
select  distinct sno from degree where cno in 
(select cno from degree where sno='s001') and sno!='s001');

33.��ѯѧ��ѧ��Ϊ��s001��ͬѧ�����ſε�����ͬѧѧ�ź�����
select sno,sname from students where sno in(
select sno from 
(select degree.*,
count(1) over(partition by sno) c
 from degree where cno in (
select cno from degree where sno='s001'
) and sno!='s001') where c>=
(select count(1) from degree where sno='s001'));

34.��ѯ�͡�s002���ŵ�ͬѧѧϰ�Ŀγ���ȫ��ͬ������ͬѧѧ�ź����� 
select sno,sname from students where sno in(
select sno from 
(select degree.*,
count(1) over(partition by sno) c
 from degree where cno in (
select cno from degree where sno='s002'
) and sno!='s002') where c=
(select count(1) from degree where sno='s002'));

35.������ƽ���ɼ��ӵ͵��ߺͼ����ʵİٷ����Ӹߵ���˳��
select cno,avg_score,(s/c)*100||'%' r
 from     
(select cno,avg(score) avg_score,
sum(case when score>=60 then 1 else 0 end) s,
count(1) c
 from degree group by cno) a order by avg_score,r desc;