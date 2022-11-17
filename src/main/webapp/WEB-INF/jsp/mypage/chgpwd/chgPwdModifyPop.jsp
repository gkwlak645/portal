<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="card card-primary" id = "cardDiv" style="height:auto; min-height:700px;">
    <div class="card-body" style="padding:50px;">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
				    <div class="card-body login-card-body">
				        <h1 align="center">비밀번호 변경</h1>
				        <p class="login-box-msg">새로운 비밀번호를 입력해 주세요.</p>
				        <div class="input-group mb-3">
				            <input type="hidden" id="hdnTxUserId" data-value="${sessionUserInfo.txUserId}">
				            <input type="password" class="form-control" placeholder="비밀번호" id="newPassword">
				            <div class="input-group-append">
				                <div class="input-group-text">
				                    <span class="fas fa-lock"></span>
				                </div>
				            </div>
				        </div>
				        <div class="input-group mb-3">
				            <input type="password" class="form-control" placeholder="비밀번호 확인" id="newCheckPassword">
				            <div class="input-group-append">
				                <div class="input-group-text">
				                    <span class="fas fa-lock"></span>
				                </div>
				            </div>
				        </div>
				        <div class="row">
				            <div class="col-12">
				                <button class="btn btn-primary btn-block" id="btnNewPassword">비밀번호 변경</button>
				            </div>
				        </div>
				    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    var valtxUserId = $("#hdnTxUserId").data('value');
    console.log(valtxUserId);
	$("#btnNewPassword").on("click", function(){
		var chk = "";
		var valNewPassword= $("#newPassword").val();
		var valNewCheckPassword = $("#newCheckPassword").val();
		var valUserId = $("#userId").val();
		chk = chkPw(valNewPassword);
	    if(chk != 0){
	    	if(valNewPassword != valNewCheckPassword){
	            alert("비밀번호가 일치하지 않습니다.");
	            $("#newPassword").val("").focus();
	            $("#newCheckPassword").val("");
	            return false;
	        }else{
	            url = "/mypage/chgpwd/updateNewPassword";
	            param = {
	                  "password" : valNewPassword
	                 ,"userId" : valUserId
	                  };
	            callAsyncAjax(url, param, "updatePassword");
	        }
	    }else{
	    	$("#newPassword").val("").focus();
	        $("#newCheckPassword").val("");
	    }
	});
	function chkPw(pw){
		 var num = pw.search(/[0-9]/g);
		 var eng = pw.search(/[a-z]/ig);
		 var spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);

		 if(pw.length < 8 || pw.length > 20){
		  alert("8자리 ~ 20자리 이내로 입력해주세요.");
		  return "0";
		 }else if(pw.search(/\s/) != -1){
		  alert("비밀번호는 공백 없이 입력해주세요.");
		  return "0";
		 }else if( (num < 0 && eng < 0) || (eng < 0 && spe < 0) || (spe < 0 && num < 0) ){
		  alert("영문,숫자, 특수문자 중 2가지 이상을 혼합하여 입력해주세요.");
		  return "0";
		 }
	}
	
	function updatePassword(data){
		alert("비밀번호가 바뀌었습니다.");
		$("#chgPwdPage").remove();
		$("#userId").val("").focus();
	    $("#password").val("");
	};
	
	$("#newPassword, #newCheckPassword").keyup(function(key) {
        if (key.keyCode == 13) {
        	var chk = "";
            var valNewPassword= $("#newPassword").val();
            var valNewCheckPassword = $("#newCheckPassword").val();
            var valUserId = $("#userId").val();
            chk = chkPw(valNewPassword);
            if(chk != 0){
                if(valNewPassword != valNewCheckPassword){
                    alert("비밀번호가 일치하지 않습니다.");
                    $("#newPassword").val("").focus();
                    $("#newCheckPassword").val("");
                    return false;
                }else{
                    url = "/mypage/chgpwd/updateNewPassword";
                    param = {
                          "password" : valNewPassword
                         ,"userId" : valUserId
                          };
                    callAsyncAjax(url, param, "updatePassword");
                }
            }else{
                $("#newPassword").val("").focus();
                $("#newCheckPassword").val("");
            }
        }
    });
</script>