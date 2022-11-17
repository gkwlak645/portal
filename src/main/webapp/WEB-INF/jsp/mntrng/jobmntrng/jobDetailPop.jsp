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
                <form class="form-inline">
	                <div class="form-group col-md-6 py-sm-2">
	                    <label for="inputName" class="col-sm-4 col-form-label">프로세스</label>
	                    <div class="col-sm-8">
		                    <input type="hidden" id="jobId">
		                    <input type="text" id="processName" class="form-control" disabled />
	                    </div>
	                </div>
	                <div class="form-group col-md-6 py-sm-2">
	                    <label for="inputName" class="col-sm-4 col-form-label">환경</label>
	                    <div class="col-sm-8">
		                    <input type="text" id="environmentName" class="form-control" disabled />
	                    </div>
	                </div>
	                <div class="form-group col-md-6 py-sm-2">
	                    <label for="inputName" class="col-sm-4 col-form-label">로봇</label>
	                    <div class="col-sm-8">
	                        <input type="text" id="robotName" class="form-control" disabled />
	                    </div>
	                </div>
	                <div class="form-group col-md-6 py-sm-2">
	                    <label for="inputName" class="col-sm-4 col-form-label">머신 이름</label>
	                    <div class="col-sm-8">
	                        <input type="text" id="machineName" class="form-control" disabled />
	                    </div>
	                </div>
	                <div class="form-group col-md-6 py-sm-2">
	                    <label for="inputName" class="col-sm-4 col-form-label">시작시간</label>
	                    <div class="col-sm-8">
	                        <input type="text" id="startTime" class="form-control" disabled />
	                    </div>
	                </div>
	                <div class="form-group col-md-6 py-sm-2">
	                    <label for="inputName" class="col-sm-4 col-form-label">종료시간</label>
	                    <div class="col-sm-8">
	                        <input type="text" id="endTime" class="form-control" disabled />
	                    </div>
	                </div>
	                <div class="form-group col-md-12 py-sm-2">
	                    <label for="inputName" class="col-sm-2 col-form-label">정보</label>
	                    <div class="col-sm-10">
		                    <textarea id="info" class="form-control" rows="5" style="min-width:100%;" disabled>
		                    </textarea>
	                    </div>
	                </div>
                </form>
                <div class="float-right">
                    <button type="button" class="btn btn-primary" id="cancel">목록으로</button>
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
	
	}
	
	/*
	 * 데이터 조회
	 * @param
	 * @return
	 */
	function getDetailData(jobId) {
		var param = {"id" : jobId};
		callSyncAjax("/mntrng/jobmntrng/getJobDetail", param, "printDetailData");
	}
	
    /*
     * 데이터 출력
     * @param
     * @return
     */
	function printDetailData(data) {
    	
    	if (data != null &&  data.result != null) {
    		$("#jobId").val(data.result.id);
    		$("#processName").val(data.result.processName);
    		$("#environmentName").val(data.result.environmentName);
    		$("#robotName").val(data.result.robotName);
    		$("#machineName").val(data.result.machineName);
    		$("#info").val(data.result.info);
    		$("#startTime").val(data.result.startTime);
    		$("#endTime").val(data.result.endTime);
    	}
		
	}

</script>