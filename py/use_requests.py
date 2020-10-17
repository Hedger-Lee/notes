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
