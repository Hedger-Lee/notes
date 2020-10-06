create public database link teacher_link
connect to bigdata identified by "111111"
using '(DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = WIN-1QHBNJOO802)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = orcl)
    )
  )';

select * from usa_taxi_info@teacher_link;

--��usa_taxi_info�У������ݳ�ȡ���Լ��ĵ����ϣ�
--��Ҫ�������ֶΣ�trip_id,taxi_id,trip_start_timestamp,trip_end_timestamp,
--trip_seconds,trip_miles,trip_total,payment_type,company
--�޳���ÿ���ֶ��Ͽ�ֵ��Ϣ��trip_seconds,trip_miles�����ֶ�Ϊ0�����ݡ�trip_totalת��Ϊnumber(6,2)
select trip_id,taxi_id,trip_start_timestamp,trip_end_timestamp,
trip_seconds,trip_miles,
to_number(substr(trip_total,2)),
payment_type,company from usa_taxi_info
where trip_seconds!=0 and trip_miles!=0 and trip_id is not null

select to_number(substr(trip_total,2)) from usa_taxi_info

create table usa_taxi_info as select * from usa_taxi_info@teacher_link;

select * from usa_taxi_info

create table usa_taxi_info_sdm(
    trip_id varchar2(200),
    taxi_id varchar2(600),
    trip_start_timestamp varchar2(100),
    trip_end_timestamp varchar2(100),
    trip_seconds number,
    trip_miles number,
    trip_total number(6,2),
    payment_type varchar2(100),
    company varchar2(100),
    update_time date
    );

--д���������µĽű�
--�������
create or replace procedure pro_usa_taxi_info
as
begin
    merge into usa_taxi_info_sdm a 
    using(select trip_id,taxi_id,trip_start_timestamp,trip_end_timestamp,
                 trip_seconds,trip_miles,round(to_number(substr(trip_total,2)),2) trip_total,
                                 payment_type,company from usa_taxi_info
                 where trip_seconds!=0 and trip_miles!=0 and trip_id is not null and taxi_id is not null
                 and trip_start_timestamp is not null and trip_end_timestamp is not null and trip_seconds is not null and taxi_id is not null
                 and trip_total is not null and payment_type is not null and substr(trip_start_timestamp,1,10)=to_char(sysdate,'mm/dd/yyyy')
                 ) b
    on (a.trip_id=b.trip_id)
    when matched then
      update set a.taxi_id=b.taxi_id,a.trip_start_timestamp=b.trip_start_timestamp,
      a.trip_end_timestamp=b.trip_end_timestamp,
                 a.trip_seconds=b.trip_seconds,a.trip_miles=b.trip_miles,a.trip_total=b.trip_total,
                                 a.payment_type=b.payment_type,a.company=b.company,a.update_time=sysdate
    when not matched then
      insert (a.trip_id,a.taxi_id,a.trip_start_timestamp,a.trip_end_timestamp,
                 a.trip_seconds,a.trip_miles,a.trip_total,
                                 a.payment_type,a.company,a.update_time)
                   values(b.trip_id,b.taxi_id,b.trip_start_timestamp,b.trip_end_timestamp,
                 b.trip_seconds,b.trip_miles,b.trip_total,
                                 b.payment_type,b.company,sysdate);
end;

call pro_usa_taxi_info();

--��������
create or replace procedure pro_part_taxi
as
begin
  delete from usa_taxi_info_sdm where substr(trip_start_timestamp,1,10)=to_char(sysdate,'mm/dd/yyyy');
  commit;
  insert into usa_taxi_info_sdm (trip_id,taxi_id,trip_start_timestamp,trip_end_timestamp,
                 trip_seconds,trip_miles,trip_total,
                                 payment_type,company)
  select trip_id,taxi_id,trip_start_timestamp,trip_end_timestamp,
                 trip_seconds,trip_miles,to_number(substr(trip_total,2)) trip_total,
                                 payment_type,company from usa_taxi_info
                 where trip_seconds!=0 and trip_miles!=0 and trip_id is not null 
                 and taxi_id is not null
                 and trip_start_timestamp is not null and trip_end_timestamp is not null 
                 and trip_seconds is not null and taxi_id is not null
                 and trip_total is not null and payment_type is not null 
                 and substr(trip_start_timestamp,1,10)=to_char(sysdate,'mm/dd/yyyy');
  update usa_taxi_info_sdm set update_time=sysdate;
  commit;
end;
call pro_part_taxi();


select * from usa_taxi_info_sdm;

select * from user_tables

--����0-23����24��ʱ������棬ƽ��ÿ��ʱ��γ˳���������ÿ��ʱ��θ������ķ�ʽ��ƽ��֧���Ľ��
select distinct decode(hours,24,0,hours) hours,trip_numbers,payment_type,avg_total from 
(select c.*,max(t) over(partition by hours) t2 from
(select b.*,
       count(trip_id) over(partition by hours) trip_numbers,
       count(payment_type) over(partition by hours,payment_type) t,
       avg(trip_total) over(partition by hours) avg_total
from
(select a.*,
case 
  when substr(trip_start_timestamp,-2)='PM' then
    substr(trip_start_timestamp,12,2)+12
  else
    substr(trip_start_timestamp,12,2)+0
end hours
from usa_taxi_info_sdm a) b) c) where t2=t order by hours;









