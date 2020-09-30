# python

> python用来做什么？    3.7
>
> 获取不同的数据源里面的不同类型的数据；
>
> 对数据本身进行处理；
>
> 将数据存储到数据库中。

编程语言：JAVA  C

脚本语言：python  js  ruby  

Python写代码的地方：pycharm  eclipse  vs  nodepad++  editplus  sublime  idle  ...

## 基础语法

### 注释

```python
#  单行注释

三引号  段落注释   '''     '''
```

### 变量

```python
n=10

n2='hello'

n3=1.666

变量名  赋值符号  值

传递赋值

a=b=c=d=10

多变量赋值

a,b,c,d=10,20,30,40

a,b=b,a

自增赋值

a+=2

a-=3

a*=4

a/=5
```

### 数据类型   

> print(type(变量和值))

#### 布尔

```sql
真   假   bool    做判断的时候
a=True
b=False
```

#### 数字

```python
整型  int   浮点型  float   复数  complex
a=666
b=1.5678
c=3+2j
数字运算：
+  -  *  /
**    幂运算
a=3
print(a**4)
//    取整运算
a=10
print(a//3)
%   取余运算
a=10
print(a%3)
python中的小数运算会出现误差：
print(0.1+0.1-0.3)
```

#### 字符串：str

```python
a='hello'

b="world"

c='''I'm Lilei'''   三引号里面可以回车，也可以有其他的特殊符号

输入的操作：input()  默认是接受的字符串

n1=input('输入一个数字吧：')

n2=input('输入另一个数字吧：')

print(n1+n2)

如果要输出数字，要将输入的内容进行数据类型的转换

n1=float(input('输入一个数字吧：'))

n2=float(input('输入另一个数字吧：'))

print(n1+n2)

字符串的相加：

a='hello'

b='world'

c=a+b

print(c)

字符串重复的操作：

print('hello'*100)

**字符串操作的函数：都不会作用到字符串本身**

**python中字符串的序号是从0开始**

大写   s=s.upper()

小写  s=s.lower()

首字母大写    s=s.title()

查找：找到字符在字符串中的位置，没有找到返回-1，多个只会查找第一个

a=s.find('d')

print(a)

find和index两个不同的方法有什么区别？

找不到数据的时候，find会返回-1，index会报ValueError的错误

替换    s=s.replace('o','-')        字符串.replace(old, new)

去除空格  

去除中间的  s=s.replace(' ','')

去除左边的  s=s.lstrip()

去除右边的  s=s.rstrip()

去除两边的  s=s.strip()

统计    a=s.count('o')

判断前置   s.startswith('He')

判断后置   s.endswith('orld')

截取   使用某个符号，将字符串切割成一个包含了多个字符串的列表

s="lilei,hanmeimei,lucy,tom,mike"

s1=s.split(',')

print(s1)

字符串格式化

**使用%号进行数据在字符串中的传递**

name='天下一霸'

level=30

exp=54320231.55

items='屠龙刀'

npc="%s，你当前是%d等级，任务经验是%.2f，奖励物品为%s！"%(name,level,exp,items)

print(npc)

也可以全部用%s来表示

npc="%s，你当前是%s等级，任务经验是%s，奖励物品为%s！"%(name,level,exp,items)

%s  字符串

%d  整数

%f  小数    %.小数位数f   

如果字符串中本来就包含了%，那么就不能用上面的方式来格式化数据

例如网络地址的内容 ： "https://image.baidu.com/search/index?tn=baiduimage&ipn=r&ct=201326592&cl=2&lm=-1&st=-1&fm=index&fr=&hs=0&xthttps=111111&sf=1&fmq=&pv=&ic=0&nc=1&z=&se=1&showtab=0&fb=0&width=&height=&face=0&istype=2&ie=utf-8&word=%E7%86%8A%E7%8C%AB&oq=%E7%86%8A%E7%8C%AB&rsp=-1"

**需要用字符串本身的format()方法来格式化数据：**

wangzhan='sougou'

url="https://image.{}.com/search/index" \

"?tn={}image&ipn=r&ct=201326592&cl=" \

"2&lm=-1&st=-1&fm=index&fr=&hs=0&xthttps=111111&sf=1&fmq=&pv=" \

"&ic=0&nc=1&z=&se=1&showtab=0&fb=0&width=&height=&face=0&istype" \

"=2&ie=utf-8&word=%E7%86%8A%E7%8C%AB&oq=%E7%86%8A%E7%8C%AB&rsp=-1".format(wangzhan,wangzhan)

print(url)

npc="{}，你当前是{}等级，任务经验是{}，奖励物品为{}！".format(name,level,exp,items)

**字符串的切片：**

取出某个下标

字符串[下标序号]   

s='abcdefghijklmn'

print(s[3])

取出某个范围的内容

字符串[开始序号: 结束序号+1]      前闭后开的取值范围

   

负数的下标序号，表示从后面开始数

-1是最后一个，-2是倒数第二个，以此类推

字符串[：]      从开始到结束

字符串[开始序号：]     

字符串[：结束序号]   

字符串[开始序号: 结束序号+1, 步长]       在开始到结束的范围内，隔多远获取一个数

print(s[1:10])

print(s[1:10:2])   获取的是1 3 5 7 9的下标值

\#mjg 

print(s[-2:-9:-3])

从后往前打印所有内容

print(s[::-1])
```

#### 列表：list

```python
a=["饼干","西瓜","hello",666,1.23456]

新增

在列表中追加新的元素：列表.append(元素内容)

a=["饼干","西瓜","hello",666,1.23456]

a.append('草莓')

print(a)

a.append('奥利奥')

print(a)

将元素放在固定的某个位置：列表.insert(列表的序号，元素内容)

a.insert(1,'橘子')

print(a)

删除

按照序号删除元素：列表.pop(列表的序号)

a.pop(4)

print(a)

按照内容删除元素：列表.remove(元素内容)   只会删除第一个匹配的内容

a.remove('西瓜')

print(a)

修改    使用赋值的语句实现内容的修改

列表[列表的序号]=新值

a[2]='你好'

print(a)

查询：和字符串的切片查询是一样的

print(a[0])

print(a[1:5])

print(a[1:5:2])

print(a[::-1])

排序：升序  降序

升序：列表.sort()

a=[5,8,3,1,0,9]

a.sort()

print(a)

降序：

a=[5,8,3,1,0,9]

a.sort()

print(a[::-1])

或者

a.sort(reverse=True)

print(a)

拼接：用某个符号将列表拼接成一个字符串

names=['lilei','han','lucy','tom']

names2='-'.join(names)

print(names2)

统计：

print(a.count('西瓜'))

a=[1,2,3]

b=[4,5,6]

print(a+b)   拼接多个列表

print(a*10)   重复列表的内容
```



#### 元组：tuple   

> 不可变的数据类型

> 不能新增，不能删除，不能修改，不能排序...

```python
a=("hello","大米",1000,1.666)

单元素的元组定义：需要在元素后面添加逗号

a=(1,)
```



#### 字典

> 键值对类型  key-value类型  映射类型   dict

```python
字典的元素是成对存在的，关键字是不能重复的，字典是无序的数据类型

{关键字:值, 关键字:值}

menu={"炒饭":12,"河粉":10}

查询

查询所有的关键字  print(menu.keys())

查询所有的值         print(menu.values())

查询关键字对应的值   print(menu['河粉'])

新增：关键字不存在的时候   字典名[关键字]=值

menu['奶茶']=13

print(menu)

修改：关键字已经存在的时候

menu['奶茶']=16

print(menu)

删除：字典名.pop(关键字)

menu.pop('炒饭')

print(menu)

清空字典的内容：字典名.clear()
```



#### 集合

> set   {元素1, 元素2...}   不能重复的数据类型  集合也是无序的数据类型

```python
进行数据的去重操作

a=['hello','han',234,1.2,234,'han']

a1=set(a)

print(a1)

计算数据的交集、并集、差集

a=[1,2,3,4]

b=[3,4,5,6]

\#计算两个列表的交集

a=set(a)

b=set(b)

print(a&b)

\#计算两个列表的并集

print(a|b)

\#计算两个列表的差集

print(a^b)
```

#### 数据类型的运算

```python
成员运算  in      not in

a="helloworld"

print('owo' not in a)

a={"炒饭":12,"河粉":10,"黄焖鸡":15,"炒饭":16}

print('黄焖鸡' in a)

对象运算  is      is not

判断数据的来源是否是一个内存地址

比较运算  >   <    >=    <=    !=    ==

逻辑运算  and    or     not

数据类型长度的查看：数字没有长度

len(数据)
```



### 输入输出

```python
打印输出函数：

print(n)

print(n,n2,n3)

输入
input()
```



### 逻辑操作

#### 判断  if 

```python
python的语法逻辑，是根据缩进行决定的
判断逻辑：
如果  判断:
执行语句
if num>0:
    print('开始判断')
    print('正数')

多层判断：
if  条件判断1:
执行语句
elif  条件判断2:
执行语句
elif  条件判断3:
执行语句
...

剩余逻辑进行判断
if  条件判断1:
执行语句
elif  条件判断2:
执行语句
elif  条件判断3:
执行语句
...
else:
执行语句

color='blank'
if color=='blue':
    print('蓝色')
elif color=='red':
    print('红色')
elif color=='green':
    print('绿色')
elif color=='pink':
    print('粉色')
else:
    print('其他颜色')

#练习：有一个字典  {"炒饭":12,"河粉":10,"黄焖鸡":15}
#有个用户提示输入的窗口，如果用户输入的是字典中存在的关键字，那么就打印对应的值
#否则就打印提示语句  没有这个菜
'''
d={"炒饭":12,"河粉":10,"黄焖鸡":15}
cai=input("点个菜：")
if cai in d:
    print(d[cai])
else:
    print('没有这个菜')
'''

#输入一个用户名，如果这个用户名的长度大于5小于12，并且不是数字开头，提示用户名正确，
#否则提示用户名错误
user=input("用户名：")
if not "0"<=user[0]<="9" and len(user)>5 and len(user)<12:
    print("正确")
else:
    print("错误")

```

#### 循环控制

```python
for循环基本语法
for  变量名字  in  循环范围:
执行语句
```

```python
循环范围可以是：字符串、列表、元组、字典、集合
#循环练习：有一个字符串，"I'm a single boy"，将空格所在的序号打印出来
'''xuhao=0
for i in "I'm a single boy":
    if i==" ":
        print("序号是",xuhao)
    xuhao+=1'''

#有一个列表 ['hello',123,'world',2.222,666,'hi']
#循环这个列表，将这个列表中的整数打印出来
for i in ['hello',123,'world',2.222,666,'hi']:
    if type(i)==type(100):
        print(i)

使用range()进行循环的控制
for i in range(10):
    print(i)

range(10)   0-9
range(20)   0-19
range(1,11)   1-10    前闭后开的范围
range(1,11,2)   1 3 5 7 9   可以接步长
range(10,0,-1)    10-1
range(10,0,-2)  10 8 6 4 2
```

for i in range(1,8):

​    if i<=4:

​        print((4-i)*' '+i*'* ')

​    else:

​        print((i-4)*' '+(8-i)*'* ')

\#九九乘法表

for i in range(1,10):

​    for j in range(1,i+1):

​        print('{}x{}={}'.format(j,i,i*j), end='\t')

​    print()

while的循环控制：判断为真，进入循环，为假的时候跳出循环

while  判断:

执行语句

n=1

while n<=10:

​    print(n)

​    n+=1

计算数字的while游戏：

n=3

user=int(input("计算%dx2的结果="%(n)))

while user==n*2:

​    print('答对了，你真聪明！')

​    n=n*2

​    user=int(input("计算%dx2的结果="%(n)))

print("真的是太笨了，这都不会！！！")

\#练习

\#有一张纸厚度是1mm，珠穆朗玛峰高度是8848m，

\#请问这个纸要对折多少次，才会超过山的高度

zhi=1

shan=8848000

cishu=0

while zhi

​    zhi=zhi*2

​    cishu=cishu+1

print(cishu)

循环的关键字：

结束循环   break

for i in range(1,11):

​    if i==5:

​        break

​    print(i)

跳过本次的循环，直接开始下一次循环  continue

for i in range(1,11):

​    if i==5:

​        continue

​    print(i)

\#可以循环五次，让用户输入英文单词，将输入的单词保存在一个列表中，

\#如果用户输入的是quit，那么马上退出，并且打印出已经保存的内容

liebiao=[]

for i in range(5):

​    w=input("word:")

​    if w=='quit':

​        break

​    liebiao.append(w)

print(liebiao)

常用模块：

在当前代码页面，导入需要的模块

import  模块名字

随机模块：random

import  random

\#随机小数，大于0小于1的小数

a=random.random()

print(a)

\#随机整数，大于等于开始值，小于等于结束值

a=random.randint(1,5)

print(a)

\#在有序的数据类型中进行数据的随机，字符串 列表  元组

a=random.choice("abcdefg")

print(a)

\#有一个列表，['Apple','Pear','banana']，在里面随机的抽选一个内容，

\#如果首字母是大写的，那么就把随机的内容打印出来

liebiao=['Apple','Pear','banana']

a=random.choice(liebiao)

if a[0]==a[0].upper():

​    print(a)

else:

​    print('小写的不要')

\#自己造一个双色球的号码随机，红色区域是1-32的数字，数字不能重复，

\#蓝色是1-6的数字，不能重复，红色是选择5个，蓝色是选择2个

\#将这7个数字随机出来

reds=[]

for i in range(5):

​    red=random.randint(1,32)

​    while red in reds:

​       red=random.randint(1,32) 

​    reds.append(red)

blues=[]

for i in range(2):

​    blue=random.randint(1,6)

​    while blue in blues:

​       blue=random.randint(1,6) 

​    blues.append(blue) 

reds.sort()

blues.sort()

print(reds+blues)

\#和电脑玩石头剪刀布，电脑随机一个，你选择一个，最后打印谁赢了

diannao=random.randint(1,3)

games={1:'石头',2:'剪刀',3:'布'}

print("电脑出的是：",games[diannao])

user=int(input("1:'石头',2:'剪刀',3:'布'："))

if diannao==user:

​    print('平手')

elif diannao==1 and user==2 or diannao==2 and user==3 or diannao==3 and user==1:

​    print('电脑赢了')

else:

​    print('你赢了')

\#在上面的字典中，随机一个品种，并且将对应的值一起打印出来

menu={'炒饭':18,'炒粉':16,'盖浇饭':14}

a=random.choice(list(menu.keys()))

b=menu[a]

print(a)

print(b)

\#有一只猴子，有一堆桃子，每天会吃掉桃子数量的一半再加一个。

\#第九天的时候，发现只有一个桃子了，请问一开始有几个桃子

tao=1

for i in range(1,9):

​    tao=(tao+1)*2

print(tao)

users=(('smith',10,1500,100),('allen',20,800,200),('miller',30,1600),('scott',30,1200))

\#取出数据，打印成如下格式：

\#姓名：smith 部门:10 工资：1500 

\#姓名：allen 部门:20 工资：800  奖金:200

\#姓名：miller 部门:30 工资：1600

\#姓名：scott 部门:30 工资：1200

for user in users:

​    print("姓名：{} 部门:{} 工资：{}".format(user[0],user[1],user[2]),end=' ')

​    if len(user)==4:

​        print("奖金:{}".format(user[3]))

​    else:

​        print()

\# 有个列表[1,2,2,3,8,7,2]，删除里面所有的2

liebiao=[1,2,2,3,8,7,2]

for i in range(liebiao.count(2)):

​    liebiao.remove(2)

print(liebiao)

时间模块：获取当前的系统时间

import  datetime

a=datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")

print(a)

**文件的读写：**

文本文档的读写操作：

写入的操作

\#确定文件的位置和名字

filename="C:/文件/a1.txt"

\#双击打开文件

file=open(filename,"a")    #w   write覆盖写入      a   append追加写入

\#写入文件的内容

file.write("\n")

file.write("lilei")

\#关闭保存文件

file.close()

\#练习：users=(('smith',10,1500,100),('allen',20,800,200),('miller',30,1600),('scott',30,1200))

\#将上面元组中的名字保存到一个names.txt文件中，一个名字占一行

users=(('smith',10,1500,100),('allen',20,800,200),('miller',30,1600),('scott',30,1200))

filename='C:/文件/names.txt'

file=open(filename,'a')

for u in users:

​    file.write(u[0]+'\n')

file.close()

读取的操作：一次open就只能从上往下读取一次

\#确定要读取的文件位置和名字

filename='C:/文件/names.txt'

\#打开文件

file=open(filename,'r')    #  r    read

\#读取内容

\#  read() 是把整个文件的内容当成一个字符串

neirong1=file.read()    

print(neirong1)

\#  readlines()  是把整个文件的内容当成一个列表

neirong2=file.readlines()

print(neirong2)

\#关闭文件

file.close()

\#读取users.txt文件，处理成     姓名,性别,年龄,爱好     的格式

filename="C:/文件/users.txt"

file=open(filename,'r')

contents=file.readlines()

file.close()

filename2="C:/文件/users_2.txt"

file2=open(filename2,'a')

'''cishu=1

hang=''

for i in contents:

​    hang=hang+','+i.replace('\n','')

​    cishu=cishu+1

​    if cishu==5:

​        file2.write(hang[1:]+'\n')

​        cishu=1

​        hang=''

'''

cishu=0

for i in contents:

​    i=i.replace('\n','')

​    cishu+=1

​    if cishu%4==0:

​        file2.write(i+'\n')

​    else:

​        file2.write(i+',')

file2.close()

**json文件的读取：和文本的读写方法是一样的**

什么是json：json是和字典一样的一种键值对的格式，一般是在网络数据的传输和数据的格式化存储上

​    ![alipay.js](http://note.youdao.com/yws/public/resource/e3787f23c5c181b91bd8deb4e811b295/xmlnote/1CBAC120160341AC900CB9A8DED8570A/8391)

filename="C:/文件/alipay.js"

file=open(filename,'r')

contents=file.read()

file.close()

\#将字符串格式的json，转换成字典格式

import json

c=json.loads(contents)

print(c['alipay_trade_pay_response']['voucher_detail_list'][0]['name'])

print(c['alipay_trade_pay_response']['voucher_detail_list'][0]['memo'])

练习：读取alipay.js文件，将trade_no、real_amount、goods_name读取出来

课后练习：

​    ![products.txt](http://note.youdao.com/yws/public/resource/e3787f23c5c181b91bd8deb4e811b295/xmlnote/C80258DD18A1433689D2021604DC010E/8395)

将这个products文件中，所有的ProductID，ProductName，UnitPrice三个属性读取出来，并且另存到另一个文件中，存放的格式例子如下：

1,Chai,18.0000

2,Chang,19.0000





## 常用模块

### csv模块

#### csv文件读取

```python
#导入csv操作的模块
import csv

#定位文件的位置
filename="C:/文件/香港酒店数据.csv"

#使用csv的读取工具打开文件
file=open(filename,'r')
f=csv.reader(file)

#使用for循环以行为单位读取文档数据
for i in f:
    print(i[1]+'\t'+i[2])
    
#关闭窗口
file.close()
```

#### csv文件写入

```python
import csv

filename="C:/文件/new.csv"
file=open(filename,'w')
f=csv.writer(file)

#定义要写入什么内容
#外面的列表，表示整个文件，里面的列表，表示每一行数据
datas=[['苹果',18],['桃子',26],['栗子',28],['橘子',6]]

#开始写入数据
for i in datas:
    #以行为单位写入，每次写入一个列表
    f.writerow(i)
file.close()
```

```python
#练习：读取香港酒店的数据，将里面的酒店中文名，地址，价格读取出来，
#将这三个数据，写入到另外的一个csv文件中
答案：

import csv

filename="C:/文件/香港酒店数据.csv"
file=open(filename,'r')
f1=csv.reader(file)
hangs=[]
for i in f1:
    hang=[i[2],i[4],i[8]]
    hangs.append(hang)
file.close()
print(hangs)

filename2="C:/文件/hotel.csv"
file2=open(filename2,'w')
f2=csv.writer(file2)
for h in hangs:
    f2.writerow(h)
file2.close()
```

### xml模块

#### 读取xml文件

```python
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
```

### 处理Excel

#### 读取excel xlrd模块

```python
#导入读取excel的模块
import xlrd

#指定文件位置
filename="C:/文件/香港酒店数据.xls"

#打开文件
wb=xlrd.open_workbook(filename)

#使用不同的方式选择要读取的表单
#使用表单的序号
#st=wb.sheet_by_index(1)

#使用表单的名称
st=wb.sheet_by_name('BIGDATA')

#获取表单中有内容的行数
nr=st.nrows

#使用for循环读取文件的行
for i in range(nr):
    print(st.row_values(i))
```

#### 写入Excel xlwt模块

```python
#导入excel写入的模块
import xlwt

#定义写入文件的位置和名字
filename="C:/文件/x1.xls"

#创建excel文件
wb=xlwt.Workbook(encoding='utf-8')

#在excel文件中创建表单
st=wb.add_sheet('BIGDATA')
st2=wb.add_sheet('TEST')

#在表单中写入数据   行  列  数据
st.write(2,3,'李雷')
st2.write(2,1,'哈哈哈')

#保存这个文件
wb.save(filename)
```

#### 处理时间

```python
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

```

### requests模块

> 第三方平台的网络接口的数据：API
>
> 一个接口就是一个http的链接

```python
import json
import requests

url = "https://api.inews.qq.com/newsqa/v1/automation/foreign/country/ranklist"

# 获取文本信息
contents = requests.get(url).text

contents = json.loads(contents)["data"]
print(type(contents))

for d in contents:
    print(d["name"], d["date"], d["confirmAdd"])

# 获取json格式
# contents = requests.get(url).json()
#
# contents = contents["data"]
# print(type(contents))
#
# for d in contents:
#     print(d["name"], d["date"], d["confirmAdd"])

```

```python
#练习：获取接口：https://api.inews.qq.com/newsqa/v1/automation/modules/list?modules=FAutoCountryMerge，将里面法国每一天的确诊数据保存到excel文档中，
#保存日期date和确诊confirm两个属性的内容

import xlwt
import requests

url = "https://api.inews.qq.com/newsqa/v1/automation/modules/list?modules=FAutoCountryMerge"

contents = requests.get(url).json()

# data = contents["data"]["FAutoCountryMerge"]["法国"]["list"]
data = contents["data"]["FAutoCountryMerge"]
f_list = data.keys()
# print(type(data))

wb = xlwt.Workbook(encoding="utf-8")
# st = wb.add_sheet("法国")
# st.write(0, 0, "时间")
# st.write(0, 1, "确诊人数")

for i in f_list:
    st = wb.add_sheet(i)
    st.write(0, 0, "时间")
    st.write(0, 1, "确诊人数")
    row = 1
    for info in data[i]["list"]:
        date = info["date"]
        confirm = info["confirm"]
        st.write(row, 0, date)
        st.write(row, 1, confirm)
        row += 1

# row = 1
# for info in data:
#     date = info["date"]
#     confirm = info["confirm"]
#     st.write(row, 0, date)
#     st.write(row, 1, confirm)
#     row += 1

wb.save("D:/test/info.xls")

```

```python
#豆瓣读书榜：
#https://read.douban.com/j/index//charts?type=intermediate_finalized&index=featured&verbose=1&limit=50
#保存书的  书名title   作者名name  分类shortName  评分averageRating
#保存到excel中

import requests
import xlwt

url = "https://read.douban.com/j/index//charts?type=intermediate_finalized&index=featured&verbose=1&limit=50"
headers = {
    "user-agent": "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) "
                  "Chrome/85.0.4183.121 Safari/537.36 "
}

contents = requests.get(url, headers=headers).json()["list"]

wb = xlwt.Workbook(encoding="utf-8")
st = wb.add_sheet("中篇榜")
st.write(0, 0, "书名")
st.write(0, 1, "作者")
st.write(0, 2, "分类")
st.write(0, 3, "评分")

row = 1

for info in contents:
    title = info["works"]["title"]
    if info["works"]["author"]:
        name = info["works"]["author"][0]["name"]
    else:
        name = info["works"]["origAuthor"][0]["name"]
    kind = info["works"]["kinds"][0]["shortName"]
    rate = info["works"]["averageRating"]
    st.write(row, 0, title)
    st.write(row, 1, name)
    st.write(row, 2, kind)
    st.write(row, 3, rate)
    row += 1
wb.save("D:/test/novel.xls")

```



自定义函数

自定义类

固定的操作