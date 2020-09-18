create table emp_idx as select * from scott.emp where 1=2;

--创建主键索引
alter table emp_idx add constraint pk_empno primary key(empno);
--删除主键索引
alter table emp_idx drop constraint pk_empno;

--创建唯一索引
--通过唯一约束创建
alter table emp_idx add constraint uni_ename unique(ename);
alter table emp_idx drop constraint uni_ename;
--单独创建唯一索引
create unique index emp_ename on emp_idx(ename);
drop index emp_ename;

--创建普通索引
create index idx_ename on emp_idx(ename);
drop index idx_ename;

--创建组合索引
create index idx_ename_dept_sal on emp_idx(ename,deptno,sal);
drop index idx_ename_dept_sal;

--创建函数索引
create index idx_hiredate on emp_idx(to_char(hiredate,'yyyy'));
drop index idx_hiredate;

--创建位图索引
create bitmap index bit_idx_job on emp_idx(job);
drop index bit_idx_job;

select * from user_indexes where table_name='EMP_IDX';

select * from students;
select * from teacher;
select * from course;
select * from degree;
25.查询没有学全所有课的同学的学号、姓名
select a.sno, sname
  from students a
  left join (select sno, count(cno) c from degree group by sno) b
    on a.sno = b.sno
 where c < (select count(1) from course)
    or c is null;

26.查询全部学生都选修的课程的课程号和课程名
select a.cno,cname from course a left join 
(select cno,count(1) c from degree group by cno) b
on a.cno=b.cno where c=(select count(1) from students);

27.查询选修“谌燕”老师所授课程的学生中，每门课程成绩最高的学生姓名及其成绩
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
                              (select tno from teacher where tname = '谌燕')) b
                    on a.cno = b.cno)
         where score = max_score) d
    on c.sno = d.sno;

28.查询没学过“谌燕”老师讲授的任一门课程的学生姓名 

select sname from students a left join
(select * from degree where cno  in
(select cno from course where tno=
(select tno from teacher where tname='谌燕'))) b on a.sno=b.sno where b.sno is null;
          
29.查询学过“谌燕”老师所教的所有课的同学的学号、姓名
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
                                                  where tname = '谌燕')) b
                           on a.cno = b.cno)
                where c = c2);

30.查询学过“c001”并且也学过编号“c002”课程的所有同学的学号、姓名
select sno,sname from students where sno in
(select a.sno from
(select * from degree where cno='c001') a join 
(select * from degree where cno='c002') b on a.sno=b.sno);
   
31.查询“c001”课程比“c002”课程成绩高的所有同学的学号、姓名
select sno,sname from students where sno in
(select a.sno from
(select * from degree where cno='c001') a join 
(select * from degree where cno='c002') b on a.sno=b.sno
where a.score>b.score);



select * from degree;

32.查询至少有一门课与学号为“s001”的同学所学相同的同学的学号和姓名 
select sno,sname from students where sno in(
select  distinct sno from degree where cno in 
(select cno from degree where sno='s001'));

33.查询学过学号为“s001”同学所有门课的其他同学学号和姓名
select sno,sname from students where sno in(
select sno from 
(select degree.*,
count(1) over(partition by sno) c
 from degree where cno in (
select cno from degree where sno='s001'
) and sno!='s001') where c=
(select count(1) from degree where sno='s001'));

34.查询和“s002”号的同学学习的课程完全相同的其他同学学号和姓名 
select sno,sname from students where sno in(
select sno from 
(select degree.*,
count(1) over(partition by sno) c
 from degree where cno in (
select cno from degree where sno='s002'
) and sno!='s002') where c=
(select count(1) from degree where sno='s002'));

35.按各科平均成绩从低到高和及格率的百分数从高到低顺序
select f.*, a, e
  from course f
  join (select distinct cno, a, to_char(round(d / c1,2)*100)||'%' e
          from (select b.*, sum(c2) over(partition by cno) d
                  from (select degree.*,
                               avg(score) over(partition by cno) a,
                               case
                                 when score >= 60 then
                                  1
                                 else
                                  0
                               end c2,
                               count(1) over(partition by cno) c1
                          from degree) b)
         order by a, e desc) f2
    on f.cno = f2.cno;
