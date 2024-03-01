<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001" %>
<% Response.CodePage=65001%>
<% Response.Charset="UTF-8" %>
<html>
<title>英语单词设置</title>

<head></head>
<style type="text/css">
    body {
        width: 100%;
        overflow: hidden;
    }

    .list-f {
        width: 150px;
        padding: 15px;
        margin: 0 auto;
        overflow: hidden;
    }

    .list-s {
        width: 300px;
        height: 600px;
        margin: 0 auto;
        padding: 15px;
        overflow-y: auto;
        border: solid 1px #eee;
    }

    .item-f {
        width: 120px;
        margin: 15px auto;
        height: 40px;
        border-radius: 5px;
        background-color: #06f;
        color: #fff;
        font-size: 15px;
        text-align: center;
        line-height: 40px;
    }

    .list-s-title {
        width: 100%;
        height: 80px;
        line-height: 80px;
        text-align: center;
        font-size: 15px;
        font-weight: bold;
        overflow: hidden;
    }

    .list-s-unit {
        width: 100%;
        overflow: hidden;
        height: 40px;
        line-height: 30px;
        text-align: left;
        font-size: 15px;
        font-weight: bold;
        border-bottom: dashed 1px #eee;
    }

    .list-s-item {
        width: 100%;
        height: 40px;
        overflow: hidden;
    }

    .list-s-word {
        height: 40px;
        line-height: 40px;
        font-size: 15px;
        float: left;
    }

    .list-s-des {
        height: 40px;
        line-height: 40px;
        font-size: 13px;
        color: #666;
        float: left;
    }
</style>

<body>
    <% fid=request("fid") if fid="" then fid=-1 %>
        <div class="list-f"></div>
        <div class="list-s"></div>
</body>

</html>
<script lang="javascript" src="/assets/js/jquery.js"></script>
<script lang="javascript">
    var data = []
    var fid = '<%=fid%>'
    init()

    function init() {
        $.ajax({
            url: '/db/compute/list_english.json',
            type: 'get',
            datyType: 'json',
            success: function (res) {
                data = res
                init_data(fid)
            }
        })
    }

    function init_data(fid) {
        if (fid == -1) {
            $('.list-f').show()
            $('.list-s').hide()
            for (var i = 0; i < data.length; i++) {
                var item = ''
                item = '<div class="item-f" onclick="location.href=\'?fid=' + i + '\'">' + data[i].grade + '</div>'
                $('.list-f').append(item)
                console.log(item)
            }
        } else {
            $('.list-s').show()
            $('.list-f').hide()
            $('.list-s').append('<div class="list-s-title">' + data[fid].grade + '</div>')
            var arr = data[fid].data
            console.log(arr)
            for (var i = 0; i < arr.length; i++) {
                if (arr[i].unit != '') {
                    $('.list-s').append('<div class="list-s-unit">' + arr[i].unit + '</div>')
                }
                for (var j = 0; j < arr[i].list.length; j++) {
                    var item = ''
                    item = '<div class="list-s-item"><div class="list-s-word">' + arr[i].list[j].word + ' </div><div class="list-s-des"> ' + arr[i].list[j].des + '</div></div>'
                    $('.list-s').append(item)
                }

            }
        }

    }
</script>