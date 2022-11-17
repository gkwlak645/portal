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
        <div class="content-wrapper">
            <!-- Content Header (Page header) -->
            <div class="content-header">
                <!-- .container-fluid -->
                <div class="container-fluid">
                    <div class="row mb-0">
                        <div class="col-sm-6">
                            <h1 class="m-0 text-dark">로봇관리</h1>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
                                <li class="breadcrumb-item">자원관리 / 로봇관리</li>
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
				<div class="card card-primary" id = "cardDiv">
					<div class="card-header">
						<h3 class="card-title">등록</h3>
					</div>
					<div class="card-body">
						<div class="row">
							<div class="col-md-6">
							    <div class="form-group">
			                        <label for="rgstCmpny">회사 <b style="color: red;">*</b></label>
			                        <div class="col-4">
			                            <select class="col-sm-7" id="rgstCmpny">
			                             </select>
			                        </div>
			                    </div>
							    <div class="form-group">
			                        <label for="deviceId">디바이스 <b style="color: red;">*</b></label>
			                        <div class="col-4">
			                            <select class="form-control" id="deviceId" required>
			                            </select>
			                        </div>
			                    </div>
								<div class="form-group">
									<label for="robotName">로봇명 <b style="color: red;">*</b></label>
									<div class="col-4">
										<input type="text" id="robotName" class="form-control" required>
									</div>
								</div>
								<div class="form-group">
									<label for="robotDescription">설명</label>
									<div class="col-8">
									 <textarea id="robotDescription" class="form-control"  ></textarea>
									</div>
								</div>
								<div class="form-group">
									<label for="robotType">로봇유형<b style="color: red;">*</b></label>
									<div class="col-4">
										<select id="robotType" class="form-control">
										 </select>
									</div>
								</div>
								<div class="form-group">
			                        <label for="userName">사용자명<b style="color: red;">*</b></label>
			                        <div class="col-4">
			                             <input type="text" id="userName" class="form-control" required>
			                        </div>
			                    </div>
			                    <div class="form-group">
			                        <label for="robotPW">패스워드</label>
			                        <div class="col-4">
			                             <input type="text" id="robotPW" class="form-control" onkeyup="fnChkByte(this, 100);">
			                        </div>
			                    </div>
			                    <div class="form-group">
			                        <label for="ip">아이피<b style="color: red;">*</b></label>
			                        <div class="col-4">
			                             <input type="text" id="ip" class="form-control" onkeyup="fnChkByte(this, 60);" required>
			                        </div>
			                    </div>
								<div class="float-right">
									<button type="button" class="btn btn-primary" id="robotRegister">등록</button>
									&nbsp;
									<button type="button" class="btn btn-primary" id="cancel">닫기</button>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				
				
			<script>
			
					$(document).ready(function() {
						
						pageInit();
						
						bindEvent();
						
					});
			
					function pageInit() {
						
						var params = [];
				        if("${txScreenAuthor.untenantAuthor}" == 'Y'){
				            params.push({"id" : "rgstCmpny", "clsCd" : "0024"});    //회사
				        }else{
				            params.push({"id" : "rgstCmpny", "clsCd" : "0024", "disable" : "Y", "selectValue": "${sessionUserInfo.txCmpnyCd}"});    //회사
				        }
			//	         params.push({"id" : "rgstCmpny", "clsCd" : "0024"});    //회사
			
			            params.push({"id" : "robotType", "clsCd" : "0006"});    //로봇유형
				        requestCmmnCd(params);
						
						getDeviceList();
					}
			
					function bindEvent() {
						
						$("#robotName").on('keyup', function(){
			                if($(this).val().length > 255){
			                    $(this).val($(this).val().substring(0, 255));
			                    alert("최대 입력 글자 수는 255입니다.");
			                }
			            });
						
						$("#robotDescription").on('keyup', function(){
			                if($(this).val().length > 500){
			                    $(this).val($(this).val().substring(0, 500));
			                    alert("최대 입력 글자 수는 500입니다.");
			                }
			            });
						
						$("#userName").on('keyup', function(){
			                if($(this).val().length > 100){
			                    $(this).val($(this).val().substring(0, 100));
			                    alert("최대 입력 글자 수는 100입니다.");
			                }
			            });
						
						$("#robotRegister").on("click", function() {
						 	 if($("#deviceId").val() == null || $("#deviceId").val() == ''){
			                    alert("디바이스를 선택해주세요.");
			                    return
			                } else if($("#rgstCmpny").val() == null || $("#rgstCmpny").val() == '') {
			                    alert("회사를 입력해주세요.");
			                    return
			                } else if($("#robotName").val() == null || $("#robotName").val() == '') {
			                    alert("로봇명을 입력해주세요.");
			                    return
			                } else if($("#robotType").val() == null || $("#robotType").val() == '') {
			                    alert("로봇유형을 선택해주세요.");
			                    return
			                } else if($("#userName").val() == null || $("#userName").val() == '') {
			                    alert("사용자명을 입력해주세요.");
			                    return
			                } else if($("#ip").val() == null || $("#ip").val() == '') {
			                	alert("IP 입력해주세요.");
			                    return
			                } else {
			                	idDplctCheck($("#robotName").val());   
			                	
			                } 
						 	
						});
						
						$("#cancel").on("click", function() {
							$(".over").remove();
						});
					        
					} 
					
					function fnChkByte(obj, max) {
			            var maxByte = max; //최대 입력 바이트 수
			            var str = obj.value;
			            var str_len = str.length;
			         
			            var rbyte = 0;
			            var rlen = 0;
			            var one_char = "";
			            var str2 = "";
			         
			            for (var i = 0; i < str_len; i++) {
			                one_char = str.charAt(i);
			         
			                if (escape(one_char).length > 4) {
			                    rbyte += 2; //한글2Byte
			                } else {
			                    rbyte++; //영문 등 나머지 1Byte
			                }
			         
			                if (rbyte <= maxByte) {
			                    rlen = i + 1; //return할 문자열 갯수
			                }
			            }
			         
			            if (rbyte > maxByte) {
			                alert("최대 한글 " + (maxByte / 2) + "자, 영문 " + maxByte + "자를 초과 입력할 수 없습니다.");
			                str2 = str.substr(0, rlen); //문자열 자르기
			                obj.value = str2;
			                fnChkByte(obj, maxByte);
			            } else {
			                document.getElementById('byteInfo').innerText = rbyte;
			            }
			        }
					
					function robotRegister() {
						
						
						var url = "/resrce/robot/registerRobot";
						var pw  = $("#robotPW").val();
						var param = new Object();
			
			// 			param.cmpnyCd      = $("#rgstCmpny").val();
						param.MachineId    = $("#deviceId").val();
						param.Name         = $("#robotName").val();
						param.HostingType  = 'Standard';
						param.Description  = $("#robotDescription").val();
						param.Type         = $("#robotType").val();
						param.Username     = $("#userName").val();
						param.RobotIp      = $("#ip").val();
					
						if(pw != ''){
			                param.Password = pw;       
			            }
						console.log(param);
						callSyncAjax(url, param, 'closePOP');
					}
					//device 리스트 가져오기
					function getDeviceList() {
						var url = "/resrce/device/getDeviceNameList"
						var param = '';
						callAsyncAjax(url, param, 'drawCombo');
			        }
			        //디바이스 콤보박스   
					function drawCombo(data){
			            var deviceList = data.result;
			
			            var resultCategory = "<option selected disabled>디바이스 선택</option>";	
			            
			            for(var i in deviceList){
				            resultCategory += "<option value=" + deviceList[i].id + ">"
								            +deviceList[i].name
								            + "</option>"; 
			            }
			            document.getElementById("deviceId").innerHTML = resultCategory;
					}
			        
					function idDplctCheck(name){
			            var url = "/resrce/robot/idDplctCheck";
			            var param = {"name" : name};
			            callAsyncAjax(url, param, 'idDplctCheckSuc');
			        }
			       
			        function idDplctCheckSuc(data){
			            console.log("데이터 넘어오는 값 1:" + data);
			            console.log("데이터 넘어오는 값 chk:" + data.result.chk);
			            if(data.result.chk == "N"){
			                robotRegister();
			            }else{
			                alert("이미 존재하는 로봇명입니다.");
			                $("#robotName").val("").focus();
			                return false;               
			            }
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