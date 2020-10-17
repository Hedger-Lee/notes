import cx_Oracle

# 连接数据库
conn = cx_Oracle.connect("hedger/123456@127.0.0.1:1521/ORCL")

# 创建一个游标
cursor = conn.cursor()

# 创建一个sql语句，不要添加分号
sql = "select * from emp"

# 使用游标执行语句
res = cursor.execute(sql)

# 显示查询出来的结果
print(res.fetchall())

# 关闭游标
cursor.close()

# 关闭数据库
conn.close()
