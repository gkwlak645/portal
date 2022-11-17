<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="login-box">
  <div class="login-logo">
  </div>
  <div class="card" style="width:360px; height:410px;">
    <div class="card-body login-card-body">
    <h2 align="center"><b>아이디</b>찾기</h2>
      <p class="login-box-msg">아이디를 잊으셨나요? 등록된 이메일을 작성해주세요.</p>
      <!-- <form action="recover-password.html" method="post"> -->
      <div class="input-group mb-3">
          <input type="email" class="form-control" placeholder="Email" id="emailAdr">
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-envelope"></span>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-12">
            <button class="btn btn-primary btn-block" id="btnFindUserId">아이디 찾기</button>
          </div>
        </div>
    <!--   </form> -->

      <p class="mt-3 mb-1">
        <a href="#" id="backLoginPage">Login</a>
      </p>
      <!-- <p class="mb-0">
        <a href="register.html" class="text-center">Register a new membership</a>
      </p> -->
    </div>
  </div>
</div>

<script>
    $(document).ready(function(){
    	openEvent();
    });
   
    function openEvent(){
    	$("#btnFindUserId").on("click", function(){
            var valEmailAdr=$("#emailAdr").val();
           if(valEmailAdr == ""){
        	   alert("이메일을 입력해 주세요.");
        	   return false;
           }
            var url = "/login/sendFindId";
            var param = {
                    "emailAdr" : valEmailAdr
                        };
            callAsyncAjax(url, param, "sendId");
        });
    	
    	$("#backLoginPage").on("click", function(){
    		backLogin();
    	});
    }
    
    function sendId(data){
        var resultId = data.result.result;
        
        if(resultId == ""){
        	alert("등록된 이메일이 없습니다. 다시 한번 확인해 주세요.");
        	$("#emailAdr").val("").focus();
        }else{
        	alert("등록된 이메일로 아이디를 보냈습니다.");
        	backLogin();
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
    
    $("#emailAdr").keyup(function(key) {
    	if (key.keyCode == 13) {
	        var valEmailAdr=$("#emailAdr").val();
	        if(valEmailAdr == ""){
	            alert("이메일을 입력해 주세요.");
	            return false;
	        }
	        var url = "/login/sendFindId";
	        var param = {
	                "emailAdr" : valEmailAdr
	                };
	        callAsyncAjax(url, param, "sendId");
         }
    });
</script>