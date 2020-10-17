# 将这个products文件中，
# 所有的ProductID，ProductName，UnitPrice三个属性读取出来，
# 并且另存到另一个文件中，
# 存放的格式例子如下：
# 1,Chai,18.0000
# 2,Chang,19.0000
import json

file = open(r"D:\test\products.txt", 'r')
contents = file.read()
file.close()

contents = json.loads(contents)
li = contents['value']
file2 = open(r"D:\test\products_2.txt", 'a')
for info in li:
    product_id = info['ProductID']
    product_name = info['ProductName']
    unit_price = info['UnitPrice']
    file2.write('{},{},{}'.format(product_id, product_name, unit_price)+'\n')
file2.close()


