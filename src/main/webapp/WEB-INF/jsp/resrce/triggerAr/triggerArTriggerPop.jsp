<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!--  템플릿 바디 -->        
 <div class="card card-primary" id="unmanagtErrorRegDiv">                   
    <div class="card-header">
        <h3 class="card-title">정기실행 등록</h3>
    </div>
    <div class="card-body">
        <div class="row" style="min-height:560px;">
            <div class="col-md-12">
                <form class="form-inline" id="">  
                      <div class="form-group col-md-6" >
                         <label class="col-sm-4 col-form-label" for="inputName">프로세스</label>
                         <div class="col-sm-8">
                         	<input type="text" class="form-control float-left col-sm-12" id="releasesSearchKwrd" name="releasesSearchKwrd" style="width:75%;min-width:75px;" placeholder="검색할 프로세스명 또는 코드 입력" maxlength="50" value="" /><button type="button" id="btnReleasesSearch" class="btn btn-info float-left ">조회</button>
                             <select class="form-control" id="targetReleases" style="width:60%;margin-right: 3px;">
                             </select>
                         </div>
                     </div>
                     
                     <div class="form-group col-md-6">
                         <label for="name" class="col-sm-4 col-form-label">실행로봇</label>
                         <div class="col-sm-8">
                             <select class="form-control" id="botNo" style="width:60%;margin-right: 3px;">
                             </select>
                         </div>
                      </div>
                     
                     <div class="form-group col-md-12">
                        <label for="name" class="col-sm-2 col-form-label">실행기간</label>
                        <div class="col-sm-10 float-left">
                            <div class="input-group date float-left" id="startDeDiv" data-target-input="nearest"style="min-width:200px;width:23.4%;margin-right:5px;">
                                <input type="text" id="startDe" name="startDe" class="form-control datetimepicker-input" data-target="#startDeDiv"/>
                                <div class="input-group-append" data-target="#startDeDiv" data-toggle="datetimepicker">
                                    <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                </div>
                            </div>
                            <div class="input-group date  float-left" id="endDeDiv" data-target-input="nearest"style="min-width:200px;width:23.4%;">
                                <input type="text" id="endDe" name="endDe" class="form-control datetimepicker-input" data-target="#endDeDiv"/>
                                <div class="input-group-append" data-target="#endDeDiv" data-toggle="datetimepicker">
                                    <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                </div>
                            </div>
                        </div>
                     </div>                  
                    
                     <div class="form-group col-md-12" style="display:inline;">                        
                        <div class="col-sm-2 py-sm-1  float-left"><label for="sourcUpdtNm" class="col-form-label"><input type="radio" name="schduleType1" class="custom-radio" style="width:18px;height:18px;" value="1" checked>  분</label></div>
                        <div class="col-sm-10 py-sm-2 float-left">
                        	<select id="everyMinute" class="form-control float-left" style="max-width:90px; margin-right:3px; ">
                        			<option value="">선택</option>
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="6">6</option>
                                    <option value="10">10</option>
                                    <option value="20">20</option>
                                    <option value="30">30</option>
                                    
                        	</select>분 간격
                        </div>
                        
                        <div class="col-md-12 line-top py-sm-2 float-left"></div> <!-- 사이점선 -->
                        <div class="col-sm-2 py-sm-1  float-left"><label for="sourcUpdtNm" class="col-form-label"><input type="radio" name="schduleType1" class="custom-radio" style="width:18px;height:18px;" value="2">  시간</label></div>
                        <div class="col-sm-10 py-sm-2 float-left">
                        	<div class="input-group">
                            	<input type="text" id="everyHour" class="form-control float-left" style="max-width:90px;margin-right: 3px;" maxlength="2" numberOnly>시
                            	<input type="text" id="everyHourMinute" class="form-control float-left" style="max-width:90px;margin-right: 3px;" maxlength="2" numberOnly>분 간격
                            </div>
                        </div>
                        
                        <div class="col-md-12 line-top py-sm-2 float-left"></div> <!-- 사이점선 -->
                        <div class="col-sm-2 py-sm-1 float-left"><label for="sourcUpdtNm" class="col-form-label"><input type="radio" name="schduleType1" class="custom-radio" style="width:18px;height:18px;" value="3">  매일</label></div>
                        <div class="col-sm-10 py-sm-2 float-left">
                            <div class="input-group">
	                            <input type="text" id="everyDayHour" class="form-control float-left" style="max-width:90px;margin-right: 3px;" maxlength="2" numberOnly>시&nbsp;
	                            <input type="text" id="everyDayMinute" class="form-control float-left" style="max-width:90px;margin-right: 3px;" maxlength="2" numberOnly>분
                            </div>
                        </div>
                        <div class="col-md-12 line-top float-left"></div> <!-- 사이점선 -->
                        <div class="col-sm-2 py-sm-2 float-left"><label for="sourcUpdtNm" class="col-form-label float-left"  style="padding-top:10px;"><input type="radio" name="schduleType1" class="custom-radio" style="width:18px;height:18px;" value="4">  매주</label></div>
                        <div class="col-sm-10 py-sm-3 float-left">
                            <input type="checkbox" id="everyWeekMonAt" class="custom-checkbox jq_everyWeek" style="width:18px;height:18px;margin-left:8px;" value="Y">월
                            <input type="checkbox" id="everyWeekTueAt" class="custom-checkbox jq_everyWeek" style="width:18px;height:18px;margin-left:8px;" value="Y">화
                            <input type="checkbox" id="everyWeekWedAt" class="custom-checkbox jq_everyWeek" style="width:18px;height:18px;margin-left:8px;" value="Y">수
                            <input type="checkbox" id="everyWeekThuAt" class="custom-checkbox jq_everyWeek" style="width:18px;height:18px;margin-left:8px;" value="Y">목
                            <input type="checkbox" id="everyWeekFriAt" class="custom-checkbox jq_everyWeek" style="width:18px;height:18px;margin-left:8px;" value="Y">금
                            <input type="checkbox" id="everyWeekSatAt" class="custom-checkbox jq_everyWeek" style="width:18px;height:18px;margin-left:8px;" value="Y">토
                            <input type="checkbox" id="everyWeekSunAt" class="custom-checkbox jq_everyWeek" style="width:18px;height:18px;margin-left:8px;" value="Y">일
                            <div class="m-2"></div><!-- 사이간격 -->
                            <div class="input-group">
                            	<input type="text" id="everyWeekHour" class="form-control float-left" style="max-width:90px;margin-right: 3px;" maxlength="2" numberOnly>시&nbsp;
	                        	<input type="text" id="everyWeekMinute" class="form-control float-left" style="max-width:90px;margin-right: 3px;" maxlength="2" numberOnly>분
	                        </div>
                        </div>
                        
                        <div class="col-md-12 py-sm-1 line-top float-left" ></div> <!-- 사이점선 -->
                        <div class="col-sm-2 py-sm-2 float-left"><label for="sourcUpdtNm" class="col-form-label float-left"  style="padding-top:9px;"><input type="radio" name="schduleType1" class="custom-radio" style="width:18px;height:18px;" value="5">  매월</label></div>
                        <div class="col-sm-10 py-sm-1 float-left">
                            <div class="col-sm-2 float-left py-sm-2  text-success"><input type="radio" name="schduleType2" class="custom-radio" style="width:16px;height:16px;margin:0 3px 2px 0;" value="1" checked>일   </div> 
                            <div class="col-sm-10 py-sm-2 float-left">                       
                                
                                   
                                   <div class="input-group">
	                                   <select id="everyMonthDay" class="form-control float-left" style="max-width:90px; margin-right:3px; ">
	                                   <option value="">선택</option>
	                                    <option value="1">01</option>
	                                    <option value="2">02</option>
	                                    <option value="3">03</option>
	                                    <option value="4">04</option>
	                                    <option value="5">05</option>
	                                    <option value="6">06</option>
	                                    <option value="7">07</option>
	                                    <option value="8">08</option>
	                                    <option value="9">09</option>
	                                    <option value="10">10</option>
	                                    <option value="11">11</option>
	                                    <option value="12">12</option>
	                                    <option value="13">13</option>
	                                    <option value="14">14</option>
	                                    <option value="15">15</option>
	                                    <option value="16">16</option>
	                                    <option value="17">17</option>
	                                    <option value="18">18</option>
	                                    <option value="19">19</option>
	                                    <option value="20">20</option>
	                                    <option value="21">21</option>
	                                    <option value="22">22</option>
	                                    <option value="23">23</option>
	                                    <option value="24">24</option>
	                                    <option value="25">25</option>
	                                    <option value="26">26</option>
	                                    <option value="27">27</option>
	                                    <option value="28">28</option>
	                                    <option value="29">29</option>
	                                    <option value="30">30</option>
	                                    <option value="31">31</option>
	                                    <option value="0">마지막날</option>
	                                    
	                                   </select>일&nbsp;
                                        <input type="text" id="everyMonthHour" class="form-control float-left" style="max-width:90px;margin-left: 3px;" maxlength="2" numberOnly>시&nbsp;
                                        <input type="text" id="everyMonthMinute" class="form-control float-left" style="max-width:90px;margin-right: 3px;" maxlength="2" numberOnly>분   
                                   </div>
	                               
                            </div>
                            
                            <div class="col-sm-2 float-left py-sm-1 text-success"><input type="radio" name="schduleType2" class="custom-radio" style="width:16px;height:16px;margin:0 3px 2px 0;" value="2">주차</div> 
                            <div class="col-sm-10 py-sm-1 float-left">   
                                <input type="radio" name="everyMonthWeekOrder" class="custom-checkbox" style="width:14px;height:14px;margin:0 0 0 10px;" value="1"> 첫째주
                                <input type="radio" name="everyMonthWeekOrder" class="custom-checkbox" style="width:14px;height:14px;margin:0 0 0 10px;" value="2"> 둘째주
                                <input type="radio" name="everyMonthWeekOrder" class="custom-checkbox" style="width:14px;height:14px;margin:0 0 0 10px;" value="3"> 셋째주
                                <input type="radio" name="everyMonthWeekOrder" class="custom-checkbox" style="width:14px;height:14px;margin:0 0 0 10px;" value="4"> 넷째주
                                <input type="radio" name="everyMonthWeekOrder" class="custom-checkbox" style="width:14px;height:14px;margin:0 0 0 10px;" value="0"> 마지막주
                                <div class="m-2"></div><!-- 사이간격 -->
                                <input type="radio" name="everyMonthDow" class="custom-checkbox" style="width:14px;height:14px;margin:0 0 0 10px;" value="2">월
                                <input type="radio" name="everyMonthDow" class="custom-checkbox" style="width:14px;height:14px;margin:0 0 0 10px;" value="3">화
                                <input type="radio" name="everyMonthDow" class="custom-checkbox" style="width:14px;height:14px;margin:0 0 0 10px;" value="4">수
                                <input type="radio" name="everyMonthDow" class="custom-checkbox" style="width:14px;height:14px;margin:0 0 0 10px;" value="5">목
                                <input type="radio" name="everyMonthDow" class="custom-checkbox" style="width:14px;height:14px;margin:0 0 0 10px;" value="6">금
                                <input type="radio" name="everyMonthDow" class="custom-checkbox" style="width:14px;height:14px;margin:0 0 0 10px;" value="7">토
                                <input type="radio" name="everyMonthDow" class="custom-checkbox" style="width:14px;height:14px;margin:0 0 0 10px;" value="1">일
                                <div class="m-2"></div><!-- 사이간격 -->
                                <div class="input-group">
                                	<input type="text" id="everyMonthHour2" class="form-control float-left" style="max-width:90px;margin-right: 3px;" maxlength="2" numberOnly>시&nbsp;
                                	<input type="text" id="everyMonthMinute2" class="form-control float-left" style="max-width:90px;margin-right: 3px;" maxlength="2" numberOnly>분
                                </div>
                            </div>
                        </div>
                        
                        
                        <div class="col-md-12 py-sm-1 line-top float-left" ></div>                        
                        <div class="col-sm-2 py-sm-1  float-left">
                        <label for="sourcUpdtNm" class="col-form-label">                      
                        <input type="radio" name="schduleType1" class="custom-radio" style="width:18px;height:18px;" value="6"> 크론 표현식</label></div>
                        <div class="col-sm-10 py-sm-2 float-left">
                             <input type="text" id="cronExp" class="form-control float-left" style="min-width:100px;margin-right: 3px;" maxlength="40">
                        </div>
                        
                        
                        
                    </div>           
                </form>
                <div class="float-right py-sm-2">
                    <button type="button" class="btn btn-primary" id="btnSave">저장</button>
                    <button type="button" class="btn btn-primary" id="btnClose">닫기</button>
                </div>
                <div id="divSearchUser" class="modal fade" tabindex="-1" role="dialog"></div>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript">
var lc_calendars_data = undefined;
var isValidExpression = false;

$(document).ready(function() {
	isValidExpression = false;
	//이벤트 바인딩
    pageInit();
    bindEvent();
    endLoading();
});
function pageInit(){
	
}

function isValidExpressionCallback(data){
    if (data != null && data != undefined) {
        if (data.result != null && data.result.isValidExpression != null) {
            if(!data.result.isValidExpression) {
                $("#cronExp").focus();
                alert("올바르지 않은 크론 표현식입니다.");
                $('.dimmed').css({ display: 'none' });
                $('.loading').css({ display: 'none' });
                $('.loading').removeClass('show'); 
                return false;
            }
            
            isValidExpression = true;           
        }  
    }
}

function saveRoutinePlanCallback(data){
	alert("저장되었습니다.");
    $('.dimmed').css({ display: 'none' });
	$('.loading').css({ display: 'none' });
	$('.loading').removeClass('show'); 
	closeReloadPop();	
}

function triggerArInstantSearchReleasesCallback(data){
	//console.log("function triggerArInstantSearchReleasesCallback");
	GBL_createSearchResultComboBox({id: "targetReleases", resultList: data.result.resultList, viewType:2, optVal: "processCd", optNm: "processNm"});
	GBL_createSearchResultComboBox({id: "botNo", resultList: []});
}

function triggerArInstantSearchRobotCallback(data){
	//console.log("function triggerArInstantSearchRobotCallback");
	lc_robot_data = data.result.resultList;
	GBL_createSearchResultComboBox({id: "botNo", resultList: data.result.resultList, optVal: "botNo", optNm: "botNm", addNm: "state"});
}

function bindEvent() {
	console.log("function bindEvent()");
	$('#startDeDiv').datetimepicker({
        format: 'YYYY-MM-DD'
      , defaultDate: (new Date()).setDate((new Date()).getDate())
    });
	
	let dTempEndDate = new Date();
	dTempEndDate.setYear(dTempEndDate.getYear() + 2)
	$('#endDeDiv').datetimepicker({
        format: 'YYYY-MM-DD'
      , defaultDate: getYearMonth2(24)
    });
	$("#btnClose").on("click", function(e){
		closePop()
	});
	
	$("#btnReleasesSearch").on("click", function(e){
		const oReleasesSearchKwrd = $("#releasesSearchKwrd")
		/* if($.trim(oReleasesSearchKwrd.val()) == ""){
			alert("검색할 프로세스 코드를 입력해 주십시오.");
			oReleasesSearchKwrd.focus();
			return false;
		} */
		
		let params = {searchKwrd: oReleasesSearchKwrd.val()}
		callAsyncAjax("/resrce/triggerAr/triggerArInstantSearchReleases", params, "triggerArInstantSearchReleasesCallback");
	});
	
	$("#targetReleases").on("change", function(e){
		const oThis = $("#targetReleases");
		if(oThis.val() == ""){
			//초기화
			GBL_createSearchResultComboBox({id: "botNo", resultList: []});
		}
		else{
			let params = {processCd: oThis.val()}
			callAsyncAjax("/resrce/triggerAr/triggerArInstantSearchRobot", params, "triggerArInstantSearchRobotCallback");
			//실행로봇 검색
		}
	});
	
	// 다른 스케줄 타입을 클릭했을 때, 나머지 스케줄 타입에 입력된 문구들 지우기
	$('input:radio[name="schduleType1"]').on("click", function(e){ 
        var selectSchdType = parseInt($('input:radio[name="schduleType1"]:checked').val());
        
        for(var i=1; i<=6; i++) {
        	if(i != selectSchdType) {
        		initSchdType(i);
        	}
        }
    });
	
	$("#btnSave").on("click", function(e){
		var schduleType1 = $('input:radio[name="schduleType1"]:checked').val();
    	var schduleType2 = $('input:radio[name="schduleType2"]:checked').val()
    	var oObj;
    	var sText;
    	var iNumber;
    	const oTargetReleases = $("#targetReleases");
    	const oBotNo = $("#botNo");
        var cronexp = $("#cronExp").val();

    	let bUseCalendar = false
    	let iCalendarId = 0

    	//프로세스 확인
    	if(oTargetReleases.val() == ""){
    		alert("프로세스를 선택해 주십시오.");
    		oTargetReleases.focus();
    		return false;
    	}
    	
		//실행로봇 화인
    	if(oBotNo.val() == ""){
    		alert("실행로봇을 선택해 주십시오.");
    		oBotNo.focus();
    		return false;
    	}
    	
    	if($("#targetCalendars").val() != ""){
    		bUseCalendar = true;
    		iCalendarId = parseInt($("#targetCalendars").val()); 
    	}
 
    	
    	//CalendarId : 휴일 번호
    	//실행기간 확인 최대 2년 넘지 않도록
    	let dMaxDe = new Date($("#startDe").val());
		dMaxDe.setYear(dMaxDe.getFullYear() + 2);
		const dEndDe = new Date($("#endDe").val());
		if(dEndDe >= dMaxDe ){
			alert("최대 실행 기간은 2년입니다.");
			return false;
		}
    	
    	if(schduleType1 == "1"){
    		oObj = $("#everyMinute");
    		sText = oObj.val(); 
    		if(sText == ""){
                alert("분을 선택해 주십시오.");
                oObj.focus();
                return false;
            }
    	}
    	
    	else if(schduleType1 == "2"){
    		oObj = $("#everyHour");
            sText = oObj.val();
            if(sText == ""){
                alert("시간을 입력해 주십시오.");
                oObj.focus();
                return false;
            }
            iNumber = parseInt(sText);
            if(iNumber < 1 || iNumber > 23){
                alert("1 ~ 23사이의 값을 입력해 주십시오.");
                oObj.focus();
                return false;
            }
    		
            oObj = $("#everyHourMinute");
            sText = oObj.val(); 
            if(sText == ""){
                alert("분을 입력해 주십시오.");
                oObj.focus();
                return false;
            }
            
            iNumber = parseInt(sText);
            if(iNumber < 0 || iNumber > 59){
                alert("0 ~ 59사이의 값을 입력해 주십시오.");
                oObj.focus();
                return false;
            }
    	}
    	
    	else if(schduleType1 == "3"){
            oObj = $("#everyDayHour");
            sText = oObj.val();
            if(sText == ""){
                alert("시간을 입력해 주십시오.");
                oObj.focus();
                return false;
            }
            iNumber = parseInt(sText);
            if(iNumber < 0 || iNumber > 23){
                alert("0 ~ 23사이의 값을 입력해 주십시오.");
                oObj.focus();
                return false;
            }
            
            oObj = $("#everyDayMinute");
            sText = oObj.val(); 
            if(sText == ""){
                alert("분을 입력해 주십시오.");
                oObj.focus();
                return false;
            }
            
            iNumber = parseInt(sText);
            if(iNumber < 0 || iNumber > 59){
                alert("0 ~ 59사이의 값을 입력해 주십시오.");
                oObj.focus();
                return false;
            }
        }
    	
    	else if(schduleType1 == "4"){
    		if($('.jq_everyWeek:checked').length < 1){
    			alert("실행 요일을 선택해 주십시오.");
    			return false;
    		}
    		
            oObj = $("#everyWeekHour");
            sText = oObj.val();
            if(sText == ""){
                alert("시간을 입력해 주십시오.");
                oObj.focus();
                return false;
            }
            iNumber = parseInt(sText);
            if(iNumber < 0 || iNumber > 23){
                alert("0 ~ 23사이의 값을 입력해 주십시오.");
                oObj.focus();
                return false;
            }
            
            oObj = $("#everyWeekMinute");
            sText = oObj.val(); 
            if(sText == ""){
                alert("분을 입력해 주십시오.");
                oObj.focus();
                return false;
            }
            
            iNumber = parseInt(sText);
            if(iNumber < 0 || iNumber > 59){
                alert("0 ~ 59사이의 값을 입력해 주십시오.");
                oObj.focus();
                return false;
            }
        }
    	else if(schduleType1 == "5"){
    		if(schduleType2 == undefined){
                alert("실행할 일 또는 주차를 선택해 주십시오.");
                return false;
            }
    		
    		if(schduleType2 == "1"){
       			oObj = $("#everyMonthDay");
				sText = oObj.val();
				if(sText == ""){
				    alert("일을 선택해 주십시오.");
				    oObj.focus();
				    return false;
				}              
                   
       			oObj = $("#everyMonthHour");
                sText = oObj.val();
                if(sText == ""){
                    alert("시간을 입력해 주십시오.");
                    oObj.focus();
                    return false;
                }
                iNumber = parseInt(sText);
                if(iNumber < 0 || iNumber > 23){
                    alert("0 ~ 23사이의 값을 입력해 주십시오.");
                    oObj.focus();
                    return false;
                }
                
                oObj = $("#everyMonthMinute");
                sText = oObj.val(); 
                if(sText == ""){
                    alert("분을 입력해 주십시오.");
                    oObj.focus();
                    return false;
                }
                
                iNumber = parseInt(sText);
                if(iNumber < 0 || iNumber > 59){
                    alert("0 ~ 59사이의 값을 입력해 주십시오.");
                    oObj.focus();
                    return false;
                }
            }
    		else if(schduleType2 == "2"){
    			 var everyMonthWeekOrder = $('input:radio[name="everyMonthWeekOrder"]:checked').val();
	             if(everyMonthWeekOrder == undefined){
	                 alert("실행할 주차를 선택해 주십시오.");
	                 return false;
	             }
	       			
	       		 var everyMonthDow = $('input:radio[name="everyMonthDow"]:checked').val();
	             if(everyMonthDow == undefined){
	                 alert("실행할 요일을 선택해 주십시오.");
	                 return false;
	             }
	       			
	       		 oObj = $("#everyMonthHour2");
	             sText = oObj.val();
	             if(sText == ""){
	                 alert("시간을 입력해 주십시오.");
	                 oObj.focus();
	                 return false;
	             }
	             iNumber = parseInt(sText);
	             if(iNumber < 0 || iNumber > 23){
	                 alert("0 ~ 23사이의 값을 입력해 주십시오.");
	                 oObj.focus();
	                 return false;
	             }
	             
	             oObj = $("#everyMonthMinute2");
	             sText = oObj.val(); 
	             if(sText == ""){
	                 alert("분을 입력해 주십시오.");
	                 oObj.focus();
	                 return false;
	             }
	             
	             iNumber = parseInt(sText);
	             if(iNumber < 0 || iNumber > 59){
	                 alert("0 ~ 59사이의 값을 입력해 주십시오.");
	                 oObj.focus();
	                 return false;
	             }
	        }
    	}
    	else if(schduleType1 == "6") {
    		if(cronexp.length == 0 || cronexp == null || cronexp == "") {
    			alert("크론 표현식을 입력해주세요.");
    			return false;
    		}
    	}
    	
    	var returnParam = {
    			startDe1:$("#startDe").val(), endDe:$("#endDe").val()
    			, schduleNo: $("#schduleNo").val()
                , schduleType1: schduleType1, schduleType2: 1
                , everyMinute: null
                , everyHour: null, everyHourMinute: null
                , everyWeekMonAt: "N", everyWeekTueAt: "N", everyWeekWedAt: "N", everyWeekThuAt: "N", everyWeekFriAt: "N", everyWeekSatAt: "N", everyWeekSunAt: "N"
                , executDay: null, executHour: null, executMinute: null
                , everyMonthWeekOrder: null, everyMonthDow:null
                , schduleCrontab: ""
                , schduleText: ""
            }
    	
    	var schduleText = $("#startDe").val() + " ~ " + $("#endDe").val() + " ";
    	if(schduleType1 == "1"){
    		var everyMinute = $("#everyMinute").val();
    		returnParam["everyMinute"] = everyMinute;
    		returnParam["executMinute"] = everyMinute;
    		schduleText += "매 " + everyMinute + "분 간격"
    		schduleCrontab =  "0 */"+ everyMinute +" * * * ? *"
    	}
    	else if(schduleType1 == "2"){
    		var everyHour = $("#everyHour").val();
    		var everyHourMinute = $("#everyHourMinute").val();
            returnParam["everyHour"] = everyHour;
            returnParam["executMinute"] = everyHourMinute;
            schduleText += "매 " + everyHour + "시간 간격 " +everyHourMinute + "분"
            
            schduleCrontab =  "0 "+ everyHourMinute +" */"+ everyHour +" * * ? *"
            
        }
    	else if(schduleType1 == "3"){
    		var everyDayHour = $("#everyDayHour").val();
    		var everyDayMinute  = $("#everyDayMinute").val();
            returnParam["executHour"] = everyDayHour;
            returnParam["executMinute"] = everyDayMinute;
            schduleText += "매일 " + everyDayHour + "시 " +  everyDayMinute + "분"
            
            schduleCrontab =  "0 "+ everyDayMinute +" "+ everyDayHour +" * * ? *"
        }
    	else if(schduleType1 == "4"){
    		var dayOfWeek = "";
    		var cronDayOfWeek = "";
    		var everyWeekHour = $("#everyWeekHour").val();
            var everyWeekMinute = $("#everyWeekMinute").val();
            
    		returnParam["everyWeekMonAt"] = $('#everyWeekMonAt:checked').val() != undefined ? "Y" : "N";
    		if(returnParam["everyWeekMonAt"] == "Y"){
    			dayOfWeek += (dayOfWeek == "" ? "" : ", ") + "월";
    			cronDayOfWeek += (cronDayOfWeek == "" ? "" : ", ") + "MON";
    		}
    		
    		returnParam["everyWeekTueAt"] = $('#everyWeekTueAt:checked').val() != undefined ? "Y" : "N";
    		if(returnParam["everyWeekTueAt"] == "Y"){
                dayOfWeek += (dayOfWeek == "" ? "" : ", ") + "화";
                cronDayOfWeek += (cronDayOfWeek == "" ? "" : ", ") + "TUE";
            }
    		
    		returnParam["everyWeekWedAt"] = $('#everyWeekWedAt:checked').val() != undefined ? "Y" : "N";
    		if(returnParam["everyWeekWedAt"] == "Y"){
                dayOfWeek += (dayOfWeek == "" ? "" : ", ") + "수";
                cronDayOfWeek += (cronDayOfWeek == "" ? "" : ", ") + "WEN";
            }
    		
    		returnParam["everyWeekThuAt"] = $('#everyWeekThuAt:checked').val() != undefined ? "Y" : "N";
    		if(returnParam["everyWeekThuAt"] == "Y"){
                dayOfWeek += (dayOfWeek == "" ? "" : ", ") + "목";
                cronDayOfWeek += (cronDayOfWeek == "" ? "" : ", ") + "THU";
            }
    		
    		returnParam["everyWeekFriAt"] = $('#everyWeekFriAt:checked').val() != undefined ? "Y" : "N";
    		if(returnParam["everyWeekFriAt"] == "Y"){
                dayOfWeek += (dayOfWeek == "" ? "" : ", ") + "금";
                cronDayOfWeek += (cronDayOfWeek == "" ? "" : ", ") + "FRI";
            }
    		
    		returnParam["everyWeekSatAt"] = $('#everyWeekSatAt:checked').val() != undefined ? "Y" : "N";
    		if(returnParam["everyWeekSatAt"] == "Y"){
                dayOfWeek += (dayOfWeek == "" ? "" : ", ") + "토";
                cronDayOfWeek += (cronDayOfWeek == "" ? "" : ", ") + "SAT";
            }
    		
    		returnParam["everyWeekSunAt"] = $('#everyWeekSunAt:checked').val() != undefined ? "Y" : "N";
    		if(returnParam["everyWeekSunAt"] == "Y"){
                dayOfWeek += (dayOfWeek == "" ? "" : ", ") + "일";
                cronDayOfWeek += (cronDayOfWeek == "" ? "" : ", ") + "SUN";
            }
    		
    		var everyWeekHour = $("#everyWeekHour").val();
            var everyWeekMinute = $("#everyWeekMinute").val();
            
            returnParam["executHour"] = everyWeekHour;
            returnParam["executMinute"] = everyWeekMinute;
            
            schduleText += "매주 " + dayOfWeek + " " + everyWeekHour + "시 " + everyWeekMinute + "분"
            
            schduleCrontab = "0 "+ everyWeekMinute +" "+ everyWeekHour +" ? * " + cronDayOfWeek + " *";
        }
    	else if(schduleType1 == "5"){
    		returnParam["schduleType2"] = schduleType2
    		
    		if(schduleType2 == "1"){
    			var everyMonthDay = $("#everyMonthDay").val();
                var everyMonthHour = $("#everyMonthHour").val();
                var everyMonthMinute = $("#everyMonthMinute").val();
                
    			returnParam["executDay"] = everyMonthDay;
    			returnParam["executHour"] = everyMonthHour;
    			returnParam["executMinute"] = everyMonthMinute;
    			schduleText += "매월 " + (everyMonthDay == "0" ? "마지막날 " : everyMonthDay + "일 ") + everyMonthHour + "시 " + everyMonthMinute + "분"
    			schduleCrontab = "0 "+ everyMonthMinute +" "+ everyMonthHour +" "+ (everyMonthDay == "0" ? "L" : everyMonthDay) + " * ? *";
    		}
    		else if(schduleType2 == "2"){
    			var everyMonthWeekOrder = $('input:radio[name="everyMonthWeekOrder"]:checked').val();
                var everyMonthDow = $('input:radio[name="everyMonthDow"]:checked').val();
                var everyMonthHour2 = $("#everyMonthHour2").val();
                var everyMonthMinute2 = $("#everyMonthMinute2").val();
                
    			returnParam["everyMonthWeekOrder"] = everyMonthWeekOrder
    			returnParam["everyMonthDow"] = everyMonthDow
    			
    			returnParam["executHour"] = everyMonthHour2;
                returnParam["executMinute"] = everyMonthMinute2;
                
                schduleText += "매월 ";
                if(everyMonthWeekOrder == "1"){
                	schduleText += "첫째주 ";
                } 
                else if(everyMonthWeekOrder == "2"){
                    schduleText += "둘째주 ";
                }
                else if(everyMonthWeekOrder == "3"){
                    schduleText += "셋째주 ";
                }
                else if(everyMonthWeekOrder == "4"){
                    schduleText += "넷째주 ";
                }
                else if(everyMonthWeekOrder == "0"){
                    schduleText += "마지막주 ";
                }
                
                if(everyMonthDow == "1"){
                    schduleText += "일 ";
                } 
                else if(everyMonthDow == "2"){
                    schduleText += "월  ";
                }
                else if(everyMonthDow == "3"){
                    schduleText += "화 ";
                }
                else if(everyMonthDow == "4"){
                    schduleText += "수 ";
                }
                else if(everyMonthDow == "5"){
                    schduleText += "목 ";
                }
                else if(everyMonthDow == "6"){
                    schduleText += "금 ";
                }
                else if(everyMonthDow == "7"){
                    schduleText += "토 ";
                }
                
                schduleText += everyMonthHour2 + "시 " + everyMonthMinute2 + "분"
                schduleCrontab = "0 "+ everyMonthMinute2 +" "+ everyMonthHour2 +" ? * "+ everyMonthDow + (everyMonthWeekOrder == "0" ? "L" : "#" + everyMonthWeekOrder) +" *";
                
            }
    	}
        else if(schduleType1 == "6") {
        	schduleText = $("#startDe").val() + " ~ " + $("#endDe").val() + ", " + cronexp;
        	schduleCrontab = cronexp;
        }
    	
    	//console.log("schduleText: " + schduleText);
    	//console.log("schduleCrontab: " + schduleCrontab);
    	returnParam["schduleText"] = schduleText;
    	returnParam["schduleCrontab"] = schduleCrontab;
    	let selectRobot = GBL_array_find(lc_robot_data, "botNo", oBotNo.val());
    	
    	// 로딩 시작
        //$('.dimmed').css({ display: 'block' });
        //$('.loading').css({ display: 'block' });
        //$('.loading').addClass('show');
        
    	
    	/* let selectRobot = lc_robot_data.find(function(oRobot) {
			  return oRobot.botNo === parseInt(oBotNo.val());
			});
		
		if(selectRobot.state != 0){
			alert("사용가능한 실행로봇을 선택해 주십시오.");
			oBotNo.focus();
			return false;
		} */
    	
/*    	
botNo: "295"
botType: "3"
cmpnyCd: "E"
inputArguments: "{}"
processCd: "E00201"
processKey: "portal_success"
releasesId: "307"
releasesKey: "1a230f80-155a-4592-aa7b-3cd4cd4cddfd"
releasesName: "portal_success_E_Robot_Portal_Test"
*/



		let oParams = 	{
							botNo: selectRobot.botNo
				    		, botType: selectRobot.botType
				    		, cmpnyCd: selectRobot.cmpnyCd
							, inputArguments: "{}"
							, processCd: selectRobot.processCd
							, processKey: selectRobot.processKey
							, releasesId: selectRobot.releasesId
							, releasesKey: selectRobot.releasesKey
							, releasesName: selectRobot.releasesName
							, cronExp : cronexp
							, schduleData: returnParam
						}
				
		// 로딩 시작
		$('.dimmed').css({ display: 'block' });
		$('.loading').css({ display: 'block' });
		$('.loading').addClass('show');             

		// 크론표현식으로 등록
        if(schduleType1 == "6") {
            callSyncAjax("/resrce/triggerAr/isValidExpression", oParams, "isValidExpressionCallback");
            if(isValidExpression) {
                callAsyncAjax("/resrce/triggerAr/saveRoutinePlan", oParams, "saveRoutinePlanCallback");  
                alert("최대 약 1분 정도 소요되니 창을 닫지 말아주세요.");
            }         
            isValidExpression = false;
        }
        else {   	
            callAsyncAjax("/resrce/triggerAr/saveRoutinePlan", oParams, "saveRoutinePlanCallback");
        }
        
	    //closeReloadPop(); 
	});
	
	
	let initParams = {searchKwrd: ""}
	callAsyncAjax("/resrce/triggerAr/triggerArInstantSearchReleases", initParams, "triggerArInstantSearchReleasesCallback");
}

// 선택한 스케줄 타입을 제외한 나머지 스케줄 타입의 입력 및 선택들 초기화
function initSchdType(i) {
	if(i==1) {
		// 분
        $("#everyMinute option:eq(0)").prop("selected", true)
    }
    else if(i==2) {
    	// 시간
        $("#everyHour").val('');
        $("#everyHourMinute").val('');          
    }
    else if(i==3) {
    	// 매일
        $("#everyDayHour").val('');
        $("#everyDayMinute").val('');  
    }
    else if(i==4) {
    	// 매주
        $(".jq_everyWeek").each(function(index, item){ 
            $(item).prop("checked", false);
        });
        $("#everyWeekHour").val('');
        $("#everyWeekMinute").val('');
    }
    else if(i==5) {
        // 매월
        $('input:radio[name="schduleType2"]').each(function(index, item){ 
            $(item).prop("checked", false);
        });
        
        $("#everyMonthDay option:eq(0)").prop("selected", true);

        $("#everyMonthHour").val('');
        $("#everyMonthMinute").val('');
        
        $('input:radio[name="everyMonthWeekOrder"]').each(function(index, item){ 
            $(item).prop("checked", false);
        });

        $('input:radio[name="everyMonthDow"]').each(function(index, item){ 
            $(item).prop("checked", false);
        });
        
        $("#everyMonthHour2").val('');
        $("#everyMonthMinute2").val('');

    }
    else if(i==6) {
    	// 크론표현식
        $("#cronExp").val('');
    }
}

</script>
 </div>

<!--  템플릿 바디 끝 -->   
