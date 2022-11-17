/*
 * 동기 ajax 콜
 * @param
 * @return
 */
function callSyncAjax(url, param, callbackFunc){
	if(param != undefined){
		if(param.loading_id  != undefined){
        	GBL_makeLoading(param.loading_id);
        }
    }
	
	$.ajax({
        type: "post",
        url: url,
        async: false,
        dataType: "json",
        contentType : "application/json;charset=UTF-8",
        data: JSON.stringify(param),
        success : function(data){
        	if (data.responseCode != null && data.responseCode != undefined && data.responseCode.substr(0, 1) == "E") {
        		alert(data.responseMessage);
        	} else {
        		if (callbackFunc != null && callbackFunc != undefined) {
				    var fn = window[callbackFunc];
				    if (typeof fn === "function") {
				    	fn(data);
				    }
        		}
        	}
        },
		error: function(request, status, err){
			alert(request.responseText);
			console.log(err);
		},
        complete:function(){
        	if(param != undefined){
        		if(param.loading_id  != undefined){
        			GBL_removeLoading(param.loading_id);
        		}
        	}
        }
    });
}


/*
 * 비동기 ajax 콜
 * @param
 * @return
 */
function callAsyncAjax(url, param, callbackFunc){
	var param = param;
	
	if(param != undefined){
		if(param.loading_id  != undefined){
        	GBL_makeLoading(param.loading_id);
        }
    }
	
	$.ajax({
		type: "post",
        url: url,
        async: true,
        dataType: "json",
        contentType : "application/json;charset=UTF-8",
        data: JSON.stringify(param),
        success : function(data){
        	if (data.responseCode != null && data.responseCode != undefined && data.responseCode.substr(0, 1) == "E") {
        		alert(data.responseMessage);
        	} else {
        		if (callbackFunc != null && callbackFunc != undefined) {
				    var fn = window[callbackFunc];
				    if (typeof fn === "function") {
				    	fn(data, param);
				    }
        		}
        	}
        },
		error: function(request, status, err){
			alert(request.responseText);
			console.log(err);
		},
        complete:function(){
        	if(param != undefined){
        		if(param.loading_id  != undefined){
        			GBL_removeLoading(param.loading_id);
        		}
        	}
        }
    });
}

