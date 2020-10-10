操作系统   unix
肯汤普森  unics   unix
丹尼斯  B+   C
李纳斯  linux

centos   redhat   suse  opensuse   debian   ubuntu  ...

centos6  7
虚拟机

VMware-workstation-full-14.1.3-9474260.exe

远程连接的工具：xshell   securtCRT  ssh  putty ...

如果没有网卡地址：
cd  /etc
cd  sysconfig
cd  network-scripts
vi  ifcfg-ens33
i
将ONBOOT=NO  修改为YES
ESC按键
ZZ
service network restart
ifconfig


基本的系统命令：
Linux系统的第一级目录： 根目录  /
根目录中文件夹的含义：
bin  存放的是所有系统中的命令
boot  管理开机启动的
etc  存放所有的系统配置文件
home  家目录，所有非管理员用户所在的文件夹
root  管理员的家目录
mnt  类似于windows系统的光驱
usr  一般是用来存放自己的文件或者安装一些软件等等

绝对路径和相对路径：
绝对路径：从根目录开始定位
相对路径：从你当前所在的位置开始定位

扩展选项： 命令  -选项内容
ls -l

基本操作
打开某个目录：
cd 文件夹的位置和名字
cd /      打开根目录
cd ..     返回上一级目录
查看当前位置有哪些内容：
ls
ls  -l  查看当前位置下文件或者文件夹的详细信息
ls  -a  查看包含了隐藏文件的文件名
清除当前屏幕：
clear
查看自己当前所在的位置：
pwd

文件操作，Linux里面的后缀名和系统文件本身没有任何的关系，后缀名是给人看的
创建文件：
touch 文件的位置和文件名
touch a.txt

复制文件：
cp  源文件位置和名字  目标文件夹的名字
cp  /usr/t03.doc  /home

剪切文件：
mv  源文件位置和名字  目标文件夹的名字
mv  /usr/games  /home

重命名文件：
mv  源文件名字  新的文件名

删除文件：
rm  文件名字               删除的时候有提示
rm  -f  文件名字           强制删除，删除的时候没有提示

编辑文件：vi编辑器   vim编辑器
vim  文件名
刚打开的窗口是  “查看模式”；
从查看模式进入到  “编辑模式”：i  或者  a
从编辑模式返回到  "查看模式"： ESC按键
保存文件并且退出，在查看模式，连续的两个大写ZZ

在查看模式，进入命令模式：  :号
:w  保存文件
:q  退出编辑
:wq  保存并且退出

快捷方式：
查看模式中的快捷方式：
复制：  nyy     n表示的数字
粘贴：  p
删除行：  ndd     n表示数字
光标到第一行：  gg
光标到最后一行：  G
光标往下挪动N行：     n回车按键
查找字符串：   /要查找的字符

命令模式一些常用命令：
:wq!    强制保存并且退出
显示行号：  :set nu
关闭行号：  :set nonu
字符串的替换：   :开始行数,结束行数s/旧内容/新内容/g
$表示最后一行
:5,$s/a/b/g

查看文件：
一次查看整个文件内容：   cat 文件名
分页查看文件：     more  文件名           回车一次往下一行，空行是一次往下一页
查看前面几行：     head -n  行数  文件名
查看后面几行：     tail -n  行数  文件名

文件夹的操作：
创建文件夹：
mkdir  文件夹的名字
mkdir -p  文件夹的名字       -p选项是递归的意思

复制文件夹：
cp -r  源文件夹的名字  目标目录的名字

剪切文件夹：
mv  源文件夹的名字  目标目录的名字

重命名文件夹：
mv  旧的文件夹的名字  新的文件夹的名字

删除文件夹：
rm -rf  文件夹的名字        -r是一层层往下的意思

系统操作
硬件
CPU：
查看进程列表：top
查看cpu型号：  cat /proc/cpuinfo

硬盘：df -h

网卡 ：ifconfig

内存： free -h

软件：
在线安装：yum -y install 软件名字
卸载软件：yum -y remove 软件名字

查看所有进程：
ps  -aux
-a  所有的
-u  所有的用户
-x  正在运行的

结束掉某个进程：
kill  进程编号

查看当前使用的端口号信息：
netstat  -atunp

检查网络是否通畅：
ping  域名/ip地址

打包和压缩：
tar 包
打包：
tar -cf 包名.tar  要打包的文件和文件夹
tar -cf new02.tar t01.txt t02.jpg
tar -cf new01.tar ./*
解包：
tar -xf 包名
查看包的内容：
tar -tf  包名

tar.gz 压缩包
压缩：
tar -zcf 压缩包名字.tar.gz  要压缩打包的文件和文件夹
解压：
tar -zxf 压缩包的名字
查看压缩包的内容：
tar -ztf  压缩包的名字

zip压缩包
压缩：
zip 压缩包名字.zip  要压缩打包的文件和文件夹
解压：
unzip 压缩包的名字
查看压缩包的内容：
unzip -l 压缩包的名字

权限操作：
drwxr-xr-x
-rw-r--r--
drwx------

d      	  				 rwx				r-x			r-x
类型		   				 所属主                    所属组             其他人	
d 文件夹					r  可读的权限
-  普通的文件				w  编辑的权限
l  链接文件（快捷方式）		x  执行的权限（./运行的脚本文件需要执行权限）
    -  当前的位置没有权限

修改权限的命令：
chmod  ugo+rwx  文件名
chmod  ugo-rwx  文件名

修改文件夹已经里面所有文件的权限：
chmod -R  权限修改  文件夹的名字

用数字的方式表达权限：
r  4
w  2
x  1
6  rw-
5  r-x
7  rwx
3  -wx
0  ---
chmod  760  文件名

查找文件：
find  范围  查找的规则  值

根据名称查找文件
find /usr -name t01.txt
find /home -name "t*"
find /home -name "t01*" -o -name "t02*"
find /home -name "t*" -a -name "*.txt"

根据文件大小查找
find  /usr  -size  +2k
find  /usr  -size  -2k
+2k
+2M
+2G

根据文件类型查找    d  l  f
find /usr/aaa -type d

文件内容的增删改查：sed
内容的新增，插入一行新内容
sed  -i  行数i\内容  文件名字
sed -i 5i\emp text.txt

内容的删除：以行为单位删除数据
sed -i '开始行数，结束行数d'  文件名

内容的修改：
sed  -i '开始行数，结束行数s/旧内容/新内容/g'  文件名

查看某行：
sed -n '开始行数，结束行数p'  文件名

查看行数：
wc -l  文件名

过滤信息：grep
netstat -atunp | grep ":25"
ps -aux | grep "top"
查看/home里面所有的文本文档的详细信息
ls -l /home | grep ".txt"

使用grep对文件进行以行为单位的内容过滤
查看以什么开头的行：
grep -e "^[0-9a-zA-Z]"  文件名

查看以什么结尾的行：
grep -e "[0-9a-zA-Z]$"  文件名

查看以什么开头以什么结尾的行
grep -e "^[0-9].*[A-Z]$" text.txt 

定时任务：crontab
查看有没有定时任务：
crontab -l

创建定时任务：
crontab -e
任务分成两段：
时间   命令
时间：  分钟  小时  天  月  周
* * * * *  每分钟跑一次
*/5  * * * *    每隔5分钟跑一次
5-10 * * * *   每个小时的第5分钟到第10分钟每分钟运行一次
* 8 * * *   每天的8点钟运行一次
*/10 7 * 1-6 1    1-6月每个星期一早上7点每隔10分钟运行一次
0-59   0-23  1-31  1-12  0-7

0 7 1 * *   每个月1号早上7点整

查看定时任务是否开启：
service crond status

开启：
service crond start

停止：
service crond stop