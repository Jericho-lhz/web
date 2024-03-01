<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<% Response.CodePage=65001%>
<% Response.Charset="UTF-8" %>
<!--#include file="../../tools/dbconn.asp"-->
<!--#include file="../../tools/json.asp"-->
<!--#include file="../../tools/function.asp"-->
<%
act=request("act")

if act="add_news" then	
    fid=request("fid")&fid
	title=request("title")
	content=request("content")
	if fid="" then fid=1
    sql="insert into news(cid,title,content)values("&fid&",'"&title&"','"&content&"')"
	response.Write(sql)
	' response.write(err.description)
	' 'dbconn.execute(sql)
	' response.Write("{""errCode"":200}")
	' response.end()
end if

%>