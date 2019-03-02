### MySQL 自定义起始日，按周分组查询

**先来看看简单的按日（天）、月、年分组查询**  
用到的 mysql 内置方法  
DATE_FORMAT  
用于对日期字段的格式化输出，使用格式如下：
```
#第一个参数：待格式化的日期类型的列；第二个参数：格式化的规则（联想 java 中的 SimpleDateFormat）
DATE_FORMAT(createtime, '%Y-%m-%d')
```
示例：  
假设有表 member_info   
包含时间字段 createtime（timestamp类型）、id_card（Varchar类型）  
现在要从 2018-05-25 00:00:00 到 2018-06-20 23:59:59 查询 id_card 出现的次数并按日、月、年来分组。
```
#按日（天）分组
SELECT DATE_FORMAT(createtime, '%Y-%m-%d') AS dy,COUNT(id_card) AS usercount FROM members_info WHERE createtime BETWEEN '2018-05-25 00:00:00' AND '2018-06-20 23:59:59' GROUP BY dy

#按月分组
SELECT DATE_FORMAT(createtime, '%Y-%m') AS dy,COUNT(id_card) AS usercount FROM members_info WHERE createtime BETWEEN '2018-05-25 00:00:00' AND '2018-06-20 23:59:59' GROUP BY dy

#按年分组
SELECT DATE_FORMAT(createtime, '%Y') AS dy,COUNT(id_card) AS usercount FROM members_info WHERE createtime BETWEEN '2018-05-25 00:00:00' AND '2018-06-20 23:59:59' GROUP BY dy
```
**结果如下**  
+ 日分组  
![日.png](https://upload-images.jianshu.io/upload_images/16432686-bf665c3490dba72c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)  

+ 月分组  
![月.png](https://upload-images.jianshu.io/upload_images/16432686-7785276ad61b93f1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)  

+ 年分组  
![年.png](https://upload-images.jianshu.io/upload_images/16432686-626b2dfa2a37a367.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

举三反 N ，很简单的还可以按时、分、秒来分组。

#### 稍微复杂一点儿的，按周分组：
用到的 mysql 内置方法
TO_DAYS：返回当前日期从 0 开始的天数（从 0 开始到 2018-05-25 的天数）。  
MOD：求余啊，各个语言求余都是 MOD 。
FROM_DAYS：参数->天数，返回当前天数对应的日期。  

示例：
```
SELECT FROM_DAYS(TO_DAYS(createtime) -MOD(TO_DAYS(createtime)-6, 7)) AS WEEK, COUNT(id_card) AS usernum  FROM members_info WHERE createtime BETWEEN '2018-05-25 00:00:00 00:00:00' AND '2018-06-20 23:59:59' GROUP BY WEEK;
```  
解释：  
+ TO_DAYS(createtime)-6 中的 6 是当前日期对应的星期数加1（如：2018-05-25 是星期五，则是 5 + 1 = 6，因为国外一周从周末开始所以周末是1）。  

+ 运行结果如下：  
![周.png](https://upload-images.jianshu.io/upload_images/16432686-4ec9e50d953e727d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 常见的转换格式
+ %M 月名字(January……December)
+ %W 星期名字(Sunday……Saturday)
+ %D 有英语前缀的月份的日期(1st, 2nd, 3rd, 等等。）
+ %Y 年, 数字, 4 位
+ %y 年, 数字, 2 位
+ %a 缩写的星期名字(Sun……Sat)
+ %d 月份中的天数, 数字(00……31)
+ %e 月份中的天数, 数字(0……31)
+ %m 月, 数字(01……12)
+ %c 月, 数字(1……12)
+ %b 缩写的月份名字(Jan……Dec)
+ %j 一年中的天数(001……366)
+ %H 小时(00……23)
+ %k 小时(0……23)
+ %h 小时(01……12)
+ %I 小时(01……12)
+ %l 小时(1……12)
+ %i 分钟, 数字(00……59)
+ %r 时间,12 小时(hh:mm:ss [AP]M)
+ %T 时间,24 小时(hh:mm:ss)
+ %S 秒(00……59)
+ %s 秒(00……59)
+ %p AM或PM
+ %w 一个星期中的天数(0=Sunday ……6=Saturday ）
+ %U 星期(0……52), 这里星期天是星期的第一天
+ %u 星期(0……52), 这里星期一是星期的第一天
+ %% 一个文字“%”
