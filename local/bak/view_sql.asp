<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="include/dbconn.asp"-->
<%
id=request("id")
set rs=dbconn.execute("select * from news where id='"&id&"'")
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>文档查看</title>
<style type="text/css">
body{ font-size:14px; font-family:micorsoft Yahei; margin:0px; background-image:url(images/bg3.jpeg);background-attachment:fixed}
.main{ width:1400px; height:800px; margin:0 auto; border-radius:10px; background-color:#fff; margin-top:50px;overflow-y:auto  }
.main-nav{ width:100%; height:51px; margin:0 auto; overflow:hidden; background-color:#f5f5f5}
.main-title{ width:300px; height:20px; margin-top:15px; text-align:left;  float:left; font-size:19px; color:#006f69; line-height:20px; border-left:3px solid #006f69; padding-left:15px; margin-left:15px}
.btn-back{ width:80px; height:30px; border-radius:3px; cursor:pointer;  color:#0f847b; float:right; text-align:center; line-height:30px; margin-top:10px; margin-right:15px}
.warp{ width:100%; height:730PX; overflow-y:auto}
.warp::-webkit-scrollbar{width:3px; }
.warp::-webkit-scrollbar-track{ background-color:#d7e4e4} 
.warp::-webkit-scrollbar-thumb{background-color:#0f847b}
.title{ width:100%; height:60px;text-align:center;   font-size:30px; color:#333; line-height:60px;}
.content{ width:1300px; margin:0 auto; overflow:hidden; font-size:14px; color:#555; line-height:35px}
.foot{ width:100%; height:50px; text-align:center; line-height:50px; }


</style>
</head>

<body>

<div class="banner"></div>

<div class="main">
	<div class="main-nav">
    	<div class="main-title">文档查看</div>
    	<div class="btn-back" onClick="history.go(-1)">返回></div>
    </div>
	<div class="warp">  
    	<div class="title">常用SQL语句</div>
        <div class="content">
            查询字段信息：SELECT * FROM INFORMATION_SCHEMA.columns WHERE TABLE_NAME='all_file'<br>
            修改字段属性：alter table tab_info alter column thisname varchar(200) not null<br>
            修改默认值：alter table tabinfo add constraint df default('嘿嘿') for thisname<br>	
            删除重复记录：delete from people where   peopleName in (select peopleName    from people group by peopleName      having count(peopleName) > 1) and   peopleId not in (select min(peopleId) from people group by peopleName     having count(peopleName)>1) <br>	
            重命名：EXEC sp_rename 'comments.[addDate]', 'addtime', 'COLUMN'    <br>	
            根据b表的字段修改a表的数据列：update t1 set t1.v1= t2.v1 from t2 inner join t1 on t2.v2= t1.v2	<br>	
            查询所有表名：select name from sysobjects where xtype='U'<br>
            创建表：CREATE TABLE poster_cls(id int IDENTITY (1, 1) NOT NULL,) ON [PRIMARY]
        </div>
	</div>
</div>

<div class="foot">www.chinaxinge.com@Lhz</div>

</body>
</html>
