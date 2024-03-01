<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>  
<% Response.CodePage=65001%>   
<% Response.Charset="UTF-8" %>
<%
data=request("store")
bak=request("bak")
oldfile=Server.MapPath("/db/gamebak/GameBak.json")
newfile=Server.MapPath("/db/gamebak/bak/bak_"&year(now())&"_"&month(now())&"_"&day(now())&"_"&hour(now())&"_"&minute(now())&"_"&second(now())&".json")


Set fs = CreateObject("Scripting.FileSystemObject")
'备份老文件
if bak<>"1" then
    set f=fs.GetFile(oldfile)
    f.Copy(newfile)
end if

'更新数据
Set file = fs.CreateTextFile(oldfile, True) ' 第三个参数设置为True表示覆盖已存在的文件
file.Write data
file.Close

set f=nothing
set fs=nothing

response.write("{""errCode"":200}")
%>
