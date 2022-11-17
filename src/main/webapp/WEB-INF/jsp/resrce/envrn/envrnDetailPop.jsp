<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="card card-primary" id = "cardDiv">
    <div class="card-header" alt="자원>환경관리 상세">
        <h3 class="card-title">상세조회</h3>
    </div>
     <div class="card-body" style="height:560px; overflow:auto;">
            <div class="row">
                <div class="col-md-12">
                
                    <div class="form-inline">
                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                            <label class="col-sm-4 col-form-label">회사 <b style="color: red;">*</b></label>
                            <div class="col-sm-8">
	                            <select class="form-control" id="cmpnyCd" style="width:50%;margin-right: 3px;">
	                            </select>
                            </div>
                         </div>
                    </div>
                    <div class="form-inline"> 
                         <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                            <label class="col-sm-4 col-form-label" for="inputName">이름 <b style="color: red;">*</b></label>
                            <div class="col-sm-8">
                                <input type="hidden" id="detailEnvrnId">
                                <input style="width:50%;margin-right: 3px;"type="text" id="detailEnvrnName" class="form-control" disabled>
                            </div>
                        </div>
                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                            <label for="inputDescription" class="col-sm-4 col-form-label">설명</label>
                            <div class="col-sm-8">
                                <input style="width:80%;margin-right: 3px;"type="text" id="detailEnvrnDescription" class="form-control">
                            </div>
                        </div>                      
                    </div>
                    <div class="float-right" style="margin:15px 0 15px 2px;">
                        <button type="button" class="btn btn-primary" id="cancel" style="margin: 0.2rem 0 0.2rem 0;">목록으로</button>
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
			    <h5>해당 환경을 삭제하시겠습니까?</h5>
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
            params.push({"id" : "cmpnyCd", "clsCd" : "0024", "disable" : "Y"});    //회사
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
        param.cmpnyCd = $("#cmpnyCd").val();   
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
            var param = {
            		  "Id" : id
            		, "cmpnyCd" : $("#cmpnyCd").val()
            	};
            console.log(param);
            console.log("envrn 삭제");
            callAsyncAjax(url,param,'closePOP');
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
		param.cmpnyCd              = $("#cmpnyCd").val();          
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
		param.cmpnyCd = $("#cmpnyCd").val(); 
		param.id = registerEnvrnId;          
		console.log(param);
		callAsyncAjax(url,param,'getRobotList');
    }
    
 </script>