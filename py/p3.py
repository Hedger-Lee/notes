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
