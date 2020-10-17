from xml.dom.minidom import parse

# 解析文件
file = parse("D:/test/product.xml")

# 获取文件DOM对象
contents = file.documentElement
# print(contents)

# 获取指定标签的所有对象，得到一个NodeList对象列表，里面存的是一个个的Element对象
products = contents.getElementsByTagName("m:properties")
# print(products)

# 获取文本信息
for p in products:
    ProductID = p.getElementsByTagName("d:ProductID")

    # print(ProductID[0], type(ProductID[0]))
    # ProductID[0] 元素对象，Element对象，存储于NodeList对象列表中

    # print(ProductID[0].childNodes[0].data, type(ProductID[0].childNodes[0].data))
    # Element.childNodes也是NodeList对象列表，存放一个个的Text文本对象
    # Text.data取出对应的文本信息

    # 通过标签对象获取元素文本信息
    product_id = ProductID[0].childNodes[0].data
    # print(product_id)

    ProductName = p.getElementsByTagName("d:ProductName")
    product_name = ProductName[0].childNodes[0].data

    UnitPrice = p.getElementsByTagName("d:UnitPrice")
    unit_price = UnitPrice[0].childNodes[0].data

    print(product_id,product_name,unit_price)