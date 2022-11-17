<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!--  템플릿 바디 -->        
 <div class="card card-primary" id="unmanagtErrorRegDiv">                   
    <div class="card-header" alt="과제 >과제개발>프로세스상세">
        <h3 class="card-title">프로세스 상세</h3>
    </div>
    <div class="card-body">
        <div class="row">
            <div class="col-md-12">
                <form class="form-inline" id="unmanagtErrorDetail">                    
                    <div class="form-group col-md-12"><h5 class="text-success">⊙  과제정보</h5></div> 
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">과제코드<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8">
                            <select id="taskCd" class="form-control" style="width:80%;margin-right: 3px;"></select>
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
                            <textarea rows="2" id="taskDc" class="form-control" style="width:92.5%;" disabled></textarea>
                        </div>
                    </div>                   
                    
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">회사<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8">
                            <select id="cmpnyCd" class="form-control" style="width:80%; margin-right:3px;" disabled>
                            </select>
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">업무분류<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8">
                            <select id="clsCd" class="form-control" style="width:80%;margin-right: 3px;" disabled>
                                <option value="">영업</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">업무담당부서<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8">
                            <input type="hidden" id="jobChrgDeptCd" class="form-control float-left" style="width:50%;margin-right: 3px;" type="text" >
                            <input type="text" id="jobChrgDeptNm" class="form-control"  style="width:80%;" disabled>
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">업무담당자<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8">
                            <input type="hidden" id="jobChargerId" class="form-control float-left" style="width:50%;margin-right: 3px;" type="text" onchange="getUserInfo()">
                            <input type="text" id="jobChargerNm" class="form-control"  style="width:80%;" disabled>
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">업무시간(연간)</label>
                        <div class="col-sm-8">
                            <input type="text" id="jobTm" class="form-control float-left" style="width:120px;margin-right: 3px;" type="text" disabled>H
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">빈도</label>
                        <div class="col-sm-8">
                            <select id="fqCd" class="form-control float-left" style="width:30%;margin-right: 10px;" disabled>
                                <option value="">월</option>
                            </select>
                            <input type="text" id="executCnt" class="form-control float-left" style="width:120px;margin-right: 3px;" type="text"disabled>회
                        </div>
                    </div>    
                    
                    
                     
                    <div class="col-md-12 m-3"></div> 
                    
                    <div class="form-group col-md-12"><h5 class="text-success">⊙ 프로세스정보</h5></div>  
                                                         
                    <div class="form-group col-md-12">
                        <label for="errorTyCd" class="col-sm-2 col-form-label">제목<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-10">
                            <input type="text" id="sj" class="form-control"  style="width:92.5%;" maxlength="100"/>
                        </div>
                    </div>
                    
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">프로세스코드<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8">
                            <input type="hidden" id="processNo" class="form-control"  style="width:80%;" maxlength="12">
                            <input type="text" id="processCd" class="form-control"  style="width:80%;" maxlength="6" numberEnglish readonly>
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">프로세스명<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8">
                            <input type="text" id="processNm" class="form-control"  style="width:80%;" maxlength="100">
                        </div>
                    </div>
                    
                    <div class="form-group col-md-12">
                        <label for="errorCn" class="col-sm-2 col-form-label">업무설명</label>
                        <div class="col-sm-10">
                            <textarea rows="10" id="jobDc" class="form-control" style="width:92.5%;" maxlength="2000"></textarea>
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">회사</label>
                        <div class="col-sm-8">
                            <select id="cmpnyCdReg" class="form-control" style="width:80%; margin-right:3px;" disabled><b style="color:red;padding-left:10px;">*</b></select>
                        </div>
                    </div>
                    <div class="form-group col-md-6"></div>
<%-- 
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">업무분류<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8">
                            <select id="jobClsCd" class="form-control" style="width:80%;margin-right: 3px;"></select>
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">RPA분류<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8">
                            <select id="rpaClsCd" class="form-control" style="width:80%;margin-right: 3px;"></select>
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label float-left">업무시간(년간)<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8">
                            <input type="text" id="processJobTm" class="form-control float-left" style="width:120px;margin-right: 3px;" maxlength="7" numberOnly>H
                        </div>
                    </div>
--%>
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label float-left">예상절감시간(년간)①<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8">
                            <input type="text" id="redcnTm" class="form-control float-left" style="width:120px;margin-right: 3px;" maxlength="7" numberOnly>H
                        </div>
                    </div>
                    
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label float-left">예상절감금액<br/>(① X 33,000원)<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8">
                            <input type="text" id="expectRedcnAmt" class="form-control float-left" style="width:120px;margin-right: 3px;"  maxlength="10" readonly="readonly">원
                        </div>
                    </div>
                    
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">실행주기<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8">
                            <select id="fqCdReg" class="form-control float-left" style="width:30%;margin-right: 10px;" ></select>
                            <input type="text" id="executCntReg" class="form-control float-left" style="width:120px;margin-right: 3px;" type="text" numberOnly>회
                        </div>
                    </div>
                                    
                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">실행시간<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8">
                            <input type="text" id="executTm" class="form-control float-left" style="width:120px;margin-right: 3px;" maxlength="4" decimalNumberType1>H
                        </div>
                    </div>     
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">개발공수②<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8">
                            <input type="text" id="devlopWdcnt" class="form-control float-left" style="width:120px;margin-right: 3px;" maxlength="3" numberOnly>일
                        </div>
                    </div>                    
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">예상개발비용<br/>(② X 8.5Hr X 33,000원)<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8">
                            <input type="text" id="expectDevlopCt" class="form-control float-left" style="width:120px;margin-right: 3px;" maxlength="10" readonly="readonly">원
                        </div>
                    </div>                   
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">긴급대응</label>
                        <div class="col-sm-8">
                            <input type="text" id="emrgncyCrspnd" class="form-control float-left" style="width:120px;margin-right: 3px;" maxlength="100">
                        </div>    
                    </div>
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">RTO</label>
                        <div class="col-sm-8">
                            <input type="text" id="rto" class="form-control float-left" style="width:120px;margin-right: 3px;" maxlength="4" numberOnly>H
                        </div>
                    </div>
                    <div class="form-group col-md-6"></div>
                    <div class="form-group col-md-12">
                        <label for="errorTyCd" class="col-sm-2 col-form-label">ROI평가<br/>(② X 10 ≤ ①)</label>
                        <div class="col-sm-10">
                            <input type="text" id="roiEvaluate" class="form-control"  style="width:92.5%;" maxlength="100" readonly="readonly"/>
                        </div>
                    </div>
                    <div class="form-group col-md-12">
                        <label for="errorCn" class="col-sm-2 col-form-label">개발사유</label>
                        <div class="col-sm-10">
                            <textarea rows="2" id="devlopResn" class="form-control" style="width:92.5%;" maxlength="2000"></textarea>
                        </div>
                    </div>
                    
                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">내부개발여부<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8">
                            <select id="insideDevlopAt" class="form-control" style="width:80%;margin-right: 3px;"></select>
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="devlopChargerNm" class="col-sm-4 col-form-label">개발담당자</label>
                        <div class="col-sm-8 float-left">
                            <input type="hidden" id="devlopChargerId" name="devlopChargerId">
                            <input type="text" id="devlopChargerNm" class="form-control float-left" disabled class="form-control float-left" style="width:65%;margin-right:5px" />
                            <button type="button" class="btn btn-outline-primary float-left" id="btnSchDevlopChargerId">찾기</button>
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="devlopChargerNm" class="col-sm-4 col-form-label">실행구분<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8 float-left">
                            <select id="executSe" class="form-control" style="width:80%;margin-right: 3px;"></select>
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="belongingDe" class="col-sm-4 col-form-label">개발귀속일<b style="color: red;"> *</b></label>
                        <div class="col-sm-4">
                             <div class="input-group date float-left" id="belongingDeDiv" data-target-input="nearest"style="min-width:140px;width:100%;margin-right:5px;">
                                  <input type="text" id="belongingDe" name="belongingDe" class="form-control datetimepicker-input" data-target="#belongingDeDiv"/>
                                  <div class="input-group-append" data-target="#belongingDeDiv" data-toggle="datetimepicker">
                                      <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                  </div>
                              </div>
                        </div>
                    </div>
                    <div class="form-group col-md-12">
                        <label for="managtChargerId" class="col-sm-2 col-form-label">첨부파일 </label>
                        <div class="col-sm-10">
                            <div class="form-check2 row"  id="fileUpload"></div>
                        </div>
                   </div>
                   <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">상태별 첨부문서</label>
                        <div class="col-sm-8">
                              1) 결재요청: 업무기술서<br/>
                              2) 개발 중: 분석설계서<br/>
                              3) 개발완료: QA관리기준서<br/>
                        </div>
                    </div>
<%--                    
                    <div class="form-group col-md-12">
                        <label for="managtChargerId" class="col-sm-2 col-form-label">연관문서 </label>
                        <div class="col-sm-10">
                            <input type="text" id="relateDoc" class="form-control"  style="width:80%;" maxlength="2000">
                       </div>
                   </div>
--%>                   
                   
                   <div class="col-md-12 m-3"></div>
                   <div class="form-group col-md-12">
                       <div class="col-sm-4"><h5 class="text-success float-left">⊙ 담당자 정보</h5><b style="color:red;padding-left:10px;">*</b></div>
                       <div class="col-sm-8">
                           <button type="button" id="btnAddCharger" class="btn btn-secondary float-right" style="margin: 0;">+ 추가</button>
                       </div>
                   </div>
                   <div class="form-group col-md-12" id="chargerList"></div>
                    
                    <div class="col-md-12 m-3"></div>
                    <div class="form-group col-md-12">
                        <div class="col-sm-4"><h5 class="text-success float-left">⊙ 개인별 절감시간</h5></div>
                        <div class="col-sm-8">
                            <button type="button" id="btnAddIndividualRedcnTm" class="btn btn-secondary float-right" style="margin: 0;">+ 추가</button>
                        </div>
                     </div>
                     <div class="form-group col-md-12" id="individualRedcnTmList">
                     </div>
                     <div class="form-group col-md-12 py-sm-1 line-footer">
                        <div class="form-group col-md-7"></div> 
                        <div class="form-group col-md-5">
                            <label for="sourcUpdtNm" class="col-sm-4 col-form-label text-warning" >합계(hour)</label>
                            <div class="col-sm-8">
                                <input type="text" id="redcnTmSum" class="form-control text-warning" style="width:48%; " disabled>   
                            </div>
                        </div> 
                    </div> 
                                        
                    
                    <div class="col-md-12 m-3"></div> 
                    <div class="form-group col-md-12">
                        <div class="col-sm-4"><h5 class="text-success float-left">⊙ 개인별 기여도</h5><b style="color:red;padding-left:10px;">*</b></div>
                        <div class="col-sm-8">
                            <button type="button" id="btnAddIndividualContribute" class="btn btn-secondary float-right" style="margin: 0;">+ 추가</button>
                        </div>
                     </div>
                     <div class="form-group col-md-12" id="individualContributeList"></div>
                                     
                    <div class="form-group col-md-12 py-sm-1 line-footer">
                        <div class="form-group col-md-7"></div> 
                        <div class="form-group col-md-5">
                            <label for="sourcUpdtNm" class="col-sm-4 col-form-label text-warning" >합계(%)</label>
                            <div class="col-sm-8">
                                <input type="text" id="contributeSum" class="form-control text-warning" style="width:48%; " disabled>   
                            </div>
                        </div> 
                    </div>
                    
                    <div class="col-md-12 m-3"></div>
<%--
//                    <div class="form-group col-md-12"><h5 class="text-success">⊙  실행정보</h5></div>
//
//                    <div class="form-group col-md-6">
//                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">프로세스파일</label>
//                        <div class="col-sm-8 float-left">
//                            <div class="form-check2 row"  id="fileUpload2"></div>
//                        </div> 
//                    </div>
//                    <div class="form-group col-md-6">
//                        <label for="managtChargerId" class="col-sm-4 col-form-label">실행구분</label>
//                        <div class="col-sm-8">
//                           <select id="executSe" class="form-control" style="width:45%;"></select> 
//                        </div>
//                    </div>
--%>
                    <div class="form-group col-md-12">
                        <label class="col-sm-4 float-left">업무시스템</label>
                        <div class="col-sm-8 float-right">
                            <button type="button" id="btnCntcSysAdd"class="btn btn-secondary float-right" style="margin-left: 3px;">+ 업무시스템 검색</button>
                            <button type="button" id="btnCntcSysDelete"class="btn btn-secondary float-right" style="margin-left: 0;">- 삭제</button>
                        </div>
                     </div> 
                     <div class="form-group col-md-12">
                           <table class="table" style="padding:0" id="cntcSysList" >
					        <colgroup>
					          <col width="10%">
					          <col width="20%">
					          <col width="22%">
					          <col width="20%">
					          <col width="*">
					        </colgroup>
					        <thead>						        
						        <tr>
						            <th><input type="checkbox" class="custom-checkbox" id="cntcSysAll" style="width:18px;height:18px;"></th>
						            <th>분류</th>
						            <th>회사</th>
						            <th>시스템코드</th>
						            <th>시스템명</th>
						        </tr>
						    </thead>
					        <tbody />
					    </table>
                     </div> 
                     
                    <div class="col-md-12 m-3"></div>
                    <div class="form-group col-md-12"><h5 class="text-success">⊙  상태</h5></div> 
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">프로세스상태</label>
                        <div class="col-sm-8">
                            <select id="processSttus" class="form-control" style="width:45%;margin-right: 3px;"></select> 
                        </div>
                    </div>
                    
                    
                    <div class="col-md-12 m-3"></div>
                    <div class="form-group col-md-12"><h5 class="text-success">⊙  변경내용</h5></div> 
                    <div class="form-group col-md-12">
                        <label for="sourcUpdtNm" class="col-sm-2 col-form-label">변경사유 및 내용<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-10">
                            <textarea rows="2" id="changeCn" class="form-control" style="width:92.5%;" maxlength="2000"></textarea>
                        </div>
                    </div>
                    
                    
                    <div class="col-md-12 m-3"></div>
                    <div class="form-group col-md-12"><h5 class="text-success">⊙  프로세스 변경이력</h5></div>
                    <div class="col-md-12 m-1"></div>
                    <div class="form-group col-md-12">
                           <table id="changeHistList" class="table" style="padding:0">
                            <colgroup>
                              <col width="25%">
                              <col width="18%">
                              <col width="15%">
                              <col width="*">
                            </colgroup>
                            <thead>                             
                                <tr>
                                    <th>일시</th>
                                    <th>상태</th>
                                    <th>작업자</th>
                                    <th>변경사유 및 내용</th>
                                </tr>
                            </thead>
                            <tbody>
                        </table>
                     </div>                
                </form>
                <div class="float-right py-sm-2">
<c:if test="${identityFlag}">
                    <button type="button" class="btn btn-primary" id="saveBtn" style="display:none">저장</button>
</c:if>
                    <button type="button" class="btn btn-primary" id="backListBtn">닫기</button>
                </div>
                <div id="divSearchUser" class="modal fade" tabindex="-1" role="dialog"></div>
            </div>
        </div>
    </div>
</div>








<script>
var chargerCnt = 1;
var individualConCnt = 1;
var individualRedcnTmCnt = 1;
var iFileGrpNo =0;
var iFileGrpNo2 =0;

var oRpaUploadUpload;
//var oRpaUploadUpload2;
$(document).ready(function() {
    //이벤트 바인딩
    pageInit();
    bindEvent();
});
/*
 * 이벤트 바인딩
 * @param
 * @return
 */
function bindEvent() {
	
	$('#belongingDeDiv').datetimepicker({
        format: 'YYYY-MM-DD'
      //, defaultDate: (new Date())
    });
	
	//담당자 정보 추가버튼 이벤트
    $("#btnAddCharger").on('click', function(){
        var iTempCnt = $(".jq_chargerDept").length;
        
        if (iTempCnt >= 10) {
            alert("담당자 정보는 10개까지 추가 가능합니다.");
            return;
        }
        
        var str = "";
        str += '<div class="form-group col-md-6" name="chargerList'+ chargerCnt + '">'
        str += '<label for="sourcUpdtNm" class="col-sm-4 col-form-label">부서</label>'
        str += '<div class="col-sm-8 jq_chargerDept">'
        str += '    <input type="hidden" id="chrgDeptCd'+ chargerCnt + '" class="form-control"  style="width:80%;" readonly>'
        str += '    <input type="text" id="chrgDeptNm'+ chargerCnt + '" class="form-control"  style="width:80%;" readonly>'
        str += '</div>'
        str += '</div>'
        str += '<div class="form-group col-md-6" name="chargerList'+ chargerCnt + '">'
        str += '    <label for="sourcUpdtNm" class="col-sm-4 col-form-label">성명</label>'
        str += '    <div class="col-sm-8 jq_chrgUser">'
        str += '        <input type="hidden" id="chrgUserId'+ chargerCnt + '" class="form-control float-left"  style="width:30%; margin:2px 5px 0 0;" readonly>'
        str += '        <input type="text" id="chrgUserNm'+ chargerCnt + '" class="form-control float-left"  style="width:30%; margin:2px 5px 0 0;" readonly>'
        str += '        <input type="button" class="btn btn-outline-primary float-left" name="btnSearchUser" onclick="searchUserV2(\'chrg\', '+ chargerCnt + ')" value="사원검색" />'
        str += '        <input type="button" class="btn btn-outline-secondary float-left" name="" onclick="popDeleteList(\'chargerList\', '+ chargerCnt + ')" value="삭제" />'
        str += '    </div>'
        str += '</div>'
        
        $("#chargerList").append(str);
        
        chargerCnt++;
    });
    
    
    //개인별 절감시간 추가버튼 이벤트
    $("#btnAddIndividualRedcnTm").on('click', function(){
        var iTempCnt = $(".jq_redcnTmDept").length;
        
        if (iTempCnt >= 10) {
            alert("개인별 절감시간은 10개까지 추가 가능합니다.");
            return;
        }
        
        var str = "";
        str += ' <div class="form-group col-md-3" name="individualRedcnTm'+ individualRedcnTmCnt + '">'
        str += '     <label for="sourcUpdtNm" class="col-sm-4 col-form-label">부서</label>'
        str += '     <div class="col-sm-8 jq_redcnTmDept">'
        str += '         <input type="hidden" id="redcnTmDeptCd'+ individualRedcnTmCnt + '" class="form-control">'
        str += '         <input type="text" id="redcnTmDeptNm'+ individualRedcnTmCnt + '" class="form-control"  style="width:75%;" readonly>'
        str += '     </div>'
        str += ' </div>'                    
        str += ' <div class="form-group col-md-4" name="individualRedcnTm'+ individualRedcnTmCnt + '">'
        str += '     <label for="sourcUpdtNm" class="col-sm-4 col-form-label">성명</label>'
        str += '     <div class="col-sm-8 jq_redcnTmUser">'
        str += '         <input type="hidden" id="redcnTmUserId'+ individualRedcnTmCnt + '" class="form-control float-left"  style="width:48%;margin:2px 5px 0 0;" readonly>'
        str += '         <input type="text" id="redcnTmUserNm'+ individualRedcnTmCnt + '" class="form-control float-left"  style="width:48%;margin:2px 5px 0 0;" readonly>'
        str += '         <input type="button" class="btn btn-outline-primary float-left" name="" onclick="searchUserV2(\'redcnTm\', '+ individualRedcnTmCnt + ')" value="사원검색" />'
        str += '     </div>'
        str += ' </div>'
        str += ' <div class="form-group col-md-5" name="individualRedcnTm'+ individualRedcnTmCnt + '">'
        str += '     <label for="sourcUpdtNm" class="col-sm-4 col-form-label">절감시간(hour)</label>'
        str += '     <div class="col-sm-8 float-left">'
        str += '         <input type="text" id="redcnTmRedcnTm'+ individualRedcnTmCnt + '" class="form-control float-left jq_redcnTmRedcnTm" style="width:48%; margin:2px 5px 0 0;">'
        str += '         <input type="button" class="btn btn-outline-secondary float-left" name=""  onclick="popDeleteList(\'individualRedcnTm\', '+ individualRedcnTmCnt + ')" value="삭제" />' 
        str += '     </div>'
        str += ' </div>'
        
        $("#individualRedcnTmList").append(str);
        
        individualRedcnTmCnt++;
    });
    
    
    //개인별 기여도 추가버튼 이벤트
    $("#btnAddIndividualContribute").on('click', function(){
        var iTempCnt = $(".jq_contributeDept").length;
        
        if (iTempCnt >= 10) {
            alert("개인별 기여도는 10개까지 추가 가능합니다.");
            return;
        }
        
        var str = "";
        
        str += '   <div class="form-group col-md-3" name="individualContributeList'+ individualConCnt + '">'
        str += '       <label for="sourcUpdtNm" class="col-sm-4 col-form-label">부서</label>'
        str += '       <div class="col-sm-8 jq_contributeDept">'
        str += '           <input type="hidden" id="contributeDeptCd'+ individualConCnt + '" class="form-control">'
        str += '           <input type="text" id="contributeDeptNm'+ individualConCnt + '" class="form-control"  style="width:80%;" readonly>'
        str += '       </div>'
        str += '</div>'                    
        str += '<div class="form-group col-md-4" name="individualContributeList'+ individualConCnt + '">'
        str += '    <label for="sourcUpdtNm" class="col-sm-4 col-form-label">성명</label>'
        str += '    <div class="col-sm-8 jq_contributeUser">'
        str += '        <input type="hidden" id="contributeUserId'+ individualConCnt + '" class="form-control">'
        str += '        <input type="text" id="contributeUserNm'+ individualConCnt + '" class="form-control float-left"  style="width:48%;margin:2px 5px 0 0;" readonly>'
        str += '        <input type="button" class="btn btn-outline-primary float-left" name="" onclick="searchUserV2(\'contribute\', '+ individualConCnt + ')" value="사원검색" />'
        str += '    </div>'
        str += '</div>'
        str += '<div class="form-group col-md-5" name="individualContributeList'+ individualConCnt + '">'
        str += '    <label for="sourcUpdtNm" class="col-sm-4 col-form-label">기여도(%)</label>'
        str += '    <div class="col-sm-8 float-left">'
        str += '        <input type="text" id="contributeRate'+ individualConCnt + '" class="form-control float-left jq_contributeRate" style="width:48%; margin:2px 5px 0 0;">'
        str += '        <input type="button" class="btn btn-outline-secondary float-left" name="" onclick="popDeleteList(\'individualContributeList\', '+ individualConCnt + ')" value="삭제" />'
        str += '    </div>  '
        str += '</div>'
        
        
        $("#individualContributeList").append(str);
        
        individualConCnt++;
    });
    
    $("#btnCntcSysDelete").on("click", function() { 
    	var aObj = $(".jq_cntcSysChackbox:checked");
    	$.each(aObj, function(index, item) {
            $(item).closest("tr").remove();
        });
    	
    });
    
    $("#btnCntcSysAdd").on("click", function() { 
    	openSearchCntcSysPopup("divSearchUser", "callbackOpenSearchCntcSysPopup");
    });
    
    function openSearchCntcSysPopup(divId, callbackName){
    	
        

    	var url = "/task/develop/searchCntcSysPopup";
        $.ajax({
            url : url,
            dataType : "html",
            type : "GET",
            async : false,
            success : function(result){
                $("#" + divId).html(result);
                $("#" + divId).modal('show');
                
                $("#btnGwpwrSelect").on("click", function(){
                    if ($("#gwpwrGrid").jsGrid("option", "selectData") == null || $("#gwpwrGrid").jsGrid("option", "selectData") == "") {
                        alert("업무시스템을 선택하셔야 합니다.");
                        return;
                    }
                    if (callbackName != null && callbackName != undefined) {
                        var fn = window[callbackName];
                        if (typeof fn === "function") {
                            fn($("#gwpwrGrid").jsGrid("option", "selectData"));
                        }
                    }
                    $("#" + divId).modal('hide');
                });
            }
        });
    }
    
    $("#cntcSysAll").on("click", function() {
    	if($(this).is(":checked") == true){
    		$(".jq_cntcSysChackbox").prop("checked", true)
    	}
    	else{
    		$(".jq_cntcSysChackbox").prop("checked", false)
    	}
    });
    
    $("#saveBtn").on("click", function() {
    	var iChk = 0;
        var oSj = $("#sj");
        var oProcessCd = $("#processCd");
        var oProcessNm = $("#processNm");
        var oCmpnyCdReg = $("#cmpnyCdReg");
//        var oJobClsCd = $("#jobClsCd");
//        var oRpaClsCd = $("#rpaClsCd");
//        var oProcessJobTm = $("#processJobTm");
        var oRedcnTm = $("#redcnTm");
        var oExpectRedcnAmt = $("#expectRedcnAmt");
        var oFqCdReg = $("#fqCdReg");
        var oExecutCntReg = $("#executCntReg");
        var oExecutTm = $("#executTm");
        var oDevlopWdcnt = $("#devlopWdcnt");
        var expectDevlopCt = $("#expectDevlopCt");
        var changeCn = $("#changeCn");
        var oInsideDevlopAt = $("#insideDevlopAt");
        var oExecutSe = $("#executSe");
        var oBelongingDe = $("#belongingDe");
        
        if($.trim(oSj.val()) == ""){
            alert("제목을 입력해 주십시오.");
            oSj.focus();
            return false;
        }
        else if($.trim(oProcessCd.val()) == ""){
            alert("프로세스 코드를 입력해 주십시오.");
            oProcessCd.focus();
            return false;
        }
        else if($.trim(oProcessCd.val()).length < 4){
            alert("프로세스코드는 6자리입니다.");
            oProcessCd.focus();
            return false;
        }
        else if((oProcessCd.val()).substring(0,1) != oCmpnyCdReg.val())
        {
            alert("프로세스코드 첫번째 문자는 회사코드와 동일해야 합니다.");
            oProcessCd.focus();
            return false;
        }
        else if(isNaN((oProcessCd.val()).substring(1,6)))
        {
            alert("프로세스코드 2번째 문자부터 숫자만 입력가능합니다.");
            oProcessCd.focus();
            return false;
        }
        else if($.trim(oProcessNm.val()) == ""){
            alert("프로세스명을 주십시오.");
            oProcessNm.focus();
            return false;
        }
        else if($.trim(oCmpnyCdReg.val()) == ""){
            alert("회사를 선택해 주십시오.");
            oCmpnyCdReg.focus();
            return false;
        }
//        else if($.trim(oJobClsCd.val()) == ""){
//            alert("업무분류를 선택해 주십시오.");
//            oJobClsCd.focus();
//            return false;
//        }
//        else if($.trim(oRpaClsCd.val()) == ""){
//            alert("RPA분류를선택해 주십시오.");
//            oRpaClsCd.focus();
//            return false;
//        }
//        else if($.trim(oProcessJobTm.val()) == ""){
//            alert("업무시간을 입력해 주십시오.");
//            oProcessJobTm.focus();
//            return false;
//        }
        else if($.trim(oRedcnTm.val()) == ""){
            alert("예상절감시간을 입력해 주십시오.");
            oRedcnTm.focus();
            return false;
        }
        else if($.trim(oExpectRedcnAmt.val()) == ""){
            alert("예상절감금액을 임력해 주십시오.");
            oExpectRedcnAmt.focus();
            return false;
        }
        else if($.trim(oFqCdReg.val()) == ""){
            alert("주기를 선택해 주십시오.");
            oFqCdReg.focus();
            return false;
        }
        else if($.trim(oExecutCntReg.val()) == ""){
            alert("실행횟수를  입력해 주십시오.");
            oExecutCntReg.focus();
            return false;
        }
        else if($.trim(oExecutTm.val()) == ""){
            alert("시간을  입력해 주십시오.");
            oExecutTm.focus();
            return false;
        }
        else{ 
            var sTempText = oExecutTm.val().replace(/,/gi, "");
            if(parseInt(sTempText) >= 100){
                alert("시간을 100시간 미만으로 입력해 주십시오.");
                oExecutTm.focus();
                return false;
            }
        }
        
        if($.trim(oDevlopWdcnt.val()) == ""){
            alert("개발공수를  입력해 주십시오.");
            oDevlopWdcnt.focus();
            return false;
        }
        else if($.trim(expectDevlopCt.val()) == ""){
            alert("예상계발금액을  입력해 주십시오.");
            expectDevlopCt.focus();
            return false;
        }
        else if($.trim(oInsideDevlopAt.val()) == ""){
            alert("내부개발여부를  선택해 주십시오.");
            oInsideDevlopAt.focus();
            return false;
        }
        
        if(oInsideDevlopAt.val() == "Y"){
        	if($.trim($("#devlopChargerId").val()) == ""){
        		alert("개발 담당자를 입력해 주십시오.");
        		$("#devlopChargerId").focus();
        		return false;
        	}
        }
        
        if(oExecutSe.val() == ""){
        	alert("실행구분을 선택해 주십시오.");
        	oExecutSe.focus();
    		return false;
        }
        else if(oBelongingDe.val() == ""){
        	alert("개발귀속일을 선택해 주십시오.");
        	oBelongingDe.focus();
    		return false;
        }
        else if(oBelongingDe.val().length != 10){
        	alert("개발귀속일이 비정상입니다.");
        	oBelongingDe.focus();
    		return false;
        }
        
        
        //담당자 정보
        var aChargerDeptCd = $(".jq_chargerDept [type=hidden]");
        var aChargerDeptNm = $(".jq_chargerDept [type=text]");
        var aChargerUserId = $(".jq_chrgUser [type=hidden]");
        var aChargerUserNm = $(".jq_chrgUser [type=text]");
        var iaChargerDeptCd = aChargerDeptCd.length;
        var aChargerList = []
        
        for(var i = 0; i < iaChargerDeptCd; i++){
            if($(aChargerDeptCd[i]).val() != ""){
                if($(aChargerDeptCd[i]).val() !=""){
                	iChk ++
                	aChargerList.push({
                        chargerDeptCd: $(aChargerDeptCd[i]).val()
                        , chargerDeptNm: $(aChargerDeptNm[i]).val()
                        , chargerUserId: $(aChargerUserId[i]).val()
                        , chargerUserNm: $(aChargerUserNm[i]).val()
                    });
                }
            }
        }
        
        if(iChk < 1){
            alert("1명 이상의 담당자 정보를 입력해 주십시오.")
            return false;
        }
        
        
        //개인별 절감시간
        iChk = 0;
        var aRedcnTmList = [];
        var aRedcnTmDeptCd = $(".jq_redcnTmDept [type=hidden]");
        var aRedcnTmDeptNm = $(".jq_redcnTmDept [type=text]");
        var aRedcnTmUserId = $(".jq_redcnTmUser [type=hidden]");
        var aRedcnTmUserNm = $(".jq_redcnTmUser [type=text]");
        var aRedcnTmRedcnTm = $(".jq_redcnTmRedcnTm");
        
        var iaRedcnTmDeptCd = aRedcnTmDeptCd.length;
        
        for(var i = 0; i < iaRedcnTmDeptCd; i++){
            var oTemp01 =$(aRedcnTmDeptCd[i]);
            var oTemp02 =$(aRedcnTmRedcnTm[i]);
            
            if(oTemp01.val() != "" && oTemp02.val() == ""){
                alert("개인별 절감시간의 절감 시간을 입력해 주십시오.")
                oTemp02.focus();
                return false;
            }else if(oTemp01.val() == "" && oTemp02.val() != ""){
                alert("개인별 절감시간의 사원 정보를  입력해 주십시오.")
                return false;
            }
            else if(oTemp01.val() != "" && oTemp02.val() != ""){
            	iChk ++
                aRedcnTmList.push({
                    redcnTmDeptCd: $(aRedcnTmDeptCd[i]).val()
                    , redcnTmDeptNm: $(aRedcnTmDeptNm[i]).val()
                    , redcnTmUserId: $(aRedcnTmUserId[i]).val()
                    , redcnTmUserNm: $(aRedcnTmUserNm[i]).val()
                    , redcnTmRedcnTm: $(aRedcnTmRedcnTm[i]).val().replace(/,/gi, "")
                });
            }
        }
        /*
        if(iChk < 1){
            alert("1명 이상의 개인별 절감시간을 입력해 주십시오.")
            return false;
        }
        */
        
        //개인별 기여도
        iChk = 0;
        var aContributeDeptCd = $(".jq_contributeDept [type=hidden]");
        var aContributeDeptNm = $(".jq_contributeDept [type=text]");
        var aContributeUserId = $(".jq_contributeUser [type=hidden]");
        var aContributeUserNm = $(".jq_contributeUser [type=text]");
        var aContributeRate = $(".jq_contributeRate");
        var aContributeList = [];
        
        var iaContributeDeptCd = aContributeDeptCd.length;
        var iTempSum = 0;
        for(var i = 0; i < iaContributeDeptCd; i++){
            var oTemp01 =$(aContributeDeptCd[i]);
            var oTemp02 =$(aContributeRate[i]);
            
            if(oTemp01.val() == "" && oTemp02.val() != ""){
                alert("개인별 기여도의 사원 정보를  입력해 주십시오.");
                oTemp01.focus();
                return false;
            }
            else if(oTemp01.val() != "" && oTemp02.val() == ""){
                alert("개인별 기여도의 기여도를 입력해 주십시오.");
                oTemp02.focus();
                return false;
            }
            else if(oTemp01.val() != "" && oTemp02.val() != ""){
            	iChk ++
                aContributeList.push({
                    contributeDeptCd: $(aContributeDeptCd[i]).val()
                    , contributeDeptNm: $(aContributeDeptNm[i]).val()
                    , contributeUserId: $(aContributeUserId[i]).val()
                    , contributeUserNm: $(aContributeUserNm[i]).val()
                    , contributeRate: $(aContributeRate[i]).val()
                });
            	iTempSum += Number(removeCommas(oTemp02.val()));
            }

            
        }
        
        if(iChk < 1){
            alert("1명 이상의 개인별 기여도를 입력해 주십시오.")
            return false;
        }
        
        if(iTempSum != 100){
            alert("기여도 합계가 100% 되어야합니다.")
            return false;
        }
        
        if($.trim(changeCn.val()) == ""){
            alert("변경사유 및 내용을 입력해 주십시오.");
            changeCn.focus();
            return false;
        }
        
        
        var sProcessSttus =  $("#processSttus").val();
                
        var aFileList = $("#fileUpload input[type='file']")
        console.log("aFileList: " + aFileList);
        var iaFileList = aFileList.length;
        console.log("iaFileList: " + iaFileList);
        var isNotExistFileType1 = true;
        var isNotExistFileType2 = true;
        var isNotExistFileType3 = true;
        //var isNotExistFileType4 = true;
        
        for(var i = 0; i < iaFileList; i++){
            var sTempFileName = aFileList[i].value;
            console.log("sTempFileName: " + sTempFileName);
            if(sTempFileName.indexOf("업무기술서") >= 0){
                isNotExistFileType1  = false    
            }
            else if(sTempFileName.indexOf("분석설계서") >= 0){
                isNotExistFileType2  = false    
            }
            else if(sTempFileName.indexOf("QA관리기준서") >= 0){
                isNotExistFileType3  = false    
            }
            else if(sTempFileName.indexOf("QA관리기준서") >= 0){
                //isNotExistFileType4  = false    
            }
        }
        
        aFileList = $("#fileUpload input[type='text']")
        iaFileList = aFileList.length;
        for(var i = 0; i < iaFileList; i++){
            var sTempFileName = aFileList[i].value;
            console.log("sTempFileName: " + sTempFileName);
            if(sTempFileName.indexOf("업무기술서") >= 0){
                isNotExistFileType1  = false    
            }
            else if(sTempFileName.indexOf("분석설계서") >= 0){
                isNotExistFileType2  = false    
            }
            else if(sTempFileName.indexOf("QA관리기준서") >= 0){
                isNotExistFileType3  = false    
            }
            else if(sTempFileName.indexOf("QA관리기준서") >= 0){
                //isNotExistFileType4  = false    
            }
        }
        
        if(sProcessSttus == "D1"){//개발중
            if(isNotExistFileType1){
                alert("첨부파일 > 업무기술서를 첨부해 주십시오.");
                return false;
            }
        }
        else if(sProcessSttus == "D3"){//개발중
        	if(isNotExistFileType1 || isNotExistFileType2){
        		alert("첨부파일 > 업무기술서, 분석설계서를 첨부해 주십시오.");
                return false;
        	}
        }
        else if(sProcessSttus == "D4"){//개발완료
        	if(isNotExistFileType1 || isNotExistFileType2 || isNotExistFileType3){
        		alert("첨부파일 > 업무기술서, 분석설계서, QA관리기준서을 첨부해주십시오.");
                return false;
        	}
        }
        else if(sProcessSttus == "O1"){//개발완료
        	//if(isNotExistFileType1 || isNotExistFileType2 || isNotExistFileType3 || isNotExistFileType4){
        	if(isNotExistFileType1 || isNotExistFileType2 || isNotExistFileType3){
        		console.log("오류")
        		alert("첨부파일 > 업무기술서, 분석설계서, QA관리기준서를 첨부해주십시오.");
                return false;
        	}
        }
        
        iFileGrpNo =  oRpaUploadUpload.upload();
        console.log("iFileGrpNo: " + iFileGrpNo);
        
        
        //iFileGrpNo2 = oRpaUploadUpload2.upload();
        
        var aObj = $(".jq_cntcSysChackbox:checkbox");
        var aCntcSysList = [];
        
        $.each(aObj, function(index, item) {
        	aCntcSysList.push({cntcSysCd:$(item).val()});
        });
        
     
        var param = {
            devlopSn: $("#taskCd").val()
            ,   sj: oSj.val()
            ,   processNo: $("#processNo").val()
            ,   processCd: oProcessCd.val()
            ,   processNm: oProcessNm.val()
            ,   jobDc: $("#jobDc").val().replace(/\n/g, "<br>")
            ,   cmpnyCd: oCmpnyCdReg.val()
//            ,   jobClsCd: oJobClsCd.val()
//            ,   rpaClsCd: oRpaClsCd.val()
//            ,   jobTm: oProcessJobTm.val().replace(/,/gi, "") 
            ,   redcnTm: oRedcnTm.val().replace(/,/gi, "")
            ,   expectRedcnAmt: oExpectRedcnAmt.val().replace(/,/gi, "")
            ,   fqCd: oFqCdReg.val()
            ,   executCnt: oExecutCntReg.val().replace(/,/gi, "")
            ,   executTm: oExecutTm.val().replace(/,/gi, "")
            ,   emrgncyCrspnd: $("#emrgncyCrspnd").val()
            ,   rto: $("#rto").val().replace(/,/gi, "")
            ,   devlopWdcnt: oDevlopWdcnt.val().replace(/,/gi, "")
            ,   expectDevlopCt: expectDevlopCt.val().replace(/,/gi, "")
            ,   roiEvaluate: $("#roiEvaluate").val()
            ,   devlopResn: $("#devlopResn").val().replace(/\n/g, "<br>")
            ,   insideDevlopAt: oInsideDevlopAt.val()
            ,	devlopChargerId: $("#devlopChargerId").val()
			,	executSe: oExecutSe.val()
			, 	belongingDe: oBelongingDe.val()
            ,   fileGrpNo: iFileGrpNo
//            ,   relateDoc: $("#relateDoc").val()
            ,   chargerList: aChargerList
            ,   redcnTmList: aRedcnTmList
            ,   contributeList: aContributeList
//            ,   processFileGrpNo:iFileGrpNo2
            ,   cntcSysList: aCntcSysList
            ,   processSttus: $("#processSttus").val()
            ,   changeCn: changeCn.val()
        }

        callAsyncAjax("/task/develop/updateTaskDevelopProcess", param, "mainPopCloseReload");
    });
    
	$("#backListBtn").on("click", function() { 
        mainPopClose();
        searchList();
    });
	
	$("#redcnTm")
    .on("focus", function() {
        var x = $(this).val();
        x = removeCommas(x);
        $(this).val(x);
    }).on("focusout", function() {
        var x = $(this).val();
        if(x && x.length > 0) {
            if(!$.isNumeric(x)) {
                x = x.replace(/[^0-9]/g,"");
            }
            
            $("#expectRedcnAmt").val(addCommas(x * 33000));
            x = addCommas(x);
            $(this).val(x);
        }
        else{
        	$("#expectRedcnAmt").val("");
        }
        chkRoiEvaluate();
    }).on("keyup", function() {
        $(this).val($(this).val().replace(/[^0-9]/g,""));
    });
	
	$("#devlopWdcnt")
    .on("focus", function() {
        var x = $(this).val();
        x = removeCommas(x);
        $(this).val(x);
    }).on("focusout", function() {
        var x = $(this).val();
        if(x && x.length > 0) {
            if(!$.isNumeric(x)) {
                x = x.replace(/[^0-9]/g,"");
            }
            
            $("#expectDevlopCt").val(addCommas(x * 33000 * 8.5));
            x = addCommas(x);
            $(this).val(x);
        }
        else{
            $("#expectDevlopCt").val("");
        }
        chkRoiEvaluate();
    }).on("keyup", function() {
        $(this).val($(this).val().replace(/[^0-9]/g,""));
    });
	
	//개발담당자
    $("#btnSchDevlopChargerId").on("click",function(){
        openGwpwrUserPopup("divSearchUser", "callbackDevlopCharger");           
    });
}

function chkRoiEvaluate(){
	var x = $("#devlopWdcnt").val();   //개발공수
	var y = $("#redcnTm").val();       //절감시간
	var sSetText = "NO";
    if(x && x.length > 0 && y && y.length > 0) {
    	if(parseInt(removeCommas(x)) * 10 <= parseInt(removeCommas(y))){
    		sSetText = "OK";
    	} 
    }
    
    $("#roiEvaluate").val(sSetText);
}


function pageInit(){
	
	//권한에 따른 다운로드 버튼 제외 페이지 여부
	isDownloadBtnRolePageAt = true;
	
	//다운로드 버튼 권한 여부
	isDownloadBtnRoleAt = ${isDownloadBtnRoleAtFlag};

	oRpaUploadUpload = new RpaUploadV2("fileUpload");
	//oRpaUploadUpload2 = new RpaUploadType2("fileUpload2");
};
    

//담당자 정보 추가버튼 이벤트
function drawChargerList(aList){
	var iaList = aList.length;
	
	for(var i = 0; i < iaList; i++){
		var oaList = aList[i];
		var str = "";
	    str += '<div class="form-group col-md-6" name="chargerList'+ chargerCnt + '">'
	    str += '<label for="sourcUpdtNm" class="col-sm-4 col-form-label">부서</label>'
	    str += '<div class="col-sm-8 jq_chargerDept">'
	    str += '    <input type="hidden" id="chrgDeptCd'+ chargerCnt + '" class="form-control" style="width:80%;" value="' + oaList.chrgDeptCd +'">'
	    str += '    <input type="text" id="chrgDeptNm'+ chargerCnt + '" class="form-control"  style="width:80%;" value="' + oaList.chrgDeptNm +'" readonly>'
	    str += '</div>'
	    str += '</div>'
	    str += '<div class="form-group col-md-6" name="chargerList'+ chargerCnt + '">'
	    str += '    <label for="sourcUpdtNm" class="col-sm-4 col-form-label">성명</label>'
	    str += '    <div class="col-sm-8 jq_chrgUser">'
	    str += '        <input type="hidden" id="chrgUserId'+ chargerCnt + '" class="form-control float-left"  style="width:30%; margin:2px 5px 0 0;" value="' + oaList.chargerId +'" readonly>'
	    str += '        <input type="text" id="chrgUserNm'+ chargerCnt + '" class="form-control float-left"  style="width:30%; margin:2px 5px 0 0;" value="' + oaList.chargerNm +'" readonly>'
	    str += '        <input type="button" class="btn btn-outline-primary float-left" name="btnSearchUser" onclick="searchUserV2(\'chrg\', '+ chargerCnt + ')" value="사원검색" />'
	    str += '        <input type="button" class="btn btn-outline-secondary float-left" name="" onclick="popDeleteList(\'chargerList\', '+ chargerCnt + ')" value="삭제" />'
	    str += '    </div>'
	    str += '</div>'
	    
	    $("#chargerList").append(str);
	    
	    chargerCnt++;
	}
}

function drawRedcnTmList(aList){
    var iaList = aList.length;
    var iTempRedcnTmSum = 0
    for(var i = 0; i < iaList; i++){
    	var oaList = aList[i];
		var str = "";
	    str += ' <div class="form-group col-md-3" name="individualRedcnTm'+ individualConCnt + '">'
	    str += '     <label for="sourcUpdtNm" class="col-sm-4 col-form-label">부서</label>'
	    str += '     <div class="col-sm-8 jq_redcnTmDept">'
	    str += '         <input type="hidden" id="redcnTmDeptCd'+ individualConCnt + '" class="form-control" value="'+ oaList.deptCd+'">'
	    str += '         <input type="text" id="redcnTmDeptNm'+ individualConCnt + '" class="form-control"  style="width:75%;" value="'+ oaList.deptNm+'" readonly>'
	    str += '     </div>'
	    str += ' </div>'                    
	    str += ' <div class="form-group col-md-4" name="individualRedcnTm'+ individualConCnt + '">'
	    str += '     <label for="sourcUpdtNm" class="col-sm-4 col-form-label">성명</label>'
	    str += '     <div class="col-sm-8 jq_redcnTmUser">'
 	    str += '         <input type="hidden" id="redcnTmUserId'+ individualConCnt + '" class="form-control float-left"  style="width:48%;margin:2px 5px 0 0;" value="'+ oaList.userId+'">'
	    str += '         <input type="text" id="redcnTmUserNm'+ individualConCnt + '" class="form-control float-left"  style="width:48%;margin:2px 5px 0 0;" value="'+ oaList.userNm+'" readonly>'
	    str += '         <input type="button" class="btn btn-outline-primary float-left" name="" onclick="searchUserV2(\'redcnTm\', '+ individualConCnt + ')" value="사원검색" />'
	    str += '     </div>'
	    str += ' </div>'
	    str += ' <div class="form-group col-md-5" name="individualRedcnTm'+ individualConCnt + '">'
	    str += '     <label for="sourcUpdtNm" class="col-sm-4 col-form-label">절감시간(hour)</label>'
	    str += '     <div class="col-sm-8 float-left">'
	    str += '         <input type="text" id="redcnTmRedcnTm'+ individualConCnt + '" class="form-control float-left jq_redcnTmRedcnTm" style="width:48%; margin:2px 5px 0 0;"  value="'+ (addCommas(oaList.redcnTm)) +'">'
	    str += '         <input type="button" class="btn btn-outline-secondary float-left" name=""  onclick="popDeleteList(\'individualRedcnTm\', '+ individualConCnt + ')" value="삭제" />' 
	    str += '     </div>'
	    str += ' </div>'
	    
	    $("#individualRedcnTmList").append(str);
	    
	    iTempRedcnTmSum += parseInt(oaList.redcnTm);
	    individualConCnt++;
    }
    
    $("#redcnTmSum").val(addCommas(iTempRedcnTmSum));
    
    
	
}

function drawContributeList(aList){
    var iaList = aList.length;
    var iTempContributeSum = 0;
    for(var i = 0; i < iaList; i++){
        var oaList = aList[i];
        var str = "";
        
        str += '   <div class="form-group col-md-3" name="individualContributeList'+ individualConCnt + '">'
        str += '       <label for="sourcUpdtNm" class="col-sm-4 col-form-label">부서</label>'
        str += '       <div class="col-sm-8 jq_contributeDept">'
        str += '           <input type="hidden" id="contributeDeptCd'+ individualRedcnTmCnt + '" class="form-control" value="'+ oaList.deptCd +'">'
        str += '           <input type="text" id="contributeDeptNm'+ individualRedcnTmCnt + '" class="form-control"  style="width:80%;" value="'+ oaList.deptNm +'" readonly>'
        str += '       </div>'
        str += '</div>'                    
        str += '<div class="form-group col-md-4" name="individualContributeList'+ individualConCnt + '">'
        str += '    <label for="sourcUpdtNm" class="col-sm-4 col-form-label">성명</label>'
        str += '    <div class="col-sm-8 jq_contributeUser">'
        str += '        <input type="hidden" id="contributeUserId'+ individualRedcnTmCnt + '" class="form-control" value="'+ oaList.userId +'">'
        str += '        <input type="text" id="contributeUserNm'+ individualRedcnTmCnt + '" class="form-control float-left"  style="width:48%;margin:2px 5px 0 0;" value="'+ oaList.userNm +'" readonly>'
        str += '        <input type="button" class="btn btn-outline-primary float-left" name="" onclick="searchUserV2(\'contribute\', '+ individualConCnt + ')" value="사원검색" />'
        str += '    </div>'
        str += '</div>'
        str += '<div class="form-group col-md-5" name="individualContributeList'+ individualConCnt + '">'
        str += '    <label for="sourcUpdtNm" class="col-sm-4 col-form-label">기여도(%)</label>'
        str += '    <div class="col-sm-8 float-left">'
        str += '        <input type="text" id="contributeRate'+ individualRedcnTmCnt + '" class="form-control float-left jq_contributeRate" style="width:48%; margin:2px 5px 0 0;" value="'+ oaList.contribute +'">'
        str += '        <input type="button" class="btn btn-outline-secondary float-left" name="" onclick="popDeleteList(\'individualContributeList\', '+ individualConCnt + ')" value="삭제" />'
        str += '    </div>  '
        str += '</div>'
        
        
        $("#individualContributeList").append(str);
        
        individualConCnt++;
        iTempContributeSum += parseInt(oaList.contribute);
    }

    $("#contributeSum").val(iTempContributeSum)
}

function drawCntcSysList(aList){
    var iaList = aList.length;
    for(var i = 0; i < iaList; i++){
        var oaList = aList[i];
        var str = "";
        str += '<tr>';
        str += '    <td><input type="checkbox" class="custom-checkbox jq_cntcSysChackbox" style="width:18px;height:18px;" value="' + oaList.cntcSysCd +'"></td>';
        str += '    <td>' + oaList.cntcSysClsNm +'</td>';
        str += '    <td>'+ (oaList.cmpnyNm == undefined ? "" : oaList.cmpnyNm) +'</td>';
        str += '    <td>' + oaList.cntcSysCd +'</td>';
        str += '    <td>' + oaList.cntcSysNm +'</td>';
        str += '</tr>';
        $("#cntcSysList tbody").append(str);
    }
}


function drawChangeHistList(aList){
	var iaList = aList.length;
    for(var i = 0; i < iaList; i++){
        var oaList = aList[i];
        var str = "";
        str += '<tr>';
        str += '    <td>' + oaList.regDt + '</td>';
        str += '    <td>' + oaList.processSttusNm + '</td>';
        str += '    <td>' + oaList.empNm + '</td>';
        str += '    <td style="text-align:left">' + (oaList.changeCn == undefined  ? "" : oaList.changeCn.replace(/(\n|\r\n)/g, '<br>')); + '</td>';
        str += '</tr>';
        $("#changeHistList tbody").append(str);
    }
}


/*
 * 사원검색 팝업 함수
 * @param
 * @return
 */
function searchUserV2(sPositionId, iNumber){
    lc_sPositionId = sPositionId; 
    lc_iNumber = iNumber;
    openGwpwrUserPopupV2("divSearchUser", "callbackSearchUserV2", $("#cmpnyCd").val());
}

/*
 * 사원검색 콜백 함수
 * @param
 * @return
 */
function callbackSearchUserV2(data) {
    $("#" + lc_sPositionId + "DeptCd" + lc_iNumber).val(data.deptCd)
    $("#" + lc_sPositionId + "DeptNm" + lc_iNumber).val(data.deptNm)
    $("#" + lc_sPositionId + "UserId" + lc_iNumber).val(data.gwpwrId)
    $("#" + lc_sPositionId + "UserNm" + lc_iNumber).val(data.userNm)
};

function popDeleteList(sDeleteNm, inumber){
    var iTempCnt = 0
    
    if(sDeleteNm == "chargerList"){
        iTempCnt = $(".jq_chargerDept").length; 
    }
    else if(sDeleteNm == "individualRedcnTm"){
        iTempCnt = $(".jq_redcnTmDept").length;
    }
    else if(sDeleteNm == "individualContributeList"){
        iTempCnt = $(".jq_contributeDept").length;
    }
    
        
    
    if(sDeleteNm != "individualRedcnTm" && iTempCnt <= 1){
        alert("더 이상 삭제 할 수 없습니다.");
        return false;
    }
    
    $("div[name=" + sDeleteNm + inumber + "]").remove();
};

function callbackOpenSearchCntcSysPopup(data){
    var str = "";
    str += '<tr>';
    str += '    <td><input type="checkbox" class="custom-checkbox jq_cntcSysChackbox" style="width:18px;height:18px;" value="' + data.cntcSysCd+ '"></td>';
    str += '    <td>'+ data.cntcSysClsNm+'</td>';
    str += '    <td>'+ (data.cmpnyNm == undefined ? "" : data.cmpnyNm) +'</td>';
    str += '    <td>' + data.cntcSysCd + '</td>';
    str += '    <td>' + data.cntcSysNm + '</td>';
    str += '</tr>';
    $("#cntcSysList tbody").append(str);
    
}

/*
 * 과제개발 > 과제 프로세스 상세 pop: Data표시
 * @param
 * @return
 */
function popProcessDetailDrawData(data){
    //데이터 화면에 출력
    var aResult = data.result
    var params = [];
    for (var sKey in aResult) {
        if(sKey == "taskCd"){
            getTaskCdListByClsCd('taskCd');
            $("#taskCd option").filter(function(){
                return this.text == aResult[sKey];
            }).attr('selected', true);
            $("#taskCd").attr("disabled", true);
        }
        else if(sKey == "cmpnyCd"){
            params.push({"id" : "cmpnyCd", "clsCd" : "0024", "disable" : "N", "selectValue": aResult[sKey]} );
            params.push({"id" : "cmpnyCdReg", "clsCd" : "0024", "disable" : "N", "selectValue": aResult[sKey]} );
        }
        else if(sKey == "clsCd"){
            params.push({"id" : "clsCd", "clsCd" : "0040", "selectValue": aResult[sKey]});
        }
        else if(sKey == "fqCd"){
            params.push({"id" : "fqCd", "clsCd" : "0017", "selectValue": aResult[sKey]});    //빈도
        }
        else if(sKey == "jobChargerNm"){
            $("#jobChargerNm").val(aResult[sKey]);
            $("#jobChargerNmReg").val(aResult[sKey]);
        }
        else if(sKey == "jobChrgDeptNm"){
            $("#jobChrgDeptNm").val(aResult[sKey]);
            $("#jobChrgDeptNmReg").val(aResult[sKey]);
        }
        else if(sKey == "jobClsCd"){
            params.push({"id" : "jobClsCd", "clsCd" : "0040", "selectValue": aResult[sKey]});    //업무분류
        }
        else if(sKey == "rpaClsCd"){
            params.push({"id" : "rpaClsCd", "clsCd" : "0042", "selectValue": aResult[sKey]});    //RPA분류
        }
        else if(sKey == "fqCdReg"){
            params.push({"id" : "fqCdReg", "clsCd" : "0017", "selectValue": aResult[sKey]});    //빈도
        }
        else if(sKey == "jobDc"){
            $("#" + sKey).val(aResult[sKey].replace(/<br>/gi, "\r\n"));
        }
        else if(sKey == "insideDevlopAt"){
        	
            if(aResult[sKey] == null){
            	params.push({"id" : "insideDevlopAt", "clsCd" : "0047"});    //빈도
            }else{
            	params.push({"id" : "insideDevlopAt", "clsCd" : "0047", "selectValue": aResult[sKey]});    //빈도
            }
        
        }
        else if(sKey == "executSe"){
            params.push({"id" : "executSe", "clsCd" : "0049", "selectValue": aResult[sKey]});    //빈도
        }
        else if(sKey == "processSttus"){
        	var sTempVal = aResult[sKey];
            var aExclusionList = []
            var sDisable = "N";
            
            if(sTempVal != "D1" && sTempVal != "D2" && sTempVal != "D3" && sTempVal != "M1" || sTempVal != "P2" || sTempVal != "O1"){
            	aExclusionList["O2"] = "";//운영취소 결재중
                aExclusionList["O3"] = "";//운영취소
                aExclusionList["O4"] = "";//운영취소 반려
                aExclusionList["O5"] = "";//운영 기안취소
                aExclusionList["O6"] = "";//운영취소 결재 대기중
                aExclusionList["P1"] = "";//개발 결재중
                aExclusionList["P2"] = "";//개발 결재반료
                aExclusionList["P3"] = "";//개발 기안취소
                aExclusionList["P4"] = "";//개발 임시저장
                $("#saveBtn").show();
            }
            else{
            	sDisable = "Y";
            }
            
            params.push({"id" : "processSttus", "clsCd" : "0037", "selectValue": aResult[sKey], disable: sDisable, exclusionList: aExclusionList, emptyOption: "Y"} );    //프로세스 상태
        }
        else if(sKey == "chargerList"){
        	if(aResult[sKey].length > 0){
        		drawChargerList(aResult[sKey]);
        	}
        	else{
        		$("#btnAddCharger").click();
        	}
        }
        else if(sKey == "redcnTmList"){
        	if(aResult[sKey].length > 0){
        		drawRedcnTmList(aResult[sKey]);
        	}
        	else{
        		$("#btnAddIndividualRedcnTm").click();
        	}
        }
        else if(sKey == "contributeList"){
        	if(aResult[sKey].length > 0){
        		drawContributeList(aResult[sKey]);
        	}
        	else{
        		$("#btnAddIndividualContribute").click();
        	}
        }
        else if(sKey == "cntcSysList"){
            drawCntcSysList(aResult[sKey]);
        }
        else if(sKey == "changeHistList"){
            drawChangeHistList(aResult[sKey]);
        }
        else if(sKey == "fileGrpNo"){
            var sTempFileGrpNo = aResult[sKey]
            if(sTempFileGrpNo != "" && sTempFileGrpNo != "0" && sTempFileGrpNo != null){
                oRpaUploadUpload.draw(sTempFileGrpNo,true);
            }
            else{
                oRpaUploadUpload.draw('',true);
            }
        }
//        else if(sKey == "processFileGrpNo"){
//            var sTempFileGrpNo = aResult[sKey]
//            if(sTempFileGrpNo != "" && sTempFileGrpNo != "0" && sTempFileGrpNo != null){
//                oRpaUploadUpload2.draw(sTempFileGrpNo,true);
//            }
//            else{
//                oRpaUploadUpload2.draw('',true);
//            }
//        }
        else if(
                sKey == "redcnTm" || sKey == "expectRedcnAmt" || sKey == "executCntReg" || sKey == "executTm" || sKey == "expectDevlopCt"  || sKey == "rto"
                     || sKey == "jobTm" || sKey == "processJobTm"
                ){
            $("#" + sKey).val(addCommas(aResult[sKey]));
        }
        else if(sKey == "executSe"){
            params.push({"id" : "executSe", "clsCd" : "0043", "selectValue": aResult[sKey]});    //실행구분
        }
        
        else{
            $("#" + sKey).val(aResult[sKey])
        }
    }
    
    if(aResult["fqCdReg"] == undefined){
		params.push({"id" : "fqCdReg", "clsCd" : "0017"});    //빈도
	}
    if(aResult["executSe"] == undefined){
    	params.push({"id" : "executSe", "clsCd" : "0049"});    //실행구분
    }
    	
    requestCmmnCd(params);      
    
    
    // 로딩 끝
    $('.dimmed').css({ display: 'none' });
    $('.loading').css({ display: 'none' });
    $('.loading').removeClass('show');
    
}

function callbackDevlopCharger (data){
    $("#devlopChargerId").val(data.gwpwrId)
    $("#devlopChargerNm").val(data.userNm)
}
</script>
 </div>
