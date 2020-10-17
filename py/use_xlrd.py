import xlrd
from datetime import date

file_name = "D:/test/香港酒店数据.xls"

# 打开文件，获取文件操作句柄
wb = xlrd.open_workbook(file_name)

# 获取要读取的表单
# 1.使用表单的序号
st = wb.sheet_by_index(1)

# 2.使用表单的名称
# st = wb.sheet_by_name('BIGDATA')

# 获取表单中有内容的行数
nr = st.nrows

# 用for循环读取文件行
# for i in range(nr):
#     print(st.row_values(i))

# # 日期处理
# 还原时间的格式，时间在excel里面是用1900-1-1开始至今的天数来表示的
for i in range(nr):
    t = st.cell(0, 4)
    # 将日期格式当成元组来进行存储
    # t_v = xlrd.xldate_as_tuple(t.value, datemode=0)

    t_v = xlrd.xldate_as_datetime(t.value, datemode=0)
    print(t_v, type(t_v))
    print(t_v.strftime("%Y-%m-%d"))

    # print(*t_v[:3])
    # 使用strftime方法处理时间的格式
    # d = date(*t_v[:3]).strftime("%Y-%m-%d")
    # print(d,type(d))
