--个人贷款项目

--数据表格准备
create public database link teacher_link
connect to bigdata identified by "111111"
using '(DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = WIN-1QHBNJOO802)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = orcl)
    )
  )';
  
--银行分行信息表
create table bank_info(
  bank_id number primary key, --银行id
  bank_addr varchar2(100)  --银行所在城市
);
create table bank_info as select * from bigdata.bank_info@teacher_link;

select * from bank_info;
--客户信息表
create table customer_info(
  cus_id number primary key,   --客户id
  cus_name varchar2(20),       --客户名字
  cus_type varchar2(50),         --证件类型
  cus_number varchar2(50)    --证件号码
);
select * from customer_info;
--客户余额表
create table balance_info(
  bal_id varchar2(50) primary key,  --借据号
  contract_id varchar2(50),         --合同编号
  petition_id varchar2(50),         --申请编号 
  loan_amount number(11,2),   --贷款金额
  loan_balance number(11,2),  --贷款余额
  overdue number              --逾期天数
);

--客户贷款合同表
create table contract_info(
  contract_id varchar2(50) primary key,    --合同编号
  petition_id varchar2(50),   --申请编号
  cus_id number,                --客户id
  amount number,              --授信金额
  amount_date date            --授信日期
);

--客户贷款申请表
create table petition_info(
  petition_id varchar2(50) primary key,       --申请编号
  petition_date date,         --申请日期
  product varchar2(50),       --产品名称
  status char(1),             --申请状态
  stat_mod_date date,         --状态最新变更日期
  cus_id number,              --客户编号
  bank_id number           --银行编号
);
select * from petition_info;
--贷款类型
create table product_type(
 tid number,                   --贷款类型编号
 tname varchar2(20)       --贷款类型名称
);
select * from product_type;
drop table bank_info;
drop table customer_info;
drop table balance_info;
drop table contract_info;
drop table petition_info;
drop table product_type;

--创建一个表格，存储的是
--20-29
--30-39
--40-49
--其他
--四个不同年龄段申请最多的贷款类型、和平均申请的贷款金额。
create table age_range_info(
  age_range varchar2(8),
  tname varchar2(20),
  avg_amount number
);


select a.age_range, tname, avg_amount
from
(select distinct age_range, tname
from
(select e.*, max(pro_num) over(partition by age_range) m
from
(select age_range,tname,
   count(1) over(partition by age_range, tname) pro_num
from 
(select a.*,
   case
     when age between 20 and 29 then
      '[20-29]'
     when age between 30 and 39 then
      '[30-39]'
     when age between 40 and 49 then
      '[40-49]'
     else 'others'
   end age_range from
(select cus_id,
       floor(months_between(sysdate,to_date(substr(cus_number,7,8),'yyyymmdd'))/12) age
         from customer_info) a) c
join petition_info b on b.cus_id=c.cus_id
join product_type d on d.tid=b.product) e) a where pro_num=m) a
join
(select age_range, round(avg(amount), 2) avg_amount from 
(select * from (select a.*,
   case
     when age between 20 and 29 then
      '[20-29]'
     when age between 30 and 39 then
      '[30-39]'
     when age between 40 and 49 then
      '[40-49]'
     else 'others'
   end age_range
from (select cus_id,
             floor(months_between(sysdate,to_date(substr(cus_number,7,8),'yyyymmdd')) / 12) age
        from customer_info) a) a
join contract_info b
  on a.cus_id = b.cus_id) c
     group by age_range) b
on a.age_range = b.age_range;





















create or replace procedure pro_all_agerange as
begin
  execute immediate 'truncate table age_range_info';
  insert into age_range_info
    select a.age_range, tname, avg_amount
      from 
      
      
      join (select age_range, round(avg(amount), 2) avg_amount
              from (select *
                      from (select a.*,
                                   case
                                     when age between 20 and 29 then
                                      '[20-29]'
                                     when age between 30 and 39 then
                                      '[30-39]'
                                     when age between 40 and 49 then
                                      '[40-49]'
                                     else
                                      'others'
                                   end age_range
                              from (select cus_id,
                                           floor(months_between(sysdate,
                                                                to_date(substr(cus_number,
                                                                               7,
                                                                               8),
                                                                        'yyyymmdd')) / 12) age
                                      from customer_info) a) a
                      join contract_info b
                        on a.cus_id = b.cus_id) c
             group by age_range) b
        on a.age_range = b.age_range;
  commit;
end; select * from age_range_info; call pro_all_agerange();




























