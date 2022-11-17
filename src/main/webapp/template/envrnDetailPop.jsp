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
                            <h1 class="m-0 text-dark">환경관리 상세</h1>
                        </div>
                        <!-- /.col -->
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
                                <li class="breadcrumb-item">자원관리 / 환경관리</li>
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
					    <div class="card-header" alt="자원>환경관리 상세">
					        <h3 class="card-title">상세조회</h3>
					    </div>
					     <div class="card-body" style="min-height:654px; overflow:auto;">
					            <div class="row">
					                <div class="col-md-12">
					                
					                    <div class="form-inline">
					                        <div class="form-group col-md-6 py-sm-2">
					                            <label for="name" class="col-sm-4 col-form-label">회사</label>
					                            <div class="col-sm-8">
						                            <select class="form-control" id="cmpnyCd" style="width:60%;margin-right: 3px;">
						                            </select>
					                            </div>
					                         </div>
					                         <div class="form-group col-md-6 py-sm-2" >
                                                <label class="col-sm-4 col-form-label" for="inputName">환경명 <b style="color: red;">*</b></label>
                                                <div class="col-sm-8">
                                                    <input type="hidden" id="detailEnvrnId">
                                                    <input style="width:60%;"type="text" id="detailEnvrnName" class="form-control" disabled>
                                                </div>
                                            </div>
					                         
					                        <div class="form-group col-md-12 py-sm-2" >
					                            <label for="inputDescription" class="col-sm-2 col-form-label">설명</label>
					                            <div class="col-sm-10">
					                                <textarea id="detailEnvrnDescription" class="form-control"style="width:85%;"></textarea>
					                            </div>
					                        </div>                      
					                    </div>
					                    <div class="float-right" >
					                        <button type="button" class="btn btn-primary" id="cancel" >목록으로</button>
											    <c:if test="${txScreenAuthor != null}">
											        <c:if test="${txScreenAuthor.wrtngAuthor eq 'Y'}">
								                        <button type="button" class="btn btn-primary" id="envrnModify"style="margin: 0.2rem 0 0.2rem 0;">저장</button>
								                        <button type="button" class="btn btn-primary" id="envrnManage"style="margin: 0.2rem 0 0.2rem 0;">관리</button>
								                        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal-lg3"style="margin: 0.2rem 0 0.2rem 0;">삭제</button>
								                        <button type="button" class="btn btn-primary" id="envrnCancel"style="margin: 0.2rem 0 0.2rem 0;">취소</button>
								                    </c:if>
								                </c:if>
					                    </div>  
					            </div>
					        </div>
					    </div>
					</div>
					
					<div class="modal fade-dept" id="modal-lg3">
						<div class="modal-dialog modal-lg">
							<div class="modal-content">
								<div class="modal-header" style="background-color: #007bff;color: white;"><h5>삭제</h5></div>
								<div class="modal-body" >
								    <h5>해당 디바이스를 삭제하시겠습니까?</h5>
								</div>
								<div class="modal-footer justify-content-between">
								    <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
								    <button type="button" class="btn btn-primary" id="deleteEnvrn">삭제</button>
								</div>
							</div>
						</div>
					</div>
					
					
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
							
							var params = [];
					        if("${txScreenAuthor.untenantAuthor}" == 'Y'){
					            params.push({"id" : "cmpnyCd", "clsCd" : "0024"});    //회사
					        }else{
					            params.push({"id" : "cmpnyCd", "clsCd" : "0024", "disable" : "Y"});    //회사
					        }
					//       params.push({"id" : "cmpnyCd", "clsCd" : "0024"});    //회사
					
					        requestCmmnCd(params);
					        
						}
						
						/*
						 * 이벤트 바인딩
						 * @param
						 * @return
						 */
						function bindEvent() {
							
						    $("#cancel").on("click", function() {
						        $(".over").remove();
						    });
						    
						    $("#envrnCancel").on("click", function() {
						        $(".over").remove();
						    });
						    
						    $("#envrnModify").on("click", function() {
						    	envrnModify();
						    });
						    
						    $("#envrnManage").on("click", function() {
						    	envrnManage();
						    });
						    
						    $("#deleteEnvrn").on("click", function() {
						    	console.log('삭제버튼 클릭');
						    	$("#modal-lg3").modal("hide");
						    	checkRobotList();
						    });
						}
					
						/*
					     * 환경 삭제 전 로봇 목록 조회
					     * @param
					     * @return
					     */
					    function checkRobotList() {
					        var url = "/resrce/envrn/getEnvrnRobotList";
					        var param = new Object();                                      
					        param.id = registerEnvrnId;          
					        callAsyncAjax(url,param,'deleteEnvrn');
					     }
						
						/*
						 * 환경 삭제
						 * @param
						 * @return
						 */
						function deleteEnvrn(data) {
							console.log(data);
							if (data.result.length != 0) {
								alert("연결된 로봇을 해제해주세요.");
							} else {
								var id = $("#detailEnvrnId").val();
					            var url = "/resrce/envrn/deleteEnvrn";
					            var param = {"Id" : id};
					            console.log("envrn 삭제");
					            callSyncAjax(url,param,'closePOP');
							}
					     }
					     
						/*
						 * 환경 수정
						 * @param
						 * @return
						 */
					    function envrnModify() {
							console.log('envrn 수정');
							var url = "/resrce/envrn/updateEnvrn";
							var param = new Object();                                      
							param.Id                   = $("#detailEnvrnId").val();          
							param.Name                 = $("#detailEnvrnName").val();          
							param.Description          = $("#detailEnvrnDescription").val();          
							console.log(param);
							callAsyncAjax(url,param,'closePOP');
					    }
						
					    /*
					     * 환경 수정 - 로봇 리스트 관리
					     * @param
					     * @return
					     */
					    function envrnManage() {
							console.log('envrn 수정 로봇 리스트 관리');
							var url = "/resrce/envrn/getEnvrnRobotList";
							var param = new Object();                                      
							param.id = registerEnvrnId;          
							console.log(param);
							callAsyncAjax(url,param,'getRobotList');
					    }
					    
					    </script>
	                    <!--  템플릿 바디 끝 -->    

	                    </div>
	             </section>
             <!-- /.Main content -->
            </div>
            
            <div id="footer">
                <footer class="main-footer">Copyright &copy; 2020 <a href="http://www.echoit.co.kr">에코아이티</a>&nbsp;.&nbsp;All rights reserved.</footer>
            </div>
            
        </div>
    </body>
</html>