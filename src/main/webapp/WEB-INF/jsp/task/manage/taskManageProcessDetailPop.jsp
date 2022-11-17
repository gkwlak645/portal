<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!--  템플릿 바디 -->
 <div class="card card-primary" id="proDetailPopMainDiv">
    <div class="card-header" alt="과제 >과제운영>프로세스상세">
        <h3 class="card-title">상세</h3>
    </div>
    <div class="card-body">
        <div class="row" style="min-height:560px;">
            <div class="col-md-12">
                <form class="form-inline" id="unmanagtErrorDetail">
                    <div class="form-group col-md-12"><h5 class="text-success">⊙  과제정보</h5></div>
                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">과제명<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8">
                            <input type="text" id="taskCd" class="form-control"  style="width:80%;" disabled>
                        </div>
                    </div>
                    
                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">과제명<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8">
                            <input type="text" id="taskNm" class="form-control"  style="width:80%;" disabled>
                        </div>
                    </div>
                    
                    <div class="form-group col-md-12">
                        <label for="errorCn" class="col-sm-2 col-form-label">과제설명<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-10">
                            <textarea rows="1" id="taskDc" class="form-control" style="width:92.5%;" disabled></textarea>
                        </div>
                    </div>

                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">회사<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8">
                            <select id="cmpnyCd" class="form-control" style="width:80%;margin-right: 3px;" type="text" disabled></select>
                        </div>
                    </div>

                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">분류<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8">
                            <select id="clsCd" class="form-control" style="width:80%;margin-right: 3px;" disabled></select>
                        </div>
                    </div>

                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">업무담당부서<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8">
                            <input type="text" id="jobChrgDeptNm" class="form-control"  style="width:80%;" disabled>
                        </div>
                    </div>
                    
                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">업무담당자<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8">
                            <input type="text" id="jobChargerNm" class="form-control"  style="width:80%;" disabled>
                        </div>
                    </div>
                    
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">업무시간</label>
                        <div class="col-sm-8">
                            <input type="text" id="jobTm" class="form-control float-left" style="width:120px;margin-right: 3px;" value="" type="text" disabled>H
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">빈도</label>
                        <div class="col-sm-8">
                            <select id="fqCd" class="form-control float-left" style="width:30%;margin-right: 10px;" disabled></select>
                            <input type="text" id="executCnt" class="form-control float-left" style="width:120px;margin-right: 3px;" type="text" value=""disabled>회
                        </div>
                    </div>

                    <div class="col-md-12 m-3"></div>

                    <div class="form-group col-md-12"><h5 class="text-success">⊙ 프로세스정보</h5></div>

                    <div class="form-group col-md-12">
                        <label for="" class="col-sm-2 col-form-label">제목</label>
                        <div class="col-sm-10">
                            <input type="text" id="sj" class="form-control"  style="width:92.5%;"disabled/>
                        </div>
                    </div>

                    <div class="form-group col-md-6">
                        <label for="" class="col-sm-4 col-form-label">프로세스코드</label>
                        <div class="col-sm-8">
                            <input type="text" id="processCd" class="form-control"  style="width:80%;" value="H00101" disabled>
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">프로세스명</label>
                        <div class="col-sm-8">
                            <input type="text" id="processNm" class="form-control"  style="width:80%;" disabled>
                        </div>
                    </div>

                    <div class="form-group col-md-12  py-sm-1">
                        <label for="" class="col-sm-2 col-form-label">업무설명</label>
                        <div class="col-sm-10">
                            <textarea rows="10" id="jobDc" class="form-control" style="width:92.5%;" disabled></textarea>
                        </div>
                    </div>

                    <div class="form-group col-md-6">
                        <label for="" class="col-sm-4 col-form-label">업무분류</label>
                        <div class="col-sm-8">
                            <select id="jobClsCd" class="form-control" style="width:80%;margin-right: 3px;" disabled></select>
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="" class="col-sm-4 col-form-label">RPA분류</label>
                        <div class="col-sm-8">
                            <select id="rpaClsCd" class="form-control" style="width:80%;margin-right: 3px;" disabled></select>
                        </div>
                    </div>

                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">회사<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-6">
                            <select id="cmpnyCdPrc" class="form-control" style="width:80%;margin-right: 3px;" type="text" disabled></select>
                        </div>
                    </div>

                    <div class="form-group col-md-6">
                        <label for="" class="col-sm-4 col-form-label">업무시간</label>
                        <div class="col-sm-8">
                            <input type="text" id="jobTmPrc" class="form-control float-left" style="width:120px;margin-right: 3px;" value="264" disabled>H
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="" class="col-sm-4 col-form-label">예상절감시간①</label>
                        <div class="col-sm-8">
                            <input type="text" id="redcnTm" class="form-control float-left" style="width:120px;margin-right: 3px;" value="264" disabled>H
                        </div>
                    </div>

                    <div class="form-group col-md-6">
                        <label for="" class="col-sm-4 col-form-label">예상절감금액<br/>(① X 33,000원)</label>
                        <div class="col-sm-8">
                            <input type="text" id="expectRedcnAmt" class="form-control float-left" style="width:120px;margin-right: 3px;" value="8,712,000" disabled>원
                        </div>
                    </div>

                    <div class="form-group col-md-6">
                        <label for="" class="col-sm-4 col-form-label">주기</label>
                        <div class="col-sm-8">
                            <select id="fqCdPrc" class="form-control float-left" style="width:30%;margin-right: 10px;" disabled></select>
                            <input type="text" id="executCntPrc" class="form-control float-left" style="width:120px;margin-right: 3px;" type="text" value="22" disabled>회
                        </div>
                    </div>

                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">시간</label>
                        <div class="col-sm-8">
                            <input type="text" id="executTm" class="form-control float-left" style="width:120px;margin-right: 3px;" value="1" disabled>H
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">긴급대응</label>
                        <div class="col-sm-8">
                            <input type="text" id="emrgncyCrspnd" class="form-control"  style="width:80%;" disabled>
                        </div>
                        
                    </div>

                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">개발공수②</label>
                        <div class="col-sm-8">
                            <input type="text" id="devlopWdcnt" class="form-control float-left" style="width:120px;margin-right: 3px;" value="10" disabled>일
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">예상개발비용<br/>(② X 8.5Hr X 33,000원)</label>
                        <div class="col-sm-8">
                            <input type="text" id="expectDevlopCt" class="form-control float-left" style="width:120px;margin-right: 3px;" value="2,805,000" disabled>원
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">RTO</label>
                        <div class="col-sm-8">
                            <input type="text" id="rto" class="form-control float-left" style="width:120px;margin-right: 3px;" value="1" disabled>H
                        </div>
                    </div>

                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">ROI평가<br/>(② X 10 ≤ ①)</label>
                        <div class="col-sm-8">
                            <input type="text" id="roiEvaluate" class="form-control"  style="width:80%;" disabled>
                        </div>
                    </div>

                    <div class="form-group col-md-12  py-sm-1">
                        <label for="errorCn" class="col-sm-2 col-form-label">업무설명</label>
                        <div class="col-sm-10">
                            <textarea rows="2" id="devlopResn" class="form-control" style="width:92.5%;" disabled></textarea>
                        </div>
                    </div>
                    
                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">내부개발여부<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8">
                            <select id="insideDevlopAt" class="form-control" style="width:80%;margin-right: 3px;" disabled></select>
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="devlopChargerNm" class="col-sm-4 col-form-label">개발담당자</label>
                        <div class="col-sm-8 float-left">
                            <input type="hidden" id="devlopChargerId" name="devlopChargerId">
                            <input type="text" id="devlopChargerNm" class="form-control float-left" disabled class="form-control float-left" style="width:65%;margin-right:5px" />
                            <!-- <button type="button" class="btn btn-outline-primary float-left" id="btnSchDevlopChargerId">찾기</button> -->
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="devlopChargerNm" class="col-sm-4 col-form-label">실행구분<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8 float-left">
                            <select id="executSe" class="form-control" style="width:80%;margin-right: 3px;" disabled></select>
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="belongingDe" class="col-sm-4 col-form-label">개발귀속일<b style="color: red;"> *</b></label>
                        <div class="col-sm-4">
                             <div class="input-group date float-left" id="belongingDeDiv" data-target-input="nearest"style="min-width:140px;width:100%;margin-right:5px;">
                                  <input type="text" id="belongingDe" name="belongingDe" class="form-control datetimepicker-input" data-target="#belongingDeDiv" disabled/>
                                  <div class="input-group-append" data-target="#belongingDeDiv" data-toggle="datetimepicker">
                                      <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                  </div>
                              </div>
                        </div>
                    </div>

                    <div class="form-group col-md-12">
                        <label for="managtChargerId" class="col-sm-2 col-form-label">첨부파일 </label>
                        <div class="col-sm-10">
                            <div class="form-check2 row"  id="fileUpload" disabled></div>
                        </div>
                   </div>

                    <div class="form-group col-md-12">
                        <label for="managtChargerId" class="col-sm-2 col-form-label">연관문서 </label>
                        <div class="col-sm-10">
                            <input type="text" id="fileGrpNo" class="form-control"  style="width:92.5%;"value="개발지침.pptx" disabled>
                       </div>
                   </div>


                   <div class="col-md-12 m-3"></div>

                    <div class="form-group col-md-12">
                        <div class="col-sm-4"><h5 class="text-success float-left">⊙ 담당자 정보</h5></div>
                        <div class="col-sm-8"></div>
                    </div>

                   <div class="form-group col-md-12" id="chargerList"></div>

                    <div class="col-md-12 m-3"></div>
                    <div class="form-group col-md-12">
                        <div class="col-sm-4"><h5 class="text-success float-left">⊙ 개인별 절감시간</h5></div>
                        <div class="col-sm-8"></div>
                     </div>
                     
                     <div class="form-group col-md-12" id="individualRedcnTmList"></div>

                     <div class="form-group col-md-12 py-sm-1 line-footer">
                        <div class="form-group col-md-6"></div>
                        <div class="form-group col-md-6">
                            <label for="sourcUpdtNm" class="col-sm-4 col-form-label text-warning" >합계(hour)</label>
                            <div class="col-sm-8">
                                <input type="text" id="redcnTmSum" class="form-control text-warning" style="width:40%; margin:2px 5px 0px 2px;" value="" disabled>
                            </div>
                        </div>
                    </div>


                    <div class="col-md-12 m-3"></div>
                    <div class="form-group col-md-12">
                        <div class="col-sm-4"><h5 class="text-success float-left">⊙ 개인별 기여도</h5></div>
                        <div class="col-sm-8"></div>
                     </div>
                     
                     <div class="form-group col-md-12" id="individualContributeList"></div>

                    <div class="form-group col-md-12 py-sm-1 line-footer">
                        <div class="form-group col-md-6"></div>
                        <div class="form-group col-md-6">
                            <label for="sourcUpdtNm" class="col-sm-4 col-form-label text-warning" >합계(%)</label>
                            <div class="col-sm-8">
                                <input type="text" id="contributeSum" class="form-control float-left text-warning" style="width:40%; margin:2px 5px 0 2px;" value="" disabled>
                            </div>
                         </div>
                    </div>


                    <div class="col-md-12 m-3"></div>
                    <div class="form-group col-md-12"><h5 class="text-success">⊙  실행정보</h5></div> 
                    
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">프로세스파일</label>
                        <div class="col-sm-8 float-left">
                            <div class="form-check2 row"  id="fileUpload2" disabled></div>
                        </div> 
                    </div>
                    
                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">실행구분</label>
                        <div class="col-sm-8">
                           <select id="executSe" class="form-control" style="width:40%;" disabled></select> 
                        </div>
                    </div>

                    <div class="form-group col-md-12">
                        <label class="col-sm-4 float-left">업무시스템</label>
                        <div class="col-sm-8 float-right"></div>
                    </div>
                    <div class="form-group col-md-12">
                        <table class="table" style="padding:0" id="cntcSysList">
                            <colgroup>
                              <col width="20%">
                              <col width="22%">
                              <col width="20%">
                              <col width="*">
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>분류</th>
                                    <th>회사</th>
                                    <th>시스템코드</th>
                                    <th>시스템명</th>
                                </tr>
                            </thead>
                            <tbody></tbody>
                         </table>
                    </div>

                    <div class="form-group col-md-12" id="schtextDivList">
						<div class="form-group col-md-6" id="schtextDivList1">
						    <label for="sourcUpdtNm" class="col-sm-4 col-form-label">실행구분</label>
						    <div class="col-sm-8">
						    <input type="text" id="" class="form-control float-left" style="width:40%; margin:2px 5px 10px 0;" value="정기실행" disabled >
						    </div>
						</div>
						<div class="form-group col-md-6" id="schtextDivList2">
						    <label for="managtChargerId" class="col-sm-4 col-form-label">실행계획</label>
						    <div class="col-sm-8">
						       <input type="text" id="" class="form-control float-left" style="width:100%; margin:2px 5px 10px 0;" value="" disabled >
						    </div>
						</div>
                    </div>

                    <div class="form-group col-md-12">
	                    <div class="form-group col-md-6">
	                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">실행구분</label>
	                        <div class="col-sm-8">
	                            <input type="text" id="" class="form-control float-left" style="width:40%; margin:2px 5px 10px 0;" value="예약실행" disabled >
	                        </div>
	                    </div>
	                    <div class="form-group col-md-6">
	                        <label for="managtChargerId" class="col-sm-4 col-form-label">실행계획</label>
	                        <div class="col-sm-8">
	                           <input type="text" id="rsvDt" class="form-control float-left" style="width:100%; margin:2px 5px 10px 0;" value="" disabled >
	                        </div>
	                    </div>
                    </div>

                     <div class="col-md-12 m-3"></div>
                    <div class="form-group col-md-12"><h5 class="text-success">⊙  상태</h5></div>
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">프로세스상태</label>
                        <div class="col-sm-8">
                            <select id="processSttus" class="form-control" style="width:40%;margin-right: 3px;" disabled></select>
                        </div>
                    </div>
                    
                    
                    
                    <div class="form-group col-md-12" id="calendarDivList">  </div>
                    
                    
                    
                </form>
                <div class="float-right py-sm-2">
<c:if test="${txScreenAuthor.wrtngAuthor eq 'Y'}">                
<%--
                    <button type="button" class="btn btn-primary" id="saveCalenBtn">휴일관리저장</button>
                    <button type="button" class="btn btn-primary" id="resurvRun">예약실행</button>
                    <button type="button" class="btn btn-primary" id="scheduleRun">정기실행</button>
--%>
                    <button type="button" class="btn btn-primary" id="cancelPop">운영취소요청</button>
</c:if>                    
                    <button type="button" class="btn btn-primary" id="popCloseBtn">닫기</button>
                     <input type="hidden" id="processNo" value="">
                     <input type="hidden" id="devlopSn" value="">
                </div>
                <div id="divSearchUser" class="modal fade" tabindex="-1" role="dialog"></div>
                <div id="divModal" class="modal fade jq_inModal" tabindex="-1" role="dialog"></div>
            </div>
        </div>
    </div>
</div>


<script>

var iFileGrpNo =0;
var iFileGrpNo2 =0;
var oRpaUploadUpload;
var oRpaUploadUpload2;
var LC_SCHDULE_DATA = null;   //정기 실행 계획

$(document).ready(function() {
    //이벤트 바인딩
    pageInit();
    bindEvent();
});


function pageInit(){
	
	//권한에 따른 다운로드 버튼 제외 페이지 여부
    isDownloadBtnRolePageAt = true;
    
    //다운로드 버튼 권한 여부
    isDownloadBtnRoleAt = ${isDownloadBtnRoleAtFlag};
	
    oRpaUploadUpload = new RpaUploadV2("fileUpload");
    oRpaUploadUpload2 = new RpaUploadType2("fileUpload2");
};

/*
 * 이벤트 바인딩
 * @param
 * @return
 */
function bindEvent() {

    $("#popCloseBtn").on("click", function() {
        closePop();
    });
    
    //정기실행계획 저장
    $("#savePlanBtn").on("click", function() {
        var params = {
        	processCd : $('#processCd').val()
        	, schduleData : LC_SCHDULE_DATA
        }
        callAsyncAjax("/task/manage/saveRoutinePlan", params, "saveRoutinePlanCallback");
    });
    
    //정기실행계획 Popup
    $("#stopPop").on("click", function() {
        appendDetailPopupType2("divModal", "/task/manage/taskManageRoutineExecutplanPop", "popTaskManageRoutineExecutplanCallback", LC_SCHDULE_DATA);
    });
    
    $("#cancelPop").on('click', function(){
        var params = {processNo : $('#processNo').val(), processCd : $('#processCd').val()};
        taskmanageCancelPop(params);
    });

    $("#resurvRun").on('click', function(){
        var params = {processNo : $('#processNo').val(), devlopSn : $('#devlopSn').val(), processCd : $('#processCd').val()};
        taskManageReserve(params);
    });
    
    $("#scheduleRun").on('click', function(){
        var params = {processNo : $('#processNo').val(), devlopSn : $('#devlopSn').val(), processCd : $('#processCd').val()};
        taskManageRoutine(params);
    });
    
    $("#saveCalenBtn").on('click', function(){
        var chkVal = "";
        $("input[name=calchk]:checked").each(function(i) {
            chkVal +=  $(this).val()+",";
        });
        chkVal = chkVal.substring(0,chkVal.lastIndexOf(","));

        var cmpnyCd = $('#cmpnyCd').val();
        var processCd = $('#processCd').val();
        var params = { 
		        		cmpnyCd : cmpnyCd 
		        	  , processCd : processCd
		              , chkVal : chkVal
		              }
        callAsyncAjax("/task/manage/updateCalendarPlan", params, "updateCalendarPlanCallback");        
    });
    
}

//휴일관리 수정 처리 후
function updateCalendarPlanCallback(data) {
    alert(data.result.msg);
}


//-- 정기실행계획 관련 START
function popTaskManageRoutineExecutplanCallback(data){
    drawExecutplan(data);
}

function returnDrawExecutplan(data){
// 	$("#routineExecutPlan").val(data["schduleText"]);
    LC_SCHDULE_DATA = data;
}

function saveRoutinePlanCallback(data){
	alert("정기실행계획 저장 완료")
}

//담당자 정보 리스트 화면
function drawChargerList(adata){
    var aCnt = adata.length;
    for(var i = 0; i < aCnt; i++){
        var aaList = adata[i];
        var j = i + 1;
        var str = "";
        str += '<div class="form-group col-md-6" name="chargerList'+ j + '">';
        str += '<label for="sourcUpdtNm" class="col-sm-4 col-form-label">부서</label>';
        str += '<div class="col-sm-8">';
        str += '    <input type="hidden" id="chrgDeptCd'+ j + '" value="' + aaList.chrgDeptCd +'" readonly>';
        str += '    <input type="text" id="chrgDeptNm'+ j + '" class="form-control"  style="width:40%; margin:2px 5px 0 0;" value="' + aaList.chrgDeptNm +'" readonly>';
        str += '</div>';
        str += '</div>';
        str += '<div class="form-group col-md-6">';
        str += '    <label for="sourcUpdtNm" class="col-sm-4 col-form-label">성명</label>';
        str += '    <div class="col-sm-8">';
        str += '        <input type="hidden" id="chrgUserId'+ j + '" value="' + aaList.chargerId +'" readonly>';
        str += '        <input type="text" id="chrgUserNm'+ j + '" class="form-control float-left"  style="width:40%; margin:2px 5px 0 0;" value="' + aaList.empNm +'" readonly>';
        str += '    </div>';
        str += '</div>';
        $("#chargerList").append(str);
    }
}

//절감시간 리스트 화면
function drawRedcnTmList(bdata){
    var bCnt = bdata.length;
    var iTempRedcnTmSum = 0;
    for(var i = 0; i < bCnt; i++){
        var bbList = bdata[i];
        var k = i+1;
        var str = "";
        str += ' <div class="form-group col-md-3" name="individualRedcnTm'+ k + '">';
        str += '     <label for="sourcUpdtNm" class="col-sm-4 col-form-label">부서</label>';
        str += '     <div class="col-sm-8 jq_redcnTmDept">';
        str += '         <input type="hidden" id="redcnTmDeptCd'+ k + '" class="form-control" value="'+ bbList.deptCd+'">';
        str += '         <input type="text" id="redcnTmDeptNm'+ k + '" class="form-control"  style="width:80%;" value="'+ bbList.deptNm+'" readonly>';
        str += '     </div>';
        str += ' </div>';
        str += ' <div class="form-group col-md-3" name="individualRedcnTm'+ k + '">';
        str += '     <label for="sourcUpdtNm" class="col-sm-4 col-form-label">성명</label>';
        str += '     <div class="col-sm-8 jq_redcnTmUser">';
        str += '         <input type="hidden" id="redcnTmUserId'+ k + '" class="form-control float-left"  style="width:80%;margin:2px 5px 0 0;" value="'+ bbList.userId+'">';
        str += '         <input type="text" id="redcnTmUserNm'+ k + '" class="form-control float-left"  style="width:80%;margin:2px 5px 0 0;" value="'+ bbList.userNm+'" readonly>';
        str += '     </div>';
        str += ' </div>';
        str += ' <div class="form-group col-md-6" name="individualRedcnTm'+ k + '">';
        str += '     <label for="sourcUpdtNm" class="col-sm-4 col-form-label">절감시간(hour)</label>';
        str += '     <div class="col-sm-8 float-left">';
        str += '         <input type="text" id="redcnTmRedcnTm'+ k + '" class="form-control float-left jq_redcnTmRedcnTm" style="width:40%; margin:2px 5px 0 0;"   value="'+ bbList.redcnTm+'" readonly>';
        str += '     </div>';
        str += ' </div>';
        
        $("#individualRedcnTmList").append(str);
        
        iTempRedcnTmSum += parseInt(bbList.redcnTm);
        k++;
    }
    
    $("#redcnTmSum").val(iTempRedcnTmSum)
}

//기여도 리스트 화면
function drawButeList(cdata){
    var cCnt = cdata.length;
    var iTempContributeSum = 0;
    for(var i = 0; i < cCnt; i++){
        var ccList = cdata[i];
        var l = i+1;
        var str = "";
        str += '   <div class="form-group col-md-3">';
        str += '       <label for="sourcUpdtNm" class="col-sm-4 col-form-label">부서</label>';
        str += '       <div class="col-sm-8 jq_contributeDept">';
        str += '           <input type="hidden" class="form-control" value="'+ ccList.deptCd +'">';
        str += '           <input type="text" class="form-control"  style="width:80%;" value="'+ ccList.deptNm +'" readonly>';
        str += '       </div>';
        str += '</div>';
        str += '<div class="form-group col-md-3">';
        str += '    <label for="sourcUpdtNm" class="col-sm-4 col-form-label">성명</label>';
        str += '    <div class="col-sm-8 jq_contributeUser">';
        str += '        <input type="hidden" class="form-control" value="'+ ccList.userId +'">';
        str += '        <input type="text" class="form-control float-left"  style="width:80%;margin:2px 5px 0 0;" value="'+ ccList.userNm +'" readonly>';
        str += '    </div>';
        str += '</div>';
        str += '<div class="form-group col-md-6">';
        str += '    <label for="sourcUpdtNm" class="col-sm-4 col-form-label">기여도(%)</label>';
        str += '    <div class="col-sm-8 float-left">';
        str += '        <input type="text" class="form-control float-left jq_contributeRate" style="width:40%; margin:2px 5px 0 2px;" value="'+ ccList.contribute +'" readonly>';
        str += '    </div>  ';
        str += '</div>';
        
        
        $("#individualContributeList").append(str);
        
        iTempContributeSum += parseInt(ccList.contribute);
    }

    $("#contributeSum").val(iTempContributeSum)
}

// 연관시스템 리스트 화면
function drawCntcSysList(ddata){
    var dCnt = ddata.length;
    for(var i = 0; i < dCnt; i++){
        var ddList = ddata[i];
        var str = "";
        str += '<tr>';
        str += '    <td>'+ddList.gbn+'</td>';
        str += '    <td>'+ddList.cmpnyNm+'</td>';
        str += '    <td>'+ddList.cntcSysCd+'</td>';
        str += '    <td>'+ddList.cntcSysNm+'</td>';
        str += '</tr>';
        $("#cntcSysList tbody").append(str);
    }
}

// 정기 실행계획 목록 리스트
function drawSchtextList(edata){
    var eCnt = edata.length;
    if(eCnt > 0){
        var str = "";
        $("#schtextDivList1").remove();
        $("#schtextDivList2").remove();
        for(var i = 0; i < eCnt; i++){
        	var edList = edata[i];
            str += '    <div class="form-group col-md-6">';
            str += '        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">실행구분</label>';
            str += '        <div class="col-sm-8">';
            str += '            <input type="text" id="" class="form-control float-left" style="width:40%; margin:2px 5px 10px 0;" value="정기실행" disabled >';
            str += '        </div>';
            str += '    </div>';
            str += '    <div class="form-group col-md-6">';
            str += '        <label for="managtChargerId" class="col-sm-4 col-form-label">실행계획</label>';
            str += '        <div class="col-sm-8">';
            str += '            <input type="text" id="" class="form-control float-left" style="width:80%; margin:2px 5px 10px 0;" value="'+edList.schduleNo+' : '+edList.schduleText+'" disabled >';
            str += '            <input type="button" class="btn btn-outline-secondary float-left" onclick="delText('+edList.schduleNo+','+edList.botNo+')" value="삭제" />';
            str += '        </div>';
            str += '    </div>';
        }
        $("#schtextDivList").append(str);
    }
}


//휴일관리 리스트 화면
function drawCalendarlist(fdata){
    var fCnt = fdata.length;
    var str = "";
    str += '<div class="form-group col-md-6">';
    str += '    <label for="sourcUpdtNm" class="col-sm-4 col-form-label">휴일관리</label>';
    str += '    <div class="col-sm-8"  id="calendarList">';
    
    for(var i = 0; i < fCnt; i++){
        var fList = fdata[i];
	     str += '        <tr>';
	     str += '            <input type="checkbox" id="'+fList.calendarId+'" name="calchk" class="custom-checkbox jq_everyWeek" style="width:25px;height:25px;margin-left:8px;" value="'+fList.calendarId+'">';
	     str += '            <input type="text" id=""  style="width:85%; margin:2px 5px 10px 0;" value="'+fList.calendarNm+'" disabled >';
	     str += '        </tr>';
    }
    str += '    </div>';
    str += '</div>';
    $("#calendarDivList").append(str);

    // 휴일관리 체크박스
    
    if(fCnt > 0){
    	var arr = fdata[0].calendarSet.split(",");
        for(var j=0; j < arr.length;j++){
            $("input:checkbox[id='"+arr[j]+"']").prop("checked", true);
        }
    }
}



// 정기 실행계획 삭제
function delText(schduleNo, botNo) {
    var params = { 
                   processCd : $('#processCd').val()
                 , botNo : botNo
                 , schduleNo : schduleNo
                 }
    callAsyncAjax("/task/manage/deleteRoutinePlan", params, "deleteRoutinePlanCallback");
}

// 삭제 처리 후
function deleteRoutinePlanCallback(data) {
    alert(data.result.msg);
    closePop();
}


/*
 * 과제운영 > 운영 취소요청: 
 * @param
 * @return
 */
function taskmanageCancelPop(params) {
    callAsyncAjax("/task/manage/getTaskManageProcessCancel", params, "popTaskProCancleback");
}

/*
 * 과제운영 > 운영 취소요청
 * @param
 * @return
 */
function popTaskProCancleback(data) {
    //데이터 존제 유무 확인
    if(data.result == null){
        alert("존재하지 않는 프로새스 입니다.");
        return false;
    }
    //데이터 존재 시 호출
    appendDetailPopup("taskManageMainDiv", "/task/manage/taskManageProcessCancelPop?registerId=" + data.result.registerId, "popTaskCancelDrawData", data);
}

 /*
  * 과제운영 > 과제 상세 pop: Data표시
  * @param
  * @return
  */
 function popTaskCancelDrawData(data){
     //데이터 화면에 출력
     var aResult = data.result
     var params = [];
     for (var sKey in aResult) {
         if(sKey == "cmpnyCd"){
             params.push({"id" : "cmpnyCd", "clsCd" : "0024", "disable" : "N", "selectValue": aResult[sKey]} );
         }
         else if(sKey == "fqCd"){
             params.push({"id" : "fqCd", "clsCd" : "0017", "selectValue": aResult[sKey]});    //빈도
         }
         else if(sKey == "jobClsCd"){
             params.push({"id" : "jobClsCd", "clsCd" : "0040", "selectValue": aResult[sKey]}); // 업무분류
         }
         else if(sKey == "processCnt"){
             //프로세스가 등록 되어 있으면 삭제 불가
             if(parseInt(aResult[sKey]) > 0 ){
                 $("#deleteBtn").hide();
             }
         }
         else{
             $("#" + sKey).val(aResult[sKey])
         }
     }
     requestCmmnCd(params);      
 }

 /*
  * 과제운영 > 운영 예약실행: 
  * @param
  * @return
  */
 function taskManageReserve(params) {
     callAsyncAjax("/task/manage/getTaskManageReserve", params, "popTaskProReserveRun");
 }
 
 /*
  * 과제운영 > 운영 예약실행: 
  * @param
  * @return
  */
 function popTaskProReserveRun(data) {
     //데이터 존제 유무 확인
     if(data.result == null){
         alert("존재하지 않는 프로새스 입니다.");
         return false;
     }
     //데이터 존재 시 호출
     appendDetailPopup("taskManageMainDiv", "/task/manage/taskManageReservePop?registerId=" + data.result.registerId, "popTaskReserveDrawData", data);
 }
 
 /*
  * 과제운영 > 예약실행 : Data표시
  * @param
  * @return
  */
 function popTaskReserveDrawData(data){
     //데이터 화면에 출력
     var aResult = data.result
     var params = [];
     var bott = aResult.botcountlist; 
     
     var tmp = '';
     tmp = '<option value="">선택</option>';
     for(var i=0; i < aResult.botcountlist.length; i++){
    	 tmp += '<option value="'+bott[i].cmpnyCd+',,'+bott[i].botNo+',,'+bott[i].releasesId+',,'+bott[i].releasesKey+',,'+bott[i].inputarguments+',,'+bott[i].botType+',,'+bott[i].releasesName+',,'+bott[i].processKey+'">'+bott[i].botNo+' : '+bott[i].releasesName+'</option>"';
     }
     $("#botNo").html(tmp);
     
     for (var sKey in aResult) {
         if(sKey == "cmpnyCd"){
             params.push({"id" : "cmpnyCd", "clsCd" : "0024", "disable" : "N", "selectValue": aResult[sKey]} );
         }
         else if(sKey == "fqCd"){
             params.push({"id" : "fqCd", "clsCd" : "0017", "selectValue": aResult[sKey]});    //빈도
         }
         else if(sKey == "jobClsCd"){
             params.push({"id" : "jobClsCd", "clsCd" : "0040", "selectValue": aResult[sKey]}); // 업무분류
         }
         else if(sKey == "processCnt"){
             //프로세스가 등록 되어 있으면 삭제 불가
             if(parseInt(aResult[sKey]) > 0 ){
                 $("#deleteBtn").hide();
             }
         }
         else if(sKey == "botcountlist"){
            
            // col group 비율 설정
            var strrr = "";
            strrr += '<col width="10%">';
            for(var m=0; m < aResult.botcountlist.length; m++){
                    strrr += '<col width="*"></th>';
            }
            $("#schduleList colgroup").append(strrr);
            
            // thead 숫자에 따른 컬럼 설정
            var strr = "";
            strr += '<tr>';
            strr += '<th>Time</th>';
            for(var l=0; l < aResult.botcountlist.length; l++){
                strr += '<th>BOT '+aResult.botcountlist[l].botNo+'</th>';
            }
            strr += '<tr>';
            $("#schduleList thead").append(strr);
            
            // 시간별 / 봇 별 항목 ID 설정 그리기
            var str = "";
            for(var i = 0; i < aResult.timelistcnt ; i++){  //144
                str += '<tr>';
                str += '    <td>'+ aResult.timelist[i].timeLine +'</td>';
                for(var z=0; z < aResult.botcountlist.length; z++ ){ //11
                    str += '    <td id="'+aResult.botcountlist[z].botNo+'_'+(i+1)+'" value="'+aResult.botcountlist[z].botNo+'_'+(i+1)+'"></td>';
                }
                str += '</tr>';
            }    
            $("#schduleList tbody").append(str);
        }
        else{
            $("#" + sKey).val(aResult[sKey])
        }
     }
     
     // 봇의 스케쥴 시간을 불러와 봇+시간값 입력과 class 변경
     for(var i = 0; i < aResult.timelistcnt ; i++){
         var ida = aResult.reservlist[i].botNo+"_"+aResult.reservlist[i].timeNo;
         $("#"+ida).attr('class', 'color small');
         $("#"+ida).html(aResult.reservlist[i].processCd);
     }
     requestCmmnCd(params);
 }
 
 
 
  /*
  * 과제운영 > 운영 정기실행: 
  * @param
  * @return
  */
 function taskManageRoutine(params) {
     callAsyncAjax("/task/manage/getTaskManageRoutine", params, "popTaskProRoutineRun");
 }
 
 
 /*
  * 과제운영 > 운영 정기실행: 
  * @param
  * @return
  */
 function popTaskProRoutineRun(data) {
     //데이터 존제 유무 확인
     if(data.result == null){
         alert("존재하지 않는 프로새스 입니다.");
         return false;
     }
     //데이터 존재 시 호출

     appendDetailPopup("taskManageMainDiv", "/task/manage/taskManageRoutinePop?registerId=" + data.result.registerId, "popTaskRoutineDrawData", data);
 }
 
 
 /*
  * 과제운영 > 정기실행 : Data표시
  * @param
  * @return
  */
 function popTaskRoutineDrawData(data){
     //데이터 화면에 출력
     var aResult = data.result
     var bott = aResult.botcountlist;// 실행로봇 select box set
     var params = [];
     
     for (var sKey in aResult) {
         if(sKey == "cmpnyCd"){
             params.push({"id" : "cmpnyCd", "clsCd" : "0024", "disable" : "N", "selectValue": aResult[sKey]} );
         }
         else if(sKey == "fqCd"){
             params.push({"id" : "fqCd", "clsCd" : "0017", "selectValue": aResult[sKey]});    //빈도
         }
         else if(sKey == "jobClsCd"){
             params.push({"id" : "jobClsCd", "clsCd" : "0040", "selectValue": aResult[sKey]}); // 업무분류
         }
         else if(sKey == "startde"){
        	 $("#startDe").val(aResult[sKey])
         }
         else if(sKey == "processCnt"){
             //프로세스가 등록 되어 있으면 삭제 불가
             if(parseInt(aResult[sKey]) > 0 ){
                 $("#deleteBtn").hide();
             }
         }
         else if(sKey == "botcountlist"){
            // 실행로봇 select box set
       	    tmp = '<option value="">선택</option>';
       	    for(var i=0; i < aResult.botcountlist.length; i++){
       	        tmp += '<option value="'+bott[i].cmpnyCd+',,'+bott[i].botNo+',,'+bott[i].releasesId+',,'+bott[i].releasesKey+',,'+bott[i].inputarguments+',,'+bott[i].botType+',,'+bott[i].releasesName+',,'+bott[i].processKey+'">'+bott[i].botNo+' : '+bott[i].releasesName+'</option>"';
       	    }
       	    $("#botNo").html(tmp);
        	    
            // col group 비율 설정
            var strrr = "";
            strrr += '<col width="10%">';
            for(var m=0; m < aResult.botcountlist.length; m++){
                    strrr += '<col width="*"></th>';
            }
            $("#schduleList colgroup").append(strrr);
            
            // thead 숫자에 따른 컬럼 설정
            var strr = "";
            var botNoList = "";
            strr += '<tr>';
            strr += '<th>Time</th>';
            for(var l=0; l < aResult.botcountlist.length; l++){
                strr += '<th>BOT '+aResult.botcountlist[l].botNo+'</th>';
                botNoList += aResult.botcountlist[l].botNo+",,";
            }
            $("#botNoList").val(botNoList);
            strr += '<tr>';
            $("#schduleList thead").append(strr);
            
            // 시간별 / 봇 별 항목 ID 설정 그리기
            var str = "";
            for(var i = 0; i < aResult.timelistcnt ; i++){  //144
                str += '<tr>';
                str += '    <td>'+ aResult.timelist[i].timeLine +'</td>';
                for(var z=0; z < aResult.botcountlist.length; z++ ){ //11
                    str += '    <td id="'+aResult.botcountlist[z].botNo+'_'+(i+1)+'"></td>';
                }
                str += '</tr>';
            }    
            $("#schduleList tbody").append(str);
        }
        else{
            $("#" + sKey).val(aResult[sKey])
        }
     }
     
     // 봇의 스케쥴 시간을 불러와 봇+시간값 입력과 class 변경
     for(var i = 0; i < aResult.timelistcnt ; i++){
         var ida = aResult.reservlist[i].botNo+"_"+aResult.reservlist[i].timeNo;
         $("#"+ida).attr('class', 'color small');
         $("#"+ida).html(aResult.reservlist[i].processCd);
     }
     requestCmmnCd(params);
 }
 
 
 
 
 
 
 
 
 
 
 
</script>

