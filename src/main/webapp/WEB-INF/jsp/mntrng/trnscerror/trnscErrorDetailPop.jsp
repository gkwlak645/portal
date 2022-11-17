<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<div class="card card-primary" id="trnscErrorDetailDiv">
    <div class="card-header">
        <h3 class="card-title">상세조회</h3>
    </div>
    <div class="card-body">
        <div class="row">
            <div class="col-md-12">
                <form class="form-inline" id="trnscErrorDetail">
                	<input type="hidden" id="id" name="id"/>
                	<input type="hidden" id="jobId" name="jobId"/><!-- 중복 오류 확인 -->
                	<input type="hidden" id="robotId" name="robotId"/><!-- Image View -->
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
                        <label for="message" class="col-sm-2 col-form-label">오류메시지</label>
                        <div class="col-sm-10">
                            <input type="text" id="message" class="form-control" disabled style="width:92.5%;"/>
                        </div>
                    </div>
                    <div class="form-group col-md-12 py-sm-1">
                        <label for="errorCn" class="col-sm-2 col-form-label">오류내용</label>
                        <div class="col-sm-10">
                            <textarea rows="5" id="errorCn" class="form-control" maxlength="1000" disabled style="width:92.5%;"></textarea>
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-1 jq_trans_view" style="display:none">
                        <label for="reprsntAt" class="col-sm-4 col-form-label">대표여부</label>
                        <div class="col-sm-8">
                             <input type="text" id="reprsntAt" class="form-control" disabled style="width:80%;" />
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-1 jq_trans_view" style="display:none"></div>
                    <div class="form-group col-md-6 py-sm-1 jq_trans_view" style="display:none">
                        <label for="errorUnitySn" class="col-sm-4 col-form-label">오류통합아이디</label>
                        <div class="col-sm-8">
                             <input type="text" id="errorUnitySn" class="form-control" disabled style="width:80%;" />
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-1 jq_trans_view" style="display:none">
                        <label for="errorUnityCnt" class="col-sm-4 col-form-label">발생건수</label>
                        <div class="col-sm-8">
                            <input type="text" id=errorUnityCnt name=occrrncCnt class="form-control" maxlength="4" style="width:80%;" disabled/>
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
                            <input type="text" id="robotNm" name="processTm" class="form-control" disabled maxlength="4" style="width:80%;"/>
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-1 jq_trans_view" style="display:none">
                        <label for="sttusCd" class="col-sm-4 col-form-label">조치상태<b style="color: red;"> *</b></label>
                        <div class="col-sm-8">
                            <select id="sttusCd" name="sttusCd" class="form-control" style="width:80%;"></select>
                        </div>
                    </div>
                    
                    <div class="form-group col-md-12 py-sm-2 jq_trans_view" style="display:none"><h5 class="text-success">⊙ 오류 통합</h5></div>
                    
                    <div class="col-md-12 float-right jq_trans_view" style="display:none">
                        <button type="button" class="btn btn-outline-primary float-right" id="unityOverTrnsc">중복오류통합</button>
                        <button type="button" class="btn btn-outline-primary float-right" id="releaseOverTrnsc">중복오류해제</button>
                    </div>
                    
                    <div class="col-md-12 py-sm-2 jq_trans_view" style="display:none">
			            <div class="card">
			                <div class="card-body">
			                    <div id="trnscErrorGridPop"></div>
			                    <div id="trnscErrorGridPopPager" class="portal-pager"></div>
			                </div>
			            </div>
			        </div>
                    
                    <div class="form-group col-md-12 py-sm-1 jq_image_view " style="display:none">
                    	<label class="col-sm-2 col-form-label">스크린샷</label>
                        <div class="col-sm-10" id="screenImg">
                         <image id="screenShotDetl" src="" style="width:384px;height:216px;" onclick="imagePopup(this)"></image><br />
                         	이미지를 클릭하시면 원래 크기를 볼 수 있습니다
                         
                    	</div>
                    </div>
                </form>
                <div class="py-sm-1 float-right">
<c:if test="${txScreenAuthor.wrtngAuthor eq 'Y'}">
                    <button type="button" id="trnscErrorSave" class="btn btn-primary" style="display:none">저장</button>
</c:if>
                    <button type="button" class="btn btn-primary" id="trnscErrorCancel">닫기</button>
                </div> 
                <div id="divSearchUser" class="modal fade" tabindex="-1" role="dialog"></div>
            </div>
        </div>
    </div>
</div>
    
<script>

//트랜잭션_오류_일련번호
var trnscErrorSn;

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
      //상세 페이지 데이터 조회
      getDetailData(trnscErrorSn);
	}
	
	/*
	 * 이벤트 바인딩
	 * @param
	 * @return
	 */
	function bindEvent() {
		
        $("#trnscErrorCancel").on("click", function() { 
        	closePOP();
        });
        
        $("#trnscErrorSave").on("click", function() {
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
					, where                 : {sn : $("#id").val()}
				};
	        callSyncAjax("/mntrng/trnscerror/updateTrnscError", param, "callBackUpdateTrnscError");
        });
        
        //오류발생구분 change 이벤트
        $("#trnscErrorDetail #occrrncSeCd").on("change",function(){
            var occrrncSeCd = $('#trnscErrorDetail #occrrncSeCd').val(); 
            chgOccrrncSeCd(occrrncSeCd);
        });
        
        
        $("#overTrnscErrorUnity").on("click", function() { 
        	fncOverTrnscErrorUnity();
        });
        
        $("#managtDeDiv").datetimepicker({
            format: 'YYYY-MM-DD'
//          , defaultDate: (new Date())
        });
        
       //중복오류통합버튼 클릭 이벤트 처리
       /*  $("#trnscErrorDetail #overTrnscErrorUnity").on("click",function(){ debugger;
        	fncOverTrnscErrorUnity();
        }); */
        
        
        //소스수정내역ID
        $("#btnSchSourcUpdtId").on("click",function(){ 
            openGwpwrUserPopup("divSearchUser", "callbackSourcCharger");           
        });
        
        //분석담당자
        $("#btnSchAnalsChargerId").on("click",function(){ 
            openGwpwrUserPopup("divSearchUser", "callbackAnalsCharger");           
        });
      
        //개발담당자
        $("#btnSchDevlopChargerId").on("click",function(){
            openGwpwrUserPopup("divSearchUser", "callbackDevlopCharger");           
        });
	}
	
	/*
	 * 데이터 조회
	 * @param
	 * @return
	 */
	function getDetailData(id) { 
		var param = {"id" : id};
		callSyncAjax("/mntrng/trnscerror/getTrnscErrorDetail", param, "printDetailData");
		
		// 로딩 끝
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
    		var params = [];
    		
    		var sOccrrncSeCd = data.result.occrrncSeCd == undefined ? "" : data.result.occrrncSeCd; 
    		var sTyCd = data.result.tyCd == undefined ? "" : data.result.tyCd;
    		var sManagtTyCd = data.result.managtTyCd == undefined ? "" : data.result.managtTyCd;
    		var sManagtHm = data.result.managtHm == undefined ? "" : data.result.managtHm;
    		var sSttusCd = data.result.sttusCd == undefined ? "" : data.result.sttusCd;
    		var sLosSe = data.result.logSe == undefined ? "" : data.result.logSe;
    		var sLevel = data.result.level == undefined ? "" : data.result.level;
    		
    		$("#id").val(data.result.id);
    		$("#jobId").val(data.result.jobId);
    		$("#robotId").val(data.result.robotId);
    		
    		$("#cmpnyNm").val(data.result.cmpnyNm);
    		$("#occrrncDt").val(data.result.occrrncDt);
    		$("#processCd").val(data.result.processCd);
    		$("#processNm").val(data.result.processNm);

    		$("#message").val(data.result.message);
    		$("#errorCn").val(data.result.errorCn);
    		
    		
    		if(sLosSe == "I"){//이미지 표시
    			const  c_sErrorCn = data.result.errorCn;
    		
    			var sFileName = c_sErrorCn.match( /ExceptionScreenshot_\d{6}\.\d{6}\.png/ );
    	        console.log( sFileName[0] );
    			$(".jq_image_view").show();
    			$("#screenShotDetl").attr("src", "/mntrng/trnscerror/errorImg?robotId=" + data.result.robotId + "&processCd=" + data.result.processCd + "&fileName=" + sFileName);
    			
    			return false;
    		}
    		else if(sLosSe != "T" || (sLevel != "4" && sLevel != "5")){
    			return false;
    		}
    		
    		//------------------------------------------
    		//	트랜잭션 오류 처리
    		//------------------------------------------
    		$(".jq_trans_view").show();
    		<c:if test="${txScreenAuthor.wrtngAuthor eq 'Y'}">
    		$("#trnscErrorSave").show();
    		</c:if>
    		
    		
    		$("#reprsntAt").val(data.result.reprsntAt);
    		$("#errorUnitySn").val(data.result.errorUnitySn);
    		$("#errorUnityCnt").val(data.result.errorUnityCnt);
    		
    		var params = [];
    		
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
            
            searchTrnscErrorPopList();
    	}
	}
    
	function callBackUpdateTrnscError(){
    	console.log("function callBackUpdateTrnscError");
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
	
	
	function fncOverTrnscErrorUnity(){ 
		
		//상세 페이지 div 생성
        appendDetailPopup("trnscErrorDetailDiv", "/mntrng/trnscerror/overTrnscErrorDetailPop");
		
	}
	
	
   function callbackSourcCharger (data){
        $("#trnscErrorDetail #sourcUpdtId").val(data.gwpwrId)
        $("#trnscErrorDetail #sourcUpdtNm").val(data.userNm)
    }
    
    function callbackAnalsCharger (data){
        $("#trnscErrorDetail #managtChargerId").val(data.gwpwrId)
        $("#trnscErrorDetail #managtChargerNm").val(data.userNm)
    }
    
    function callbackDevlopCharger (data){
        $("#trnscErrorDetail #devlopChargerId").val(data.gwpwrId)
        $("#trnscErrorDetail #devlopChargerNm").val(data.userNm)
    }
	

    function imagePopup(oObj){
    	console.log($(oObj).attr("src"));
    	msgWindow = window.open($(oObj).attr("src"),'popup','width=' + screen.availWidth + ',height=' +screen.availHeight + ',top=0,left=0, scrollbars=yes');
    }
    
    /*
     * 그리드 초기화
     * @param
     * @return
     */
    function drawGridPop(data){

        var params = {};
        if (data != null && data != undefined) {
            if (data.result != null && data.result.resultList != null) {
                
                var resultList = data.result.resultList;
                
                $.each(resultList,function(idx,item){
                	resultList[idx].chk = true;
                }); 
                
                params = resultList;
                
            }
            drawPager("trnscErrorGridPopPager", data.result.paginationInfo, "searchTrnscErrorPopList");
        }

        $("#trnscErrorGridPop").jsGrid({
              height : "auto"
            , width : "100%"
            , autoload: true
            , sorting : true
            , align : "center"
            , multiselect: true
            , data : params
            , rowClick: function(arg){
                //trnscErrorDetail(arg.item.trnscErrorSn);
            }
            , fields : [
                  {name: "chk"   , title : ""    , width : 2 , sorting: false ,align : "center"
                	  ,itemTemplate: function(value, item) { 
                          //return $("<input>").html('<input type="checkbox" name="chkOver" value="">');
                		  return $("<input value='"+ item.id + "'>").attr("type", "checkbox").attr("name", "chkOver")
                      }
                      ,headerTemplate: function() {
                          return $("<input>").attr("type", "checkbox")
                          .on("click", function () {
                        	  if($(this).prop("checked")){ 
                        		  $("input[name=chkOver]").prop("checked",true); 
                              }else{ 
                            	  $("input[name=chkOver]").prop("checked",false); 
                              }
                          });
		              }
                  }
                , {name: "occrrncDt"        , title : "발생일시"          , type : "text"        , width : 15, align : "center"}
                , {name: "errorUnitySn"     , title : "오류통합아이디"     , type : "text"        , width : 15, align : "center"}
                , {name: "message"          , title : "오류내용"        , type : "text"        }
                
            ]
        });
    }
    
    /*
     * 검색
     * @param 페이지번호
     * @return
     */
    var currentPopPageNo = 1;
    function searchTrnscErrorPopList(pageNo) {
        var url = '/mntrng/trnscerror/selectOverlapTrnscErrorList';
        currentPopPageNo = 1;
        if (pageNo != null && pageNo != undefined && pageNo != "") {
        	currentPopPageNo = pageNo;
        }
        
        
        var param = {
            currentPageNo         : currentPopPageNo
            , recordCountPerPage    :   10
            , pageSize              :   10
            , id: $("#id").val()
            , jobId: $("#jobId").val()
            , message: $("#message").val()
            
        };

        callAsyncAjax(url, param, "drawGridPop");
    }
    

    $("#unityOverTrnsc").on("click", function() { 
    	const aObjList = $('input:checkbox[name="chkOver"]:checked');
    	const iaObjList = aObjList.length;
    	let aWhereList = [];
    	
    	if(iaObjList < 1){
        	alert("통합할 오류 메시지를 선택해 주십시오.");
        	return false;
        }
    	
    	$.each(aObjList, function(index, item) {
    		aWhereList.push($(item).val());
        });
    	
    	var param = {
    			errorUnitySn: $("#id").val()		//합치기 대상 ID
            	, where: aWhereList
            	, unity: "Y"				//합치기 여부
            };
    	
    	callSyncAjax("/mntrng/trnscerror/setOverlapTrnscError", param, "callBackUpdateDetailData");
    });
    
    
    $("#releaseOverTrnsc").on("click", function() { 
    	const aObjList = $('input:checkbox[name="chkOver"]:checked');
    	const iaObjList = aObjList.length;
    	let aWhereList = [];
    	
    	if(iaObjList < 1){
    		alert("해제할 오류 메시지를 선택해 주십시오.");
        	return false;
        }
    	
    	$.each(aObjList, function(index, item) {
    		aWhereList.push($(item).val());
        });
    	
    	var param = {
    			errorUnitySn: $("#id").val()		//합치기 대상 ID
            	, where: aWhereList
            	, unity: "N"				//해제
            };
    	
    	callSyncAjax("/mntrng/trnscerror/setOverlapTrnscError", param, "callBackUpdateDetailData");
    });
    function callBackUpdateDetailData(data){
    	$("#errorUnityCnt").val(data.result.errorUnityCount);
    	$("#reprsntAt").val(data.result.reprsntAt);
    	alert('저장되었습니다.');
    	searchTrnscErrorPopList();
	}
    
    

    

    
</script>









