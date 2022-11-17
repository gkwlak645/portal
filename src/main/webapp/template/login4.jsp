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
        <!-- Google Font: Source Sans Pro -->
        <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
    </head>
    
    <body class="hold-transition login-page">
    <!-- jQuery -->
        <script src="/resources/plugins/jquery/jquery.min.js"></script>
        <!-- Bootstrap 4 -->
        <script src="/resources/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
        <!-- AdminLTE App -->
        <script src="/resources/js/dist/adminlte.min.js"></script>
        <div class ="card wrap" id="wrap" style="position:relative;">
            <div class="login-box">
                <div class="card-header">
                    <div class="login-logo">
                    </div>
                    <div class="card">
                        <div class="card-body login-card-body" align="center">
                        <h2>RPA 포탈</h2>
                        <p class="login-box-msg">로그인</p>
                            <div class="input-group mb-3">
                                <input type="text" id="userId" class="form-control" placeholder="아이디" value="gwtest12">
                                <div class="input-group-append">
                                    <div class="input-group-text">
                                        <span class="fas fa-user"></span>
                                    </div>
                                </div>
                            </div>
                            <div class="input-group mb-3">
                                <input type="password" id="password" class="form-control" placeholder="비밀번호" value="gwtest12">
                                <div class="input-group-append">
                                    <div class="input-group-text">
                                        <span class="fas fa-lock"></span>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-8">
                                    <div class="icheck-primary">
                                        <input type="checkbox" id="remember">
                                        <label for="remember">로그인 상태 유지</label>
                                    </div>
                                </div>
                                <div class="col-4"> 
                                    <button class="btn btn-primary btn-block" id="btnLogin">로그인</button>
                                     <button class="btn btn-primary btn-block" id="btnLoginXML">로그인xml</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    
        <script>
            var userId = "";
            var password = "";
            var idKey ="";
            var pwdKey ="";
            $(document).ready(function(){
                idKey = getCookie("idKey");
                pwdKey = getCookie("pwdKey");
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
                
                $("#btnLogin").on("click", function(){
                    userId = $("#userId").val();
                    password = $("#password").val();
                    if(userId == "" || password == ""){
                        alert("아이디와 비밀번호를 입력하세요.");
                        return false;
                    }
                    
                    
                    //var url = "/login/loginCheck";
                    var url = "https://gwdev.dongwon.com/WebSite/Approval/RpaDraft.aspx";//SSO 로그인
                    
                    var param = {
                        "mKey" : "Z_20_001_04|4|9"
                        ,"title" : "test"
                        ,"bodies" : "<h1>test</h1>"
                        ,"userid" : "gwtest1"
                        ,"formName" : "test12"
                        ,"formPrefix" : "Z_20_001_04"
                        ,"bodytype" : "html"
                    }
                        
                    callAsyncAjax(url, param, "loginCheck");
                    
                    if($("#remember").is(":checked")){
                        setCookie("idKey", $("#userId").val(), 7);
                        setCookie("pwdKey", $("#password").val(), 7);
                    }else{
                        deleteCookie("idKey");
                        deleteCookie("pwdKey");
                    };
                    
                });
                
                
                $("#btnLoginXML").on("click", function(){ 
                    userId = $("#userId").val();
                    password = $("#password").val();
                    if(userId == "" || password == ""){
                        alert("아이디와 비밀번호를 입력하세요.");
                        return false;
                    }
                    
                    
                   /*  var param = "mKey=" + "Z_20_001_04|4|9" + 
                    "&title=" + "test" + 
                    "&bodies=" + "<h1>test</h1>"+ 
                    "&userid=" + "gwtest1"+ 
                    "&formName=" + "test12"+ 
                    "&formPrefix=" + "Z_20_001_04"+ 
                    "&bodytype=" + "html"; */
                    
                    //var url = "/login/loginCheck";
                    var url = "https://gwdev.dongwon.com/WebSite/Approval/RpaDraft.aspx";//SSO 로그인
                    
                    var param = {
                        "mKey" : "Z_20_001_04|4|9"
                        ,"title" : "test"
                        ,"bodies" : "<h1>test</h1>"
                        ,"userid" : "gwtest1"
                        ,"formName" : "test12"
                        ,"formPrefix" : "Z_20_001_04"
                        ,"bodytype" : "html"
                    } 
                        
                    ///callAsyncAjax(url, param, "loginCheck");
                    
                    
                    
                        $.ajax({
                            type: "post",
                            url: url,
                            async: false,
                            dataType: "xml",
                           // contentType : "application/xml;charset=UTF-8",
                            data: param,
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
                    var url = "/login/loginCheck";
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