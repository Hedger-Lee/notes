'''
d = {"炒饭":12,"河粉":10,"黄焖鸡":15}
c = input("请输入：")
if c in d:
    print(d[c])
else:
    print("没有这个菜")
'''

# name = input('请输入用户名：')
# if 5 < len(name) < 12 and name[0] not in [str(i) for i in range(0, 10)]:
#     print('用户名正确')
# else:
#     print('用户名错误')
'''
s = "I'm a single boy"
# for i in range(0, len(s)):
#     if s[i] == ' ':
#         print(i)

c = 0
for i in s:
    if i == ' ':
        print(c)
    c += 1
'''
'''
# l = ['hello', 123, 'world', 2.222, 666, 'hi']
# for i in l:
#     # if type(i) == int:
#     #     print(i)
#     if isinstance(i, int):
#         print(i)
'''

# s = 0
# for i in range(0, 101, 2):
#     s += i
# print(s)

# -----------------------------------------------------------

# for i in range(100):
#     if i % 7 != 0 and i % 10 != 7 and i//10 != 7:
#         print(i)

# for i in range(100):
#     if i % 7 == 0 or i % 10 == 7 or i//10 == 7:
#         continue
#     print(i)

# -----------------------------------------------------------
'''
for i in range(1, 8):
    if i <= 4:
        print((4 - i) * ' ' + ' '.join(i * '*'))
    else:
        print((i - 4) * ' ' + ' '.join((8 - i) * '*'))
'''
# c = 0
# h1 = 1
# h2 = 8848000
# while h1 <= h2:
#     # print(c, h1)
#     c += 1
#     h1 *= 2
# print(c)

# l = []
# for i in range(5):
#     word = input("请输入英文单词:")
#     if word == 'quit':
#         break
#     l.append(word)
# print(l)

import random

# li = ['Apple', 'Pear', 'banana']
# f = random.choice(li)
# w = f[0]
# if 'A' <= w <= 'Z':
#     print(f)

# s_red = set()
# s_blue = set()
# while len(s_red) < 5:
#     s_red.add(random.randint(1, 32))
# while len(s_blue) < 2:
#     s_blue.add(random.randint(1, 6))
# print(list(s_blue) + list(s_red))


# def fight(c, y):
#     if c == '石头':
#         if y == '剪刀':
#             print('电脑胜利了')
#         elif y == '布':
#             print('你胜利了')
#         else:
#             print('平局')
#     elif c == '剪刀':
#         if y == '石头':
#             print('你胜利了')
#         elif y == '布':
#             print('电脑胜利了')
#         else:
#             print('平局')
#     else:
#         if y == '石头':
#             print('电脑胜利了')
#         elif y == '剪刀':
#             print('你胜利了')
#         else:
#             print('平局')
#
# while True:
#     li = ['石头', '剪刀', '布']
#     ld = {'1': '石头', '2': '剪刀', '3': '布'}
#     comp = random.choice(li)
#     while True:
#         print('''1.石头
#     2.剪刀
#     3.布''')
#         n = input("请选择：")
#         if n in ['1', '2', '3']:
#             break
#         print('选择不存在，请重新选择')
#     choice = ld[n]
#     print('电脑：', comp)
#     print('你：', choice)
#     fight(comp, choice)

# menu = {'炒饭': 18, '炒粉': 16, '盖浇饭': 14}
# cai = random.choice(list(menu.keys()))
# print(cai, menu[cai])


# count = 1
# for i in range(8):
#     print(9-i,count)
#     count = (count + 1) * 2
# print(count)

# user = (('smith', 10, 1500, 100), ('allen', 20, 800, 200), ('miller', 30, 1600), ('scott', 30, 1200))
# for i in user:
#     print('姓名：', end='')
#     print(i[0], end='\t')
#     print('部门：', end='')
#     print(i[1], end='\t')
#     print('工资：', end='')
#     print(i[2], end='\t')
#     if len(i) == 4:
#         print('奖金：', i[3], end='')
#     print()

# li = [1, 2, 2, 3, 8, 7, 2]
# li = list(set(li))
# li.remove(2)
# print(li)

# user = (('smith', 10, 1500, 100), ('allen', 20, 800, 200), ('miller', 30, 1600), ('scott', 30, 1200))
# f = open(r'D:\测试\names.txt', 'a')
# for i in user:
#     f.write(i[0] + '\n')
# f.close()

# with open(r'D:\测试\names.txt', 'a') as f:
#     for i in user:
#         f.write(i[0] + '\n')


# file1 = open(r'D:\test\users.txt', 'r')
# file2 = open(r'D:\test\users_2.txt', 'a')
#
# content = file1.read()
# li = content.split('\n')
# tmp = []
# for i in li:
#     tmp.append(i)
#     if len(tmp) == 4:
#         file2.write(','.join(tmp) + '\n')
#         tmp = []

# li = file1.readlines()
# tmp = []
# for line in li:
#     tmp.append(line.replace('\n', ''))
#     if len(tmp) == 4:
#         file2.write(','.join(tmp) + '\n')
#         tmp = []

# file2.close()
# file1.close()

import json

file = open(r"D:\test\alipay.js", 'r')
contents = file.read()
file.close()

c = json.loads(contents)

print('trade_no:'+c['alipay_trade_pay_response']['trade_no'])
print('real_amount:', c['alipay_trade_pay_response']['fund_bill_list'][0]['real_amount'])
d = json.loads(c['alipay_trade_pay_response']['discount_goods_detail'])
print(d[0]['goods_name'])


