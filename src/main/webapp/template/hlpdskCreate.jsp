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
                            <h1 class="m-0 text-dark">처리요청 등록</h1>
                        </div>
                        <!-- /.col -->
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
                                <li class="breadcrumb-item">HelpDesk /처리요청</li>
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
					    <div class="card-body2" style="min-height:654px; overflow:auto;">
					        <div class="row">
					            <div class="col-md-12">
					                <div class="form-inline">
					                    <div id="cmmnClsCdGrid"></div>                    
					                    <div class="form-group col-md-6 py-sm-2" >
					                        <label class="col-sm-4 col-form-label" for="inputDescription">요청구분 <b style="color:red;padding-left:10px;">*</b></label>
					                        <div class="col-sm-8">
					                        <select class="form-control float-left" id="searchCombo3" style="width:60%;  max-width:220px;">                              
					                        </select>
					                        <input type="hidden" id="boardTy">
					                        </div>
					                    </div>
					                    <div class="form-group col-md-6 py-sm-2" >
					                    </div>
					                    <div class="form-group col-md-12 py-sm-2" >
					                        <label class="col-sm-2 col-form-label" for="inputDescription">요청제목<b style="color:red;padding-left:10px;">*</b></label>
					                        <div class="col-sm-9" style="padding-left: 4px;">
					                            <textarea id="requstSj" class="form-control" rows="2" style="width:100%;" ></textarea>
					                        </div>
					                    </div>              
					                    <div class="form-group col-md-12 py-sm-2" >
					                        <label class="col-sm-2 col-form-label" for="inputDescription">요청내용<b style="color:red;padding-left:10px;">*</b></label>
					                        <div class="col-sm-9" style="padding-left: 4px;">
					                            <textarea id="requstCn" class="form-control" rows="5" style="width:100%;" ></textarea>
					                        </div>
					                    </div>
					                   <div class="form-group col-md-12 py-sm-2"  >
					                   <label class="col-sm-2 col-form-label">첨부파일 </label>
					                   <table>                   
					                   <tbody>                   
					                   <tr>
					                       <td>
					                       <div class="form-check2 row"  id="fileUpload"></div>                       
					                       </td>                     
					                   </tr>  
					                   </tbody>
					                   </table>                     
					                   </div>
					               </div>
					                   <div class="float-right" style="margin:15px 0 15px 2px;">
					                       <button type="button" class="btn btn-primary" id="RegisterIdea">저장</button>
					                       <button type="button" class="btn btn-primary" id="cancel">닫기</button>
					                   </div>
					               </div>
					            </div>
					        </div>
					    </div>
					
					
					<script>
					
					    $(function() {
					    	
					        bindEvent();
					                
					        hlpUpload = new RpaUpload("fileUpload");
					        hlpUpload.draw(0,true);
					        
					        var params = [];
					        params.push({"id" : "searchCombo3", "clsCd" : "0036"});
					        requestCmmnCd(params);
					        
					    });
					  
						/*
						 * 이벤트 바인딩
						 * @param
						 * @return
						 */
						function bindEvent(){
							
							//닫기 클릭시
						    $("#cancel").on("click", function() {
						    	$('#insert2').hide();
						    	$('.card-body2').hide();
						    	$('#insert').show();
						        $('.card-body').show();
						        $(".over").remove();
						    });
							  
							//저장 클릭시
						    $("#RegisterIdea").on("click", function() {
						    	var inputTitle = $('#requstSj').val();
						    	var inputContent = $('#requstCn').val();
						    	var searchCombo3 = $('#searchCombo3').val();
						    	
						    	if(inputTitle == ""){
					                alert("제목을 입력하세요.");
					                $("#requstSj").focus();
					                return false;
					                
					            } else if (inputContent == ""){
					                alert("내용을 입력하세요.");
					                $("#requstCn").focus();
					                return false;
					                
					            } else {
					                if(hlpUpload.upload() == 0){
					                    fileGrpNo = 0;
					                }else{
					                    fileGrpNo = hlpUpload.upload();
					                }
					            if (searchCombo3 == '') {
					            	alert("요청구분을 선택하세요.");
					            	return false;
					            }
					            	Register();
					            	alert("등록 완료");
					                location.reload(true);
					            }            
						    });		
						}
						
						function Register() {
						    var url = '/hlpdsk/requst/insertHlpdsk';
						    var param = new Object();
						    param.requstSe = $("#searchCombo3").val();
						    param.requstSj = $("#requstSj").val();
						    param.requstCn = $("#requstCn").val();
						    param.requstFileGrpNo = fileGrpNo;
						    callSyncAjax(url, param, null);
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