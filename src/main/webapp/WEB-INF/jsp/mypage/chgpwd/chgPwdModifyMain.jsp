<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<div class="card wrap" id="wrap">
    <div class="card-header">
        <div class="login-logo">
            <b>본인인증</b>
            ${sessionUserInfo}
        </div>
        <div class="card-body login-card-body">
            <p class="login-box-msg">아이디와 비밀번호를 입력해 주세요</p>
            <div class="input-group mb-3">
                <input type="text" class="form-control" placeholder="Id" id="userId">
                <div class="input-group-append">
                    <div class="input-group-text">
                        <span class="fas fa-user"></span>
                    </div>
                </div>
            </div>
            <div class="input-group mb-3">
                <input type="password" class="form-control" placeholder="Password" id="password">
                <div class="input-group-append">
                    <div class="input-group-text">
                        <span class="fas fa-lock"></span>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <button class="btn btn-primary btn-block" id="btnNewPwd">본인 인증</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
	function bindEvent(){
		$("#btnNewPwd").on("click", function(){
			if($("#userId").val() == ""|| $("#password").val() == ""){
	            alert("아이디와 비밀번호를 입력하여 주세요.");
	            return false;
	        }
			var valUserId = $("#userId").val();
			var valPassword = $("#password").val();
			var url ="/login/loginCheck";
			var param = {
					 "userId" : valUserId
					,"password" : valPassword
				}
			callAsyncAjax(url, param, "userCheck");
		});
	};
	
	function userCheck(data){
		var resultData = data.result.result;
		if(resultData == null|| resultData == ""){
			alert("아이디나 비밀번호가 잘못되었습니다.");
			$("#userId").val("").focus();
			$("#password").val("");
			return false;
		}else{
			alert("본인인증에 성공하였습니다.");
			var url ="/mypage/chgpwd/chgPwdModifyPop";
			appendDivChgPwd(url);
		}
	};
	
	function appendDivChgPwd(url){
	    var html = "";
	    html += '<div id="chgPwdPage" class="over"></div>';
	    $("#wrap").append(html);
	    $.ajax({
	        url : url,
	        dataType : "html",
	        type : "get",
	        success : function(result){
	            $("#chgPwdPage").html(result);
	        }
	    });
	}
	
	$("#password, #userId").keyup(function(key) {
        if (key.keyCode == 13) {
            if($("#userId").val() == ""|| $("#password").val() == ""){
                alert("아이디와 비밀번호를 입력하여 주세요.");
                return false;
            }
            var valUserId = $("#userId").val();
            var valPassword = $("#password").val();
            var url ="/login/loginCheck";
            var param = {
                 "userId" : valUserId
                ,"password" : valPassword
                }
            $("#password").blur();
            callAsyncAjax(url, param, "userCheck");
        }
    });
</script>
