import requests
import cx_Oracle

conn = cx_Oracle.connect("hedger/123456@127.0.0.1:1521/ORCL")
cursor = cx_Oracle.Cursor(conn)

sql = '''select count(1) from user_tables where table_name=upper('day_epidemic')'''
res = cursor.execute(sql)

if res.fetchall()[0][0] == 0:
    sql = '''create table day_epidemic(
    d date,
    confirm number,
    dead number,
    heal number,
    add_confirm number
    )
    '''
    cursor.execute(sql)
else:
    sql = '''truncate table day_epidemic'''
    cursor.execute(sql)

url = "https://api.inews.qq.com/newsqa/v1/automation/modules/list?" \
      "modules=FAutoGlobalStatis,FAutoContinentStatis,FAutoGlobalDailyList,FAutoCountryConfirmAdd"

response = requests.get(url).json()

for day in response['data']['FAutoGlobalDailyList']:
    date = day['date']
    confirm = day['all']['confirm']
    dead = day['all']['dead']
    heal = day['all']['heal']
    add_confirm = day['all']['newAddConfirm']
    sql = '''insert into day_epidemic values
    (to_date(to_char(sysdate,'yyyy')||{},'yyyymm.dd'),{},{},{},{})'''.format(date, confirm, dead, heal, add_confirm)
    # print(sql)
    cursor.execute(sql)
    conn.commit()

cursor.close()
conn.close()
