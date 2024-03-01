function Get(url,data) {
    if(data==undefined){
        data={}
    }
    return new Promise((resolve) => {
        $.ajax({
            url: url,
            type: 'get',
            dataType: "json",
            data:data,
            success: function (res) {
                resolve(res)
            }
        })
    })
}

function Post(url, data) {
    if(data==undefined){
        data={}
    }
    return new Promise((resolve) => {
        $.ajax({
            url: url,
            type: 'post',
            data: data,
            dataType: "json",
            success: function (res) {
                resolve(res)
            }
        })
    })
}