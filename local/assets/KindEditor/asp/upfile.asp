<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>  
<% Response.CodePage=936%>   
<% Response.Charset="GB2312" %> 
<!--#include file="upload.inc"-->
<%
on error resume next

dim upload,f_folder,file,formPath,iCount,filename,fileExt,filesizemin,filesizemax

filesizemin=100
filesizemax=40000*1024 '4M
set upload=new upload_5xSoft '建立上传对象

f_folder="/upload/editor/"



'********************************列出所有上传文件***************************************************
For each formName in upload.objFile
set file=upload.file(formName)
If file.filesize>0 then

    '********************************检测文件大小***************************************************
    If file.filesize<filesizemin Then
		response.Write("{ ""error"" : 1,""url"" : ""你上传的文件太小""}")
		response.End()
    ElseIf file.filesize>filesizemax then      
		response.Write("{ ""error"" : 1,""url"" : ""你上传的文件太大""}")
		response.End()
    End If

    '********************************检测文件类型****************************************************
	file_oldname=file.filename
	arr_name=split(file_oldname,".")
	fileExt=ucase(arr_name(ubound(arr_name)))

    uploadsuc=false
    'Forum_upload="RAR|ZIP|SWF|JPG|PNG|GIF|DOC|TXT|CHM|PDF|ACE|MP3|WMA|WMV|MIDI|AVI|RM|RA|RMVB|MOV|XLS"
	Forum_upload="JPG|PNG|GIF|JPEG"
    Forumupload=split(Forum_upload,"|")
    for i=0 to ubound(Forumupload)
        if fileEXT=trim(Forumupload(i)) then
            uploadsuc=true
            exit for
        else
            uploadsuc=false
        end if
    next
    if uploadsuc=false then
		response.Write("{ ""error"" : 1,""url"" : ""服务器不支持上传""}")
		response.End()
    end if

    '********************************建立文件上传的目录文件夹****************************************
    Set upf=Server.CreateObject("Scripting.FileSystemObject")
    If Err<>0 Then
        Err.Clear        
		response.Write("{ ""error"" : 1,""url"" : ""服务器不支持上传""}")
		response.End()

    End If
    f_type= replace(fileExt,".","")
    f_name= year(now)&right("0"&month(now),2)
    If upf.FolderExists(Server.MapPath(f_folder&"/"&f_name))=False Then
    upf.CreateFolder Server.MapPath(f_folder&"/"&f_name)
    End If

    f_ftn=f_folder&"/"&f_name
    Set upf=Nothing

    '********************************保存上传文件至文件夹*****************************************
    randomize
    ranNum=int(9000*rnd)+1000
    filename=f_ftn&"/"&year(now)&right("0"&month(now),2)&right("0"&day(now),2)&right("0"&hour(now),2)&right("0"&minute(now),2)&right("0"&second(now),2)&ranNum&"."&fileExt
    if file.filesize>filesizemin and file.filesize<filesizemax then
		file.SaveAs Server.mappath(filename)  '保存文件 
		
	
		
		filenameb=filename
		
		
		Set Jpeg = Server.CreateObject("Persits.Jpeg")
		Path = Server.MapPath(filename)
		Jpeg.Open Path	
		if Jpeg.OriginalWidth>850 then
			Jpeg.Width=850
			Jpeg.Height=850*Jpeg.Originalheight/Jpeg.OriginalWidth
			Jpeg.Save Server.MapPath(filename)
		end if	
		
		
	'	set Photo = server.CreateObject("Persits.Jpeg")
'		PhotoPath = Server.MapPath(filename)
'		Photo.open PhotoPath
'		set Logo = server.CreateObject("Persits.Jpeg")
'		LogoPath=server.MapPath("logo.png")
'		Logo.open LogoPath
'		w=photo.OriginalWidth-200
'		h=Photo.Originalheight-65
'		Photo.Canvas.DrawPNG w,h,LogoPath'　　
'		Photo.save PhotoPath
'		
		
		'filename
	       
    end if
set file=nothing
end if

next
set upload=nothing '删除此对象



response.Write("{ ""error"" : 0,""url"" : """&filename&"""}")
response.End()

%>


