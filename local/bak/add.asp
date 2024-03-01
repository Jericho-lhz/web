<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="include/dbconn.asp"-->
<%
id=request("id")
tag="添加文档"
if id<>"" then 
	sql="select * from news where id="&id&""
	set rs=dbconn.execute(sql)
	title=rs("title")
	content=replace(rs("content"),"<br>",chr(13))
	content=replace(content,"<br>",chr(10))
	content=replace(content,"&nbsp;"," ")
	tag="修改文档"
else
	id="0"
end if
%>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title><%=tag%></title>
<style type="text/css">
body{ font-size:14px; font-family:micorsoft Yahei; margin:0px; background-image:url(images/bg3.jpeg);background-attachment:fixed}
.main{ width:1200px; height:800px; margin:0 auto; border-radius:10px; background-color:#fff; margin-top:50px;overflow-y:auto  }
.main-nav{ width:100%; height:51px; margin:0 auto; overflow:hidden; background-color:#f5f5f5}
.main-title{ width:300px; height:20px; margin-top:15px; text-align:left;  float:left; font-size:19px; color:#006f69; line-height:20px; border-left:3px solid #006f69; padding-left:15px; margin-left:15px}
.btn-back{ width:80px; height:30px; border-radius:3px; cursor:pointer;  color:#0f847b; float:right; text-align:center; line-height:30px; margin-top:10px; margin-right:15px}
.warp{ width:100%; height:730PX; overflow-y:auto}
.title{ width:790px; height:40px; margin:15px auto; border:solid 1px #cc9e97; border-radius:5px}
#title{ width:750px; margin-left:10px; height:40px; font-size:19px; border:none; background:none; outline:none}
#title::placeholder{ color:#ddd}
.content{ width:800px; margin:20px auto; overflow:hidden; height:530px;border-radius:5px}
#content{ width:790px; height:510px; margin:10px; border:none; outline:none; background:none; line-height:22px; font-size:15px}
#content::placeholder{ color:#aaa}
#content::-webkit-scrollbar{width:3px; height:2px }
#content::-webkit-scrollbar-track{ background-color:#d7e4e4} 
#content::-webkit-scrollbar-thumb{background-color:#0f847b}
.btn-sub{width:120px; height:40px; border-radius:3px; cursor:pointer;  color:#fff; text-align:center; line-height:40px; margin:20px auto; background-color:#cc9e97; font-size:17px}
.foot{ width:100%; height:50px; text-align:center; line-height:50px; }
</style>
<link rel="stylesheet" href="kindeditor/themes/default/default.css" />
<link rel="stylesheet" href="kindeditor/plugins/code/prettify.css" />
<script charset="utf-8" src="kindeditor/kindeditor.js?t=3"></script>
<script charset="utf-8" src="kindeditor/lang/zh-CN.js"></script>
<script charset="utf-8" src="kindeditor/plugins/code/prettify.js"></script>
<script language="javascript">
    var KE 
    KindEditor.ready(function(K) {
        KE = K.create('textarea[name="content"]', {
			cssData: 'body {font-family: "微软雅黑"; font-size: 14px}',
            cssPath : 'kindeditor/plugins/code/prettify.css',
            uploadJson : 'kindeditor/asp/upimg.aspx',
            fileManagerJson : 'kindeditor/asp/upimg.aspx',
            allowFileManager : true,
			allowImageRemote: false,
            resizeType:0,
			afterBlur: function(){this.sync();}	
        });
        prettyPrint();
    });
</script>
</head>

<body>

<div class="banner"></div>

<div class="main">
	<div class="main-nav">
    	<div class="main-title"><%=tag%></div>
    	<div class="btn-back" onClick="history.go(-1)">返回></div>
    </div>
	<div class="warp">  
    	<div class="title">
        	<input type="text" id="title" placeholder="请输入文档标题" value="<%=title%>">
        </div>
        <div class="content">
        	<textarea id="content" name="content" placeholder="请输入文档内容"><%=content%></textarea>
        </div>
        <div class="btn-sub">提 交</div>
    </div>
</div>

<div class="foot">www.chinaxinge.com@Lhz</div>

<script language="javascript" src="include/jquery.js"></script>
<script language="javascript">
var id='<%=id%>'
$('.btn-sub').click(function(){
	var title=$('#title').val()
	var content=$('#content').val()
	if(title==''){
		alert('请输入文档标题')
		return false
	}
	if(content==''){
		alert('请输入文档内容')
		return false
	}
	$.ajax({
		url:'include/data.asp',
		type:'post',
		data:{
			act:'add_news',
			id:id,
			title:title,
			content:content
		},
		dataType:"json",
		success: function(res){
			if(res.errCode==200){
				location.href='index.html'
			}
		}
	})

})
</script>
</body>
</html>
