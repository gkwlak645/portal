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
                            <h1 class="m-0 text-dark">사용자관리</h1>
                        </div>
                        <!-- /.col -->
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
                                <li class="breadcrumb-item">시스템관리 /사용자관리</li>
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
					<div class="container-fluid wrap">
					    <div class="row">
					        <div class="col-md-12">
					             <div class="card card-default">
						            <div class="card-header" style="height:auto;" >
						                <form name="searchForm"id="searchForm" class="form-inline">                                      
                                          <div class="form-group col-sm-6">
                                                 <label for="inputUserId" class="col-sm-2 col-form-label">아이디</label>
                                                 <div class="col-sm-10">
                                                    <input type="text" class="form-control" style="width:60%;max-width:200px;" id="inputUserId" placeholder="사용자아이디" />
                                                 </div>
                                             </div>
                                        
                                        
                                            <div class="form-group col-sm-6">
                                                <label for="inputEmpNm" class="col-sm-2 col-form-label">이름</label>
                                                <div class="col-sm-10 float-left">
                                                    <input type="text" class="form-control float-left"style="width:60%;max-width:200px;" id="inputEmpNm" placeholder="사용자명" />
                                                    <input type="button" id="searchBtn" class="btn btn-info  float-left" value="조회" />
                                                </div>
                                            </div>                                        
                                        </form> 
						            </div>
							     </div>
					        </div>
					    </div>
					    <div class="row">
					        <div class="col-md-12">
					            <div class="card">
					            
					                <div class="card-body">
					                    <button type="button" id="regBtn" class="btn btn-primary float-right"style="margin:5px 0 15px 2px;">등록</button>
					                    <div id="userSearchGrid"></div>
					                    <div id="Pager" class="portal-pager"></div>
					                </div>
					            </div>
					        </div>
					    </div>
					<!--     <div class="card-body">
						    <div class="col-sm-12">
						        <button type="button" id="regBtn" class="btn btn-info float-right">등록</button>
						    </div>
					        <div id="userSearchGrid"></div>
					        <div id="paging" style="text-align:center"></div>
					    </div> -->
					</div>
					
					<!-- page script -->
					<script>
					
					$(document.body).ready(function () {    
						ajaxGridComm('','',1);
					});
					
					    var searchId = "";
					    var searchNm = "";
					    var userList = "";
					    var cudPage = 1;
					    function pageInit() { 
					        drawGrid("");
					    };
					    
					    function bindEvent(){
					        $("#searchBtn").on("click",function(){
					            $(".pagingClass").remove();
					            searchId = $("#inputUserId").val();
					            searchNm = $("#inputEmpNm").val();
					            cudPage = 1;
					            ajaxGridComm(searchId,searchNm,cudPage);
					        });
					        
					        $("#inputUserId, #inputEmpNm").keyup(function(e){
					            if(e.keyCode == 13){
					                $(".pagingClass").remove();
					                searchId = $("#inputUserId").val();
					                searchNm = $("#inputEmpNm").val();
					                cudPage = 1;
					                ajaxGridComm(searchId,searchNm,cudPage); 
					            }
					        });
					
					        $("#regBtn").on("click",function(){
					            var url = "/orgnzt/user/userRegisterPagePop";
					            appendDivReg(url);
					        });
					        
					        $(document).on("click",".pagingClass",function(){
					            if($(this).text() == "처음"){
					                cudPage = 1;
					            }else if($(this).text() == "이전"){
					                cudPage = userList.pageInfo.currentPageNo-1;
					            }else if($(this).text() == "다음"){
					                cudPage = userList.pageInfo.currentPageNo+1;
					            }else if($(this).text() == "마지막"){
					                cudPage = userList.pageInfo.totalPageCount;
					            }else{
					                cudPage = $(this).text();
					            }
					            
					            ajaxGridComm(searchId,searchNm,cudPage);
					        });
					        
					    }
					    
					    function ajaxGridComm(id,name,pageNum){
					        var url = '/orgnzt/user/userManageList';
					        var param = {
					                userId: id,
					                empNm: name,
					                pageInfo: {
					                    currentPageNo: pageNum
					                }
					        };
					        callAsyncAjax(url, param, "drawGrid");
					    }
					    
					    function drawGrid(data){
					        var pageSize = 10;
					        if(data != ""){
					            userList = data.result.userList;
					            pageSize = userList.pageInfo.recordCountPerPage;
					            if(userList.pageInfo.totalRecordCount > userList.pageInfo.recordCountPerPage){
					                pagingGrid(userList.pageInfo,"paging");
					            }
					        }
					        $("#userSearchGrid").jsGrid({
					            height : "auto",
					            width : "100%",
					            autoload: true,
					            sorting : true,
					            paging : true,
					            scroll : true,
					            pageSize: pageSize,
					            rowClick: function(arg){
					                detailPageMove(arg.item.userId);
					            },
					            data: userList.items,
					    
					            fields : [ 
					            	/* {name: "cmpnyNm" ,title : "회사", align : "center", type : "text", width : 60},  */
					                {name: "userId" ,title : "아이디", align : "center", type : "text", width : 60}, 
					                {name: "empNm" ,title : "사용자명", align : "center", type : "text", width : 65}, 
					                {name: "empNo" ,title : "사원번호", align : "center", type : "text", width : 60}, 
					                {name: "pstNm" ,title : "직급", align : "center", type : "text", width : 50}, 
					                {name: "deptNm" ,title : "부서", align : "center", type : "text", width : 100}, 
					                {name: "telno" ,title : "전화번호", align : "center", 
					                    itemTemplate:function(value){
					                           return $("<span>").text(dashPlus(value));
					                    }}, 
					                {name: "emailAdr" ,title : "이메일주소", align : "center",  type : "text", width : 120}, 
					                {name: "useAt" ,title : "사용여부", align : "center", type : "text"} 
					            ]
					        });
					    }
					    
					    function appendDivDetailGet(url){
					        var html = "";
					        html += '<div id="overPage2" class="over"></div>';
					        $(".wrap").append(html);
					        $.ajax({
					            url : url,
					            dataType : "html",
					            type : "GET",
					            async : false,
					            success : function(result){
					                $("#overPage2").html(result);
					            }
					        });
					    }
					    
					    function appendDivDetailPost(url,id){
					        var param = {"userId" : id};
					         callAsyncAjax(url, param, "drawValue");
					    }
					    
					    function drawValue(data){
					        var userListValue = data.result.userDetailSelect.items;
					        
					        $("#userId").val(userListValue.userId);
					        $("#empNo").val(userListValue.empNo);
					        $("#empNm").val(userListValue.empNm);
					        $("#pstCd").append('<option value="'+userListValue.pstCd+' selected">'+userListValue.pstNm+'</option>');
					        $("#deptNm").val(userListValue.deptNm);
					        $("#deptCd").val(userListValue.deptCd);
					        $("#emailAdr").val(userListValue.emailAdr);
					        $("#telno").val(dashPlus(userListValue.telno));
					        $("#mbtlnum").val(dashPlus(userListValue.mbtlnum));
					        $('#userCls').val(userListValue.userCls).prop("selected", true);
					        $("#useAt").val(userListValue.useAt);
					    }
					    
					    function appendDivReg(url){
					        var html = "";
					        html += '<div id="overPage" class="over"></div>';
					        $(".wrap").append(html);
					        
					        $.ajax({
					            url : url,
					            dataType : "html",
					            type : "get",
					            success : function(result){
					                $("#overPage").html(result);
					            }
					        });
					    }
					    
					    function backList(){
					        $(".over").remove();
					    }
					    
					    function cudBackList(){
					        $(".over").remove();
					        ajaxGridComm(searchId,searchNm,cudPage);
					    }
					    
					    function dashPlus(value){
					    	
					    	if(value == null || value == ""){
					    		return "";
					    	}
					    	
					        var tel = "";
					        var number = value.replace(/[^0-9]/g, "");
					        
					        if(number.lengh < 5){
					            return number;
					        }else if(number.length < 9){
					            var preLength = number.length-4;
					            tel += number.substr(0,preLength);
					            tel += "-";
					            tel += number.substr(prelength);
					            return tel;
					        }else if(number.length == 9){
					            tel += number.substr(0,2);
					            tel += "-";
					            tel += number.substr(2,3);
					            tel += "-";
					            tel += number.substr(5);
					            return tel;
					        }else if(number.length == 10){
					            if(number.substr(0,2).equals("02")){
					                tel += number.substr(0,2);
					                tel += "-";
					                tel += number.substr(2,4);
					                tel += "-";
					                tel += number.substr(6);
					                return tel;
					            }else{
					                tel += number.substr(0,3);
					                tel += "-";
					                tel += number.substr(3,3);
					                tel += "-";
					                tel += number.substr(6);
					                return tel;
					            }
					        }else if(number.length > 10){
					            tel += number.substr(0,3);
					            tel += "-";
					            tel += number.substr(3,4);
					            tel += "-";
					            tel += number.substr(7);
					            return tel;
					        }
					    }
					    
					    function detailPageMove(value){
					        var url = "/orgnzt/user/userDetailPagePop";
					        var id = value;
					        appendDivDetailGet(url);
					        appendDivDetailPost(url,id);      
					    };
					    
					    function pagingGrid(param,id){
					        var result = "";
					        if(param.currentPageNo > param.pageSize){
					            result += '<a class="'+id+'Class" href="#">처음</a>&nbsp;&nbsp;';
					        }
					        if(param.currentPageNo != 1){
					            result += '<a class="'+id+'Class" href="#">이전</a>&nbsp;&nbsp;';
					        }
					        for(var i = param.firstPageNoOnPageList ; i <= param.lastPageNoOnPageList ; i++){
					            if(param.currentPageNo == i){
					                result += '<a class="'+id+'Class" href="#"><strong>'+i+'</strong></a>&nbsp;&nbsp;';
					            }else{
					                result += '<a class="'+id+'Class" href="#">'+i+'</a>&nbsp;&nbsp;';
					            }
					        }
					        if(param.currentPageNo != param.totalPageCount){
					            result += '<a class="'+id+'Class" href="#">다음</a>&nbsp;&nbsp;';
					        }
					        if(param.currentPageNo <= (param.totalPageCount - (param.totalPageCount % param.pageSize))){
					            result += '<a class="'+id+'Class" href="#">마지막</a>';
					        }
					            
					        $("#"+id).html(result);
					    };
					    
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