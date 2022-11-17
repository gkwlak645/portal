<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>템플릿화면</title>
<!-- Tell the browser to be responsive to screen width -->
<meta name="viewport" content="width=device-width, initial-scale=1">

<jsp:include page="/template/script.jsp"></jsp:include>
</head>
<body class="hold-transition sidebar-mini layout-fixed">
    <div class="wrapper">
        <div id="header">
            <!-- Navbar -->
            <nav
                class="main-header navbar navbar-expand border-bottom-0 navbar-dark navbar-primary text-sm">
                <ul class="navbar-nav">
                    <li class="nav-item"><a class="nav-link"
                        data-widget="pushmenu" href="#" role="button"><i
                            class="fas fa-bars"></i></a></li>
                </ul>
                <ul class="navbar-nav ml-auto">
                    <!-- Messages Dropdown Menu -->
                    <li class="nav-item"></a></li>
                </ul>
            </nav>
            <!-- /.navbar -->
        </div>

        <jsp:include page="/template/menu.jsp"></jsp:include>

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Content Header (Page header) -->
            <div class="content-header">
                <div class="container-fluid">
                    <div class="row mb-0">
                        <div class="col-sm-6">
                            <h1 class="m-0 text-dark">패키지관리</h1>
                        </div>
                        <!-- /.col -->
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
                                <li class="breadcrumb-item">자원관리/ 패키지관리</li>
                            </ol>
                        </div>
                        <!-- /.col -->
                    </div>
                    <!-- /.row -->
                </div>
                <!-- /.container-fluid -->
            </div>
            <!-- /.content-header -->


           <!-- Main content -->
            <section class="content">
                <div id="content">



                    <!--  템플릿 바디 -->
					 <div class="modal-dialog modal-lg">
                        <div class="modal-content" id = "cardDiv">
                            <div class="modal-header">
                                <h4 class="modal-title">버전정보</h4>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">×</span>
                                </button>
                            </div>
                            <div class="modal-body" >
					            <div id="packageLibraryVerGrid"></div>
					        </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-primary" id="cancel">닫기</button>
                            </div>
                        </div>
                    </div>
					                
					<!--                                         입력값 -->
					<!--                   <div id = "inputValue"></div> -->
					                  
					<!--                                         출력값 -->
					<!--                   <div id="outputValue"></div>  -->
					                
					<script>
					
					    $(document).ready(function() {
					       
					        //페이지 초기화
					        pageInit();
					        
					        //이벤트 바인딩
					        bindEvent();
					    });
					
					    /*
					     * 페이지 초기화
					     * @param
					     * @return
					     */
					    function pageInit() {
					        
					    }
					    
					    /*
					     * 이벤트 바인딩
					     * @param
					     * @return
					     */
					    function bindEvent() {
					        
					        $("#cancel").on("click", function() {
					            closePOP();
					        });
					        
					    }
					    
					    function packageLibrayVerList(data){
					        console.log("@"+data);
					        var url = "/resrce/package/packageLibraryVersionInfoList";
					        var param ={"identifier" : data
					                   ,"checked" : $('input:radio[name="checkRadio"]:checked').val()
					                   };
					        if($('input:radio[name="checkRadio"]:checked').val() == 'package'){
					        	callAsyncAjax(url, param, "drawPackageVerList");
					        } else {
					        	callAsyncAjax(url, param, "drawLibraryVerList");
					        }
					        
					    }
					    
					    function drawPackageVerList(data){
					        console.log(data)
					        var params = data.result.resultList;
					        $("#packageLibraryVerGrid").jsGrid({
					            height : "auto"
					          , width : "100%"
					          , autoload: true
					          , sorting : true
					          , align : "center"
					          , data : params
					          , checkboxes:true
					          , fields : [
					        	   {name: "statement"    , title : "상태" , type : "text" , width : 100, align : "center"}
					             , {name: "version"      , title : "버전"   , type : "text" , width : 150, align : "center"}
					             , {name: "created"      , title : "게시일"  , type : "text" , width : 80, align : "center"}
					             , {name: ""             , title : "다운로드"   , type : "text" , width : 80, align : "center"
					            	 , itemTemplate: function(value, item) {
					                     var itemIcon = "";
					                     
					                     itemIcon = '<svg class="bi bi-box-arrow-up" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">';
					                     itemIcon += '<path fill-rule="evenodd" d="M4.646 4.354a.5.5 0 0 0 .708 0L8 1.707l2.646 2.647a.5.5 0 0 0 .708-.708l-3-3a.5.5 0 0 0-.708 0l-3 3a.5.5 0 0 0 0 .708z"/>';
					                     itemIcon += '<path fill-rule="evenodd" d="M8 11.5a.5.5 0 0 0 .5-.5V2a.5.5 0 0 0-1 0v9a.5.5 0 0 0 .5.5z"/>';
					                     itemIcon += '<path fill-rule="evenodd" d="M2.5 14A1.5 1.5 0 0 0 4 15.5h8a1.5 1.5 0 0 0 1.5-1.5V7A1.5 1.5 0 0 0 12 5.5h-1.5a.5.5 0 0 0 0 1H12a.5.5 0 0 1 .5.5v7a.5.5 0 0 1-.5.5H4a.5.5 0 0 1-.5-.5V7a.5.5 0 0 1 .5-.5h1.5a.5.5 0 0 0 0-1H4A1.5 1.5 0 0 0 2.5 7v7z"/>';
					                     itemIcon += '</svg>';
					                     
					                     return $(itemIcon).on("click", function(){packageDownload(item.processKey, item.version)});
					                }}
					         ]
					        });  
					    }   
					        
					    function drawLibraryVerList(data){
					         console.log(data)
					         var params = data.result.resultList;
					         $("#packageLibraryVerGrid").jsGrid({
					             height : "auto"
					           , width : "100%"
					           , autoload: true
					           , sorting : true
					           , align : "center"
					           , data : params
					           , checkboxes:true
					           , fields : [
					                {name: "version"      , title : "버전"   , type : "text" , width : 80, align : "center"}
					              , {name: "created"      , title : "게시일"  , type : "text" , width : 80, align : "center"}
					          ]
					      });    
					    }
					    
					    function packageDownload(processKey, version){
					    	var url = "/resrce/package/packageDownload";
					        var param = {
					                processKey  : processKey,
					                version     : version
					            };
					        callAsyncAjax(url, param, null);
					    }
					
					    
					    </script>
	                    <!--  템플릿 바디 끝 -->    
	                </div>
	        </section>
	        <!-- /.Main content -->
	    </div>
	    <div id="footer">
	        <footer class="main-footer">
	            Copyright &copy; 2020 <a href="http://www.echoit.co.kr">에코아이티</a>&nbsp;.&nbsp;All
	            rights reserved.    >
	        </footer>
	    </div>
	</div>