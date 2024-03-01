<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!doctype html>
<html>
<head>
<meta charset="gb2312">
<title>敏感词排查结果</title>
<style type="text/css">
body{ margin:0px}
.main{ width:95%; margin:0px auto; margin-top:10px; height:800px; border:solid 1px #ddd; overflow-y:auto}
.main-title{ width:200px; height:50px; line-height:50px; font-size:14px; text-align:left;  margin-left:10px; font-weight:bold}
.btn{ width:100px; height:32px; line-height:32px; margin:5px auto; background-color:#0076AE; border-radius:3px; text-align:center; color:#fff; font-size:15px; cursor:pointer}
.main-wd{ width:98%; height:700px; line-height:25px; font-size:13px; margin:1%}
.main-result{ width:95%; margin:1px auto; background-color:#f5f5f5; text-align:center; font-size:13px; line-height:30px; height:30px; }
.btn-on{ background-color:#f00;}
</style>
</head>

<body>
<div class="main">
	<div class="main-title">查询结果：</div>
    <div class="main-wd"></div>
</div>

    <div class="main-result"></div>
    <div class="btn" onClick="chk()">开始统计</div>


<script language="javascript" src="../js/jquery.js"></script>
<script language="javascript">
var k=0
var ending=0
var num=100
var page=1
var id='<%=request("id")%>'

//chk(id)

//getAll()

function chk(){
	if(ending==0){
		$.ajax({
			url:'scan_data.asp',
			dataType:"json",
			data:{
				act:'result_r',
				page:page
			},
			type:'post',
			success: function(res){
				console.log(res)
				if(res.error_code==200){
					$.each(res.list,function(i){
						k=k+1
						$('.main-wd').append('id:'+res.list[i].id+'$result:'+res.list[i].result+'<br>')
						$('.main-result').text('已加载：'+k+' / '+num)
					})
					page=page+1
					chk()
					//chk(res.id)
				}else{
					ending=1
					$('.main-result').text('已加载完成')
				}
				
			}
		})
	}
}

function getAll(){
	$.ajax({
		url:'scan_data.asp',
		dataType:"json",
		data:{
			act:'result_all',
		},
		type:'post',
		success: function(res){
			if(res.error_code==200){
				num=res.result
			}
		}
	})	
}

function getResult(){
	if(id!=''){
		$.ajax({
			url:'scan_data.asp',
			dataType:"json",
			data:{
				act:'result_r1',
				id:id
			},
			type:'post',
			success: function(res){
				if(res.error_code==200){
					$('.main-wd').html(res.result+'<br><br><br>'+res.kwd)
					$('.main-result,.btn').hide()
				}
			}
		})	
	}
}

getResult()
</script>
</body>
</html>
