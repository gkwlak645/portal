<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="card card-primary">
    <div class="card-header">
        <h3 class="card-title">프로세스 설정</h3>
    </div>
    <div class="card-body">
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label>표시이름</label>
                    <div class="col-6">
                        <input type="hidden" id="id" name="id" value="" />
                        <input type="text" id="name" class="form-control" name="id" value="" />
                    </div>
                </div>
                <div class="form-group">
                    <label>우선순위</label>
                    <div class="col-6">
                        <input type="hidden" id="jobPriority">
                        <select id="cmbJobPriority" class="form-control">
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label>프로세스를 자동으로 시작</label>
                    <div class="col-6">
                         <input type="checkbox" id="cbxAutoStartProcess" class="form-control">
                    </div>
                </div>
                <div class="float-right">
                    <c:if test="${txScreenAuthor != null}">
                        <c:if test="${txScreenAuthor.wrtngAuthor eq 'Y'}">
                            <button type="button" class="btn btn-primary" id="btnSave">저장</button>&nbsp;
                        </c:if>
                        <button type="button" class="btn btn-primary" id="btnCancel">취소</button>
                    </c:if>
                </div>
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
    	
    	//콤보 데이터 조회
        var param = {"clsCd" : "0010"};
        callSyncAjax("/stdrinfo/cmmncd/getCmmnCdListByClsCd", param, "setJobPriority");

    }
    
    /*
     * 이벤트 바인딩
     * @param
     * @return
     */
    function bindEvent() {
    	
    	
        $("#btnSave").on("click", function() {
            updateProcessEstbs();
        });
    	
        $("#btnCancel").on("click", function() {
            closePOP();
        });
    }
    
    /*
     * 우선순위 콤보 설정
     * @param
     * @return
     */
    function setJobPriority(data) {
        $.each(data.result, function(idx, cd) {
            $("#cmbJobPriority").append("<option value='" + cd.cd + "'>" + cd.cdNm + "</option>");
        });
        $("#cmbJobPriority").val($("#jobPriority").val());
    }
    
    /*
     * 데이터 조회
     * @param
     * @return
     */
    function getEstbsData(processId) {
        var param = {"id" : processId};
        callSyncAjax("/resrce/process/getProcessEstbs", param, "printEstbsData");
    }
    
    /*
     * 데이터 출력
     * @param
     * @return
     */
    function printEstbsData(data) {

        if (data != null &&  data.result != null) {
        	$("#id").val(data.result.id);
        	$("#name").val(data.result.name);
        	$("#jobPriority").val(data.result.jobPriority);
        	if (data.result.autoStartProcess) {
        		$("#cbxAutoStartProcess").prop("checked", true);
        	}
        }
    }
    
    /*
     * 프로세스 설정 저장
     * @param
     * @return
     */
    function updateProcessEstbs() {
    	
    	var autoStartProcess = false;
    	if ($("#cbxAutoStartProcess").is(":checked")) {
    		autoStartProcess = true;
    	}
    	var param = {
    			"id" : $("#id").val()
    		  , "name" : $("#name").val()
    		  , "jobPriority" : $("#cmbJobPriority").val()
    		  , "autoStartProcess" : autoStartProcess
    	
    	};
    	callSyncAjax("/resrce/process/updateProcessEstbs", param, null);
    }



</script>