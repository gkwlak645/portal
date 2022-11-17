<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    <div class="card card-primary" id="cardDiv">
        <div class="card-header">
            <h3 class="card-title">상세조회</h3>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="tenant">회사<b style="color: red;">*</b></label>
                        <div class="col-4">
                            <select class="form-control" id="tenant" disabled>
                                    <option selected disabled>계열사선택</option>
                                    <option value="1">동원산업</option>
                                    <option value="X">동원로엑스</option>
                                    <option value="F">동원FnB</option>
                                    <option value="H">동원홈푸드</option>
                                    <option value="C">동원시스템즈</option>
                                    <option value="T">테크팩솔루션</option>
                                    <option value="A">동원건설산업</option>
                                </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="deviceId">디바이스 <b style="color: red;">*</b></label>
                        <div class="col-4">
                            <input type="hidden" id="deviceId">
                            <input type="text" id="deviceName" class="form-control" disabled>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="robotName">로봇명 <b style="color: red;">*</b></label>
                        <div class="col-4">
                            <input type="hidden" id="robotId">
                            <input type="text" id="robotName" class="form-control" disabled>
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
                            <select id="robotType" class="form-control" disabled>
                                 <option selected disabled>로봇유형 선택</option>
                                 <option value='0'>NonProduction</option>
                                 <option value='1'>Attended</option>
                                 <option value='2'>Unattended</option>
                                 <option value='3'>Studio</option>
                                 <option value='4'>StudioX</option>
                                 <option value='5'>StudioPro</option>
                                 <option value='6'>Testing</option>
                             </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="userName">사용자명<b style="color: red;">*</b></label>
                        <div class="col-4">
                             <input type="text" id="userName" class="form-control" disabled>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="robotPW">패스워드</label>
                        <div class="col-4">
                             <input type="password" id="robotPW" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="ip">아이피<b style="color: red;">*</b></label>
                        <div class="col-4">
                             <input type="text" id="ip" class="form-control" required>
                        </div>
                    </div>
                    
                    
                    <div class="float-right">
                        <button type="button" class="btn btn-primary" id="cancel">목록으로</button>
                        <c:if test="${txScreenAuthor != null}">
                            <c:if test="${txScreenAuthor.wrtngAuthor eq 'Y'}">
                                <button type="button" class="btn btn-primary" id="robotModify">저장</button>&nbsp;
                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal-lg3">삭제</button>&nbsp;
                                <button type="button" class="btn btn-primary" id="deviceCancel">취소</button>
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
				<div class="modal-header" style="background-color: #007bff;color: white;"><h5>삭제</h5>
				</div>
				<div class="modal-body" >
				    <h5>해당 로봇을 삭제하시겠습니까?</h5>
				</div>
				<div class="modal-footer justify-content-between">
				    <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
				    <button type="button" class="btn btn-primary" id="deleteRobot" data-dismiss="modal">삭제</button>
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
            
            $("#deviceCancel").on("click", function() {
            	closePOP();
            });
            
            $("#robotModify").on("click", function() {
            	if($("#robotName").val() == null || $("#robotName").val() == '') {
                    alert("로봇명을 입력해주세요.");
                } else if($("#robotType").val() == null || $("#robotType").val() == '') {
                    alert("로봇유형을 선택해주세요.");
                } else if($("#userName").val() == null || $("#userName").val() == '') {
                    alert("사용자명을 입력해주세요.");
                } else {
                	robotModify();
                }
            });
            
            $("#deleteRobot").on("click", function() {
            	console.log('삭제버튼 클릭');
            	$("#modal-lg3").modal("hide");
            	deleteRobot();
            });
        }
        
        /*
         * 로봇 삭제
         * @param
         * @return
         */
		function deleteRobot(){
			var robotId = $("#robotId").val();
			var url = "/resrce/robot/deleteRobot";
			var param = {"Id" : robotId};
			console.log("robot 삭제");
			console.log(param);
			callAsyncAjax(url,param,'closePOP');
		}
         
		function robotModify(){
			console.log('device 수정');
			var url = "/resrce/robot/updateRobot";
			var pw  = $("#robotPW").val();
			var param = new Object();
			param.MachineId      = $("#deviceId").val();          
// 			param.MachineName    = $("#deviceName").val();          
			param.Id             = $("#robotId").val();          
			param.Name           = $("#robotName").val();          
			param.Description    = $("#robotDescription").val();   
			param.Type           = $("#robotType").val();  
			param.Username       = $("#userName").val();
			param.HostingType    = 'Standard';
			param.RobotIp        = $("#ip").val();
			
			if (pw != '') {
			    param.Password= pw;
			} 0
			console.log(param);
			callAsyncAjax(url,param,'closePOP');
		}
         
    </script>