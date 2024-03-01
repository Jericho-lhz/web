<%
function deleteHtml(text)
    Dim regEx, Match ' 建立变量。
    Set regEx = New RegExp ' 建立正则表达式。
    regEx.Pattern = "<[^>]*>" ' 设置模式。
    regEx.IgnoreCase = true ' 设置是否区分字符大小写。
    regEx.Global = True ' 设置全局可用性。
    Matches = regEx.replace(text,"") ' 执行搜索。
    deleteHtml = matches
end function
%>