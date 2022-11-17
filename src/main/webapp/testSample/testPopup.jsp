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
    <button id="test">TEST</button>
    </body>
<script>
$("#test").on("click",function(){
	
//	var popup = window.open('http://www.facebook.com/sharer/sharer.php?u=http://www.google.com', '', "width=400, height=400");

//    popup.onbeforeunload = function() {
//        alert('unload');
//    }
    
	var win = window.open('http://www.google.com'); 
	var timer = setInterval(function() { 
	    if(win.closed) {
	        clearInterval(timer);
	        alert('closed');
	    }
	}, 1000);
});

/*
$("#test").on("click", function(){
	var popup = window.open('http://www.facebook.com/sharer/sharer.php?u=http://www.google.com', '', "width=400, height=400");

	popup.onbeforeunload = function() {
	    alert('unload');
	}
});
*/

</Script>