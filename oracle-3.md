# oracle-3

## 统计注意点

进行统计的时候，可以用count(列名)，也可以用count(1)，也可以用count(*)，

count(1)和count(*)，只要这一行，任何一列有数据，就会统计这一行的数量，两种方法是一样的。

count(列名)效率更高。

## 上卷函数`rollup()`

> 专门做最终的汇总统计的

```sql
select deptno,count(1) from emp group by rollup(deptno);
```

先对每个组分别做计算，然后最终对整个表做计算。

## 集合运算

### union all

> 将上下两个语句的结果进行拼接

```sql
select * from emp where sal<1000
union all
select * from emp where sal>3000;
```

### union

> 先将结果拼接，然后去除重复值

```sql
select job from emp where deptno=10
union
select job from emp where deptno=20;

select distinct job from emp where deptno=10 or deptno=20;
```

### intersect

> 取两个计算结果的交集

```sql
select job from emp where deptno=10
intersect
select job from emp where deptno=20;

--取出10和20部门都共有的工作岗位
select distinct job from emp where deptno=20 and job in
(select job from emp where deptno=10);
```

### minus

> 取第一个结果有的但是第二个结果没有的数据

```sql
select job from emp where deptno=20
minus
select job from emp where deptno=10;

select distinct job from emp where deptno=20 and job not in
(select job from emp where deptno=10);
```

