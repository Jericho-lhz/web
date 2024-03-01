<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="include/dbconn.asp"-->
<%
id=request("id")
if id="0" then response.Redirect("view_sql.asp")
set rs=dbconn.execute("select * from news where id='"&id&"'")
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>文档查看</title>
<style type="text/css">
body{ font-size:14px; font-family:micorsoft Yahei; margin:0px; background-image:url(images/bg3.jpeg);background-attachment:fixed}
.main{ width:1400px; height:800px; margin:0 auto;  margin-top:50px;overflow-y:auto; background:rgb(255,255,255,0.85); backdrop-filter:blur(6px)  }
.main-nav{ width:100%; height:51px; margin:0 auto; overflow:hidden; background-color:#fff}
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
    	<div class="title"><%=rs("title")%></div>
        <div class="content">
        	<%=rs("content")%>
        </div>
	</div>
</div>

<div class="foot">www.chinaxinge.com@Lhz</div>

</body>
</html>
