<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>  
<% Response.CodePage=65001%>   
<% Response.Charset="UTF-8" %>
<%
data=request("store")
Set fs = CreateObject("Scripting.FileSystemObject")
Set fsoTextStream = fs.OpenTextFile(Server.MapPath("/db/GameBak/GameBak.json"), 1) ' 第三个参数设置为True表示覆盖已存在的文件
content = fsoTextStream.ReadAll() '将文件内容存入变量content
fsoTextStream.Close() '关闭文件流
response.write(content)
%>
