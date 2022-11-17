<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="card card-primary" id="cardDiv">
	<div class="card-header">
	    <h3 class="card-title">JOB 이력관리 사유 등록 및 수정</h3>
	</div>
	<div class="card-body">
	    <div class="row">
	        <div class="col-md-12">
	            <form class="form-inline" id=jobMngDetailPop>
					<input type="hidden" id="id" name="id"/>
					<input type="hidden" id="cmpnyCd" name="cmpnyCd"/>
					
					<div class="form-group col-md-6 py-sm-1">
                        <label for="detailCmpnyNm" class="col-sm-4 col-form-label">회사</label>
                        <div class="col-sm-8">
                            <input type="text" id="detailCmpnyNm" class="form-control" disabled style="width:80%;"/>
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-1">
                        <label for="detailJobId" class="col-sm-4 col-form-label">JOB ID</label>
                        <div class="col-sm-8">
                            <input type="text" id="detailJobId" class="form-control" disabled style="width:80%;"/>
                        </div>
                    </div>
					
                	<div class="form-group col-md-6 py-sm-1">
                        <label for="detailSearchStartDe" class="col-sm-4 col-form-label">시작 시간</label>
                        <div class="col-sm-8">
                            <input type="text" id="detailSearchStartDe" class="form-control" disabled style="width:80%;"/>
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-1">
                        <label for="detailSearchEndDe" class="col-sm-4 col-form-label">종료 시간</label>
                        <div class="col-sm-8">
                            <input type="text" id="detailSearchEndDe" class="form-control" disabled style="width:80%;"/>
                        </div>
                    </div>
                    
                    <div class="form-group col-md-6 py-sm-1">
                        <label for="detailProcessCd" class="col-sm-4 col-form-label">프로세스 코드</label>
                        <div class="col-sm-8">
                            <input type="text" id="detailProcessCd" class="form-control" disabled style="width:80%;"/>
                        </div>
                    </div>
                    
                    <div class="form-group col-md-6 py-sm-1">
                        <label for="detailProcessNm" class="col-sm-4 col-form-label">프로세스 명</label>
                        <div class="col-sm-8">
                            <input type="text" id="detailProcessNm" class="form-control" disabled style="width:100%;"/>
                        </div>
                    </div>
                                        
                    <div class="form-group col-md-6 py-sm-1">
                        <label for="detailRobotName" class="col-sm-4 col-form-label">로봇</label>
                        <div class="col-sm-8">
                            <input type="text" id="detailRobotName" class="form-control" disabled style="width:80%;"/>
                        </div>
                    </div>
                    
                    <div class="form-group col-md-6 py-sm-1">
                        <label for="detailSuccessAt" class="col-sm-4 col-form-label">JOB 상태<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8 float-left">
                            <select id="detailSuccessAt" class="form-control float-left" style="min-width: 40px;width:80%;">
                                <option value=""></option>
                            </select> 
                        </div>
                    </div>
                    
                    <div class="form-group col-md-6 py-sm-1">
                        <label for="detailSearchResn" class="col-sm-4 col-form-label">사유<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8 float-left">
                            <select id="detailResn" class="form-control float-left" style="min-width: 40px;width:80%;">
                                <option value=""></option>
                            </select> 
                        </div>
                    </div>
                    
                </form>
                <div class="py-sm-2 float-right" >
                    <%-- <c:if test="${txScreenAuthor.wrtngAuthor eq 'Y'}">
                        <button type="button" class="btn btn-primary" id="jobErrorSave" style="display:none">저장</button>
                    </c:if> --%>
                    <button type="button" class="btn btn-primary" id="btnSave">등록 및 수정</button>
                    <button type="button" class="btn btn-primary" id="btnCancel">닫기</button>
                </div>
                <div id="divSearchUser" class="modal fade" tabindex="-1" role="dialog"></div>
            </div>
        </div>
    </div>
</div>
    
<script>
var getSuccessAt;
var getResn;
var getCmpnyCd;

$(document).ready(function() {
	var makeComboBox = [];
	makeComboBox.push({"id" : "detailResn", "clsCd" : "0060"});    //사유
	makeComboBox.push({"id" : "detailSuccessAt" , "clsCd" : "0061"});    //JOB 상태
    requestCmmnCd(makeComboBox);	
	bindEvent();
	
	if(getSuccessAt != null && getSuccessAt != undefined && getResn != null && getResn != undefined) {
	    $("#detailSuccessAt").val(getSuccessAt).prop("selected", true);
	    $("#detailResn").val(getResn).prop("selected", true);
	}
	else {
		alert("사유와 JOB 상태를 불러올 수 없습니다.\n클릭하신 JOB의 ID를 관리자에게 말씀해주세요.");
	}
	
	// 쓰기 권한 없으면 사유나 JOB상태를 변경할 수 없음.
    <c:if test="${txScreenAuthor.wrtngAuthor eq 'N'}">
    $("#detailSuccessAt").attr("disabled",true);
    $("#detailResn").attr("disabled",true);
    </c:if>

    // 로딩 끝
    $('.dimmed').css({ display: 'none' });
    $('.loading').css({ display: 'none' });
    $('.loading').removeClass('show');
});
	
	/*
	 * 이벤트 바인딩
	 * @param
	 * @return
	 */
	function bindEvent() {
		// 저장
        $("#btnSave").on("click",function(){
            updateResn();
        });
		
		// 닫기
        $("#btnCancel").on("click",function(){
        	closePOP();
        });	
	}
	
	function updateResn() { 
        if($("#detailSuccessAt").val() == "" || $("#detailResn").val() == "") {
            alert("JOB 상태 또는 사유를 선택해주세요.");
            return false;
        }
        
        var url = "/mntrng/jobmng/updateJobMngResn";
        var userId = "${txUserId}";
     
        var param = {
              cmpnyCd   : getCmpnyCd
            , jobId     : $("#detailJobId").val()
            , processCd : $("#detailProcessCd").val()
            , resn      : $("#detailResn").val()
            , successAt : $("#detailSuccessAt").val()
            , updateId  : userId
        }; 
        
        callAsyncAjax(url, param, "updateJobMngResnCallback");
        
        // 로딩 시작
        $('.dimmed').css({ display: 'block' });
        $('.loading').css({ display: 'block' });
        $('.loading').addClass('show');
    }
    
    function updateJobMngResnCallback(){
        alert("등록 및 수정이 완료되었습니다.");       
        //closePOP();
        // 로딩 끝
        $('.dimmed').css({ display: 'none' });
        $('.loading').css({ display: 'none' });
        $('.loading').removeClass('show');
    }
</script>