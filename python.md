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



常用函数

常用模块

自定义函数

自定义类

固定的操作