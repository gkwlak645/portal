<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script src="/resources/plugins/bootstrap-input-spinner.js"></script>

 <div class="card card-primary" id="queRegDiv">                   
    <div class="card-header" alt="자원관리 >큐관리>큐등록">
        <h3 class="card-title">등록</h3>
    </div>
    <div class="card-body">
        <div class="row">
            <div class="col-md-12">
                <form class="form-inline" id="">                    
                    <div class="form-group col-md-12"><h5 class="text-success">⊙  큐추가</h5></div> 
                    <div class="form-group col-md-12">
                        <label for="cmpny" class="col-sm-2 col-form-label">회사<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-6">
                            <select class="form-control" id="cmpny" style="width:80%;  max-width:220px;margin-right: 3px;">
                            <option value="">선택</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="name" class="col-sm-4 col-form-label">이름<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8">
                            <input type="text" id="name" class="form-control"  style="width:80%;" maxlength="15">
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="efurfY" class="col-sm-4 col-form-label">고유참조</label>
                        <div class="col-sm-8">
                            <input type="radio" name="enforceUniqueReference" id="efurfY" value="Y" class="custom-radio" style="width:18px;height:18px;"><label for="efurfY">예 </label> &nbsp;
                            <input type="radio" name="enforceUniqueReference" id="efurfN" value="N" class="custom-radio" style="width:18px;height:18px;" checked><label for="efurfN">아니오</label>
                        </div>
                    </div>
                    
                    <div class="form-group col-md-12">
                        <label for="managtChargerId" class="col-sm-2 col-form-label">설명</label>
                        <div class="col-sm-10">
                            <textarea rows="2" id="description" class="form-control" style="width:92.5%;" maxlength="80"></textarea>
                        </div>
                    </div>                                   
                    
                    
                    <div class="form-group col-md-6">
                        <label for="aarY" class="col-sm-4 col-form-label">자동재시도</label>
                        <div class="col-sm-8">
                            <input type="radio" name="acceptAutomaticallyRetry" id="aarY" value="Y" class="custom-radio" style="width:18px;height:18px;" checked><label for="aarY">예 </label> &nbsp;
                            <input type="radio" name="acceptAutomaticallyRetry" id="aarN" value="N" class="custom-radio" style="width:18px;height:18px;"><label for="aarN">아니오</label>  &nbsp;                            
                        </div>
                    </div>
                    <div class="form-group col-md-6" id="aarDiv">
                        <label for="maxNumberOfRetries" class="col-sm-4 col-form-label"  style="display:block;">최대 재시도 횟수</label>
                        <div class="col-sm-3">
                            <input type="number" id="maxNumberOfRetries" value="0" min="0" max="50" maxlength="2">
                        </div>
                    </div>
                                        
                     
                    <div class="col-md-12 m-3"></div> 
                    
                    <div class="form-group col-md-12"><h5 class="text-success">⊙ 스키마 정의</h5></div>  
                                                         
                    <div class="form-group col-md-12">
                        <label for="fileUpload1" class="col-sm-2 col-form-label">특정데이터 Json 첨부</label>
                        <div class="col-sm-3">
                             <div id="sfdjsUpDiv">
                                <input type="file" id="sfdjsUpFile" name="file" style="min-width:260px;line-height:120%" accept=".json">
                                <input type="button" class="btn btn-secondary float-right" style="margin:0 15px 0 5px;" id="btnFileUploadType1" name="add" value="등록" />
                            </div>
                            <div id="sfdjsDownDiv" style="display : none">
                                <input type="text" id="sfdjsFile" name="fileSchema"  disabled>
                                <input type="button" class="btn btn-outline-secondary float-right" name="btnDelSchema" id="sfdjsDel" value="삭제"> 
                                <a href="#" class="btn btn-outline-secondary float-right" id="sfdjsLink"  style="margin:0 15px 0 5px;" download="specificDataSchema.json">다운로드</a>
                            </div>
                        </div>
                   </div>
                   <div class="form-group col-md-12">
                        <label for="fileUpload2" class="col-sm-2 col-form-label">출력데이터 Json 첨부</label>
                        <div class="col-sm-3">
                            <div id="opdjsUpDiv">
                                <input type="file" id="opdjsUpFile" name="file" style="min-width:260px;line-height:120%" accept=".json">
                                <input type="button" class="btn btn-secondary float-right" style="margin:0 15px 0 5px;" id="btnFileUploadType2" name="add" value="등록" />
                            </div>
                            <div id="opdjsDownDiv" style="display : none">
                                <input type="text" id="opdjsFile" name="fileSchema" disabled>
                                <input type="button" class="btn btn-outline-secondary float-right" name="btnDelSchema" id="opdjsDel" value="삭제"> 
                                <a href="#" class="btn btn-outline-secondary float-right" id="opdjsLink" style="margin:0 15px 0 5px;" download="outputDataSchema.json">다운로드</a>
                            </div>
                        </div>
                   </div>
                   <div class="form-group col-md-12">
                        <label for="fileUpload3" class="col-sm-2 col-form-label">분석데이터 Json 첨부</label>
                        <div class="col-sm-3">
                             <div id="atdjsUpDiv">
                                <input type="file" id="atdjsUpFile" name="file" style="min-width:260px;line-height:120%" accept=".json">
                                <input type="button" class="btn btn-secondary float-right" style="margin:0 15px 0 5px;" id="btnFileUploadType3" name="add" value="등록" />
                            </div>
                            <div id="atdjsDownDiv" style="display : none">
                                <input type="text" id="atdjsFile" name="fileSchema" disabled>
                                <input type="button" class="btn btn-outline-secondary float-right" name="btnDelSchema" id="atdjsDel" value="삭제"> 
                                <a href="#" class="btn btn-outline-secondary float-right" id="atdjsLink" style="margin:0 15px 0 5px;" download="analyticsDataSchema.json">다운로드</a>
                            </div>
                        </div>
                   </div> 
                                        
                    
                    <div class="col-md-12 m-3"></div> 
                    <div class="form-group col-md-12">
                        <div class="col-sm-4"><h5 class="text-success float-left">⊙ SLA 예측</h5></div>
                        <div class="col-sm-8 custom-control custom-switch float-right">
                            <input type="checkbox" id="customSwitch1" class="custom-control-input float-right"  >
                            <label class="custom-control-label  float-right" for="customSwitch1">이 큐에 대해  SLA활성화</label>
                        </div>
                     </div>
                                        
                     <div class="form-group col-md-12" id="divNone" style="display:none;"><!-- 스위치 꺼지면 display:none처리 -->
	                     <div class="form-group col-md-12">
	                         <div class="form-group col-md-6">
	                            <label for="sourcUpdtNm" class="col-sm-4 col-form-label">프로세스<b style="color:red;padding-left:10px;">*</b></label>
	                            <div class="col-sm-8">
	                                <select class="form-control" id="releaseId" style="width:80%;margin-right:3px; ">
	                                    <option value="">선택</option>
	                                </select>                               
	                            </div>
	                         </div>
	                         <div class="form-group col-md-6">
	                            <label for="sourcUpdtNm" class="col-sm-4 col-form-label">새로운 큐항목 SLA</label>
	                            <div class="col-sm-3">
	                               <input type="number" id="slaDay" value="0" min="0" max="90" maxlength="2" placeholder="일"><label>일</label>
                                </div>
                                <div class="col-sm-3">
                                    <input type="number" id="slaTime" value="0" min="0" max="23" maxlength="2" placeholder="시간"><label>시간</label>
                                </div>
	                        </div>
	                        <div class="col-md-12">                        
	                            <div class="col-sm-12 custom-control custom-switch">     
	                                <input type="checkbox" id="customSwitch2" class="custom-control-input" >                       
	                                <label class="custom-control-label float-right" for="customSwitch2">위험  SLA</label>                         
	                            </div>            
	                        </div>
	                        <div class="form-group col-md-12 py-sm-3" id="divNone2" style="display:none;"><!-- 스위치 꺼지면 display:none처리2 -->
		                        <div class="form-group col-md-6">
	                                <label for="sourcUpdtNm" class="col-sm-4 col-form-label">위험 SLA</label>
	                                <div class="col-sm-3">
	                                   <input type="number" id="riskSlaDay" value="0" min="0" max="90" maxlength="2" placeholder="일"><label>일</label>
	                                </div>
	                                <div class="col-sm-3">
	                                    <input type="number" id="riskSlaTime" value="0" min="0" max="23" maxlength="2" placeholder="시간"><label>시간</label>
	                                </div>
	                            </div>
		                    </div>
	                        <!-- 스위치 꺼지면 display:none처리2  END -->    
	                    </div>
                    </div>
                    <!-- <!-- 스위치 꺼지면 display:none처리 END -->         
                </form>
                
                <div class="float-right" style="margin:15px 0 15px 2px;">
                    <c:if test="${txScreenAuthor.wrtngAuthor eq 'N'}">
                        <button type="button" class="btn btn-primary float-right" id="cancel">목록으로</button><br><br>
                    </c:if>
                    <c:if test="${txScreenAuthor.wrtngAuthor eq 'Y'}">
                        <button type="button" class="btn btn-primary" id="queDel" data-toggle="modal" data-target="#modal-lg3">삭제</button>
                        &nbsp;
                        <button type="button" class="btn btn-primary" id="btnRegist">등록</button>
                        <button type="button" class="btn btn-primary" id="btnUpdate">수정</button>
                        &nbsp;
                        <button type="button" class="btn btn-primary" id="btnClose">취소</button>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>
    
    
<div class="modal fade-dept" id="modal-lg3">
   <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header"></div>
            <div class="modal-body">
                <span>해당 큐 를 삭제하시겠습니까?</span>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary" id="queDelete">삭제</button>
            </div>
        </div>
    </div>
</div>
    
    
<script>

//회사코드
var cmpnyCd;
//Queue 아이디
var queId;

//json 스키마 정의
//특정데이터 Json 첨부
var specificDataJsonSchema = '';
//출력데이터 Json 첨부
var outputDataJsonSchema = '';
//분석데이터 Json 첨부
var analyticsDataJsonSchema = '';


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
            params.push({"id" : "cmpny", "clsCd" : "0024"});    //회사
            $("#releaseId").html('<option value="">회사를 선택하지 않았습니다.</option>'); //프로세스 리스트
	    }else{
	        params.push({"id" : "cmpny", "clsCd" : "0024", "disable" : "Y", "selectValue": "${sessionUserInfo.txCmpnyCd}"});    //회사
	        getRlseList("${sessionUserInfo.txCmpnyCd}"); //프로세스 리스트
	    }

        requestCmmnCd(params);
        
      //상세 페이지 데이터 조회 
      if(queId != null && queId != ""){ 
    	  getDetailData(cmpnyCd, queId);
    	  $("#btnRegist").hide();
          $("#btnUpdate").show();
      }else{
    	  $("#btnRegist").show();
          $("#btnUpdate").hide();
      }
      
    }
    
    
    /*
     * 이벤트 바인딩
     * @param
     * @return
     */
    function bindEvent() {
    	
    	//number에 bootstrap 적용
    	$("input[type='number']").inputSpinner();
    	
       //등록 ,수정전 체크
    	$("#btnRegist ,#btnUpdate").on("click", function() {  
        	if($("#cmpny").val() == null || $("#cmpny").val() == '') {
                alert("회사를 선택해주세요.");
                $('#cmpny').focus();
            } else  if($("#name").val() == null || $("#name").val() == '') {
            	alert("que명을 입력해주세요.");
                $('#name').focus();
            } else if($("input:checkbox[id=customSwitch1]").is(":checked") && ($("#releaseId").val() == null || $("#releaseId").val() == '')) {
                alert("프로세스를 선택해주세요.");
                $('#releaseId').focus();
            } else if(!updateSlaChk()) {
            	alert("위험 SLA는 SLA보다 작아야 합니다.");
            } else{
            	updateQue();
            }  
        });
       
       
       //팝업 종료
        $("#cancel, #btnClose").on("click", function() {
            closePOP();
        });
        
       //que 삭제
        $("#queDelete").on("click", function() {
        	deleteQue();
        });
       
       
      //회사 SELECT change 이벤트
        $("#cmpny").on("change", function() { 
            if($("#cmpny").val() == null || $("#cmpny").val() == ""){
            	//초기화
                $("#releaseId").html('<option value="">회사를 선택하지 않았습니다.</option>');
            }else{
            	getRlseList();
            }
       });
        
        //자동재시도 변경 evnet
        $("input:radio[name='acceptAutomaticallyRetry']").on("change", function() {
        	 if($("input:radio[id='aarY']").is(":checked")){
        		 $("#maxNumberOfRetries").prop("disabled",false); 
        		 $("#maxNumberOfRetries").val(0);
        	 }else{
        		 $("#maxNumberOfRetries").prop("disabled",true); 
        		 $("#maxNumberOfRetries").val('');
        	 }
        });
        
        //이 큐에 대해 SLA활성화 변경 evnet
        $("#customSwitch1").on("change", function() {
             if($("input:checkbox[id='customSwitch1']").is(":checked")){  
            	 $('#divNone').css({ display: 'block' });
             }else{ 
                 $('#divNone').css({ display: 'none' });
             }
        });
        
        
       //위험 SLA 변경 evnet
        $("#customSwitch2").on("change", function() {
             if($("input:checkbox[id='customSwitch2']").is(":checked")){
            	 $('#divNone2').css({ display: 'block' });
             }else{
            	 $('#divNone2').css({ display: 'none' });
             }
        });
       
       
       //스키마정의 파일 삭제 선택 event
        $("input[name='btnDelSchema']").on("click", function() { 
            var id = $(this).attr('id');

            if(id == "sfdjsDel"){       //특정데이터 Json 첨부
            	specificDataJsonSchema = '';
            	$('#sfdjsDownDiv').css({ display: 'none' });
            	$('#sfdjsUpDiv').css({ display: 'block' });
            }else if(id == "opdjsDel"){ //출력데이터 Json 첨부
            	outputDataJsonSchema = '';
            	$('#opdjsDownDiv').css({ display: 'none' });
                $('#opdjsUpDiv').css({ display: 'block' });
            }else if(id == "atdjsDel"){ //분석데이터 Json 첨부
            	analyticsDataJsonSchema = '';
            	$('#atdjsDownDiv').css({ display: 'none' });
                $('#atdjsUpDiv').css({ display: 'block' });
            }else{}
            
        });
       
       
       //특정데이터 json 첨부 파일 등록 event
       $("#btnFileUploadType1").on("click", function() { 
    	   
    	   if($("#sfdjsUpFile").val() == null || $("#sfdjsUpFile").val() == ""){
    		   alert('파일을 등록해주세요.')
    	   }else{
    		   var fileValue = $("#sfdjsUpFile").val().split("\\");
               var fileName = fileValue[fileValue.length-1]; // 파일명
               $('#sfdjsFile').val(fileName);
               $("#sfdjsLink").attr("download", fileName); 
               
               var sfdjsDataUri = chgUri(specificDataJsonSchema);
               $("#sfdjsLink").attr("href", sfdjsDataUri);  
               
               
               $('#sfdjsDownDiv').css({ display: 'block' });
               $('#sfdjsUpDiv').css({ display: 'none' });
               
               $("#sfdjsUpFile").val("");
    	   }
       }); 
       
       
     //출력데이터 json 첨부 파일 등록 event
       $("#btnFileUploadType2").on("click", function() { 
    	   if($("#opdjsUpFile").val() == null || $("#opdjsUpFile").val() == ""){
               alert('파일을 등록해 주세요.')
           }else{
        	   var fileValue = $("#opdjsUpFile").val().split("\\");
               var fileName = fileValue[fileValue.length-1]; // 파일명
               $('#opdjsFile').val(fileName);
               $("#opdjsLink").attr("download", fileName); 
               
               var opdjsDataUri = chgUri(outputDataJsonSchema);
               $("#opdjsLink").attr("href", opdjsDataUri);  
               
               
               $('#opdjsDownDiv').css({ display: 'block' });
               $('#opdjsUpDiv').css({ display: 'none' });
               
               $("#opdjsUpFile").val("");
           }
       }); 
       
     
     //분석데이터 json 첨부 파일 등록 event
       $("#btnFileUploadType3").on("click", function() { 
    	   if($("#atdjsUpFile").val() == null || $("#atdjsUpFile").val() == ""){
               alert('파일을 등록해 주세요.')
           }else{
        	   var fileValue = $("#atdjsUpFile").val().split("\\");
               var fileName = fileValue[fileValue.length-1]; // 파일명
               $('#atdjsFile').val(fileName);
               $("#atdjsLink").attr("download", fileName); 
               
               var atdjsDataUri = chgUri(analyticsDataJsonSchema);
               $("#atdjsLink").attr("href", atdjsDataUri);  
               
               
               $('#atdjsDownDiv').css({ display: 'block' });
               $('#atdjsUpDiv').css({ display: 'none' });
               
               $("#atdjsUpFile").val("");
           }
       }); 
       
       
      //스키마정의 파일 선택 json체크 및 json값 읽어오기 event
        $("input[name='file']").on("change", function() {
        	var id = $(this).attr('id');
        	
        	if(id == "sfdjsUpFile"){ 
                specificDataJsonSchema = "";
            }else if(id == "opdjsUpFile"){
                outputDataJsonSchema = "";
            }else if(id == "atdjsUpFile"){
                analyticsDataJsonSchema = "";
            }else{}
        	
            var result = loadFile(this,id); 

        });
        
    }
    
    
    //위험 SLA 등록전 체크
    //새로운 큐항목  SLA보다 위험 SLA값이 크면 XXX
    function updateSlaChk(){
        
        var slaChk = true;
        
        if($("input:checkbox[id=customSwitch1]").is(":checked")){
           
            var slaDay  = $("#slaDay").val() * 24 * 60;
            var slaTime = $("#slaTime").val() * 60;
            var SlaInMinutes  =  slaDay + slaTime;
            
            if($("input:checkbox[id=customSwitch2]").is(":checked")){
                var riskSlaDay  = $("#riskSlaDay").val() * 24 * 60;
                var riskSlaTime = $("#riskSlaTime").val() * 60;
                var RiskSlaInMinutes    =    riskSlaDay + riskSlaTime; 
                if (SlaInMinutes < RiskSlaInMinutes){ 
                     slaChk = false;
                }
            }
        }
        
        return slaChk;
    }
    
    
    //프로세스list 조회
    function getRlseList(cmpnyCd) {
    	
    	var param = {};
    	
    	if(cmpnyCd == null || cmpnyCd == ""){
    		param.cmpnyCd = $("#cmpny").val();  
    	}else{
    		param.cmpnyCd = cmpnyCd;  
    	}
    	
         callSyncAjax("/resrce/que/getRlseList", param, "callBackRlseList");
    }
    
    
    function callBackRlseList(data){
    	var rlseList = data.result.rlseList;
    	var tmp = "";
    	tmp = "<option value=''>선택</option>";
    	$.each(rlseList, function(idx, item) {
            tmp += "<option value='" + item.Id + "'>" + item.Name + "</option>";
        });
    	
    	$("#releaseId").html(tmp);
    }
    
    
    
    /*
     * 데이터 조회
     * @param
     * @return
     */
    function getDetailData(cmpnyCd, queId) {
        var param = {"cmpnyCd" : cmpnyCd ,"Id" : queId}; 
        callSyncAjax("/resrce/que/getQueDetail", param, "printDetailData");
    }
    
    
    /*
     * que 데이터출력
     * @param
     * @return
     */
    function printDetailData(data) {
    	
    	if (data != null &&  data.result != null &&  data.result.queDetail != null) { 
    		
    		var queData = data.result.queDetail;
    		
    		//***********************큐 기본***********************************
    		
    		//회사
    		$('#cmpny').val(queData.cmpnyCd).prop("selected", true);
    		
    		//이름
            $("#name").val(queData.Name);
            
            //고유참조
            if(queData.EnforceUniqueReference){ 
                $('input:radio[name=EnforceUniqueReference]:input[value="Y"]').attr("checked", true);
            }else{
                $('input:radio[name=EnforceUniqueReference]:input[value="N"]').attr("checked", true);
            }
            
            //설명
            $("#description").val(queData.Description);
            
            //자동재시도
           	if(queData.AcceptAutomaticallyRetry){ 
           		$('input:radio[name=acceptAutomaticallyRetry]:input[value="Y"]').attr("checked", true);
           		//최대 재시도 횟수
                   $("#maxNumberOfRetries").val(queData.MaxNumberOfRetries);
           	}else{
           		$('input:radio[name=acceptAutomaticallyRetry]:input[value="N"]').attr("checked", true);
           		$("#aarDiv").css({ display: 'none' });
           	}
            
            
            //***********************스키마정의***********************************
            // SpecificDataJsonSchema  특정데이터
            if(queData.SpecificDataJsonSchema != null && queData.SpecificDataJsonSchema != ""){
            	specificDataJsonSchema = queData.SpecificDataJsonSchema; 
                specificDataJsonSchema = JSON.parse(specificDataJsonSchema); 
                delete specificDataJsonSchema.$schema; 
                var sfdjsDataUri = chgUri(specificDataJsonSchema);
                $("#sfdjsLink").attr("href", sfdjsDataUri); 
                $("#sfdjsFile").val("specificDataSchema.json"); 
                
                $('#sfdjsUpDiv').css({ display: 'none' });
                $('#sfdjsDownDiv').css({ display: 'block' });
            }
            
           
            // OutputDataJsonSchema    출력데이터
            if(queData.OutputDataJsonSchema != null && queData.OutputDataJsonSchema != ""){
            	outputDataJsonSchema = queData.OutputDataJsonSchema;
                outputDataJsonSchema = JSON.parse(outputDataJsonSchema); 
                delete outputDataJsonSchema.$schema; 
                var opdjsDataUri = chgUri(outputDataJsonSchema);
                $("#opdjsLink").attr("href", opdjsDataUri); 
                $("#opdjsFile").val("outputDataSchema.json");
                
                $('#opdjsUpDiv').css({ display: 'none' });
                $('#opdjsDownDiv').css({ display: 'block' });
            }
            
            
            // AnalyticsDataJsonSchema 분석데이터
            if(queData.AnalyticsDataJsonSchema != null && queData.AnalyticsDataJsonSchema != ""){
            	analyticsDataJsonSchema = queData.AnalyticsDataJsonSchema;
                analyticsDataJsonSchema = JSON.parse(analyticsDataJsonSchema); 
                delete analyticsDataJsonSchema.$schema; 
                var opdjsDataUri = chgUri(analyticsDataJsonSchema);
                $("#atdjsLink").attr("href", opdjsDataUri); 
                $("#atdjsFile").val("analyticsDataSchema.json");
                
                $('#atdjsUpDiv').css({ display: 'none' });
                $('#atdjsDownDiv').css({ display: 'block' });
            }
            
            //***********************SLA예 측***********************************
     		if(queData.ReleaseId != "" && queData.ReleaseId != null){
                
     			//이 큐에 대해 SLA 활성화
     			$('#divNone').css({ display: 'block' });
     			$("input:checkbox[id='customSwitch1']").prop("checked", true);

     			
     			//프로세스  queData.ReleaseId
     			if (data.result.queRlseDetail != null) { 
     				var queRlseDetail = data.result.queRlseDetail;
     				$("#releaseId").html("<option value='" + queRlseDetail.Id + "' selected>" + queRlseDetail.Name + "</option>");
                    $("#releaseId").attr('disabled', true);
     			}
     			
     			
     			//새로운 큐항목 SLA
     			var slaInMinutes = 0;
     			var slaDay = 0;
     			var slaTime = 0;
     			
     			slaInMinutes = queData.SlaInMinutes;
     			slaDay = Math.floor(slaInMinutes/1440);
     			slaTime = (slaInMinutes - (1440 * slaDay)) / 60;
     			
     			$("#slaDay").val(slaDay);
     			$("#slaTime").val(slaTime);
     			
     			if(queData.RiskSlaInMinutes != "" && queData.RiskSlaInMinutes != null){
     				
     				var riskSlaInMinutes = 0;
                    var riskSlaDay = 0;
                    var riskSlaTime = 0;
     				
     				//위험 SLA 활성화
                    $('#divNone2').css({ display: 'block' });
                    $("input:checkbox[id='customSwitch2']").prop("checked", true);
     				
     				riskSlaInMinutes = queData.RiskSlaInMinutes;
     				riskSlaDay = Math.floor(riskSlaInMinutes/1440);
                    riskSlaTime = (riskSlaInMinutes - (1440 * riskSlaDay)) / 60;
     				
     				$("#riskSlaDay").val(riskSlaDay);
                    $("#riskSlaTime").val(riskSlaTime);
     			}
     			
            }else{
            	//프로세스(릴리즈) 아이디 없을시에는 list 불러오기
            	getRlseList();
            }
            
            //수정시 disabled 필요한것들
     		$('#cmpny, #name, #maxNumberOfRetries').attr('disabled', true);
     		$('input:radio[name=enforceUniqueReference]').attr('disabled', true);
     		$('input:radio[name=acceptAutomaticallyRetry]').attr('disabled', true);
            
    	}else{
    		alert('큐를 찾을 수 없습니다.');
    		closePOP();
    	}
    }
    
    /*
     * que 등록/수정
     * @param
     * @return
     */
    function updateQue() {
    	
        var param ={};
    	
    	param = {
    		  "Name": "",
    		  "Description": "",
    		  "MaxNumberOfRetries": 0,
    		  "AcceptAutomaticallyRetry": false,
    		  "EnforceUniqueReference": false,
    		  "SpecificDataJsonSchema": "",
    		  "OutputDataJsonSchema": "",
    		  "AnalyticsDataJsonSchema": "",
    		  //"CreationTime": "",
    		  "ProcessScheduleId": null,
    		  "SlaInMinutes": 0,
    		  "RiskSlaInMinutes": 0,
    		  "ReleaseId": null,
    		  "Id": 0
    		}
    	
    	
    	//*********************** 큐 기본 ***********************************
    	
    	$("#cmpny").val() == "" ? param.cmpnyCd = "" : param.cmpnyCd = $("#cmpny").val() 
    			
        param.Name                      =   $("#name").val()
        
        if($("input:radio[name=enforceUniqueReference]:checked").val() == "Y"){
        	param.EnforceUniqueReference    =   true;
        }
        
    	param.Description               =   $("#description").val();
    	
    	if($("input:radio[name=acceptAutomaticallyRetry]:checked").val() == "Y"){
            param.AcceptAutomaticallyRetry    =   true;
            param.MaxNumberOfRetries    =   parseInt($("#maxNumberOfRetries").val());
        }
    	
    	//*********************** 스키마 정의 ***********************************
            // SpecificDataJsonSchema  특정데이터
            if(specificDataJsonSchema != null && specificDataJsonSchema != ""){
            	param.SpecificDataJsonSchema   =   JSON.stringify(specificDataJsonSchema);    
            }
            
            // OutputDataJsonSchema    출력데이터
            if(outputDataJsonSchema != null && outputDataJsonSchema != ""){
            	param.OutputDataJsonSchema     =   JSON.stringify(outputDataJsonSchema);   
            }
            
            // AnalyticsDataJsonSchema 분석데이터
            if(analyticsDataJsonSchema != null && analyticsDataJsonSchema != ""){
            	param.AnalyticsDataJsonSchema   =  JSON.stringify(analyticsDataJsonSchema);
            }
            
        //*********************** SLA 예 측 ***********************************
        
        if($("input:checkbox[id=customSwitch1]").is(":checked") && $("#releaseId").val() != ""){
        	
        	param.ReleaseId              =   parseInt($("#releaseId").val())
            
            var slaDay  = $("#slaDay").val() * 24 * 60;
            var slaTime = $("#slaTime").val() * 60;
            
            param.SlaInMinutes            =    slaDay + slaTime;
            
            if($("input:checkbox[id=customSwitch2]").is(":checked")){
                
                var riskSlaDay  = $("#riskSlaDay").val() * 24 * 60;
                var riskSlaTime = $("#riskSlaTime").val() * 60;
                	
                param.RiskSlaInMinutes    =    riskSlaDay + riskSlaTime;
            }
        }

    	if(queId == null || queId == ""){ 
        	callSyncAjax("/resrce/que/registQue", param, "callBackQue");
        }else{
        	param.Id                        =   queId
        	callSyncAjax("/resrce/que/updateQue", param, "callBackQue");
        }
    }
    
    
    /*
     * que 삭제
     * @param
     * @return
     */
    function deleteQue() {
        var param = {
        		 cmpnyCd : $("#cmpny").val()
        		,id     :  queId
          };
        

         callSyncAjax("/resrce/que/deleteQue", param, "callBackDeleteQue");
    }
    
    
    function callBackQue(){
    	alert('저장되었습니다.');
    	searchQueList();
    	closePOP();
    }
    
    function callBackDeleteQue(){
        alert('삭제되었습니다.');
        searchQueList();
        $("#modal-lg3").modal("toggle");
        closePOP();
    }
    
    
    //json string 변경후 uri 생성
    function chgUri(jsonSchema){
        var dataJsonSchema = JSON.stringify(jsonSchema);
        var dataUri = "data:application/json;charset=utf-8,"+ encodeURIComponent(dataJsonSchema);
        return dataUri;
    }
    
  
    //파일 등록시 json 파싱
    function loadFile(sender,id){ 
    	
    	//var result = false;
        // check file ext
        var validExts = new Array(".json");
        var fileExt   = sender.value;
        fileExt = fileExt.substring(fileExt.lastIndexOf('.'));
     
        // If ext is not valid -> alert
        if (fileExt && validExts.indexOf(fileExt) < 0) {
            alert("json 파일만 등록 가능합니다.");
            $(this).val("");
        } else{
        	// file read
            var reader = new FileReader(); 
            reader.onload = function (sender) { 

            var data = sender.target.result;
                
                // .. if json
                if (fileExt === ".json") {
                    
                	data = data.replace(/u'(?=[^:]+')/g, "'");
                	
                	if(IsJsonString(data)){
                		
                		data = JSON.parse(data);  
                		
                		if(id == "sfdjsUpFile"){ 
                            specificDataJsonSchema = data;
                        }else if(id == "opdjsUpFile"){
                            outputDataJsonSchema = data;
                        }else if(id == "atdjsUpFile"){
                            analyticsDataJsonSchema = data;
                        }else{}
                		
                		//result = true; 
                		
                	}else{ 
                	   alert('업로드된 스키마 정의가 유효한 JSON이 아닙니다.');
                	   $('#'+id).val("");
                	}
                }else{
                	alert("json 파일만 등록 가능합니다.");
                	$('#'+id).val("");
                }
            };
            
            reader.readAsText(sender.files[0]);
        }
        
       // return result;
    }
    
    
    //Json 형태 여부 확인
    function IsJsonString(str) {
	   	  try {
	   	    var json = JSON.parse(str);
	   	    return (typeof json === 'object');
	   	  } catch (e) {
	   	    return false;
	   	  }
   	}
    

</script>









