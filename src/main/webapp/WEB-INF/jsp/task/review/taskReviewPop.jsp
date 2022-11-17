<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="card card-primary" id = "cardDiv">
    <div class="card-header">
        <h3 class="card-title">과제요청</h3>
    </div>
    <div class="card-body">
        <div class="row">
            <div class="col-md-12">
                <div class="form-inline">
                    <div class="form-group col-md-12 py-sm-2">
                        <label class="col-sm-2 col-form-label">과제명 <b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8">
                            <input type="text" id="txtTaskNm" name="taskNm" class="form-control" style="width:100%" readonly/>
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-2">
                        <label class="col-sm-4 col-form-label">부서 <b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8">
                            <input type="text" id="txtChrgDeptNm" class="form-control" value="${txDeptNm}" readonly />
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-2">
                        <label class="col-sm-4 col-form-label">요청자 <b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8">
                            <input type="text" id="txtChargerUserNm" class="form-control" value="${txUserNm}" readonly />
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-2">
                        <label class="col-sm-4 col-form-label">과제빈도 <b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8">
                            <select id="cmbTaskFqCd" class="form-control" disabled>
                                <option value="">선택</option>
                            </select>
                            <input type="text" id="txtTaskFqCnt" class="form-control" value="" style="text-align:right;" readonly />&nbsp;&nbsp;회
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-2">
                        <label class="col-sm-4 col-form-label">건별처리시간 <b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8">
                            <input type="text" id="txtCsbyProcessTm" class="form-control" value="" style="text-align:right;" readonly />
                            <select id="cmbProcessTmUnit" class="form-control" disabled>
                                <option value="">선택</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-2">
                        <label class="col-sm-4 col-form-label">처리인원 <b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8">
                            <input type="text" id="txtProcessNp" class="form-control" value="" style="text-align:right;" readonly />&nbsp;&nbsp;명
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-2">
                        <label class="col-sm-4 col-form-label">총과제시간 </label>
                        <div class="col-sm-8">
                            <input type="text" id="txtTotTaskTm" class="form-control" value="" readonly />
                        </div>
                    </div>
                    <div class="form-group col-md-12 py-sm-2">
                        <label class="col-sm-2 col-form-label">과제설명 </label>
                        <div class="col-sm-10">
                            <textarea id="txtTaskDc"  class="form-control" rows="5" style="width:100%;" readonly></textarea>
                        </div>
                    </div>
                    <div id="divTaskPrcuseSys" class="form-group col-md-12 py-sm-2">
                        <label class="col-sm-2 col-form-label">활용시스템 </label>
                    </div>
                    <div class="form-group col-md-12 py-sm-2">
                        <label class="col-sm-2 col-form-label">첨부파일 </label>
                        <div id="fileUpload" class="col-sm-10"></div>
                    </div>
                    <div class="form-group col-md-6 py-sm-2">
                        <label class="col-sm-4 col-form-label">상태</label>
                        <div class="col-sm-4">
                            <input class="form-check-input" type="radio" name="sttus" />
                            <label class="form-check-label">접수</label>
                        </div>
                        <div class="col-sm-4">
                            <input class="form-check-input" type="radio" name="sttus" />
                            <label class="form-check-label">반려</label>
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-2">
                        <label class="col-sm-4 col-form-label">설계자</label>
                        <div class="col-sm-8">
                            <input type="text" id="txtDsgnrUserNm" class="form-control" value="" />
                        </div>
                    </div>
                    <div class="form-group col-md-12 py-sm-2">
                        <label class="col-sm-2 col-form-label">검토내용</label>
                        <div class="col-sm-10">
                            <textarea id="txtReviewOpin"  class="form-control" rows="5" style="width:100%;"></textarea>
                        </div>
                    </div>
                </div>
                <div class="float-right">
                    <button type="button" class="btn btn-primary" id="btnSave">반영</button>
                    <button type="button" class="btn btn-primary" id="btnCancel">취소</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>

    var upload = new RpaUpload("fileUpload");

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
        
        callSyncAjax("/stdrinfo/cmmncd/getCmmnCdListByClsCd", {clsCd : "0023"}, "printTaskPrcuseSys");
        
        //공통코드 조회
        var params = [];
        params.push({"id" : "cmbTaskFqCd", "clsCd" : "0021"});
        params.push({"id" : "cmbProcessTmUnit", "clsCd" : "0022"});
        requestCmmnCd(params);
    }
    
    /*
     * 이벤트 바인딩
     * @param
     * @return
     */
    function bindEvent() {

        
        $("#btnCancel").on("click", function(e) {
            closePOP();
        });
    
    }
    
    /*
     * 활용시스템 체크박스 출력
     * @param
     * @return
     */
    function printTaskPrcuseSys(data) {
        
        if (data != null &&  data.result != null) {
            $.each(data.result, function(idx, item) {
                $("#divTaskPrcuseSys").append('<div class="form-check"><input class="form-check-input" type="checkbox" id="chkPrcuseSys'+item.cd+'" value="'+item.cd+'" disabled><label class="form-check-label">'+item.cdNm+'</label></div>&nbsp;&nbsp;&nbsp;&nbsp;');
            });
        }
    }
    
    /*
     * 검토 페이지 데이터 출력
     * @param
     * @return
     */
    function printTaskReview(data) {

        var task = data.result;
        $("#txtTaskNm").val(task.task.taskNm);
        $("#cmbTaskFqCd").val(task.task.taskFqCd);
        $("#txtTaskFqCnt").val(task.task.taskFqCnt);
        $("#txtCsbyProcessTm").val(task.task.csbyProcessTm);
        $("#cmbProcessTmUnit").val(task.task.processTmUnit);
        $("#txtProcessNp").val(task.task.processNp);
        
        printTotProcessTm();
        
        $("#txtTaskDc").val(task.task.taskDc);
        
        if (task.task.taskPrcuseSysList != null && task.task.taskPrcuseSysList.length > 0) {
        	$.each(task.task.taskPrcuseSysList, function(idx, item){
        		$("input[id^=chkPrcuseSys]").each(function() {
        	        if (item.prcuseSysCd == $(this).val()) {
        	            $(this).prop("checked", true);
        	        }
        	    });
        	});
        }
        
        upload.draw(task.task.fileGrpNo, false);
        
        $("#txtSttusNm").val(task.taskReview.sttusNm);
        $("#txtDsgnrUserNm").val(task.task.dsgnrUserNm);
        $("#txtReviewOpin").val(task.taskReview.reviewOpin);

    }
    
    /*
     * 총과제시간 출력
     * @param
     * @return
     */
    function printTotProcessTm() {
        if ($("#cmbTaskFqCd").val() != "" && $("#cmbProcessTmUnit").val() != "" && $("#txtTaskFqCnt").val() != "" && $("#txtCsbyProcessTm").val() != "" && $("#txtProcessNp").val() != "") {
            var processTm = Number($("#txtCsbyProcessTm").val()) * Number($("#txtProcessNp").val());
            var totTaskTm = $("#cmbTaskFqCd option:checked").text() + $("#txtTaskFqCnt").val() + "회 / " + processTm + $("#cmbProcessTmUnit option:checked").text();
            $("#txtTotTaskTm").val(totTaskTm);
        } else {
            $("#txtTotTaskTm").val("");
        }
    }
    
</script>