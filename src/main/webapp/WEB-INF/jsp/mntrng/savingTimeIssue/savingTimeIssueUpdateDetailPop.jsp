<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="card card-primary" id="cardDiv">
	<div class="card-header">
	    <h3 class="card-title">사유 수정</h3>
	</div>
	<div class="card-body">
	    <div class="row">
	        <div class="col-md-12">
	            <form class="form-inline" id="jobErrorDetail">
					<input type="hidden" id="id" name="id"/>
					<input type="hidden" id="cmpnyCd" name="cmpnyCd"/>
					
					<div class="form-group col-md-6 py-sm-1">
                        <label for="pcd" class="col-sm-4 col-form-label">프로세스 코드</label>
                        <div class="col-sm-8">
                            <input type="text" id="pcd" class="form-control" disabled style="width:80%;"/>
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-1">
                        <label for="pnm" class="col-sm-4 col-form-label">프로세스 명</label>
                        <div class="col-sm-8">
                            <input type="text" id="pnm" class="form-control" disabled style="width:80%;"/>
                        </div>
                    </div>
					
                	<div class="form-group col-md-6 py-sm-1">
                        <label for="expectExcCnt" class="col-sm-4 col-form-label">예상수행횟수</label>
                        <div class="col-sm-8">
                            <input type="text" id="expectExcCnt" class="form-control" disabled style="width:80%;"/>
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-1">
                        <label for="realExcCnt" class="col-sm-4 col-form-label">수행횟수</label>
                        <div class="col-sm-8">
                            <input type="text" id="realExcCnt" class="form-control" disabled style="width:80%;"/>
                        </div>
                    </div>
                    
                    <div class="form-group col-md-6 py-sm-1">
                        <label for="succesCnt" class="col-sm-4 col-form-label">성공횟수</label>
                        <div class="col-sm-8">
                            <input type="text" id="succesCnt" class="form-control" disabled style="width:80%;"/>
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-1">
                        <label for="normalAt" class="col-sm-4 col-form-label">정상여부</label>
                        <div class="col-sm-8 float-left">
                            <select id="normalAt" class="form-control float-left" disabled style="min-width: 40px;width:50%;">
                                <option value=""></option>
                            </select> 
                        </div>
                    </div>
                    
                    <div class="form-group col-md-12 py-sm-1">
                        <label for="resn" class="col-sm-2 col-form-label">사유<b style="color: red;"> *</b></label>
                        <div class="col-sm-10">
                            <textarea rows="5" id="resn" class="form-control" maxlength="1000" style="width:92.5%;"></textarea>
                        </div>
                    </div>
                    
                </form>
                <div class="py-sm-2 float-right" >
                    <%-- <c:if test="${txScreenAuthor.wrtngAuthor eq 'Y'}">
                        <button type="button" class="btn btn-primary" id="jobErrorSave" style="display:none">저장</button>
                    </c:if> --%>
                    <button type="button" class="btn btn-primary" id="btnSave">저장</button>
                    <button type="button" class="btn btn-primary" id="btnCancel">닫기</button>
                </div>
                <div id="divSearchUser" class="modal fade" tabindex="-1" role="dialog"></div>
            </div>
        </div>
    </div>
</div>
    
<script>

$(document).ready(function() {
	var params = [];
    params.push({"id" : "normalAt", "clsCd" : "0059", "selectValue": normalAt});       
    requestCmmnCd(params);	
	bindEvent();
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
        if($("#resn").val() == null || $("#resn").val() == "" || $("#resn").val().length == 0) {
            alert("사유를 입력해주세요.");
            $("#resn").focus();
            return false;
        }
        
        var url = "/mntrng/savingTimeIssue/upadteSavingTimeIssueResn";
        var userId = "${txUserId}";
        
        /*
        value = value.replace(/\s+/, "");//왼쪽 공백제거
        value = value.replace(/\s+$/g, "");//오른쪽 공백제거
        value = value.replace(/\n/g, "");//행바꿈제거
        value = value.replace(/\r/g, "");//엔터제거
        */
        
        var input_resn = $("#resn").val().replace(/\n/g, "<br>");
        input_resn = input_resn.replace(/\s+/, "");
        input_resn = input_resn.replace(/\s+$/g, "");
        
        if(yyyymm.length != 6) {
            alert("날짜 형식이 잘못됐습니다.\nYYYYMM");
            return false;
        }

        var param = {
              cmpnyCd        : cmpnyCd
            , searchProcessCd: processCd
            , resn           : input_resn
            , normalAt       : $("#normalAt").val()
            , yyyymm         : $.trim(yyyymm)
            , updateId     : userId
        }; 
        
        callAsyncAjax(url, param, "updateSavingTimeResnCallback");
        
        // 로딩 시작
        $('.dimmed').css({ display: 'block' });
        $('.loading').css({ display: 'block' });
        $('.loading').addClass('show');     
    }
    
    
    function updateSavingTimeResnCallback(){
        alert("등록 완료되었습니다.");       
        closePOP();
        // 로딩 끝
        $('.dimmed').css({ display: 'none' });
        $('.loading').css({ display: 'none' });
        $('.loading').removeClass('show');
    }

</script>









