<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>  
<% Response.CodePage=65001%>   
<% Response.Charset="UTF-8" %>
<%
tp=request("id")

path=Server.MapPath("/db/compute/add_one.json")
if tp="1" then path=Server.MapPath("/db/compute/subtr_one.json")
if tp="2" then path=Server.MapPath("/db/compute/mult_one.json")
if tp="3" then path=Server.MapPath("/db/compute/divi_one.json")
if tp="4" then path=Server.MapPath("/db/compute/add_two.json")
if tp="5" then path=Server.MapPath("/db/compute/subtr_two.json")
if tp="6" then path=Server.MapPath("/db/compute/mult_two.json")
if tp="7" then path=Server.MapPath("/db/compute/divi_two.json")
if tp="8" then path=Server.MapPath("/db/compute/add_three.json")
if tp="9" then path=Server.MapPath("/db/compute/subtr_three.json")
if tp="10" then path=Server.MapPath("/db/compute/mix_one.json")
if tp="200" then path=Server.MapPath("/db/compute/english.json")

Set fs = CreateObject("Scripting.FileSystemObject")

Set fsoTextStream = fs.OpenTextFile(path, 1) ' 第三个参数设置为True表示覆盖已存在的文件
content = fsoTextStream.ReadAll() '将文件内容存入变量content
fsoTextStream.Close() '关闭文件流
response.write(content)

%>
