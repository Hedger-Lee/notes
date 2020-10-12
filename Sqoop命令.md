# Sqoop命令

1. 查看某个对应数据库下用户所拥有的表格

   ```
   sqoop  list-tables  --connect  jdbc:oracle:thin:@oracle服务器所在的电脑的ip地址:1521/oracle数据库名字  --username  oracle数据库的用户名  --password  用户名对应的密码
   
   sqoop list-tables --connect jdbc:oracle:thin:@192.168.2.135:1521/ORCL --username bigdata --password 111111
   ```

2.  **将oracle数据库的表格，抽取到hive数据库里面**

   **使用sqoop进行数据的全量抽取**

   ```
   sqoop  import  --hive-import  --connect jdbc:oracle:thin:@192.168.2.135:1521/ORCL --username bigdata --password 111111  --table  oracle里面的一张表的名字  --hive-database  hive里面的一个数据库的名字  --fields-terminated-by '分隔符'  -m 1
   
   -m 1：当oracle要被抽取的表格没有主键的时候，就需要添加这个 -m 1 的选项
   
   sqoop import --hive-import --connect jdbc:oracle:thin:@192.168.2.135:1521/ORCL --username bigdata --password 111111 --table EMP --hive-database practice --fields-terminated-by ',' -m 1
   ```

3. **表格的增量更新**

   **3.1 进行表格数据的追加**

   ```
   A1  -->  hive表A中
   
   A2  -->  hive表A中
   
   A3  -->  hive表A中
   
   ....  -->  hive表A中
   
   sqoop  import  --append  --connect  jdbc:oracle:thin:@oracle服务器所在的电脑的ip地址:1521/oracle数据库名字  --username  oracle数据库的用户名  --password  用户名对应的密码  --table  oracle数据库的表名  --target-dir  HDFS系统表格所在的文件夹位置和名字  --fields-terminated-by '分隔符'  -m 1
   
   sqoop import --append --connect jdbc:oracle:thin:@192.168.2.135:1521/ORCL --username bigdata --password 111111 --table EMP_NEW_RE --target-dir /user/hive/warehouse/practice.db/emp --fields-terminated-by ',' -m 1
   ```

   

   **3.2 同一个表格新增的内容，追加到hive表中    lastmodified**

   ```
   sqoop  import  --connect  jdbc:oracle:thin:@oracle服务器所在的电脑的ip地址:1521/oracle数据库名字  --username  oracle数据库的用户名  --password  用户名对应的密码   --table  oracle数据库的表名   --target-dir  HDFS系统表格所在的文件夹位置和名字   --incremental append  --check-column  被检查的oracle中表的列名  --last-value  上一次新增数据的时候的值
   
   A1  -->  hive表A中
   
   A1  -->  hive表A中
   
   sqoop import --connect jdbc:oracle:thin:@192.168.2.135:1521/ORCL --username bigdata --password 111111 --table EMP_NEW_RE --target-dir /user/hive/warehouse/practice.db/emp --incremental append --check-column EMPNO --last-value 1001 -m 1
   ```

   