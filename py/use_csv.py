import csv

file = open('D:/test/香港酒店数据.csv', 'r')
f = csv.reader(file)
file2 = open('D:/test/香港酒店数据_2.csv', 'w', newline='')
f2 = csv.writer(file2)

for info in f:
    info_2 = [info[2], info[4], info[8]]
    f2.writerow(info_2)

file2.close()
file.close()
