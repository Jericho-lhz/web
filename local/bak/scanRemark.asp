<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!doctype html>
<html>
<head>
<meta charset="gb2312">
<title>敏感词排查</title>
<style type="text/css">
body{ margin:0px}
.main{ width:95%; margin:10px auto; height:600px; border:solid 1px #ddd; }
.main-title{ width:200px; height:50px; line-height:50px; font-size:14px; text-align:left;  margin-left:10px; font-weight:bold}
.result{ width:100%; overflow:hidden; float:left}
.item{ width:95%; height:30px; line-height:30px; padding:5px; margin:2px auto;   border:solid 1px #eee; font-size:13px; color:#444; overflow:hidden; background-color:#eee}
.btn{ width:100px; height:32px; line-height:32px; margin:15px auto; background-color:#0076AE; border-radius:3px; text-align:center; color:#fff; font-size:15px; cursor:pointer}
.main-wd{ width:98%; height:520px; line-height:25px; font-size:13px; margin:1%; overflow-y:auto; }
.btn-on{ background-color:#f00;}
</style>
</head>

<body>
<div class="main">
	<div class="main-title">查询结果：</div>
    <div class="main-wd"></div>
    
</div>
<div class="item"></div>

<div class="btn">开始</div>
<script language="javascript" src="../js/jquery.js"></script>
<script language="javascript">
loading=0
var icount=0
var maxid=0
var allcount=0
var loops=0



$('.btn').click(function(){
	chk()
})

function chk(){
	loops=loops+1
	//if(loops<10000){
		if(loading==0){
			$.ajax({
				url:'scan_data.asp',
				dataType:"json",
				data:{
					act:'getremark'
				},
				type:'post',
				success: function(res){
					if(res.error_code==200){
						maxid=res.maxid
						if(res.result.indexOf('block')!=-1){
							icount=icount+1
							if(icount%100==0){
								$('.main-wd').html('')
							}
							$('.main-wd').append('firstID:'+res.firstid+'$result:'+res.result+'<br>')
						}
						$('.item').text('已扫描：'+res.lastid+'/'+allcount)
						chk()
					}else{
						loading=1
						$('.item').text('end')
					}
				}
			})		
		}
	//}
}


function getnum(){
	$.ajax({
		url:'scan_data.asp',
		dataType:"json",
		data:{
			act:'getremarkall'
		},
		type:'post',
		success: function(res){
			if(res.error_code==200){
				allcount=res.result
			}
		}
	})		
}

getnum()

/*setInterval(function(){
	getnum()
},600000)

setInterval(function(){
	$('.btn').click()
},300000)*/

setInterval(function(){
	$('.btn').click()
},300000)

</script>
</body>
</html>
