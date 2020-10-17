import re
import requests
import xlwt

# file_name = 'D:/test/top250.xls'
file_name = 'D:/test/top250-2.xls'

excel = xlwt.Workbook(encoding='utf-8')
st = excel.add_sheet('TOP250')
st.write(0, 0, '电影名')
st.write(0, 1, '导演')
st.write(0, 2, '评分')
st.write(0, 3, '评价人数')
st.write(0, 4, '简介')
st.write(0, 5, '图片地址')

start = 0
row = 1

headers = {
    "User-Agent": "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36"
}

for i in range(10):
    url = "https://movie.douban.com/top250?start=%d&filter=" % start
    response = requests.get(url, headers=headers).text

    # 图片地址
    img_pattern = '''<img width="100" alt=".+?" src="(.+?)" class="">'''
    ret_img = re.compile(img_pattern)
    imgs = ret_img.findall(response)

    # 电影名
    title_pattern = '''class="">\s+<span class="title">(.+?)</span>'''
    ret_title = re.compile(title_pattern)
    titles = ret_title.findall(response)

    # 导演
    director_pattern = '''<p class="">\s+(.+?)<br>'''
    ret_director = re.compile(director_pattern)
    directors = ret_director.findall(response)

    # 评分
    rank_pattern = '''</span>\s+<span class="rating_num" property="v:average">(.+?)</span>'''
    ret_rank = re.compile(rank_pattern)
    ranks = ret_rank.findall(response)

    # 评价人数
    number_pattern = '''<span property="v:best" content="10.0"></span>\s+<span>(.+?)</span>'''
    ret_number = re.compile(number_pattern)
    numbers = ret_number.findall(response)

    # 简介
    desc_pattern = '''(?:<p class="quote">\s+<span class="inq">(.+?)</span>\s+</p>)|(?:<span>.+?</span>
                        </div>

                    </div>)'''
    ret_desc = re.compile(desc_pattern)
    descs = ret_desc.findall(response)


    for j in range(25):
        st.write(row, 0, titles[j])
        st.write(row, 1, directors[j].replace("&nbsp;", " "))
        st.write(row, 2, ranks[j])
        st.write(row, 3, numbers[j])
        st.write(row, 4, descs[j])
        st.write(row, 5, imgs[j])
        row += 1
    start += 25
excel.save(file_name)


