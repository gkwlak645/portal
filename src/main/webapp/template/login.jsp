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
                    <input type="checkbox" id="remember">
                    <label for="remember">로그인상태유지</label>
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
                    <button class="btn btn-block btn-clr_1" id="btnFindId">아이디 찾기</button>
                    <button class="btn btn-block btn-clr_1" id="btnFindPwd">비밀번호 찾기</button>
                </div>
            </div>
        </div>
    </div>
    <div class="login-ft">COPYRIGHTⒸ2018 DONGWON. ALL RIGHTS RESERVED</div>
</div>
<!-- // 로그인 페이지 -->

</body>
</html>