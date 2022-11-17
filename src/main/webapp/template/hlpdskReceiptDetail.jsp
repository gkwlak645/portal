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
                            <h1 class="m-0 text-dark">접수처리</h1>
                        </div>
                        <!-- /.col -->
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
                                <li class="breadcrumb-item">HelpDesk /접수처리</li>
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
					<div class="card card-primary" id = "cardDiv">
					    <div class="card-header" id="insert3">
					        <h3 class="card-title">접수처리 상세</h3>
					    </div>
					    <div class="card-body">
                            <div class="row">
                                <div class="col-md-12" id="t1">
                                    <div class="form-inline">
					                        <div id="cmmnClsCdGrid"></div>                    
					                        <div class="form-group col-md-6 py-sm-2">
                                                <label class="col-sm-4 col-form-label" for="inputDescription">요청구분 <b style="color:red;padding-left:10px;">*</b></label>
                                                <div class="col-sm-8">
                                                <select class="form-control float-left" id="searchCombo3"style="width:60%;  max-width:220px;">                              
                                                </select> 
					                            <input type="hidden" id="boardTy">
					                            <input type="hidden" id="processSttusCd" value="">
					                            </div>
					                        </div>
                                            <div class="form-group col-md-6 py-sm-2" ></div>
                                            <div class="form-group col-md-12 py-sm-2" >
                                                <label class="col-sm-2 col-form-label" for="inputDescription">요청제목<b style="color:red;padding-left:10px;">*</b></label>
					                            <div class="col-sm-9" style="padding-left: 4px;">
                                                    <textarea id="requstSj2" class="form-control" rows="2" style="width:100%;" ></textarea>
                                            </div>
                                        </div>              
                                        <div class="form-group col-md-12 py-sm-2" >
                                            <label class="col-sm-2 col-form-label" for="inputDescription">요청내용<b style="color:red;padding-left:10px;">*</b></label>
                                                <div class="col-sm-9" style="padding-left: 4px;">
                                                    <textarea id="requstCn2" class="form-control" rows="5" style="width:100%;" ></textarea>
					                                <input type="hidden" id="requstSn2">
					                            </div>
					                        </div>
					                      <div class="form-group col-md-12 py-sm-2"  >
                                               <label class="col-sm-2 col-form-label">첨부파일 </label>
                                               <div class="col-sm-9"><div class="form-check2 row"  id="fileUpload"></div></div>
                                           </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="form-inline">
                                        <div class="form-group col-sm-12" id="t2" id="insert3">
                                           <h5 class="text-success">⊙ 처리결과</h5>
                                        </div>
					                        <div id="cmmnClsCdGrid"></div>
					                        <div class="form-group col-md-12 py-sm-2" >                        
					                           <label class="col-sm-2 col-form-label">처리상태<b style="color:red;padding-left:10px;">*</b></label>
					                           <select class="form-control float-left" id="sttusCd" style="width:60%;  max-width:220px;">
					                           </select>                              
					                        </div>             
					                        <div class="form-group col-md-12 py-sm-2" >
                                            <label class="col-sm-2 col-form-label" for="inputDescription">처리내용<b style="color:red;padding-left:10px;">*</b></label>
					                            <div class="col-sm-9" style="padding-left: 4px;">
                                                <textarea id="requstCn3" class="form-control" rows="5" style="width:100%;"></textarea>
					                                <input type="hidden" id="processCn">
                                            </div>
                                        </div>
                                        <div class="form-group col-md-12 py-sm-2"   id="t1">
                                           <label class="col-sm-2 col-form-label">관련파일 </label>
                                           <div class="col-sm-9">
                                               <div class="form-check2 row"  id="fileUpload2"> </div>
                                           </div>
                                        </div>
                                        
                                    </div>
                                    <div class="float-right"id="btn">
                                        <button type="button" class="btn btn-primary" id="updateBtn2">저장</button>
                                        <button type="button" class="btn btn-primary" id="cancel">닫기</button>
                                    </div>
                                </div>
                            </div>
                        </div>
					<script>
					
					    $(function() {    	
					    	
					        bindEvent();
					        
					        hlpUpload = new RpaUpload("fileUpload");
					        
					        hlpUpload2 = new RpaUpload("fileUpload2");
					        
					        $("#t1").find("*").prop("disabled", true);
					        
					        var params = [];
					        params.push({"id" : "searchCombo3", "clsCd" : "0036"});
					        params.push({"id" : "sttusCd", "clsCd" : "0041"});
					        requestCmmnCd(params);
					    });  
					
					    function bindEvent(){
					    	
					        //닫기 클릭시
					        $("#cancel").on("click", function() {
					            $('#insert3').hide();
					            $('.card-body3').hide();
					            $('#insert').show();
					            $('.card-body').show();
					            $(".over").remove();            
					        });
					        
					        //저장하기 버튼
					        $("#updateBtn2").on("click", function() {
					            var check = confirm("게시글을 저장 하시겠습니까?");
					            if(!check){
					                return false;
					            }
					            if (hlpUpload2.upload() == 0) {
					            	processFileGrpNo = 0;
					            } else {
					            	processFileGrpNo = hlpUpload2.upload();
					            }
					            updateDetail();
					            alert("저장 완료");
					            location.reload(true);
					        });
					    }   
					
					    function updateDetail() {    	
					        var url_5 = "/hlpdsk/requst/updatereceipthlpdsk";
					        var param = new Object();
					        var date = new Date();
					        var y = date.getFullYear()-2000;
					        var m = date.getMonth()+1;
					        var d = date.getDate();
					        if (m < 10) {
					        	m = "0"+m;
					        }
					        var now = y + "-" + m + "-" + d;
					        
					        if ($("#sttusCd").val() != '01') {
					        	param.processDe = now.toString();
					        }
					        param.requstSn = $("#requstSn2").val();	
					        param.processSttusCd = $("#sttusCd").val();
					        param.processCn = $("#requstCn3").val();        
					        param.processFileGrpNo = processFileGrpNo;
					        callSyncAjax(url_5, param, null);
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