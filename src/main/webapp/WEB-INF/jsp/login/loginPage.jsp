<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<title>로그인</title>
	    <!-- Tell the browser to be responsive to screen width -->
	    <meta name="viewport" content="width=device-width, initial-scale=1">
	    <!-- Font Awesome -->
	    <link rel="stylesheet" href="/resources/plugins/fontawesome-free/css/all.min.css">
	    <!-- Ionicons -->
	    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
	    <!-- icheck bootstrap -->
	    <link rel="stylesheet" href="/resources/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
	    <!-- Theme style -->
	    <link rel="stylesheet" href="/resources/css/dist/adminlte.min.css">
	    <link rel="stylesheet" href="/resources/css/custom.css"><!-- 추가 -->
	    <!-- Google Font: Source Sans Pro -->
	    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
	    <!-- jQuery -->
	    <script src="/resources/plugins/jquery/jquery.min.js"></script>
	    <!-- Bootstrap 4 -->
	    <script src="/resources/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
	    <!-- AdminLTE App -->
	    <script src="/resources/js/dist/adminlte.min.js"></script>
	</head>
	
	<body>
<!-- 로그인 페이지 -->
<div class="login-wrap">
    <div class="login-center">
        <div class="login-box">
            <div class="login-logo">동원 RPA PORTAL</div>
            <div class="login-form">
                <div class="icheck-primary" style="text-align: right;">
                    <!-- <input type="checkbox" id="remember">
                    <label for="remember">로그인상태유지</label> -->
                </div>
                <div class="login-field">
                    <div class="input-group">
                        <input type="text" id="userId" class="form-control" placeholder="아이디" value="">
                        <div class="input-group-append">
                            <div class="input-group-text">
                                <span class="fas fa-user"></span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="login-field">
                    <div class="input-group">
                        <input type="password" id="password" class="form-control" placeholder="비밀번호" value="">
                        <div class="input-group-append">
                            <div class="input-group-text">
                                <span class="fas fa-lock"></span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="login-field">
                    <button class="btn btn-block btn-clr_2 btn-over" id="btnLogin">LOGIN</button>
                </div>
                <div class="login-field btn-box_vertical">
                    <!-- <button class="btn btn-block btn-clr_1" id="btnFindId">아이디 찾기</button>
                    <button class="btn btn-block btn-clr_1" id="btnFindPwd">비밀번호 찾기</button> -->
                </div>
            </div>
        </div>
    </div>
    <div class="login-ft">COPYRIGHTⒸ2020 DONGWON. ALL RIGHTS RESERVED</div>
</div>
<!-- // 로그인 페이지 -->
	
	    <script>
	    
		    if (document.location.protocol == 'http:' && window.location.hostname.indexOf('rpaportal.dongwon.com') >= 0) {
		    	document.location.href = document.location.href.replace('http:', 'https:');
		    }
	    
			//$("#userId").val(idKey);
			//$("#password").val(pwdKey);
			if($("#userId").val() != ""){
				$("#remember").attr("checked", true);
			}
			
			function setCookie(cookieName, value, exdays){
				var exdate = new Date();
				exdate.setDate(exdate.getDate() + exdays);
				var cookieValue = escape(value) + ((exdays==null)? "" : "; expires=" +exdate.toGMTString()); //인코딩
				document.cookie = cookieName + "=" + cookieValue;
			}
			
			function deleteCookie(cookieName){
				var expireDate = new Date();
				expireDate.setDate(expireDate.getDate() - 1);
				document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
			}
			
			function getCookie(cookie_name){
				var x, y;
				var val = document.cookie.split(';');
				for(var i =0; i<val.length; i++){
					x = val[i].substr(0, val[i].indexOf('='));
					y = val[i].substr(val[i].indexOf('=') + 1);
					x = x.replace(/^\s+|\s+$/g, ''); /* 공백제거 */
					
					if(x == cookie_name){
						return unescape(y);
					}
				}
			}
			
			var userId = "";
			var password = "";
			var idKey = getCookie("idKey");
			var pwdKey = getCookie("pwdKey");
			
			$(document).ready(function(){
				$("#btnLogin").on("click", function(){
					userId = $("#userId").val();
					password = $("#password").val();
					if(userId == "" || password == ""){
						alert("아이디와 비밀번호를 입력하세요.");
						return false;
					}
					
<%--
 					var url = "/login/loginCheck";//일반 로그인
--%>					
					var url = "/login/loginSsoCheck";//SSO 로그인

					var param = {
							 "userId" : userId
							,"password" : password
						};
						
					callAsyncAjax(url, param, "loginCheck");
					
					if($("#remember").is(":checked")){
		                setCookie("idKey", $("#userId").val(), 7);
		                setCookie("pwdKey", $("#password").val(), 7);
		            }else{
		                deleteCookie("idKey");
		                deleteCookie("pwdKey");
		            };
					
				});
				
				$("#btnFindId").on("click", function(){
					var url= "/login/findId";
					appendFindIdPwd(url);
				});
				
				$("#btnFindPwd").on("click", function(){
					var url = "/login/findPwd";
					appendFindIdPwd(url);
				});
			});
			 
			function appendFindIdPwd(url){
				var html = "";
		        html += '<div id="findIdPwd" class="over" style="position:absolute; top:0px; left:0px; width:100%; height:100%;"></div>';
		        $("#wrap").append(html);
		        $.ajax({
		            url : url,
		            dataType : "html",
		            type : "get",
		            success : function(result){
		                $("#findIdPwd").html(result);
		            }
		        });
			}
			
			function backLogin(){
				$("#findIdPwd").remove();
			}
			
			function loginCheck(data){
			    var resultUser = data.result.result;
				if(resultUser !=null){
					location.href = "/main/siteMain";
				}else{
					location.href = "/login/loginPage";
					alert("로그인 실패");
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
			        }
			    });
			}
			
			$("#userId, #password").keyup(function(key) {
		        if (key.keyCode == 13) {
		            userId = $("#userId").val();
		            password = $("#password").val();
		            if(userId == "" || password == ""){
		                alert("아이디와 비밀번호를 입력하세요.");
		                return false;
		            }
<%--
					var url = "/login/loginCheck";//일반 로그인
--%>					
					var url = "/login/loginSsoCheck";//SSO 로그인
					
		            var param = {
		                     "userId" : userId
		                    ,"password" : password
		                };
		            callAsyncAjax(url, param, "loginCheck");
		            
		            if($("#remember").is(":checked")){
		                setCookie("idKey", $("#userId").val(), 7);
		                setCookie("pwdKey", $("#password").val(), 7);
		            }else{
		                deleteCookie("idKey");
		                deleteCookie("pwdKey");
		            };
		        }
		    });
		</script>
	</body>
</html>