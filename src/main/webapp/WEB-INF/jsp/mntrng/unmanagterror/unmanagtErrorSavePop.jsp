<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<div class="card card-primary" id="unmanagtErrorSaveDiv">
    <div class="card-header">
        <h3 class="card-title">상세조회</h3>
    </div>
    <div class="card-body">
        <div class="row">
            <div class="col-md-12">
                <form class="form-inline" id="unmanagtErrorSave">
	                <div class="form-group col-md-6 py-sm-2">
                        <label for="cmpnyCd" class="col-sm-4 col-form-label">회사</label>
                        <div class="col-sm-8">
                            <select id="cmpnyCd" class="form-control" style="width:80%;">
                                  <option value=""></option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-2">
                        <label for="unmanagtDe" class="col-sm-4 col-form-label">미조치일</label>
                        <div class="col-sm-6">
                            <div class="input-group date" id="unmanagtDeDiv" data-target-input="nearest">
                                <input type="text" id="unmanagtDe" name="unmanagtDe" class="form-control datetimepicker-input" data-target="#unmanagtErrorSave #unmanagtDeDiv"/>
                                <div class="input-group-append" data-target="#unmanagtDeDiv" data-toggle="datetimepicker">
                                    <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-2">
                        <label for="processCdPop" class="col-sm-4 col-form-label">프로세스코드</label>
                        <div class="col-sm-8">
                            <select id="processCdPop" class="form-control">
                                  <option value=""></option>
                            </select>
                            <select id="processCdHidden" style="display:none" class="form-control" >
                                  <option value=""></option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-2">
                        <label for="processNm" class="col-sm-4 col-form-label">프로세스명</label>
                        <div class="col-sm-8">
                            <input type="text" id="processNm" class="form-control" disabled style="width:80%;"/>
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-2">
                        <label for="errorOccrrncSeCd" class="col-sm-4 col-form-label">오류발생구분</label>
                        <div class="col-sm-8">
                            <select id="errorOccrrncSeCd" name="errorOccrrncSeCd" class="form-control" style="width:80%;"></select>
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-2">
                        <label for="errorTyCd" class="col-sm-4 col-form-label">오류유형</label>
                        <div class="col-sm-8">
                            <select id="errorTyCd" name="errorTyCd" class="form-control" style="width:80%;"></select>
                        </div>
                    </div>
                    <div class="form-group col-md-12 py-sm-2">
                        <label for="errorCn" class="col-sm-2 col-form-label">오류상세내용</label>
                        <div class="col-sm-10">
                            <textarea rows="3" id="errorCn" class="form-control" style="width:92.5%;"></textarea>
                        </div>
                    </div>
                    <div class="form-group col-md-12 py-sm-2">
                        <label for="managtCn" class="col-sm-2 col-form-label">조치상세내용</label>
                        <div class="col-sm-10">
                            <textarea rows="3" id="managtCn" class="form-control" style="width:92.5%;"></textarea>
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-2">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">소스수정내역ID</label>
                        <div class="col-sm-8">
                            <input type="hidden" id="sourcUpdtId" name="sourcUpdtId">
                            <input type="text" id="sourcUpdtNm" class="form-control" style="width:80%;" />
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-2">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">조치담당자</label>
                        <div class="col-sm-8">
                            <input type="hidden" id="managtChargerId" name="managtChargerId">
                            <input type="text" id="managtChargerNm" class="form-control"  style="width:80%;"/>
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-2">
                        <label for="occrrncDe" class="col-sm-4 col-form-label">발생일</label>
                        <div class="col-sm-6">
                            <div class="input-group date" id="occrrncDeDiv" data-target-input="nearest">
                                <input type="text" id="occrrncDe" name="occrrncDe" class="form-control datetimepicker-input" data-target="#unmanagtErrorSave #occrrncDeDiv"/>
                                <div class="input-group-append" data-target="#occrrncDeDiv" data-toggle="datetimepicker">
                                    <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                </div>
                            </div>
                        </div>                        
                    </div>
                    <div class="form-group col-md-6 py-sm-2">
                        <label for="managtPrearngeDe" class="col-sm-4 col-form-label">조치예정일</label>
                        <div class="col-sm-6">
                            <div class="input-group date" id="managtPrearngeDeDiv" data-target-input="nearest">
                                <input type="text" id="managtPrearngeDe" name="managtPrearngeDe" class="form-control datetimepicker-input" data-target="#unmanagtErrorSave #managtPrearngeDeDiv"/>
                                <div class="input-group-append" data-target="#managtPrearngeDeDiv" data-toggle="datetimepicker">
                                    <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                </div>
                            </div>
                        </div>                        
                    </div>
                    <div class="form-group col-md-6 py-sm-2">
                        <label for="managtComptDe" class="col-sm-4 col-form-label">조치완료일</label>
                        <div class="col-sm-6">
                            <div class="input-group date" id="managtComptDeDiv" data-target-input="nearest">
                                <input type="text" id="managtComptDe" name="managtComptDe" class="form-control datetimepicker-input" data-target="#unmanagtErrorSave #managtComptDeDiv"/>
                                <div class="input-group-append" data-target="#managtComptDeDiv" data-toggle="datetimepicker">
                                    <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-2">
                        <label for="tyCd" class="col-sm-4 col-form-label">현상태</label>
                        <div class="col-sm-8">
                            <select id="managtSttusCd" name="managtSttusCd" class="form-control" style="width:80%;"></select>
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-2">
                        <label for="opertTm" class="col-sm-4 col-form-label">작업시간</label>
                        <div class="col-sm-8">
                             <input type="text" id="opertTm" class="form-control" style="width:80%;" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength=5/>
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-2">
                        <label for="jobChargerGrpwrId" class="col-sm-4 col-form-label">업무담당자</label>
                        <div class="col-sm-8">
                            <input type="hidden" id="jobChargerGrpwrId" name="jobChargerGrpwrId">
                            <input type="text" id="jobChargerGrpwrNm" class="form-control"  style="width:80%;"/>
                        </div>
                    </div>	                
                </form>
                <div class="float-right">
                    <button type="button" class="btn btn-primary" id="unmanagtErrorSaveBtn">저장</button>
                    <button type="button" class="btn btn-primary" id="unmanagtErrorCancelBtn">닫기</button>
                </div>
                <div id="divSearchUser" class="modal fade" tabindex="-1" role="dialog"></div>
            </div>
        </div>
    </div>
</div>
    
<script>

//트랜잭션_오류_일련번호
var unmanagtSn;

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
	    params.push({"id" : "unmanagtErrorSave #cmpnyCd",           "clsCd" : "0024"});    //회사
	    params.push({"id" : "unmanagtErrorSave #errorOccrrncSeCd",  "clsCd" : "0025"});    //오류발생구분
	    params.push({"id" : "unmanagtErrorSave #managtTyCd",        "clsCd" : "0032"});    //조치유형
	    params.push({"id" : "unmanagtErrorSave #managtSttusCd",     "clsCd" : "0031"});    //현상태
	    requestCmmnCd(params);
	    
	    getProcessCdCumstom();
	}
	
	/*
	 * 이벤트 바인딩
	 * @param
	 * @return
	 */
	function bindEvent() {
		
        $("#unmanagtErrorCancelBtn").on("click", function() { 
        	closePOP();
        });
        
        $("#unmanagtErrorSaveBtn").on("click", function() { 
             
        	 if($("#unmanagtErrorSave #cmpnyCd").val() == null || $("#unmanagtErrorSave #cmpnyCd").val() == '') {
                alert("회사를 선택하세요.");                
             } else if($("#unmanagtErrorSave #unmanagtDe").val() == null || $("#unmanagtErrorSave #unmanagtDe").val() == '') {
                 alert("미조치일자를 선택하세요.");             
             } else if($("#unmanagtErrorSave #processCdPop").val() == null || $("#unmanagtErrorSave #processCdPop").val() == '') {
                 alert("프로세스를 선택하세요.");             
             } else if($("#unmanagtErrorSave #errorOccrrncSeCd").val() == null || $("#unmanagtErrorSave #errorOccrrncSeCd").val() == '') {
                 alert("오류발생구분을 입력해주세요.");             
             } else if($("#unmanagtErrorSave #errorTyCd").val() == null || $("#unmanagtErrorSave #errorTyCd").val() == '') {
                 alert("오류유형을 선택해주세요.");
             } else if($("#unmanagtErrorSave #managtSttusCd").val() == null || $("#unmanagtErrorSave #managtSttusCd").val() == '') {
                 alert("현상태를 선택해주세요.");
             } else {
                 saveUnmanagtErrorData();
             }
             /* else if($("#managtDe").val() == null || $("#managtDe").val() == '') {
                 alert("조치일을 입력해주세요.");
             } else if($("#occrrncHm").val() == null || $("#occrrncHm").val() == '') {
                 alert("조치시간을 입력해주세요.");
             } else if($("#processTm").val() == null || $("#processTm").val() == '') {
                 alert("처리시간을 입력해주세요.");
             } else if($("#seDe").val() == null || $("#seDe").val() == '') {
                 alert("구분날짜을 입력해주세요.");
             } else if($("#managtTyCd").val() == null || $("#managtTyCd").val() == '') {
                 alert("조치유형을 입력해주세요.");
             } else if($("#devlopChargerId").val() == null || $("#devlopChargerId").val() == '') {
                 alert("개발담당자를 입력해주세요.");
             }else if($("#managtChargerId").val() == null || $("#managtChargerId").val() == '') {
                 alert("조치담당자를 입력해주세요.");
             }else if($("#occrrncRobotId").val() == null || $("#occrrncRobotId").val() == '') {
                 alert("발생로봇을 입력해주세요.");
             */
        });
        
        //미조치일
        $("#unmanagtDeDiv").datetimepicker({
            format: 'YYYY-MM-DD'
          , defaultDate: (new Date())
        });
        //발생일
        $("#occrrncDeDiv").datetimepicker({
            format: 'YYYY-MM-DD'
          , defaultDate: (new Date())
        });
        //조치예정일
        $("#managtPrearngeDeDiv").datetimepicker({
            format: 'YYYY-MM-DD'
          , defaultDate: (new Date())
        });
        //조치완료일
        $("#managtComptDeDiv").datetimepicker({
            format: 'YYYY-MM-DD'
          , defaultDate: (new Date())
        });
        
        //오류발생구분 change 이벤트
        $("#unmanagtErrorSave #errorOccrrncSeCd").on("change",function(){
            var occrrncSeCd = $('#unmanagtErrorSave #errorOccrrncSeCd').val(); 
            if(occrrncSeCd != ""){
                chgOccrrncSeCd(occrrncSeCd);    
            }else{
                $("select#errorTyCd option").remove();
            }
        });
        
        //프로세스 선택시 프로세스명 가져오기
        $("#unmanagtErrorSave #processCdPop").on("change",function(){
            var processCdPop = $('#unmanagtErrorSave #processCdPop').val(); 
            chgProcessCdPop(processCdPop);            
        });
        
        //소스수정id
        $("#sourcUpdtNm").on("click",function(){
            openGwpwrUserPopup("divSearchUser", "callbackSourcUpdt");        	
        });
        
        //조치담당자
        $("#managtChargerNm").on("click",function(){
            openGwpwrUserPopup("divSearchUser", "callbackManagtCharger");           
        });
        
        //업무담당자
        $("#jobChargerGrpwrNm").on("click",function(){
            openGwpwrUserPopup("divSearchUser", "callbackJobChargerGrpwr");           
        });
	}
	
	
	/*
     * 사원검색 콜백 함수
     * @param
     * @return
     */
    function callbackSourcUpdt(data) {
        $("#sourcUpdtId").val(data.gwpwrId);
        $("#sourcUpdtNm").val(data.userNm);
    }
	
    function callbackManagtCharger(data) {
        $("#managtChargerId").val(data.gwpwrId);
        $("#managtChargerNm").val(data.userNm);
    }
    
    function callbackJobChargerGrpwr(data) {
        $("#jobChargerGrpwrId").val(data.gwpwrId);
        $("#jobChargerGrpwrNm").val(data.userNm);
    }
	
	/*
     * 데이터 저장
     * @param
     * @return
     */
    function saveUnmanagtErrorData() {
        
    	var opertTm = 0;
        if($("#unmanagtErrorSave #opertTm").val() != "") {
            opertTm = $("#unmanagtErrorSave #opertTm").val();
        }
		
		var param = {
        		cmpnyCd           : $("#unmanagtErrorSave #cmpnyCd").val()
        	  , unmanagtDe        : $("#unmanagtErrorSave #unmanagtDe").val().replace(/-/g, "")
              , processSn         : $("#unmanagtErrorSave #processCdPop").val()
              , errorOccrrncSeCd  : $("#unmanagtErrorSave #errorOccrrncSeCd").val()
              , errorTyCd         : $("#unmanagtErrorSave #errorTyCd").val()
              , errorCn           : $("#unmanagtErrorSave #errorCn").val()
              , managtCn          : $("#unmanagtErrorSave #managtCn").val()
              , sourcUpdtId       : $("#unmanagtErrorSave #sourcUpdtId").val()
              , managtChargerId   : $("#unmanagtErrorSave #managtChargerId").val()
              , occrrncDe         : $("#unmanagtErrorSave #occrrncDe").val().replace(/-/g, "")
              , managtPrearngeDe  : $("#unmanagtErrorSave #managtPrearngeDe").val().replace(/-/g, "")
              , managtComptDe     : $("#unmanagtErrorSave #managtComptDe").val().replace(/-/g, "")
              , managtSttusCd     : $("#unmanagtErrorSave #managtSttusCd").val()
              , opertTm           : opertTm
              , jobChargerGrpwrId : $("#unmanagtErrorSave #jobChargerGrpwrId").val()
              //, where             : {trnscErrorSn : trnscErrorSn}
          };
         callSyncAjax("/mntrng/unmanagterror/saveUnmanagtErrorData", param, "callBackUpdateUnmanagtError");         
    }
	
    /*
     * 저장 후 팝업 닫기
     * @param
     * @return
     */
     function callBackUpdateUnmanagtError(){
         
         alert('저장되었습니다.');
         saveClosePOP();         
     }
    
    
	function chgOccrrncSeCd(occrrncSeCd){
		var params = [];
        if(occrrncSeCd == '01'){
            params.push({"id" : "unmanagtErrorSave #errorTyCd" , "clsCd" : "0026"});    
        }else if(occrrncSeCd == '02'){
            params.push({"id" : "unmanagtErrorSave #errorTyCd" , "clsCd" : "0027"});
        }else if(occrrncSeCd == '03'){
            params.push({"id" : "unmanagtErrorSave #errorTyCd" , "clsCd" : "0028"});
        }else if(occrrncSeCd == '04'){
            params.push({"id" : "unmanagtErrorSave #errorTyCd" , "clsCd" : "0029"});
        }else if(occrrncSeCd == '05'){
            params.push({"id" : "unmanagtErrorSave #errorTyCd" , "clsCd" : "0030"});
        }else{}
        
        requestCmmnCd(params);
	}
	
	//프로세스 콤보 선택시 프로세스명 선택
	function chgProcessCdPop(processCdPop){
		var processCdHidden = $("#unmanagtErrorSave #processCdHidden_" + processCdPop).val();
		$("#unmanagtErrorSave #processNm").val(processCdHidden);
    }
	
	/*
	 * 프로세스 코드 콤보 박스 데이터 요청
	 * 사용예 :
	 * @param : id 
	 * @return
	 */
	function getProcessCdCumstom() {
	        var param = {};
	        $.ajax({
	            type: "post",
	            url: "/resrce/process/getProcessCdListByClsCd",
	            async: false,
	            dataType: "json",
	            contentType : "application/json;charset=UTF-8",
	            data: JSON.stringify(param),
	            success : function(data){ 
	                if (data.responseCode != null && data.responseCode != undefined && data.responseCode.substr(0, 1) != "E") {
	                    
	                    var tmp = '';
	                    var hiddenTmp = '';
	                    tmp = "<option value=''>선택</option>";
	                    $.each(data.result, function(idx, cd) {
	                        tmp +=       "<option  id=processCdPop_" + cd.processSn + " value='" + cd.processSn + "'>" + cd.processCd + "</option>";
	                        hiddenTmp += "<option  id=processCdHidden_" + cd.processSn + " value='" + cd.processNm + "'>" + cd.processSn + "</option>";
	                    });

	                    $("#processCdPop").html(tmp);	                    
	                    $("#processCdHidden").html(hiddenTmp);
	                }
	            },
	            error: function(request, status, err){
	                alert(request.responseText);
	            }	            
	    }); 
	}

</script>









