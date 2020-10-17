import xlwt

file_name = 'D:/test/x1.xls'

# 创建excel文件
wb = xlwt.Workbook(encoding='utf-8')

# 创建表单
st = wb.add_sheet('bigdata')
st2 = wb.add_sheet('test')

# 写入数据
# (行, 列, 数据)
st.write(2, 1, 'hello')
st2.write(1, 1, 'world')

# 保存文件
wb.save(file_name)
