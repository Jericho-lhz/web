
<!--#include file="include/dbconn.asp" -->
<!--#include file="include/json.asp" -->
<%
act=request("act")

'获取信息
'if act="getnews" then 
'	firstid=0
'	set rsfirst=dbconn.execute("select top 1 newsid from scanresult  order by id desc")
'	if not rsfirst.eof  then firstid=rsfirst(0)
'	url="http://gdgs.chinaxinge.com/scan_data.asp?act=getNews&id="&firstid
'	wd=getpage(url)
'	wd=replace(wd,"","")
'	wd=replace(wd,"%","")
'	arr_wd=split(wd,"{{||}}")
'	newsid=arr_wd(0)
'	wd=trim(left(wd,5000))
'	url2="http://192.168.1.45:8080/zxwsjinterface/scanText?content="&wd
'	result=getpage(url2)
'	dbconn.execute("insert into scanresult(newsid,result) values('"&newsid&"','"&result&"')")
'	'response.Write(url2&"<br><---------------------------------------------------------------><br>")
'	dbconn.close()
'	response.Write("{""error_code"":200,""newsid"":"""&newsid&""",""result"":"""&result&"""}")
'end if
'
'
'if act="getall" then
'	firstid=0
'	set rsfirst=dbconn.execute("select top 1 newsid from scanresult  order by id desc")
'	if not rsfirst.eof  then firstid=rsfirst(0)
'	url="http://gdgs.chinaxinge.com/scan_data.asp?act=getAll&id="&firstid
'	wd=getpage(url)
'	dbconn.close()
'	response.Write("{""error_code"":200,""result"":"""&wd&"""}")
'end if
'
'
if act="result" then 
	set rs=server.CreateObject("adodb.recordset")
	sql="select  * from scanresult where  result like 'block%' order by id"
	rs.open sql,dbconn,1,1
	rs.pagesize=200
	page=request("page")
	if page="" then page=1
	if page<1 then 
	page=1
	else
	page=cint(page)
	end if
	if page>rs.pagecount then 
		response.Write("{""error_code"":2002}")
	end if
	rs.absolutepage=page
	set ja=jsobject()
	ja("error_code")=200
	set ja("list")=jsarray()
	for i=1 to rs.pagesize
	if rs.eof then exit for
		set ja("list")(null)=jsobject()
		result=rs("result")
		ja("list")(null)("id")=rs("id")
		ja("list")(null)("newsid")=rs("newsid")
		ja("list")(null)("result")=result
	rs.movenext
	next
	ja.flush
	dbconn.close
end if


if act="result_all" then 
	set rs=dbconn.execute("select count(*) from scanresult where  result like '%block%'  ")
	response.Write("{""error_code"":200,""result"":"""&rs(0)&"""}")	
end if

'-------------------------------------------------------------------------
'获取信息
if act="getremark" then 
	firstid=0
	set rsfirst=dbconn.execute("select top 1 lastid from news_remark  order by id desc")
	if not rsfirst.eof  then firstid=rsfirst(0)
	url="http://news.chinaxinge.com/scan_data.asp?act=getRemark&id="&firstid
	wd=getpage(url)
	if wd<>"" then
		wd=replace(wd,"","")
		wd=replace(wd,"%","")
		arr_wd=split(wd,"$data=")
		wd=arr_wd(0)
		data=arr_wd(1)
		lastid=split(data,"|")(0)
		icount=split(data,"|")(1)
		firstid=split(data,"|")(2)
		wd=left(wd,2500)
		url2="http://192.168.1.45:8080/zxwsjinterface/scanText?content="&wd
		result=getpage(url2)
		if result="" then result="nothing"
		dbconn.execute("insert into news_remark(firstid,lastid,result,kwd) values('"&firstid&"','"&lastid&"','"&result&"','"&wd&"')")		
		response.Write("{""error_code"":200,""firstid"":"""&firstid&""",""lastid"":"""&lastid&""",""icount"":"""&icount&""",""wd"":"""&wd&""",""result"":"""&result&"""}")
	else
		response.Write("{""error_code"":201}")
	end if
	dbconn.close()
end if


if act="getremarkall" then
	firstid=0
	set rsfirst=dbconn.execute("select top 1 lastid from news_remark  order by id desc")
	if not rsfirst.eof  then firstid=rsfirst(0)
	url="http://news.chinaxinge.com/scan_data.asp?act=getRemarkAll&id="&firstid
	wd=getpage(url)
	dbconn.close()
	response.Write("{""error_code"":200,""result"":"""&wd&"""}")
end if

if act="result_r" then 
	set rs=server.CreateObject("adodb.recordset")
	sql="select  * from gdgs_remark where  result like 'block%' order by id"
	rs.open sql,dbconn,1,1
	rs.pagesize=200
	page=request("page")
	if page="" then page=1
	if page<1 then 
	page=1
	else
	page=cint(page)
	end if
	if page>rs.pagecount then 
		response.Write("{""error_code"":2002}")
	end if
	rs.absolutepage=page
	set ja=jsobject()
	ja("error_code")=200
	set ja("list")=jsarray()
	for i=1 to rs.pagesize
	if rs.eof then exit for
		set ja("list")(null)=jsobject()
		result=rs("result")
		ja("list")(null)("id")=rs("id")
		ja("list")(null)("maxid")=rs("maxid")
		ja("list")(null)("result")=result
	rs.movenext
	next
	ja.flush
	dbconn.close
end if


if act="result_r1" then 
	id=request("id")
	sql="select  * from gdgs_remark where  id="&id&""
	set rs=dbconn.execute(sql)
	response.Write("{""error_code"":200,""result"":"""&rs("result")&""",""kwd"":"""&rs("kwd")&"""}")
end if


if act="result_r2" then 
	set rs=server.CreateObject("adodb.recordset")
	sql="select  * from news_remark where  result like 'block%' order by id"
	rs.open sql,dbconn,1,1
	rs.pagesize=200
	page=request("page")
	if page="" then page=1
	if page<1 then 
	page=1
	else
	page=cint(page)
	end if
	if page>rs.pagecount then 
		response.Write("{""error_code"":2002}")
	end if
	rs.absolutepage=page
	set ja=jsobject()
	ja("error_code")=200
	set ja("list")=jsarray()
	for i=1 to rs.pagesize
	if rs.eof then exit for
		set ja("list")(null)=jsobject()
		result=rs("result")
		ja("list")(null)("id")=rs("id")
		ja("list")(null)("lastid")=rs("lastid")
		ja("list")(null)("result")=result
	rs.movenext
	next
	ja.flush
	dbconn.close
end if


if act="result_r12" then 
	id=request("id")
	sql="select  * from news_remark where  id="&id&""
	set rs=dbconn.execute(sql)
	response.Write("{""error_code"":200,""result"":"""&rs("result")&""",""kwd"":"""&rs("kwd")&"""}")
end if


function getpage(url)
	Set xml = Server.CreateObject("MSXML2.ServerXMLHTTP")
	xml.Open "POST", url, False
	xml.Send
	On Error Resume Next
	dim hok
	getpage = xml.responseText
	Set xml = Nothing
end function

%>

