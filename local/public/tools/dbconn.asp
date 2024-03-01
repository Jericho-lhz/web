<%
server.ScriptTimeout=999999
ConnStr = "Provider = Microsoft.Jet.OLEDB.4.0;Data Source = " & Server.MapPath("/db/dataBase/Localdata.mdb")
set dbconn=Server.Createobject("adodb.connection")
dbconn.open connstr
%>