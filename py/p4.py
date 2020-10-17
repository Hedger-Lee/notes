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
