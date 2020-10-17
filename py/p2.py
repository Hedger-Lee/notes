from xml.dom.minidom import parse

file = parse('D:/test/lianxi.xml')

contents = file.documentElement

foods = contents.getElementsByTagName("food")

for food in foods:
    name = food.getElementsByTagName("name")[0].childNodes[0].data
    # print(name)
    price = food.getElementsByTagName("price")[0].childNodes[0].data

    print(name, price)
