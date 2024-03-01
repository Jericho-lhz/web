<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<% Response.CodePage=65001%>
<% Response.Charset="UTF-8" %>
<!--#include file="../../tools/dbconn.asp"-->
<!--#include file="../../tools/json.asp"-->
<!--#include file="../../tools/function.asp"-->

<%
act=request("act")

if act="add_news" then	
	id=request("id")
	fid=request("fid")&""
	title=request("title")
	content=request("content")
	if fid="" then fid=1
	if id="0" then
		set rs=server.CreateObject("adodb.recordset")
		sql="select top 1 * from news"
		rs.open sql,dbconn,1,3
		rs.addnew
		rs("cid")=fid
		rs("title")=title
		rs("content")=content
		rs.update
		rs.close
	else
		set rs=server.CreateObject("adodb.recordset")
		sql="select top 1 * from news where id="&id&""
		rs.open sql,dbconn,1,3
		rs("cid")=fid
		rs("title")=title
		rs("content")=content
		rs.update
		rs.close
	end if
	response.Write("{""errCode"":200}")
	response.end()
end if


if act="del_news" then	
	id=request("id")
	sql="delete from news where id="&id&""
	dbconn.execute(sql)
	response.Write("{""errCode"":200}")
	response.end()
end if


%>