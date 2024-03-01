<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<% Response.CodePage=65001%>
<% Response.Charset="UTF-8" %>
<!--#include file="../../tools/dbconn.asp"-->
<!--#include file="../../tools/json.asp"-->
<!--#include file="../../tools/function.asp"-->

<%
act=request("act")

if act="get_cls" then
	set rs=dbconn.execute("select * from newsCls where isshow=1 order by orderid ")
	set ja=jsArray()
	do while not rs.eof
		set ja(null)=jsObject()
		ja(null)("id")=rs("id")
		ja(null)("title")=rs("title")
		ja(null)("icon")=rs("icon")
	rs.movenext
	loop
	ja.flush()
end if

if act="get_news" then
	sql="select * from news order by id desc"
	fid=request("fid")
	if fid<>"" then sql="select * from news where cid="&fid&" order by id desc"
	set rs=dbconn.execute(sql)
	set ja=jsArray()
	do while not rs.eof
		set ja(null)=jsObject()
		ja(null)("id")=rs("id")
		ja(null)("title")=rs("title")
		ja(null)("tag")=left(deleteHtml(rs("content")),50)
		ja(null)("content")=rs("content")
	rs.movenext
	loop
	ja.flush()
end if

if act="get_new" then
	id=request("id")
	set ja=jsObject()
	errCode=200
	if id="" then
		errCode=1
	else
		set rs=dbconn.execute("select * from news where id="&id)
		if rs.eof then
			errCode=1
		else
			set ja("info")=jsObject()
			ja("info")("title")=rs("title")
			ja("info")("content")=rs("content")
		end if
	end if
	ja("errCode")=errCode
	ja.flush
end if

if act="get_new_wd" then
	wd=request("wd")
	set ja=jsArray()
	errCode=200
	sql="select top 20 * from news where title like '%"&wd&"%' order by id desc"
	set rs=dbconn.execute(sql)
	if rs.eof then
		errCode=1
	else
		do while not rs.eof
			set ja(null)=jsObject()
			ja(null)("id")=rs("id")
			ja(null)("fid")=rs("cid")
			ja(null)("title")=rs("title")
			ja(null)("content")=rs("content")
		rs.movenext
		loop
	end if
	ja.flush
end if

%>