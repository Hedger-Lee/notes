import re
import requests

page = 1
name = 1

while True:
    url = "https://tieba.baidu.com/p/5272519674?pn=%d" % page

    response = requests.get(url).text

    pattern = r'src="(https://imgsa.baidu.com/forum/w%3D580/sign=.+?\.jpg)" '

    ret = re.compile(pattern)

    imgs = ret.findall(response)

    for img in imgs:
        img_bytes = requests.get(img).content
        file = open("D:/test/images/{}.jpg".format(name), "wb")
        file.write(img_bytes)
        name += 1
        file.close()
        print("下载成功%d" % (name-1))
    if '">下一页</a>' in response:
        page += 1
    else:
        break
