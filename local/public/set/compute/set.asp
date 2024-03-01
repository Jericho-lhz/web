<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>  
<% Response.CodePage=65001%>   
<% Response.Charset="UTF-8" %>
<%
data=request("store")
tp=request("tp")

path=Server.MapPath("/db/compute/add_one.json")
if tp="1" then path=Server.MapPath("/db/compute/subtr_one.json")
if tp="2" then path=Server.MapPath("/db/compute/mult_one.json")
if tp="3" then path=Server.MapPath("/db/compute/divi_one.json")

if tp="20" then path=Server.MapPath("/db/compute/add_two.json")
if tp="21" then path=Server.MapPath("/db/compute/subtr_two.json")
if tp="22" then path=Server.MapPath("/db/compute/mult_two.json")
if tp="23" then path=Server.MapPath("/db/compute/divi_two.json")

if tp="30" then path=Server.MapPath("/db/compute/add_three.json")
if tp="31" then path=Server.MapPath("/db/compute/subtr_three.json")

if tp="100" then path=Server.MapPath("/db/compute/mix_one.json")

if tp="200" then path=Server.MapPath("/db/compute/englist.json")

Set fs = CreateObject("Scripting.FileSystemObject")
Set file = fs.CreateTextFile(path, True) ' 第三个参数设置为True表示覆盖已存在的文件
file.Write data
file.Close

response.write("{""errCode"":200}")

%>
