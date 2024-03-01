<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="include/dbconn.asp"-->
<!doctype html>
<html>

<head>
    <meta charset="utf-8">
    <title>本地文档</title>
    <style type="text/css">
        /*html{
	filter:progid:DXImageTransform.Microsoft.BasicImage(grayscale=1);
	-webkit-filter:grayscale(100%)
}*/
        body {
            font-size: 14px;
            font-family: micorsoft Yahei;
            margin: 0px;
            background-color: #f5f5f5
        }

        .banner {
            width: 100%;
            height: 250px;
            background-image: url(images/bg3.jpeg);
            background-repeat: no-repeat;
            background-position: center top;
            position: absolute;
            top: 0px;
            left: 0px;
            z-index: -1
        }

        .search-box {
            width: 650px;
            height: 45px;
            margin: 0 auto;
            margin-top: 75px;
            border: solid 2px #0f847b;
            background-color: #0f847b;
            border-radius: 10px;
            overflow: hidden
        }

        .search-wd {
            width: 550px;
            height: 45px;
            overflow: hidden;
            float: left;
            background-color: #fff
        }

        #wd {
            width: 530px;
            height: 45px;
            margin-left: 10px;
            font-size: 17px;
            color: #444;
            border: none;
            background: none;
            outline: none
        }

        #wd::placeholder {
            color: #ddd
        }

        .search-btn {
            width: 100px;
            height: 45px;
            line-height: 45px;
            float: left;
            text-align: center;
            font-size: 20px;
            color: #fff;
            cursor: pointer
        }

        .main {
            width: 1200px;
            height: 660px;
            margin: 0 auto;
            background-color: #fff;
            margin-top: 75px;
            overflow: hidden
        }

        .main-nav {
            width: 100%;
            height: 51px;
            margin: 0 auto;
            overflow: hidden;
            background-color: #f5f5f5
        }

        .main-title {
            width: 300px;
            height: 20px;
            margin-top: 15px;
            text-align: left;
            float: left;
            font-size: 19px;
            color: #006f69;
            line-height: 20px;
            border-left: 3px solid #006f69;
            padding-left: 15px;
            margin-left: 15px
        }

        .btn-add {
            width: 80px;
            height: 30px;
            border-radius: 3px;
            cursor: pointer;
            background-color: #0f847b;
            color: #fff;
            float: right;
            text-align: center;
            line-height: 30px;
            margin-top: 10px;
            margin-right: 15px
        }

        .foot {
            width: 100%;
            height: 50px;
            text-align: center;
            line-height: 50px;
        }

        .warp {
            width: 100%;
            height: 590PX;
            overflow-y: auto
        }

        .warp::-webkit-scrollbar {
            width: 3px;
        }

        .warp::-webkit-scrollbar-track {
            background-color: #d7e4e4
        }

        .warp::-webkit-scrollbar-thumb {
            background-color: #0f847b
        }

        .item {
            width: 345px;
            height: 100px;
            float: left;
            margin-left: 40px;
            margin-top: 20px;
            box-shadow: 0 0 5px #d7e4e4;
            cursor: pointer;
            position: relative;
            border-radius: 3px
        }

        .item-title {
            width: 315px;
            height: 50px;
            line-height: 50px;
            margin-left: 15px;
            text-align: left;
            font-size: 15px;
            color: #0f847b;
            overflow: hidden;
            font-weight: bold
        }

        .item-des {
            width: 315px;
            height: 40px;
            line-height: 20px;
            overflow: hidden;
            margin-left: 15px;
            font-size: 12px;
            color: #999
        }

        .item:hover {
            background-color: #f5f9f9
        }


        #shadowBox {
            width: 100%;
            height: 100%;
            position: fixed;
            top: 0px;
            left: 0px;
            z-index: 1;
            background-color: #000;
            opacity: 0.3;
            display: none
        }

        #showBox {
            width: 90%;
            height: 600px;
            position: fixed;
            top: 50%;
            left: 5%;
            margin-top: -300px;
            background-color: #fff;
            z-index: 10;
            border-radius: 3px;
            overflow: hidden;
            border: solid 2px #0F847B;
            display: none
        }

        .box-nav {
            width: 100%;
            height: 40px;
            background-color: #0F847B
        }

        .box-title {
            width: 500px;
            height: 40px;
            float: left;
            text-align: left;
            margin-left: 10px;
            line-height: 40px;
            font-size: 15px;
            color: #fff;
            overflow: hidden
        }

        .box-close,
        .box-del,
        .box-edit {
            width: 40px;
            height: 40px;
            background-repeat: no-repeat;
            background-position: center center;
            cursor: pointer;
            float: right
        }

        .box-close {
            background-image: url(images/btn_close.png)
        }

        .box-del {
            background-image: url(images/btn_del.png)
        }

        .box-edit {
            background-image: url(images/btn_edit.png)
        }

        .box-main {
            width: 100%;
            height: 560px;
            overflow: auto
        }

        #showText {
            width: 94%;
            margin: 0 auto;
            overflow: hidden;
            padding-top: 15px;
            padding-bottom: 15px;
            line-height: 200%;
            text-align: left;
            font-family: microsoft Yahei;
            word-break: break-all
        }

        .box-main::-webkit-scrollbar {
            width: 2px;
        }

        .box-main::-webkit-scrollbar-track {
            background-color: #fff
        }

        .box-main::-webkit-scrollbar-thumb {
            background-color: #0F847B
        }
    </style>
</head>

<body>

    <div class="banner"></div>

    <div class="search-box">
        <div class="search-wd">
            <input type="text" id="wd" placeholder="请输入关键字">
        </div>
        <div class="search-btn">搜 索</div>
    </div>

    <div class="main">
        <div class="main-nav">
            <div class="main-title">文档列表</div>
            <div class="btn-add" onClick="location.href='add.asp'">新增文档</div>
        </div>
        <div class="warp">
            <div class="item" data-id="0">
                <div class="item-title">SQL语句</div>
                <div class="item-des">
                    查询字段信息：SELECT * FROM INFORMATION_SCHEMA.columns WHERE TABLE_NAME='all_file'<br><br>
                    修改字段属性：alter table tab_info alter column thisname varchar(200) not null<br><br>
                    修改默认值：alter table tabinfo add constraint df default('嘿嘿') for thisname<br> <br>
                    删除重复记录：delete from people where peopleName in (select peopleName from people group by peopleName having count(peopleName) > 1) and peopleId not in (select min(peopleId) from people group by peopleName having count(peopleName)>1) <br> <br>
                    重命名：EXEC sp_rename 'comments.[addDate]', 'addtime', 'COLUMN' <br> <br>
                    根据b表的字段修改a表的数据列：update t1 set t1.v1= t2.v1 from t2 inner join t1 on t2.v2= t1.v2 <br> <br>
                    查询所有表名：select name from sysobjects where xtype='U'<br><br>
                    创建表：CREATE TABLE poster_cls(id int IDENTITY (1, 1) NOT NULL,) ON [PRIMARY]
                </div>

            </div>
            <%
		set rs=dbconn.execute("select * from news order by id desc")
		do while not rs.eof
		%>
            <div class="item" data-id="<%=rs("id")%>">
                <div class="item-title"><%=rs("title")%></div>
                <div class="item-des"><%=rs("content")%></div>
            </div>
            <%
		rs.movenext
		loop
		%>
        </div>

    </div>

    <div class="foot">www.chinaxinge.com@Lhz</div>

    <div id="shadowBox"></div>
    <div id="showBox">
        <div class="box-nav">
            <div class="box-title"></div>
            <div class="box-close"></div>
            <div class="box-del"></div>
            <div class="box-edit"></div>
            <input type="hidden" id="newsid" value="0">
        </div>
        <div class="box-main">
            <div id="showText"></div>
        </div>
    </div>

    <script language="javascript" src="include/jquery.js"></script>
    <script language="javascript">
        /*$('.item').hover(function(){
	$(this).find('.item-tools').show()
},function(){
	$(this).find('.item-tools').hide()
})

$('.tools-view,.item-title').click(function(){
	var id=$(this).attr('data-id')
	location.href='view.asp?id='+id
})

$('.tools-edit').click(function(){
	var id=$(this).attr('data-id')
	location.href='add.asp?id='+id
})
*/
        $('.item').click(function() {
            var id = $(this).attr('data-id')
            var title = $(this).find('.item-title').text()
            var des = $(this).find('.item-des').html()
            $('#showBox .box-title').text(title)
            $('#showText').html(des)
            $('#newsid').val(id)
            $('#shadowBox,#showBox').fadeIn(400)
            if (id == '0') {
                $('.box-del,.box-edit').hide()
            } else {
                $('.box-del,.box-edit').show()
            }
        })

        $('.box-close').click(function() {
            $('#shadowBox,#showBox').fadeOut(400)
        })

        $('.box-edit').click(function() {
            var id = $('#newsid').val()
            location.href = 'add.asp?id=' + id
        })

        $('.box-del').click(function() {
            var id = $('#newsid').val()
            if (!confirm('你确定要删除吗')) {
                return false
            }
            $.ajax({
                url: 'include/data.asp',
                type: 'post',
                data: {
                    act: 'del_news',
                    id: id
                },
                dataType: "json",
                success: function(res) {
                    if (res.errCode == 200) {
                        location.reload()
                    }
                }
            })
        })

        $('.search-btn').click(function() {
            var wd = $('#wd').val()
            if (wd == '') {
                alert('请输入关键字')
                return false
            }
            $.each($('.item'), function(i) {
                var title = $(this).find('.item-title').text()
                if (title.indexOf(wd) == -1) {
                    $(this).hide()
                }
            })
        })
    </script>
</body>

</html>