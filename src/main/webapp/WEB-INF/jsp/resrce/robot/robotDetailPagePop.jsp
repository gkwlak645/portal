<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    <div class="card card-primary" id="cardDiv">
        <div class="card-header">
            <h3 class="card-title">상세조회</h3>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-12">
                    <div class="form-group">
                        <label for="detailCmpny">회사<b style="color: red;">*</b></label>
                        <div class="col-sm-3">
                            <select class="form-control" id="detailCmpny" disabled>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="deviceId">머신 <b style="color: red;">*</b></label>
                        <div class="col-sm-3">
                            <input type="hidden" id="deviceId">
                            <input type="text" id="deviceName" class="form-control" disabled>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="robotName">이름 <b style="color: red;">*</b></label>
                        <div class="col-sm-3">
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
                        <label for="robotType">형식<b style="color: red;">*</b></label>
                        <div class="col-sm-3">
                            <select id="robotType" class="form-control" disabled>
                             </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="userName">사용자명<b style="color: red;">*</b></label>
                        <div class="col-sm-3">
                             <input type="text" id="userName" class="form-control" disabled>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="robotPW">암호<b style="color: red;">*</b></label>
                        <div class="col-sm-3">
                             <input type="password" id="robotPW" class="form-control" onkeyup="fnChkByte(this, 100);">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="ip">아이피<b style="color: red;">*</b></label>
                        <div class="col-sm-3">
                             <input type="text" id="ip" class="form-control" onkeyup="fnChkByte(this, 60);" required>
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
	    	
        	var params = [];
            if("${txScreenAuthor.untenantAuthor}" == 'Y'){
                params.push({"id" : "detailCmpny", "clsCd" : "0024", "disable" : "Y"});    //회사
            }else{
                params.push({"id" : "detailCmpny", "clsCd" : "0024", "disable" : "Y"});    //회사
            }
//           params.push({"id" : "detailCmpny", "clsCd" : "0024"});    //회사

            params.push({"id" : "robotType", "clsCd" : "0006"});    //로봇유형

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
            
            $("#deviceCancel").on("click", function() {
            	$(".over").remove();
            });
            
            $("#robotDescription").on('keyup', function(){
                if($(this).val().length > 500){
                    $(this).val($(this).val().substring(0, 500));
                    alert("최대 입력 글자 수는 500입니다.");
                }
            });
            
            $("#robotModify").on("click", function() {
            	if($("#robotName").val() == null || $("#robotName").val() == '') {
                    alert("로봇명을 입력해주세요.");
                } else if($("#robotType").val() == null || $("#robotType").val() == '') {
                    alert("로봇유형을 선택해주세요.");
                } else if($("#userName").val() == null || $("#userName").val() == '') {
                    alert("사용자명을 입력해주세요.");
                } else if($("#robotPW").val() == null || $("#robotPW").val() == '') {
                    alert("암호를 입력해주세요.");
                } else if($("#ip").val() == null || $("#ip").val() == '') {
                    alert("아이피를 입력해주세요.");
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
        
        /*
         * 로봇 삭제
         * @param
         * @return
         */
		function deleteRobot(){
			var robotId = $("#robotId").val();
			var url = "/resrce/robot/deleteRobot";
			var param = {
					  "Id" : robotId
					, "cmpnyCd" : $("#detailCmpny").val()
				};
			console.log("robot 삭제");
			console.log(param);
			callAsyncAjax(url,param,'closePOP');
		}
         
		function robotModify(){
			console.log('device 수정');
			var url = "/resrce/robot/updateRobot";
			var pw  = $("#robotPW").val();
			var param = new Object();
			
			param.cmpnyCd        = $("#detailCmpny").val();
			param.MachineId      = $("#deviceId").val();          
// 			param.MachineName    = $("#deviceName").val();          
			param.Id             = $("#robotId").val();          
			param.Name           = $("#robotName").val();          
			param.Description    = $("#robotDescription").val();   
			param.Type           = $("#robotType").val();
			param.Username       = $("#userName").val();
			param.HostingType    = 'Standard';
			param.RobotIp        = $("#ip").val();
		    param.Password= pw;
		    
			console.log(param);
			callAsyncAjax(url,param,'closePOP');
		}
         
    </script>