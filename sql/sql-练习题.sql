--SQL练习题：
--1.查询男生、女生人数
select ssex,count(1) from students group by ssex;

select * from 
(select ssex from students)
pivot(count(ssex) for ssex in ('男','女'));

--2.查询姓“张”的学生名单
select * from students where sname like '张%';

--3.查询姓“刘”的老师的个数
select count(1) from teacher where tname like '刘%';

--4.查询选了课程的学生人数
select count(distinct sno) from degree;


--5.查询有学生考试及格的课程，并按课程号从大到小排列
select distinct cno from degree where score>=60 order by cno desc;

--6.查询各科成绩最高和最低的分：以如下形式显示：课程ID，最高分，最低分
select cno 课程ID,max(score) 最高分,min(score) 最低分 from degree group by cno;

--7.查询不同课程平均分从高到低显示，要显示授课老师
select a.*,tname from
(select cno,avg(score) avg_s from degree group by cno) a
join courses b on a.cno=b.cno
join teachers c on b.tno=c.tno
order by avg_s desc;

--8.查询所有学生的选课情况
select * from course c join
(select s.*,cno,score from students s join degree d on s.sno=d.sno) b
on c.cno=b.cno;
select a.sno,count(b.cno) from students a left join degree b on a.sno=b.sno
group by a.sno;

--9.查询“c001” 课程成绩在80 分以上的学生的学号和姓名
select * from students s join
(select * from degree where cno='c001' and score>80) a
on s.sno=a.sno;
select sno,sname from students where sno in 
(select sno from degree where cno='c001' and score>80);

--10.查询“c001”课程分数小于80的同学学号和姓名，按分数降序排列
select * from students s join
(select * from degree where cno='c001' and score<80) a
on s.sno=a.sno order by score desc;

select a.sno,sname,score from students a join
(select sno,score from degree where cno='c001' and score<80) b
on a.sno=b.sno
order by score desc;

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
 from degree where score<60) where c>=1;

--20.查询各科成绩前三名的记录:(不考虑成绩并列情况)
select * from 
(select degree.*,
       row_number() over(partition by cno order by score desc) r
 from degree)
where r<=3;

--21.查询每门功课成绩最好的前两名(并列 )
select * from 
(select degree.*,
       dense_rank() over(partition by cno order by score desc) r
 from degree)
where r<=2;

--22.查询1998年出生的学生名单 
select * from students where sage=(to_number(to_char(sysdate,'yyyy'))-1998);

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
and a.score>b.score);



select * from degree;

32.查询至少有一门课与学号为“s001”的同学所学相同的同学的学号和姓名 
select sno,sname from students where sno in(
select  distinct sno from degree where cno in 
(select cno from degree where sno='s001') and sno!='s001');

33.查询学过学号为“s001”同学所有门课的其他同学学号和姓名
select sno,sname from students where sno in(
select sno from 
(select degree.*,
count(1) over(partition by sno) c
 from degree where cno in (
select cno from degree where sno='s001'
) and sno!='s001') where c>=
(select count(1) from degree where sno='s001'));

34.查询和“s002”号的同学学习的课程完全相同的其他同学学号和姓名 
select sno,sname from students where sno in
(select a.sno from degree a left join
(select * from degree where sno='s002') b
on a.cno=b.cno where a.sno!='s002'
group by a.sno having count(1)=(select count(1) from degree where sno='s002'));

35.按各科平均成绩从低到高和及格率的百分数从高到低顺序
select cno,avg_score,(s/c)*100||'%' r
 from     
(select cno,avg(score) avg_score,
sum(case when score>=60 then 1 else 0 end) s,
count(1) c
 from degree group by cno) a order by avg_score,r desc;
