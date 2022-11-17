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
	            <form class="form-inline" id="jobErrorDetail">
					<input type="hidden" id="id" name="id"/>
					<input type="hidden" id="cmpnyCd" name="cmpnyCd"/>
                	<div class="form-group col-md-6 py-sm-1">
                        <label for="cmpnyNm" class="col-sm-4 col-form-label">회사</label>
                        <div class="col-sm-8">
                            <input type="text" id="cmpnyNm" class="form-control" disabled style="width:80%;"/>
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-1">
                        <label for="occrrncDt" class="col-sm-4 col-form-label">발생일시</label>
                        <div class="col-sm-8">
                            <input type="text" id="occrrncDt" class="form-control" disabled style="width:80%;"/>
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-1">
                        <label for="processCd" class="col-sm-4 col-form-label">프로세스코드</label>
                        <div class="col-sm-8">
                            <input type="text" id="processCd" class="form-control" disabled style="width:80%;"/>
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-1">
                        <label for="processNm" class="col-sm-4 col-form-label">프로세스명</label>
                        <div class="col-sm-8 float-left">
                            <input type="text" id="processNm" class="form-control" disabled style="width:80%;"/>
                        </div>
                    </div>
                    <div class="form-group col-md-12 py-sm-1">
                        <label for="errorCn" class="col-sm-2 col-form-label">오류내용</label>
                        <div class="col-sm-10">
                            <textarea rows="5" id="errorCn" class="form-control" maxlength="1000" disabled style="width:92.5%;"></textarea>
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-1 jq_trans_view" style="display:none">
                        <label for="occrrncSeCd" class="col-sm-4 col-form-label">오류발생구분<b style="color: red;"> *</b></label>
                        <div class="col-sm-8">
                            <select id="occrrncSeCd" name="occrrncSeCd" class="form-control" style="width:80%;">
                                <option value=''>선택</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-1 jq_trans_view" style="display:none">
                        <label for="tyCd" class="col-sm-4 col-form-label">오류유형<b style="color: red;"> *</b></label>
                        <div class="col-sm-8">
                            <select id="tyCd" name="tyCd" class="form-control" style="width:80%;">
                                <option value=''>선택</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group col-md-12 py-sm-1 jq_trans_view" style="display:none">
                        <label for="analsCn" class="col-sm-2 col-form-label">분석내용<b style="color: red;"> *</b></label>
                        <div class="col-sm-10">
                            <textarea rows="3" id="analsCn" class="form-control" maxlength="1000" style="width:92.5%;"></textarea>
                        </div>
                    </div>
                    <div class="form-group col-md-12 py-sm-1 jq_trans_view" style="display:none">
                        <label for="managtCn" class="col-sm-2 col-form-label">조치내용<b style="color: red;"> *</b></label>
                        <div class="col-sm-10">
                            <textarea rows="3" id="managtCn" class="form-control" maxlength="1000" style="width:92.5%;"></textarea>
                        </div>
                    </div>
                    <div class="form-group col-md-6 jq_trans_view" style="display:none">
                        <label for="processTm" class="col-sm-4 col-form-label">처리시간<b style="color: red;"> *</b></label>
                        <div class="col-sm-8">
                            <input type="text" id="processTm" name="processTm" class="form-control" maxlength="4" style="width:80%;" decimalnumbertype1/>H
                        </div>
                    </div>
                    <div class="form-group col-md-6 jq_trans_view" style="display:none">
                        <label for="seDe" class="col-sm-4 col-form-label">조치일시<b style="color: red;"> *</b></label>
                        <div class="col-sm-4">
                             <div class="input-group date float-left" id="managtDeDiv" data-target-input="nearest"style="min-width:140px;width:100%;margin-right:5px;">
                                  <input type="text" id="managtDe" name="managtDe" class="form-control datetimepicker-input" data-target="#managtDiv"/>
                                  <div class="input-group-append" data-target="#managtDeDiv" data-toggle="datetimepicker">
                                      <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                  </div>
                              </div>
                        </div>
                        <div class="col-sm-4 float-left">
                            <input type="text" id="managtHh" name="managtHh" class="form-control" maxlength="2" style="width:20%;" numberonly>시<input type="text" id="managtMm" name="managtMn" class="form-control" maxlength="2" style="width:20%;" numberonly>분
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-1 jq_trans_view" style="display:none">
                        <label for="managtTyCd" class="col-sm-4 col-form-label">조치유형<b style="color: red;"> *</b></label>
                        <div class="col-sm-8">
                            <select id="managtTyCd" name="managtTyCd" class="form-control" style="width:80%;"></select>
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-1 jq_trans_view" style="display:none">
                        <label for="sourcUpdtId" class="col-sm-4 col-form-label">소스수정내역ID</label>
                        <div class="col-sm-8 float-left">
                            <input type="text" id="sourcUpdtId" name="processTm" class="form-control" maxlength="4" style="width:80%;"/>
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-1 jq_trans_view" style="display:none">
                        <label for="devlopChargerNm" class="col-sm-4 col-form-label">개발담당자<b style="color: red;"> *</b></label>
                        <div class="col-sm-8 float-left">
                            <input type="hidden" id="devlopChargerId" name="devlopChargerId">
                            <input type="text" id="devlopChargerNm" class="form-control float-left" disabled class="form-control float-left" style="width:65%;margin-right:5px" />
                            <button type="button" class="btn btn-outline-primary float-left" id="btnSchDevlopChargerId">찾기</button>
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-1 jq_trans_view" style="display:none">
                        <label for="analsChargerNm" class="col-sm-4 col-form-label">조치담당자<b style="color: red;"> *</b></label>
                        <div class="col-sm-8 float-left">
                            <input type="hidden" id="managtChargerId" name="analsChargerId">
                            <input type="text" id="managtChargerNm" class="form-control float-left" disabled  class="form-control float-left" style="width:65%;margin-right:5px" />
                            <button type="button" class="btn btn-outline-primary float-left" id="btnSchAnalsChargerId">찾기</button>
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-1 jq_trans_view" style="display:none">
                        <label for="robotNm" class="col-sm-4 col-form-label">발생로봇</label>
                        <div class="col-sm-8 float-left">
                            <input type="text" id="robotNm" name="robotNm" class="form-control" disabled maxlength="4" style="width:80%;"/>
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-1 jq_trans_view" style="display:none">
                        <label for="sttusCd" class="col-sm-4 col-form-label">조치상태<b style="color: red;"> *</b></label>
                        <div class="col-sm-8">
                            <select id="sttusCd" name="sttusCd" class="form-control" style="width:80%;"></select>
                        </div>
                    </div>
                </form>
                <div class="py-sm-2 float-right" >
<c:if test="${txScreenAuthor.wrtngAuthor eq 'Y'}">
                    <button type="button" class="btn btn-primary" id="jobErrorSave" style="display:none">저장</button>
</c:if>
                    <button type="button" class="btn btn-primary" id="jobErrorCancel">닫기</button>
                </div>
                <div id="divSearchUser" class="modal fade" tabindex="-1" role="dialog"></div>
            </div>
        </div>
    </div>
</div>
    
<script>

//업무오류일련번호
var jboErrorSn;

$(document).ready(function() {
	//페이지 초기화
	pageInit();
	
	//이벤트 바인딩
	bindEvent();
	
	// 숫자입력 필드 이벤트 
    $("input:text[numberOnly2]").on("focus", function() {
        var x = $(this).val();
        x = removeCommas(x);
        $(this).val(x);
    }).on("focusout", function() {
        var x = $(this).val();
        if(x && x.length > 0) {
            if(!$.isNumeric(x)){
                x = x.replace(/[^0-9.]/g,"");
            }
            
            if (x.indexOf('.')){
                var two = /^\d*[.]\d{2}$/;
                if(!two.test(x)){
                    x = x.slice(0,4);
                }
            }else{
                x = addCommas(x);
            }
            $(this).val(x);
        }
    }).on("keyup", function() {
        $(this).val($(this).val().replace(/[^0-9.]/g,""));
    });
});
	
	/*
	 * 페이지 초기화
	 * @param
	 * @return
	 */
	function pageInit() {
		var params = [];
        params.push({"id" : "jobErrorDetail #occrrncSeCd", "clsCd" : "0025"});    //오류발생구분
        params.push({"id" : "managtTyCd", "clsCd" : "0032"});                     //조치유형
        params.push({"id" : "managtSttusCd", "clsCd" : "0031"});                  //현상태
        requestCmmnCd(params);
        
      //상세 페이지 데이터 조회
      getDetailData(jboErrorSn);
	}
	
	/*
	 * 이벤트 바인딩
	 * @param
	 * @return
	 */
	function bindEvent() {
		
		$("#managtDeDiv").datetimepicker({
            format: 'YYYY-MM-DD'
//          , defaultDate: (new Date())
        });
		
        $("#jobErrorCancel").on("click", function() { 
        	closePOP();
        });
        
        $("#jobErrorSave").on("click", function() { 
        	var sSttusCd = $("#sttusCd").val();
			let sManagtHm = "";
			if(sSttusCd == "03"){
				if($.trim($("#occrrncSeCd").val()) == ""){
					alert("오류발생구분을 입력해주세요.");
					$("#occrrncSeCd").focus();
					return false;
				}
				else if($.trim($("#tyCd").val()) == ""){
					alert("오류유형을 선택해주세요.");
					$("#tyCd").focus();
					return false;
				}
				else if($.trim($("#analsCn").val()) == ""){
					alert("분석내용을 선택해주세요.");
					$("#analsCn").focus();
					return false;
				}
				else if($.trim($("#managtCn").val()) == ""){
					alert("조치내용을 선택해주세요.");
					$("#managtCn").focus();
					return false;
				}
				else if($.trim($("#processTm").val()) == ""){
					alert("처리시간을 입력해주세요.");
					$("#processTm").focus();
					return false;
				}
				else if($.trim($("#managtDe").val()) == ""){
					alert("조치일시 > 날짜를  선택해주세요.");
					$("#managtDe").focus();
					return false;
				}
				else if($.trim($("#managtHh").val()) == ""){
					alert("조치일시 > 시간을  입력해주세요.");
					$("#managtHh").focus();
					return false;
				}
				else if($.trim($("#managtMm").val()) == ""){
					alert("조치일시 > 분을  입력해주세요.");
					$("#managtMm").focus();
					return false;
				}
				else if($.trim($("#managtTyCd").val()) == ""){
					alert("조치유형을  선택해주세요.");
					$("#managtTyCd").focus();
					return false;
				}
				else if($.trim($("#devlopChargerNm").val()) == ""){
					alert("개발담당자를 선택해주세요.");
					$("#devlopChargerNm").focus();
					return false;
				}
				else if($.trim($("#managtChargerNm").val()) == ""){
					alert("조치담당자를 선택해주세요.");
					$("#managtChargerNm").focus();
					return false;
				}
			}
			
			if($.trim($("#managtHh").val()) != "" && $.trim($("#managtMm").val()) != ""){
				const iHh = parseInt($("#managtHh").val());
				const iMm = parseInt($("#managtMm").val());
				if(iHh < 0 || iHh > 23){
					alert("조치일시 > 시간은 0~23까지 입력가능합니다..");
					$("#managtHh").focus();
					return false;
				}
				
				if(iMm < 0 || iMm > 59){
					alert("조치일시 > 분은 0~59까지 입력가능합니다..");
					$("#managtMm").focus();
					return false;
				}
				
				sManagtHm = $("#managtHh").val() + "-" + $("#managtMm").val();
			}
			else if($.trim($("#managtHh").val()) != ""){
				if($.trim($("#managtMm").val()) == ""){
					alert("조치일시 > 분을  입력해주세요.");
					$("#managtMm").focus();
					return false;
				}
			}
 			else if($.trim($("#managtMm").val()) != ""){
				if($.trim($("#managtHh").val()) == ""){
					alert("조치일시 > 시간을  입력해주세요.");
					$("#managtHh").focus();
					return false;
				}
			}
			
			if($.trim($("#sttusCd").val()) == ""){
				alert("조치상태를  선택해주세요.");
				$("#sttusCd").focus();
				return false;
			}
			
			var param = {
					occrrncSeCd				: $("#occrrncSeCd").val()
					, tyCd					: $("#tyCd").val()
					, analsCn				: $("#analsCn").val()
					, managtCn				: $("#managtCn").val()
					, processTm				: $("#processTm").val()
					, managtDe				: $("#managtDe").val().replace(/-/g, "")
					, managtHm				: sManagtHm
					, managtTyCd			: $("#managtTyCd").val()
					, sourcUpdtId			: $("#sourcUpdtId").val()
					, devlopChargerId		: $("#devlopChargerId").val()
					, managtChargerId		: $("#managtChargerId").val()
					, sttusCd     			: $("#sttusCd").val()
					, where                 : {id : $("#id").val()}
			    	, cmpnyCd				: $("#cmpnyCd").val()
			    	, processCd				: $("#processCd").val()
	    			
				}
	         callSyncAjax("/mntrng/joberror/updateDetailData", param, "callBackUpdateDetailData");
            
        });
        
        //오류발생구분 change 이벤트
        $("#jobErrorDetail #occrrncSeCd").on("change",function(){
            var occrrncSeCd = $('#jobErrorDetail #occrrncSeCd').val(); 
            chgOccrrncSeCd(occrrncSeCd);
        });
        
        $('#managtDiv').datetimepicker({
            format: 'YYYY-MM-DD'
          , defaultDate: (new Date())
        });
        
        $("#seDeDiv").datetimepicker({ 
            format: 'YYYY-MM-DD' 
          //, defaultDate: (new Date())
        });
        
        //개발담당자
        $("#btnSchDevlopChargerId").on("click",function(){ 
            openGwpwrUserPopup("divSearchUser", "callbackDevlopCharger");           
        });
      
      	//분석담당자
        $("#btnSchAnalsChargerId").on("click",function(){ 
            openGwpwrUserPopup("divSearchUser", "callbackAnalsCharger");           
        });
	
	}
	
	/*
	 * 데이터 조회
	 * @param
	 * @return
	 */
	function getDetailData(jobId) {
		var param = {"where" : {"id": jobId}};
		callSyncAjax("/mntrng/joberror/getJobErrorDetail", param, "printDetailData");
		
        $('.dimmed').css({ display: 'none' });
        $('.loading').css({ display: 'none' });
        $('.loading').removeClass('show');
	}
	
    /*
     * 데이터 출력
     * @param
     * @return
     */
	function printDetailData(data) {
    	if (data != null &&  data.result != null) {
    		$("#id").val(data.result.id);
    		$("#cmpnyCd").val(data.result.cmpnyCd);
    		$("#cmpnyNm").val(data.result.cmpnyNm);
    		$("#occrrncDt").val(data.result.occrrncDt);
    		$("#processCd").val(data.result.processCd);
    		$("#processNm").val(data.result.processNm);
    		$("#errorCn").val(data.result.errorCn);
    		
    		if(data.result.state == "4" || data.result.state == "6"){
    			$(".jq_trans_view").show();
    		}
    		else{
    			return false;
    		}
    		
    		var sOccrrncSeCd = data.result.occrrncSeCd == undefined ? "" : data.result.occrrncSeCd; 
    		var sTyCd = data.result.tyCd == undefined ? "" : data.result.tyCd;
    		var sManagtTyCd = data.result.managtTyCd == undefined ? "" : data.result.managtTyCd;
    		var sManagtHm = data.result.managtHm == undefined ? "" : data.result.managtHm;
    		var sSttusCd = data.result.sttusCd == undefined ? "01" : data.result.sttusCd;
    		
			var params = [];
			<c:if test="${txScreenAuthor.wrtngAuthor eq 'Y'}">
    		$("#jobErrorSave").show();
    		</c:if>
			
    		params.push({"id" : "occrrncSeCd", "clsCd" : "0025", "selectValue": sOccrrncSeCd});    
    		//params.push({"id" : "occrrncSeCd", "clsCd" : "0025", "disable" : "Y", "selectValue": "${sessionUserInfo.txCmpnyCd}"});    //회사
    		
    		if(sOccrrncSeCd != ""){
                if(occrrncSeCd != ''){
                	params.push({"id" : "tyCd" , "clsCd" : sOccrrncSeCd, "selectValue": sTyCd});
                }else{
                	$("#tyCd").html("<option value=''>선택</option>");
                }
    		}
    		
    		$("#analsCn").val(data.result.analsCn);
    		$("#managtCn").val(data.result.managtCn);
    		
    		$("#processTm").val(data.result.processTm);
    		
    		params.push({"id" : "managtTyCd" , "clsCd" : "0032", "selectValue": sManagtTyCd});
    		
    		$("#sourcUpdtId").val(data.result.sourcUpdtId);
    		
    		$("#devlopChargerId").val(data.result.devlopChargerId);
    		$("#devlopChargerNm").val(data.result.devlopChargerNm);
    		
    		$("#managtChargerId").val(data.result.managtChargerId);
    		$("#managtChargerNm").val(data.result.managtChargerNm);
    		
    		$("#managtDe").val(data.result.managtDe);
    		
    		if(sManagtHm != ""){
    			const aManagtHm = sManagtHm.split('-');
    			$("#managtHh").val(aManagtHm[0]);
    			$("#managtMm").val(aManagtHm[1]);
    		}
    		$("#robotNm").val(data.result.robotNm);

    		
    		params.push({"id" : "sttusCd" , "clsCd" : "0031", "selectValue": sSttusCd});
    		
            requestCmmnCd(params);
    	}
    	
	}

    
	function callBackUpdateDetailData(){ 
		alert('저장되었습니다.');
		closePOP();
	}
	
	
	function chgOccrrncSeCd(occrrncSeCd){
		var params = [];
		if(occrrncSeCd != ''){
        	params.push({"id" : "tyCd" , "clsCd" : occrrncSeCd});
        	requestCmmnCd(params);
        }
        else{
        	$("tyCd").html("<option value=''>선택</option>");
        }
        
        requestCmmnCd(params);
	}
	
	
	function callbackSourcCharger (data){
		$("#jobErrorDetail #sourcUpdtId").val(data.gwpwrId)
		$("#jobErrorDetail #sourcUpdtNm").val(data.userNm)
	}
	
	function callbackDevlopCharger (data){
        $("#jobErrorDetail #devlopChargerId").val(data.gwpwrId)
        $("#jobErrorDetail #devlopChargerNm").val(data.userNm)
    }
	
	function callbackAnalsCharger (data){
        $("#managtChargerId").val(data.gwpwrId)
        $("#managtChargerNm").val(data.userNm)
    }

</script>









