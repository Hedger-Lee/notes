# BI大数据理论

## 数据源

源系统：存储各种数据源的系统

```sql
核心系统
借贷系统
零售系统
用户系统
结算系统
财务系统
人力系统
日志流数据（埋点）
人工补录的数据
第三方系统
```

## 数据源类型

数据源不同的数据类型和格式：

### 结构化数据

数据库的数据，excel，csv，格式统一的文本文档

1，李雷，18
2，丽丽，19

### 半结构化数据

json    xml

### 非结构化数据

图片  视频   音乐...

## 临时存储层(ODS)

> Operational Data Store

ODS：临时存储层（3-6个月）
将不同数据源的数据，先保存在数据贴源层（ODM）中。

### 数据贴源层（ODM）

> Original Data Mart

先将所有的数据源的数据，按原有的格式和类型，存储到当前的项目数据库，不会去判断数据的有效性。

将数据贴源层（ODM）的数据，经过一定的规范化的整理，保存在标准数据层（SDM）。

### 标准数据层（SDM）

> Standardization & Data Management

将所有存储的数据，进行数据类型、数据长度、有效性、正确性、空值的默认值处理等

## 数据仓库(DW)

> Data Warehouse

DW：数据仓库（3年）最明细的数据，颗粒度最细的数据
将标准数据层（SDM）的数据抽取出来，将相同的或者相似的数据进行汇总，存储在基础数据层/数据整合层（FDM）。

### 基础数据层/数据整合层（FDM）

所有的相同类似的数据，都会保存在主题库中：
客户主题：存储的所有的参与银行业务的用户信息
参与者主题：对公的数据存储
产品主题：理财、保险等等各种产品的分类和详细信息
协议主题：存储的所有业务的协议内容，例如网上银行、短信通知、存款协议、报失、修改密码、征信查询...
事件主题：金额的转移相关的数据，买东西、进账、转账...
征信主题：征信相关的数据，征信情况、信用记录、贷款记录、信用卡记录...
绩效主题：销售团队的绩效信息
财务主题：各个部门的财务收支情况
公共主题：存放公共维度的信息，币种参数、汇率信息、市场金融利率、其他公共参数等

## 数据集市层(DM)

> Data Mart

DM：数据集市层
将不同的主题库中的数据进行汇总统计和计算，将计算的结果保存在聚合计算层（ADM）中。

### 数据公共汇总层/聚合计算层（ADM）

将明细数据经过不同维度的计算，保存最终的计算结果，数据的颗粒度比较粗

ADM的表格，要遵守3NF（第三范式）的数据库规范

### 第三范式

第一范式：每个列的内容都是不可再拆分的
第二范式：每个表都有主键
第三范式：每个表的每个列，和主键都是直接相关的关系

### 表格拆分模型

表格拆分和设计的模型：
星型模型：从一个大的事实表中，按照单一的维度拆分小表的数据，每一个小表都是直接从这个大的事实表中分离出来的维度表的数据，工作中用的比较多。
优点：结构比较简洁
缺点：有可能存在冗余数据

雪花模型：将一个维度表当成小的事实表，继续的进行不同维度的拆分，一直拆分到没有冗余数据为止
优点：没有冗余数据
缺点：结构复杂，表格的数量特别多

### DA：数据报表层

将DM集市层的数据，进一步进行统计和汇总，最终数据的数量一定是比较少的，给领导层做决策

# ETL

## E：数据的抽取

python   数据库链接  kettle  sqoop等

## T：数据的转换和清洗

convert   transform
convert : 格式、类型、长度、默认值、计算单位、新旧代码等数据的统一
transform：字段的合并拆分、排序、去重、聚合计算、业务计算、默认值等

## L：数据的加载

三个阶段

### 预加载：pre-load  

建立删除和恢复索引的脚本，删除表格的索引

### 加载：load  

通过全量、增量、镜像三种方法新增数据

### 恢复：post-load  

恢复索引，删除临时文件或者临时表数据等


数据的备份：1天1个增量备份，1周1个全量备份

```sql
增量更新的例子：
create or replace procedure pro_part_petdate
as
begin
  --清空当前的已有数据
  delete from dw_petition_info where to_char(petition_date,'yyyymmdd')=to_char(sysdate,'yyyymmdd');
  commit;
  --将今天的申请数据抽取到当前表格中
  insert into dw_petition_info(petition_id,petition_date,product,status,stat_mod_date,
  cus_id,bank_id) 
  select * from petition_info 
  where to_char(petition_date,'yyyymmdd')=to_char(sysdate,'yyyymmdd');
  commit;
  update dw_petition_info set resourse_sys='ODS_JIEDAI' where resourse_sys is null;
  update dw_petition_info set update_time=sysdate where update_time is null;
  commit;
end;
```

# 项目开发的流程

快速迭代、敏捷开发

1. 业务人员提交需求
2. 产品经理会收集业务提交的需求，并且编辑成需求规格说明书
3. 产品经理会召集开发、测试、设计等，参与需求评审会议
熟悉需求、判断需求的合理性、判断需求完成的时间
4. 编辑 开发规范、概要设计文档、详细设计文档
5. 编写代码，编写sql语句、存储过程
6. 如果自测通过，上传到项目管理工具中（SVN  GIT...），交给测试工程师测试
7. 所有的需求通过之后，就会进行版本上线（一周一次）
8. 检查线上版本是否OK

在哪一层工作？
DW层做主题库的数据的抽取和汇总

你平时操作比较多的表叫什么？

说几个你印象比较深刻的业务指标？

```sql
select * from usa_taxi_info;
--从usa_taxi_info中，将数据抽取到自己的电脑上，
--需要保留的字段：trip_id,taxi_id,trip_start_timestamp,trip_end_timestamp,
--trip_seconds,trip_miles,trip_total,payment_type,company
--剔除掉每个字段上空值信息、trip_seconds,trip_miles两个字段为0的数据、trip_total转换为number(6,2)
--写成增量更新的脚本

--计算0-23，这24个时间段里面，平均每个时间段乘车的数量，每个时间段付款最多的方式，平均支付的金额

答案和过程：
--创建表结构
create table dw_usa_taxi_info as 
select trip_id,taxi_id,trip_start_timestamp,trip_end_timestamp,
trip_seconds,trip_miles,trip_total,payment_type,company from usa_taxi_info where 1=2;
alter table dw_usa_taxi_info modify trip_total number(6,2);
--添加历史数据
insert into dw_usa_taxi_info
select trip_id,taxi_id,trip_start_timestamp,trip_end_timestamp,
trip_seconds,trip_miles,substr(trip_total,2),payment_type,company from usa_taxi_info
where trip_id is not null and taxi_id is not null and  trip_start_timestamp is not null
and trip_end_timestamp is not null and trip_seconds is not null and trip_miles is not null
and trip_total is not null and payment_type is not null and trip_seconds !=0 and trip_miles!=0;

select * from dw_usa_taxi_info where substr(trip_start_timestamp,1,10)=to_char(sysdate,'mm/dd/yyyy');

--编写增量的脚本
create or replace procedure pro_part_taxi
as
begin
  delete from dw_usa_taxi_info where substr(trip_start_timestamp,1,10)=to_char(sysdate,'mm/dd/yyyy');
  commit;
  insert into dw_usa_taxi_info 
  select trip_id,taxi_id,trip_start_timestamp,trip_end_timestamp,
  trip_seconds,trip_miles,substr(trip_total,2),payment_type,company from usa_taxi_info
  where trip_id is not null and taxi_id is not null and  trip_start_timestamp is not null
  and trip_end_timestamp is not null and trip_seconds is not null and trip_miles is not null
  and trip_total is not null and payment_type is not null and trip_seconds !=0 and trip_miles!=0
  and substr(trip_start_timestamp,1,10)=to_char(sysdate,'mm/dd/yyyy');
  commit;
end;

call pro_part_taxi();

--计算0-23，这24个时间段里面，平均每个时间段乘车的数量，每个时间段付款最多的方式，平均支付的金额
select distinct decode(hours,24,0,hours) hours,trip_numbers,payment_type,avg_total from
(select c.*,
       max(t) over(partition by hours) t2
  from
(select b.*,
       count(trip_id) over(partition by hours) trip_numbers,
       count(payment_type) over(partition by hours,payment_type) t,
       avg(trip_total) over(partition by hours) avg_total
  from
(select a.*,
       case 
         when substr(trip_start_timestamp,-2)='PM' then substr(trip_start_timestamp,12,2)+12
         else substr(trip_start_timestamp,12,2)+0
       end hours
  from dw_usa_taxi_info a) b) c)
  where t2=t
  order by hours;
```

