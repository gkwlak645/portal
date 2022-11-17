<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
            <nav class="main-header navbar navbar-expand border-bottom-0 navbar-dark navbar-primary text-sm">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" data-widget="pushmenu" href="#" role="button">
                            <i class="fas fa-bars"></i>
                        </a>
                    </li>
                </ul>
                <ul class="navbar-nav ml-auto">
                    <!-- Messages Dropdown Menu -->
                    <li class="nav-item">
                        <a></a>
                    </li>  
                </ul>
            </nav>
            <!-- / Navbar -->
        </div>

        <jsp:include page="/template/menu.jsp"></jsp:include>

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper" >
            <!-- Content Header (Page header) -->
            <div class="content-header">
                <!-- .container-fluid -->
                <div class="container-fluid">
                    <div class="row mb-0">
                        <div class="col-sm-6">
                            <h1 class="m-0 text-dark">연계시스템관리</h1>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
                                <li class="breadcrumb-item">기준정보 / 연계시스템관리</li>
                            </ol>
                        </div>
                    </div>
                </div>
                <!-- /.container-fluid -->
            </div>
            <!-- /.content-header -->


            <!-- Main content -->
            <section class="content">
                <div id="content">                
                
                
                <!--  템플릿 바디 -->
				<div class="card card-primary" id="cardDiv" style="min-height: 654px;">
					<div class="card-header">
						<h3 class="card-title">연계시스템 등록</h3>
					</div>
					<div class="card-body">
						<div class="row">
							<div class="col-md-12">
								<form class="form-inline">
									<div class="form-group col-md-6 py-sm-2">
										<label class="col-sm-4 col-form-label"> 분류<b
											style="color: red; padding-left: 10px;">*</b></label>
										<div class="col-sm-8">
											<select id="cntcType1" class="form-control"style="margin-right:5px;width:70%" >
												<option selected disabled>선택</option>
												<option value="01">공통</option>
												<option value="02">회사별</option>
											</select>
										</div>
									</div>
									<div class="form-group col-md-6 py-sm-2">
										<label class="col-sm-4 col-form-label"> 회사<b
											style="color: red; padding-left: 10px;">*</b></label>
										<div class="col-sm-8">
											<select id="cmpny" class="form-control"style="width:70%" >
												<option selected disabled>선택</option>
												<option value="I">동원산업</option>
												<option value="X">동원로엑스</option>
												<option value="F">동원FnB</option>
												<option value="H">동원홈푸드</option>
												<option value="C">동원시스템즈</option>
												<option value="T">테크팩솔루션</option>
												<option value="A">동원건설산업</option>
											</select>
										</div>
									</div>
									<div class="form-group col-md-6 py-sm-2">
										<label class="col-sm-4 col-form-label">시스템코드<b
											style="color: red; padding-left: 10px;">*</b></label>
										<div class="col-sm-8">
											<input type="text" id="sysCd" class="form-control" style="width:70%"/>
										</div>
									</div>
									<div class="form-group col-md-6 py-sm-2">
										<label class="col-sm-4 col-form-label">시스템명<b
											style="color: red; padding-left: 10px;">*</b></label>
										<div class="col-sm-8">
				
											<input value="text" id="sysNm" class="form-control" style="width:70%">
				
										</div>
									</div>
									<div class="form-group col-md-12 py-sm-2">
										<label class="col-sm-2 col-form-label">설명</label>
										<div class="col-10">
											<textarea id="sysDc" class="form-control" style="width:89%" ></textarea>
										</div>
									</div>
									<div class="form-group col-md-12 py-sm-2">
										<label class="col-sm-2 col-form-label">사용여부</label>
										<div class="col-6">
											<select id="use" class="form-control"style="width:45.6%">
												<option value="Y">사용</option>
												<option value="N">미사용</option>
				
											</select>
										</div>
									</div>
								</form>
								<div class="float-right">
									<button type="button" class="btn btn-primary" id="btnRegist">등록</button>
									<button type="button" class="btn btn-primary" id="btnClose">닫기</button>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				
				<script>
					$(document).ready(function() {
				
						bindEvent();
						pageInit();
					});
					
					function pageInit(){
						
						
						
					}
					
					
				
					function bindEvent() {
						    
				
						$("#btnClose").on("click", function() {
							$(".over").remove();
						});
					
						$("#btnRegist").on("click", function() {
							if($("#cntcType1").val() == null || $("#cntcType1").val() == ''){
				                alert("분류를 선택해주세요.");
				                return
				            } else if($("#cntcType1").val() == '02' && ($("#cmpny").val() == '' || $("#cmpny").val() == null)) {
				                alert("회사를 입력해주세요.");
				                return
				            } else if($("#sysCd").val() == '' || $("#sysCd").val() == null) {
				                alert("시스템코드를 입력해주세요.");
				                return
				            } else{
				            	   cntcRegister();
				                   getCntcSysList();         	
				            } 
							
							
							
							
						
					    });
						
						//코드 자동채번 
						$("#cmpny").on("change", function(){
							var url = '/stdrinfo/cntcsys/autoNumSelect';
							var param = {
									Tenant : $("#cmpny").val()
							       }
							callAsyncAjax(url,param,"pirntcode");			
						});
						
						$("#cntcType1").on("change", function(){
							if($("#cntcType1").val() == "01"){
								
								
								$("#cmpny").attr('disabled', true);
								
								var url = '/stdrinfo/cntcsys/autoNumSelect';
								var param = {
					                    Tenant : "Z"
					                   }
								callAsyncAjax(url,param,"pirntcode");
							}			
						});
						
						
						$("#cntcType1").on("change", function(){
				            if($("#cntcType1").val() == "02"){
				                           
				                $("#cmpny").attr('disabled', false);
						
				            }
						
					});
					
					}
					//연계시스템 등록
					function cntcRegister(){
						
						console.log('연계시스템 등록');
						
						var url = "/stdrinfo/cntcsys/cntcRegister";
				        var param = new Object();		
						
				        param.CntcType = $("#cntcType1").val();
				        param.Tenant = $("#cmpny").val();
				        param.SysCd = $("#sysCd").val();
				        param.SYsNm = $("#sysNm").val();
				        param.SysDc = $("#sysDc").val();
				        param.Use = $("#use").val();
				       
				        console.log(param);
				        
				        callSyncAjax(url, param, 'closePOP');
				  	}
					
					//닫기
					   function closePOP(){
					        $(".over").remove();
					       
					    }
					
					//코드 자동채번 print
					   function pirntcode(data){
						   
						   console.log(data.result.NEXT_CD);
						 $("#sysCd").val(data.result.NEXT_CD);   
						   		   
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



