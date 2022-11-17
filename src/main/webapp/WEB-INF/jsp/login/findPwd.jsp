<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="login-box">
  <div class="login-logo">
  </div>
  <div class="card" style="width:360px; height:410px;">
    <div class="card-body">
    <!-- login-card-body -->
     <h2 align="center"><b>비밀번호</b>찾기</h2>
      <p class="login-box-msg">비밀번호를 잊으셨나요?<br/>등록된 아이디와 이메일을 작성해주세요.</p>
      <div class="input-group mb-3">
          <input type="text" class="form-control" placeholder="Id" id="findUserId">
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-user"></span>
            </div>
          </div>
        </div>
        <div class="input-group mb-3">
          <input type="email" class="form-control" placeholder="Email" id="findEmailAdr">
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-envelope"></span>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-12">
            <button class="btn btn-primary btn-block" id="btnNewPwd">새 비밀번호 받기</button>
          </div>
        </div>
      <p class="mt-3 mb-1">
        <a href="#" id="backLoginPage">Login</a>
      </p>
    </div>
  </div>
</div>

<script>
    $(document).ready(function(){
    	$("#btnNewPwd").on("click", function(){
    		var valUserId = $("#findUserId").val();
    		var valEmailAdr=$("#findEmailAdr").val();
    		if(valUserId == "" || valEmailAdr ==""){
    			alert("아이디와 이메일을 작성해주세요.");
    			return false;
    		}
    		var url = "/login/sendNewPwd";
    		var param = {
    				 "userId" : valUserId
    				,"emailAdr" : valEmailAdr};
    		callAsyncAjax(url, param, "sendPwd");
    	});
    	
    	$("#backLoginPage").on("click", function(){
    		backLogin();
    	});
    });
    
    function sendPwd(data){
    	var resultSendPwd = data.result.result;
    	console.log(data);
    	console.log(resultSendPwd);
    	if(resultSendPwd == "true"){
    		backLogin();
    	}else{
    		alert("등록된 아이디나 이메일이 아닙니다.");
    		$("#findEmailAdr").val("");
    		$("#findUserId").val("").focus();
    	}
    }
    
    function callAsyncAjax(url, param, callbackFunc){
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
                            fn(data);
                        }
                    }
                }
            },
            error: function(request, status, err){
                alert(request.responseText);
                console.log(err);
            }
        });
    }
    
    $("#findUserId, #findEmailAdr").keyup(function(key) {
        if (key.keyCode == 13) {
            var valUserId = $("#findUserId").val();
            var valEmailAdr=$("#findEmailAdr").val();
            if(valUserId == "" || valEmailAdr ==""){
                alert("아이디와 이메일을 작성해주세요.");
                return false;
            }
            var url = "/login/sendNewPwd";
            var param = {
                     "userId" : valUserId
                    ,"emailAdr" : valEmailAdr};
            callAsyncAjax(url, param, "sendPwd");
        }
    });
</script>