<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!--  템플릿 바디 -->        
 <div class="card card-primary" id="unmanagtErrorRegDiv">                   
    <div class="card-header" alt="과제 >과제운영 취소">
        <h3 class="card-title">취소요청</h3>
    </div>
    <div class="card-body">
        <div class="row">
            <div class="col-md-12">
                <form class="form-inline" id="unmanagtErrorDetail">                    
                    <div class="form-group col-md-12">
                        <label for="errorTyCd" class="col-sm-2 col-form-label">제목</label>
                        <div class="col-sm-10">
                            <input type="text" id="sj" class="form-control"  style="width:92.5%;" disabled/>
                        </div>
                    </div>
                    
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">프로세스코드</label>
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
                    
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">회사</label>
                        <div class="col-sm-8">
                            <input type="text" id="cmpnyNm" class="form-control"  style="width:80%;" disabled>
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">부서</label>
                        <div class="col-sm-8">
                            <input type="text" id="jobChrgDeptNm" class="form-control"  style="width:80%;" value="" disabled>
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">담당자</label>
                        <div class="col-sm-8 float-left">
                            <input type="text" id="jobChargerNm" class="form-control float-left"  style="width:70px;margin-right:5px;" value="홍길동" disabled /> 
                            <input type="text" id="telNo" class="form-control float-left"  style="width:200px;" value="111" disabled />
                        </div>
                    </div>  
                     
                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">연락처</label>
                        <div class="col-sm-8">
                            <input type="text" id="" class="form-control"  style="width:150px;" value="???" disabled />  
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">업무분류</label>
                        <div class="col-sm-8">
                            <select id="jobClsCd" class="form-control" style="width:80%;margin-right: 3px;" type="text" disabled></select>
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">업무시간</label>
                        <div class="col-sm-8 float-left">
                            <input type="text" id="jobTmPrc" class="form-control float-left" style="width:120px;margin-right: 3px;" value="264" disabled>H
                        </div>
                    </div>                       
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">예상절감시간①</label>
                        <div class="col-sm-8 float-left">
                            <input type="text" id="redcnTm" class="form-control float-left" style="width:120px;margin-right: 3px;" value="264" disabled>H
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">예상절감금액<br/>(① X 33,000원)</label>
                        <div class="col-sm-8">
                            <input type="text" id="expectRedcnAmt" class="form-control float-left" style="width:120px;margin-right: 3px;" value="8,712,000" disabled>원
                        </div>
                    </div>

                    <div class="form-group col-md-12">
                        <label for="managtChargerId" class="col-sm-2 col-form-label">연관문서</label>
                        <div class="col-sm-10">
                            <input type="text" id="relateDoc" class="form-control"  style="width:92.5%;" disabled>
                        </div>
                    </div>
                    
                    <div class="form-group col-md-12 py-sm-2">
                        <label for="errorTyCd" class="col-sm-2 col-form-label">취소사유</label>
                        <div class="col-sm-10">
                             <input type="text" id="reason" class="form-control"  style="width:92.5%;"  maxlength="4000"/>
                        </div>
                    </div>
                    
                    <div class="form-group col-md-12 py-sm-2">
                        <label for="errorTyCd" class="col-sm-2 col-form-label">병합대상</label>
                        <div class="col-sm-10">
                             <input type="text" id="mergeTarget" class="form-control"  style="width:92.5%;" maxlength="2000" />
                        </div>
                    </div>
                    <div class="form-group col-md-12 py-sm-2">
                        <label for="errorTyCd" class="col-sm-2 col-form-label">처리사항</label>
                        <div class="col-sm-10">
                            <textarea rows="2" id="proceMatter" class="form-control" style="width:92.5%;" maxlength="2000"></textarea>
                        </div>
                    </div>
                   <div class="form-group col-md-12">
                        <label for="managtChargerId" class="col-sm-2 col-form-label">첨부파일 </label>
                       <div class="col-sm-10"><div class="form-check2 row"  id="fileUpload" ></div></div>
                   </div>

                </form>
                <div class="float-right py-sm-3">
<c:if test="${txScreenAuthor.wrtngAuthor eq 'Y'}">    
                    <button type="button" class="btn btn-primary" id="requestBtn">결제요청</button>
</c:if>
                    <button type="button" class="btn btn-primary" id="CancelBtn">닫기</button>
                    <input type="hidden" id="processNo">
                    <input type="hidden" id="devlopSn">
                </div>
                <div id="divSearchUser" class="modal fade" tabindex="-1" role="dialog"></div>
            </div>
        </div>
    </div>
</div>

<!-- 로딩바  -->
<div class="dimmed" style="display:none"></div>
<div class="loading" style="display:none">
    <div class="loading-bar"><div></div><div></div><div></div><div></div></div>
    <span class="loading-text">결재 진행중...</span>
</div>

<!-- 프로세스 결재요청 창 호출  -->
<!-- <form name="PassFormDraft" method="post" target="_blank" action="https://gwdev.dongwon.com/WebSite/Approval/RpaDraft.aspx"> -->
<form name="PassFormDraft" method="post" target="_blank">
    <input type="hidden" id="mKey" name="mKey" value="">
    <input type="hidden" id="title" name="title" value="">
    <textarea  id="bodies" name="bodies" value="" style=display:none></textarea>
    <input type="hidden" id="userid" name="userid" value="">
    <input type="hidden" id="formName" name="formName" value="">
    <input type="hidden" id="formPrefix" name="formPrefix" value="Z_20_002_02">
    <input type="hidden" id="legacyout" name="legacyout" value='<?xml version="1.0"?><XML_DATA><apprvReqNo>826361</apprvReqNo><formPrefix>Z_20_002_02</formPrefix></XML_DATA>' />       
    <input type="hidden" id="bodytype" name="bodytype" value="html">
</form>



<script>

var bbsUpload;
var iFileGrpNo =0;
var chkCount = 0;
var chkMS = 0;

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
        
        /* $("#requestBtn").on("click", function() { 
        	alert("결재화면 완료시 까지는 취소처리 버튼만 사용 가능 합니다.");
        }); */
        
        $("#requestBtn").on("click", function() { 
         var reason = $('#reason').val();
         var mergeTarget = $('#mergeTarget').val();
         var proceMatter = $('#proceMatter').val();
         var processCd = $('#processCd').val();
         var procNo = $('#processNo').val();
         var procSn = $('#devlopSn').val();
         
         iFileGrpNo = bbsUpload.upload();
         
         var param = {
        		        processCd:processCd
        		      , procNo:procNo
        		      , reason:reason
        		      , mergeTarget:mergeTarget
        		      , proceMatter:proceMatter
        		      , procSn:procSn
        		      , fileGrpNo: iFileGrpNo
        		      
        		      /* 프로세스 결재용 추가 파라미터 */
        		      , formPrefix:"Z_20_002_02"
        		      , devlopSn:procSn
                      , processNo:procNo
                      , pSj:$('#sj').val()
        		      };
         
         callAsyncAjax("/task/manage/taskManageProcUpdate", param, "callPaymentForm");

        });
        
        $("#CancelBtn").on("click", function() { 
            closePop();
        });
    }
    
    //결재 연동 FORM 호출
    function callPaymentForm(data){ 
        
    	console.log("결재 연동 API 운영 form 값 확인 : ");
        console.log(data.result);
    	
        var formData = data.result;
        
        $('#mKey').val(formData.mKey);
        $('#title').val(formData.pSj);
        $('#bodies').val(formData.bodies);
        $('#userid').val(formData.userid);
        $('#formName').val(formData.formName);

        var height = window.screen.height;
        var size = "left="+(screen.availWidth-660)/2+",top="+(screen.availHeight-430)/2+",width=900,height="+height;
        
        var pop_title = "payment_poner" ;
        var new_window = window.open("", pop_title, size) ;
        var frmData = document.PassFormDraft ;
        frmData.target = pop_title ;
        frmData.action = formData.url
        frmData.submit() ;

        //결재 로딩바 
        $('.dimmed').css({ display: 'block' });
        $('.loading').css({ display: 'block' });
        $('.loading').addClass('show');
        
        var timer = setInterval(function() { 
            if(new_window.closed) { 
                clearInterval(timer);
                setTimeout(function() {
                	chkTaskPaymentApiResponse(data); 
                }, 2000);
            }
        }, 5000);
    }
    
    //결재 연동 API 상태값 체크
    function chkTaskPaymentApiResponse(data){ 
        console.log("결재 연동 API 프로세스 상태값 ajax호출 확인 : ");
        console.log(data.result);
        
        var params = data.result;
        callAsyncAjax("/task/manage/getTaskManageProcessDetail", params, "callBackChkTaskPaymentApiResponse");
        
      //처음 체크시 30초 (단위 밀리초 : 30000) 그 후 확인 1분 (단위 밀리초 : 60000) 총 3번 확인
        /* if(chkCount > 0){
            chkMS = 60000; //1분
        }else{
            chkMS = 30000; //30초
        }
        
        setTimeout(function() {
            var params = data.result;
            callAsyncAjax("/task/manage/getTaskManageProcessDetail", params, "callBackChkTaskPaymentApiResponse");
        }, chkMS); */
          
    } 
    
    function callBackChkTaskPaymentApiResponse(data){
        
        var processSttus = data.result.processSttus;
        
        console.log("processSttus 확인 : "+processSttus);
        
        if(processSttus == "O2"){
        	//운영취소 결재중 : 정상 (O2) -> 팝업닫기
        	alert('운영취소 결재가 상신되었습니다.');
            mainPopCloseReload();
        }else{
        	//계속 운영취소 결재 대기중(O6)일 경우 프로세스 결재 삭제 처리, 프로세스 롤백
            requestTaskManageProcessCancelRollBack(data);
            $('.dimmed').css({ display: 'none' });
            $('.loading').css({ display: 'none' });
            $('.loading').removeClass('show');
        }
        
    }
    
    function requestTaskManageProcessCancelRollBack(data){
        console.log("삭제");
        console.log(data.result);
        var url = '/task/payment/requestTaskManageProcessCancelRollBack';
        var param = data.result;
        param.mKey = $('#mKey').val()
        param.formPrefix = $('#formPrefix').val()
        callAsyncAjax(url, param, "mainPopCloseReload");
    }
    
    function callBackChkTaskPaymentApiResponseASIS(data){
    	
        var processSttus = data.result.processSttus;
        
        console.log("chkCount 확인 : " + chkCount + "    processSttus 확인 : "+ processSttus);
        
        if((processSttus == null || processSttus == "" || processSttus == "O6") && 3 > chkCount){
            //개발 결재 대기중 일 경우 3번 체크
            chkTaskPaymentApiResponse(data);
        }else if(processSttus == "O2"){
            //운영취소 결재중 : 정상 (O2) -> 팝업닫기
            mainPopCloseReload();
        }else{
            //계속 운영취소 결재 대기중(O6)일 경우 프로세스 결재 삭제 처리, 프로세스 롤백
            taskPaymentRollBack(data);
        }
        
        chkCount ++;
        chkMS ++;
    }
    
    
    
    function pageInit(){
        bbsUpload = new RpaUpload("fileUpload");
        bbsUpload.draw('',true);
    };
    
    function mainPopCloseReload() {
        $(".over").remove();
        searchList();
    }
</script>
