<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="card card-primary" id = "cardDiv">
    <div class="card-header">
        <h3 class="card-title">과제요청 등록</h3>
    </div>
    <div class="card-body" style="height:704px; overflow:auto;">
        <div class="row">
            <div class="col-md-12">
                <div class="form-inline" >
                    <div class="form-group col-md-12 py-sm-2"  style="margin: 0.25rem 0 0.5rem 0;">
                        <label class="col-sm-2 col-form-label">과제명 <b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8" style="padding-left: 4px;">
                            <input type="text" id="txtTaskNm" name="taskNm" class="form-control" style="width:100%" />
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-2"  style="margin: 0.25rem 0 0.5rem 0;">
                        <label class="col-sm-4 col-form-label">부서 <b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8">
                            <input type="text" id="txtChrgDeptNm" style="width:50%;margin-right: 3px;" class="form-control" value="${txDeptNm}" readonly />
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-2"  style="margin: 0.25rem 0 0.5rem 0;">
                        <label class="col-sm-4 col-form-label">요청자 <b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8">
                            <input type="text" id="txtChargerUserNm" style="width:50%;margin-right: 3px;" class="form-control" value="${txUserNm}" readonly />
                        </div>
                    </div>
                    <div class="form-group row col-md-6 py-sm-2"  style="margin: 0.25rem 0 0.5rem 0;">
                        <label class="col-sm-4 col-form-label">과제빈도 <b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8" style="line-height:200%; vertical-align:top;">
                            <select id="cmbTaskFqCd" class="form-control float-left" style="width:50%;margin-right: 3px;">
                                <option value="">선택</option>
                            </select>
                            <input type="text" id="txtTaskFqCnt" style="width:30%;margin-right: 3px;"class="form-control float-left"> 회
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-2"  style="margin: 0.25rem 0 0.5rem 0;">
                        <label class="col-sm-4 col-form-label">건별처리시간 <b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8">                            
                            <select id="cmbProcessTmUnit" class="form-control float-left" style="width:50%;margin-right: 3px;">
                                <option value="">선택</option>
                            </select>
                            <input type="text" id="txtCsbyProcessTm" style="width:30%;" class="form-control  float-left">
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-2"  style="margin: 0.25rem 0 0.5rem 0;">
                        <label class="col-sm-4 col-form-label">처리인원 <b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8" style="line-height: 200%;vertical-align: top;">
                            <input type="text" id="txtProcessNp" class="form-control float-left" style="width:30%;margin-right: 3px;"> 명
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-2"  style="margin: 0.25rem 0 0.5rem 0;">
                        <label class="col-sm-4 col-form-label">총과제시간 </label>
                        <div class="col-sm-8">
                            <input type="text" id="txtTotTaskTm" class="form-control" style="width:50%;margin-right: 3px;" value="" readonly />
                        </div>
                    </div>
                    <div class="form-group col-md-12 py-sm-2"  style="margin: 0.25rem 0 0.5rem 0;">
                        <label class="col-sm-2 col-form-label">과제설명 </label>
                        <div class="col-sm-8" style="padding-left: 4px;">
                            <textarea id="txtTaskDc"  class="form-control" rows="6" style="width:100%;"></textarea>
                        </div>
                    </div>
                    <div class="form-group col-md-12 py-sm-2"  style="margin: 0.25rem 0 0.5rem 0;">
                        <label class="col-sm-2 col-form-label">활용시스템 </label>
                        <div class="col-sm-9"><div class="form-check row"  id="divTaskPrcuseSys" ></div></div>
                    </div>
                    <div class="form-group col-md-12 py-sm-2"  style="margin: 0.25rem 0 0.5rem 0;">
                        <label class="col-sm-2 col-form-label">첨부파일 </label>
                        <div class="col-sm-9"><div class="form-check2 row"  id="fileUpload"></div></div>
                    </div>
                </div>
                <div class="float-right" style="margin:12px 0 26px 2px;">
                    <button type="button" class="btn btn-primary" id="btnTaskRequst">개발요청</button>
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
		
		upload.draw(0, true);
    }
    
    /*
     * 이벤트 바인딩
     * @param
     * @return
     */
    function bindEvent() {

    	//숫자만 입력되게 처리
        $("#txtTaskFqCnt, #txtCsbyProcessTm, #txtProcessNp").on("keyup", function(e) {
        	$(this).val($(this).val().replace(/[^0-9]/g, ""));
        });
    	
        $("#cmbTaskFqCd, #cmbProcessTmUnit").on("change", function(e) {
            printTotProcessTm();
        });
    	
        $("#txtTaskFqCnt, #txtCsbyProcessTm, #txtProcessNp").on("blur", function(e) {
            printTotProcessTm();
        });
        
        $("#btnTaskRequst").on("click", function(e) {
            registerTaskRequest();
        });
        
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
    	        $("#divTaskPrcuseSys").append('<div style="min-width:200px;padding:0 10px 3px 0;"><input style="width:18px;height:18px;" class="form-check-input" type="checkbox" id="chkPrcuseSys'+item.cd+'" value="'+item.cd+'"><font style="font-size:13px;line-height: 200%;vertical-align: top;">'+item.cdNm+'</font>');
    		});
    	}
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
    
    /*
     * 과제요청 등록
     * @param
     * @return
     */
    function registerTaskRequest() {
    	
    	//등록 데이터 유효성 체크
    	if (!validateRegistration()) {
    		return;
    	}
    	
    	//파일업로드
    	var fileGrpNo = upload.upload();
    	if (fileGrpNo < 0) {   //파일업로드 오류시
    		return;
    	}

    	//활용시스템
    	var taskPrcuseSysArray = [];
    	$("input[id^=chkPrcuseSys]").each(function(idx, item) {
            if ($(this).is(":checked")) {
            	taskPrcuseSysArray.push({"prcuseSysCd" : $(this).val()});
            }
        });

    	//등록 데이터 세팅
        var url = "/task/requst/createTaskRequst";
        var param = {};
        param.taskNm            = $("#txtTaskNm").val();
        param.taskFqCd          = $("#cmbTaskFqCd").val();
        param.taskFqCnt         = $("#txtTaskFqCnt").val();
        param.csbyProcessTm     = $("#txtCsbyProcessTm").val();
        param.processTmUnit     = $("#cmbProcessTmUnit").val();
        param.processNp         = $("#txtProcessNp").val();
        param.taskDc            = $("#txtTaskDc").val();
        param.fileGrpNo         = fileGrpNo;
        param.taskPrcuseSysList = taskPrcuseSysArray;
        
        //데이터 등록
        callSyncAjax(url, param, 'registerCallback');
    }
    
    /*
     * 등록 유효성 검사
     * @param
     * @return
     */
    function validateRegistration() {
    	
    	if ($("#txtTaskNm").val() == "") {
    		alert("과제명을 입력해주세요.");
    		$("#txtTaskNm").focus();
    		return false;
    	}
    	
        if ($("#cmbTaskFqCd").val() == "") {
            alert("과제빈도를 선택해주세요.");
            $("#cmbTaskFqCd").focus();
            return false;
        }
        
        if ($("#txtTaskFqCnt").val() == "") {
            alert("과제빈도를 입력해주세요.");
            $("#txtTaskFqCnt").focus();
            return false;
        }
        
        if ($("#txtCsbyProcessTm").val() == "") {
            alert("건별처리시간을 입력해주세요.");
            $("#txtCsbyProcessTm").focus();
            return false;
        }
        
        if ($("#cmbProcessTmUnit").val() == "") {
            alert("건별처리시간을 선택해주세요.");
            $("#cmbProcessTmUnit").focus();
            return false;
        }
        
        if ($("#txtProcessNp").val() == "") {
            alert("처리인원을 입력해주세요.");
            $("#txtProcessNp").focus();
            return false;
        }
    	
    	return true;
    }
    
    /*
     * 등록후 콜백함수
     * @param
     * @return
     */
    function registerCallback(data) {
    	
    	if (data.responseCode.substr(0, 1) == "I") {
    		
    		alert("과제요청을 완료하였습니다.");
    	
	        //메인 리스트 재조회
	        searchTaskRequstList();
	        
	        //팝업닫기
	        closePOP();
    	}
    }
    
</script>