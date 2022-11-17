<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div id="jobMngMainDiv" class="container-fluid wrap">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <form class="form-inline">  
                        <div class="form-group col-md-6">
                           <label for="usr" class="col-form-label col-sm-4" >회사</label>
                           <div class="col-sm-8">
                               <select id="searchCmpnyCd" class="form-control"  style="min-width: 160px;width:70%;">
                                   <option value=""></option>
                               </select>
                           </div>
                         </div>
                           <div class="form-group col-md-6 py-sm-1">
                               <label for="usr" class="col-sm-4 col-form-label">날짜</label>
                               <div class="col-sm-8 float-left">
                                   <div class="input-group date float-left" id="searhcStartDeDiv" data-target-input="nearest"style="min-width:140px;width:30%;margin-right:5px;">
                                       <input type="text" id="searchStartDe" name="searchStartDe" class="form-control datetimepicker-input" data-target="#searhcStartDeDiv"/>
                                       <div class="input-group-append" data-target="#searhcStartDeDiv" data-toggle="datetimepicker">
                                           <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                       </div>
                                   </div>
                                   <div class="input-group date  float-left" id="searchEndDeDiv" data-target-input="nearest"style="min-width:140px;width:30%;">
                                       <input type="text" id="searchEndDe" name="searchEndDe" class="form-control datetimepicker-input" data-target="#searchEndDeDiv"/>
                                       <div class="input-group-append" data-target="#searchEndDeDiv" data-toggle="datetimepicker">
                                           <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                       </div>
                                   </div>
                              </div>
                          </div>
                          
                          <div class="form-group row col-sm-6">
                              <label for="usr" class="col-sm-4 col-form-label">프로세스코드</label>
                              <div class="col-sm-8">
                                  <input type="text" class="form-control float-left" value="" id="searchProcessCd" style="min-width: 160px;width:70%;" maxlength="6">
                              </div>     
                          </div>
            
                          <div class="form-group row col-sm-6">                      
                          <label for="usr" class="col-sm-4 col-form-label">프로세스명</label>
                              <div class="col-sm-8">
                                  <input type="text" class="form-control float-left" value="" id="searchProcessNm" style="min-width: 160px;width:70%;" maxlength="6">
                              </div>
                          </div>
                              
                          <div class="form-group row col-sm-6">                      
                              <label for="searchTyCd" class="col-sm-4 col-form-label">로봇</label>
                                <div class="col-sm-8 float-left">
                                   <select id="searchRobotId" class="form-control float-left"  style="min-width: 160px;width:70%;">
                                      <option value=''>전체</option>
                                   </select>
                                </div>
                          </div>
                                
                          <div class="form-group row col-sm-6">                      
                                <div class="col-sm-8 float-left">
                                
                                        <button type="button" id="btnSearch" class="btn btn-info float-left">조회</button>
                                </div>
                          </div>    

                    </form> 
                    
                                              
                    <font style="color:#1266FF;">※ 어제까지 수행 완료된 JOB만 집계됩니다. 금일 수행된 JOB은 집계되지 않습니다.</font>
                    </br>
                    <font style="color:#1266FF;">※ [모니터링] - [JOB이력관리]의 JOB을 기반으로 집계됩니다.</font>             
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-body">
                
                <font id="textTime" class="float-left text-warning"  style="margin-left:10px;"></font>
                
                <button type="button" id="btnOutExport" class="btn btn-primary float-right" style="margin: 5px 0 15px 2px;">엑셀 다운로드</button>
                
	                <table class="person_robot" id="groupRpaOperGridId">
	                            <colgroup>
	                            </colgroup>
	                            <thead>
	                            </thead>
	                            <tbody>
	                            </tbody>
	                 </table>                    
                         
                </div>
            </div>
        </div>
    </div>
    
   
    
    
     <div class="row">
        <div class="col-md-12">
            <div class="card">
            
            
            
                <div class="card-body">                
	                <div class ="person_robot-wrap" style="overflow-x:auto;overflow-y:hidden;">
	                        <font id="ㅎgrowShowtext" class="float-left text-warning"  style="margin-left:10px;">주간 성공률 추이(조치 후)</font>
	                
	                        <button type="button" id="btnOutExportForWeek" class="btn btn-primary float-right" style="margin: 5px 0 15px 2px;">엑셀 다운로드</button>
	                
	                        <table class="person_robot" id="groupRpaOperWeekGridId">
	                                <colgroup>
	                                </colgroup>
	                                <thead>
	                                </thead>
	                                <tbody>
	                                </tbody>
	                       </table>         
	                </div>
                </div>
            </div>
        </div>
    </div>
    
    
    
    
</div>

<!-- 로딩바  -->
<div class="dimmed" style="display:none"></div>
<div class="loading" style="display:none">
    <div class="loading-bar"><div></div><div></div><div></div><div></div></div>
    <span class="loading-text"></span>
</div>

<!-- 엑셀 다운로드 FORM -->                    
<form id="downloadFormExel" name="downloadFormExel" method="post">
    <input type="hidden" id="fileNo" name="fileNo" value="" />
    <input type="hidden" id="fileNm" name="fileNm" value="" />
</form>

<script>

var dataorexcel = 'data';
var offset;
var moveScroll;
var dateDiff = 0;
var growWidth = 117; // (주간 실적) width
var limitedDate = '2019-01-01';
var startDateForWeek, endDateForWeek;
var dateTextArray = [];

$(document.body).ready(function () {   
	/* alert("8월 중순 오픈 예정입니다.");
	window.location.replace("/main/siteMain");
	return false; */
	
	loadingTextChange();
	searchGroupRpaOperList();
});
    
    /*
     * 페이지 초기화
     * @param
     * @return
     */
    function pageInit() {
    	drawGrid();

        var params = [];
        
        if("${txScreenAuthor.untenantAuthor}" == 'Y'){
            // params.push({"id" : "searchCmpnyCd", "clsCd" : "0024", "selectValue": "${sessionUserInfo.txCmpnyCd}"});
            params.push({"id" : "searchCmpnyCd", "clsCd" : "0024"});
        }else{
            params.push({"id" : "searchCmpnyCd", "clsCd" : "0024", "disable" : "Y", "selectValue": "${sessionUserInfo.txCmpnyCd}"});
        }

        requestCmmnCd(params);
        
        searchRobotList();
    };
    
    /*
     * 이벤트 바인딩
     * @param
     * @return
     */
    function bindEvent(){

        //조회버튼 클릭 이벤트 처리
        $("#btnSearch").on("click",function(){
        	searchGroupRpaOperList();
        });
        
        $('#searhcStartDeDiv').datetimepicker({
            format: 'YYYY-MM-DD'
          , defaultDate: (new Date()).setDate((new Date()).getDate() - 1)
        });
        
        $("#searchEndDeDiv").datetimepicker({
            format: 'YYYY-MM-DD'
          , defaultDate: (new Date()).setDate((new Date()).getDate() - 1)
        });
      
        //엑셀다운로드 위 표
        $("#btnOutExport").on('click', function(){
            outExport();
        });
        
        //엑셀다운로드 아래 표
        $("#btnOutExportForWeek").on('click', function(){
        	outExportForWeek();
        });      
        
        $("#searchCmpnyCd").on("change",function(){
            searchRobotList();      
        });
        
        $('#searhcStartDeDiv').on('change.datetimepicker', function(e){ 
            dateDiff = dateDiffDay();
         });
        
        $('#searchEndDeDiv').on('change.datetimepicker', function(e){ 
            dateDiff = dateDiffDay();
         });
    }
    
    function idOldDateCheck() {
    	return $("#searchStartDe").val() < limitedDate || $("#searchEndDe").val() < limitedDate;
    }
    
    // dt1과 dt2가 같은 날짜인지
    function isSameDate(dt1, dt2) {
    	dt1 = new Date(dt1);
    	dt2 = new Date(dt2);
    	return dt1.getFullYear() === dt2.getFullYear() && dt1.getMonth() === dt2.getMonth() && dt1.getDate() === dt2.getDate();
    }
        
    // 2021.08.05 형식으로 문자열 return
    function getYYYYMMDD(tempDate) {
    	var dt = new Date(tempDate);
    	var year = dt.getFullYear();
        var month = ("0" + (1 + dt.getMonth())).slice(-2);
        var day = ("0" + dt.getDate()).slice(-2);
    	return year + "." + month + "." + day;
    }
    
    // pivotDate에서 diff일 전 날짜 return
    function getDateDiff(pivotDate, diff) {
    	var dt = new Date(pivotDate);
        var gdt = dt.getDate();       
        dt.setDate(gdt - diff);
        return dt;
    }
    
    // 주간 실적 표에서 기간을 표시할 텍스트
    function getDateDiffShowText(pivotDate, diff) {
    	var dt = new Date(pivotDate);
    	dt = getDateDiff(dt, diff);
    	if(dateDiff == 0) {
    		return getYYYYMMDD(dt);
    	}
    	return getYYYYMMDD(dt) + " ~ " + getYYYYMMDD(pivotDate);
    }
    
    // 선택한 시작 날짜와 끝 날짜의 차이 일수 return
    function dateDiffDay() {
        const date1 = $("#searchStartDe").val();
        const startDateArr = date1.split('-');
        const startDate = new Date(startDateArr[0], startDateArr[1]-1, startDateArr[2]);
                
        const date2 = $("#searchEndDe").val();
        const endDateArr = date2.split('-');
        const endDate = new Date(endDateArr[0], endDateArr[1]-1, endDateArr[2]);

        const elapsedMSec = startDate.getTime() - endDate.getTime();
        const elapsedDay = elapsedMSec / 1000 / 60 / 60 / 24; 
        
        var dDiff = Math.abs(Math.ceil(elapsedDay));
        
        return dDiff;
    }
    
    // dateTextArray 만들기(아래 표 연도 기간 표시해주는 문자열 배열 : 사이즈는 무조건 4)
    function makeDateTextArray() {
    	dateTextArray = [];
    	    	
        var threeDate = getDateDiff($("#searchEndDe").val(), dateDiff + 1);
        var twoDate = getDateDiff(threeDate, dateDiff + 1);
        var oneDate = getDateDiff(twoDate, dateDiff + 1);
        
        startDateForWeek = getYYYYMMDD(getDateDiff(oneDate, dateDiff));
        startDateForWeek = startDateForWeek.replaceAll(".", "");
        
        endDateForWeek = getYYYYMMDD($("#searchEndDe").val());
        endDateForWeek = endDateForWeek.replaceAll(".", "");

        var oneDateShowText = getDateDiffShowText(oneDate, dateDiff);
        var twoDateShowText = getDateDiffShowText(twoDate, dateDiff);
        var threeDateShowText = getDateDiffShowText(threeDate, dateDiff);
        var fourDateShowText = getDateDiffShowText($("#searchEndDe").val(), dateDiff);

        dateTextArray.push(oneDateShowText);
        dateTextArray.push(twoDateShowText);
        dateTextArray.push(threeDateShowText);
        dateTextArray.push(fourDateShowText);
    }
    
    /*
     * 검색
     * @param 페이지번호
     * @return
     */
    function searchRobotList() {
        var url = '/stats/groupRpaOper/getRobotList';

        var param = {
            cmpnyCd: $("#searchCmpnyCd").val()
        }; 
        
        callAsyncAjax(url, param, "makeSelectBoxRobot");
    }
    
    function makeSelectBoxRobot(data) {
        var robotList = {};
        var saveRobotId = $("#searchRobotId").val().length == 0 ? "null" : $("#searchRobotId").val();
        var template = '<option value="전체">전체</option>';

        if (data.result != null && data.result.robotList != null) {
            robotList = data.result.robotList;  
            //<option value=""></option>
            var len = robotList.length;
            for(var i=0; i<len; i++) {             
                template += '<option value=' + robotList[i].robotId + '>' + robotList[i].name + '</option>';
            }

            $("#searchRobotId").html(template);  

            var isExists = 0 != $('#searchRobotId option[value='+saveRobotId+']').length;
            
            if(isExists) {
                $("#searchRobotId").val(saveRobotId).attr("selected", "selected");
            }
            else {
                $("#searchRobotId").val("전체").attr("selected", "selected");
            }
            
            return false;
        }

        $("#searchRobotId").html(template); 
        $("#searchRobotId").val("전체").attr("selected", "selected");
    }
    
    function loadingTextChange() {
    	if(dataorexcel == 'data') {
            $(".loading-text")[0].innerHTML = "데이터 로딩 중...";
        }else {
            $(".loading-text")[0].innerHTML = "엑셀 다운로드 중...";
        }
    }
    
    // 그룹 RPA 운영 실적(위) 그리기
    function drawGroupRpaOper(data) {
    	$("#groupRpaOperGridId colgroup col").remove();
        $("#groupRpaOperGridId thead tr").remove();
        $("#groupRpaOperGridId tbody tr").remove();
        
        // 어느 날짜 기간인지 표시
        $("#textTime").html("조회 날짜 : " + getDateDiffShowText($("#searchEndDe").val(), dateDiff));
        
        // 열 컬럼 개수 설정
        var groTableColgroup = "";
        groTableColgroup += '<col style="width:130px;border:1px;">'; // 회사
        groTableColgroup += '<col style="width:120px;">'; // 실행 프로세스(건)
        groTableColgroup += '<col style="width:120px;">'; // 실행 JOB(건)
        
        groTableColgroup += '<col style="width:120px;">'; // 조치 전 성공 JOB(건)
        groTableColgroup += '<col style="width:120px;">'; // 조치 전 성공률(%)
        groTableColgroup += '<col style="width:120px;">'; // 조치 전 실패 JOB(건)
        groTableColgroup += '<col style="width:120px;">'; // 조치 전 실패율(%)
        
        groTableColgroup += '<col style="width:120px;">'; // 조치 후 성공 JOB(건)
        groTableColgroup += '<col style="width:120px;">'; // 조치 후 성공률(%)
        groTableColgroup += '<col style="width:120px;">'; // 조치 후 실패 JOB(건)
        groTableColgroup += '<col style="width:120px;">'; // 조치 후 실패율(%)
        $("#groupRpaOperGridId colgroup").append(groTableColgroup);

        // thead 컬럼 설정(위 총 7개의 열 컬럼)
        var groTableThead = "";
        groTableThead += '<tr>';
        groTableThead += '    <th style="text-align:center;" scope="col" rowspan="2">회사</th>';
        groTableThead += '    <th style="text-align:center;" scope="col" rowspan="2">실행 프로세스(건)</th>';
        groTableThead += '    <th style="text-align:center;" scope="col" rowspan="2">실행 JOB(건)</th>';
        
        groTableThead += '    <th style="text-align:center;" scope="col" colspan="4">조치 전</th>';
        groTableThead += '    <th style="text-align:center;" scope="col" colspan="4">조치 후</th>';
        groTableThead += '</tr>';
        
        groTableThead += '<tr>';
        groTableThead += '    <th style="text-align:center;" scope="col">성공 JOB(건)</th>';
        groTableThead += '    <th style="text-align:center;" scope="col">성공률(%)</th>';
        groTableThead += '    <th style="text-align:center;" scope="col">실패 JOB(건)</th>';
        groTableThead += '    <th style="text-align:center;" scope="col">실패율(%)</th>';
        
        groTableThead += '    <th style="text-align:center;" scope="col">성공 JOB(건)</th>';
        groTableThead += '    <th style="text-align:center;" scope="col">성공률(%)</th>';
        groTableThead += '    <th style="text-align:center;" scope="col">실패 JOB(건)</th>';
        groTableThead += '    <th style="text-align:center;" scope="col">실패율(%)</th>';
        groTableThead += '</tr>';
        $("#groupRpaOperGridId thead").append(groTableThead);
        
        // tbody 그리기
        var paramsLen = data.length;
        var groTableTbody = "";

        for(var i=0; i<paramsLen; i++) {
            
            // 그룹 현황 행(ROW)은 전체 회사 조회인지 특정 하나의 회사만 조회하는건지에  따라 보여주거나 안 보여줌(굵기 처리 표시 등)
            if(data[i].cmpnyNm.includes('그룹')) {
                if($("#searchCmpnyCd").val() != '') continue;       
                groTableTbody += '<tr> <td style="text-align:center;font-weight:bold">'+data[i].cmpnyNm+'</td>'; // 회사
            }
            else {
                groTableTbody += '<tr> <td style="text-align:left;">'+data[i].cmpnyNm+'</td>'; // 회사
            }
            
            groTableTbody += '    <td style="text-align:right;">'+data[i].processCount.toLocaleString()+'</td>'; // 실행 프로세스(건)
            groTableTbody += '    <td style="text-align:right;">'+data[i].jobTotalCount.toLocaleString()+'</td>'; // 실행 JOB(건)
            
            groTableTbody += '    <td style="text-align:right;">'+data[i].jobSuccessCountBefore.toLocaleString()+'</td>'; // 조치 전 성공 JOB(건)
            groTableTbody += '    <td style="text-align:right;">'+data[i].successRateBefore.toFixed(2)+'</td>'; // 조치 전 성공률(%)
            groTableTbody += '    <td style="text-align:right;">'+data[i].jobFailCountBefore.toLocaleString()+'</td>'; // 조치 전 실패 JOB(건)
            groTableTbody += '    <td style="text-align:right;">'+data[i].failRateBefore.toFixed(2)+'</td>'; // 조치 전 실패율(%)
            
            groTableTbody += '    <td style="text-align:right;">'+data[i].jobSuccessCount.toLocaleString()+'</td>'; // 조치 후 성공 JOB(건)
            groTableTbody += '    <td style="text-align:right;">'+data[i].successRate.toFixed(2)+'</td>'; // 조치 후 성공률(%)
            groTableTbody += '    <td style="text-align:right;">'+data[i].jobFailCount.toLocaleString()+'</td>'; // 조치 후 실패 JOB(건)
            groTableTbody += '    <td style="text-align:right;">'+data[i].failRate.toFixed(2)+'</td>'; // 조치 후 실패율(%)
            
            groTableTbody += '</tr>';
        }
        
        $("#groupRpaOperGridId tbody").append(groTableTbody);
    }
    
    // (주간 실적) 그룹 RPA 운영 실적
    function drawGroupRpaOperWeek(data) {
    	
    	// 120px * 총 13칸 = 1560px
    	$("#groupRpaOperWeekGridId colgroup col").remove();
        $("#groupRpaOperWeekGridId thead tr").remove();
        $("#groupRpaOperWeekGridId tbody tr").remove();
        
        // 표 전체 가로 길이 설정
        $("#groupRpaOperWeekGridId").css("width", String(growWidth*13) + "px");

        // 열 컬럼 개수 설정
        var groTableColgroup = "";
        groTableColgroup += '<col style="width:' + String(growWidth) + 'px;border:1px;">'; // 회사
        groTableColgroup += '<col style="width:' + String(growWidth) + 'px;">'; // 연도
        groTableColgroup += '<col style="width:' + String(growWidth) + 'px;">'; // 연도
        groTableColgroup += '<col style="width:' + String(growWidth) + 'px;">'; // 연도
        groTableColgroup += '<col style="width:' + String(growWidth) + 'px;">'; // 연도
        $("#groupRpaOperWeekGridId colgroup").append(groTableColgroup);

        // 아래 표 연도 기간 TEXT 4개를 담은 배열 초기화 및 생성
        makeDateTextArray();
        
        // thead 컬럼 설정(회사, 연도, 연도, 연도) + 성공률(%), 실행 JOB(건), 성공 JOB(건)
        var groTableThead = '<tr>';
        groTableThead += '     <th style="text-align:center;" scope="col" rowspan="2">회사</th>';
        groTableThead += '     <th style="text-align:center;" scope="col" colspan="3">' + dateTextArray[0] + '</th>';
        groTableThead += '     <th style="text-align:center;" scope="col" colspan="3">' + dateTextArray[1] + '</th>';
        groTableThead += '     <th style="text-align:center;" scope="col" colspan="3">' + dateTextArray[2] + '</th>';
        groTableThead += '     <th style="text-align:center;" scope="col" colspan="3">' + dateTextArray[3] + '</th>';
        groTableThead += '</tr>'; 
     
        groTableThead += '<tr>';
        for(var i=0; i<4; i++) {
            groTableThead += '    <th style="text-align:center;width:' + String(growWidth) + 'px;" scope="col">성공률(%)</th>';
            groTableThead += '    <th style="text-align:center;width:' + String(growWidth).toLocaleString() + 'px;" scope="col">실행 JOB(건)</th>';
            groTableThead += '    <th style="text-align:center;width:' + String(growWidth).toLocaleString() + 'px;" scope="col">성공 JOB(건)</th>';
        }
        groTableThead += '</tr>';
        $("#groupRpaOperWeekGridId thead").append(groTableThead);
        
        // tbody 그리기
        var paramsLen = data.length;
        var groTableTbody = "";

         for(var i=0; i<paramsLen; i++) {

            // 그룹 현황 행(ROW)은 전체 회사 조회인지 특정 하나의 회사만 조회하는건지에  따라 보여주거나 안 보여줌(굵기 처리 표시 등)
            if(data[i].cmpnyNm.includes('그룹')) {
                if($("#searchCmpnyCd").val() != '') continue;       
                groTableTbody += '<tr> <td style="text-align:center;font-weight:bold">'+data[i].cmpnyNm+'</td>'; // 회사
            }
            else {
                groTableTbody += '<tr> <td style="text-align:left;">'+data[i].cmpnyNm+'</td>'; // 회사
            }
            
            // .toFixed(2) -> 소수 2째자리 까지 표시
            
            groTableTbody += '    <td style="text-align:right;">'+data[i].DSuccessRate.toFixed(2)+'</td>';
            groTableTbody += '    <td style="text-align:right;">'+data[i].DJobTotalCount.toLocaleString()+'</td>';
            groTableTbody += '    <td style="text-align:right;">'+data[i].DJobSuccessCount.toLocaleString()+'</td>';
            
            groTableTbody += '    <td style="text-align:right;">'+data[i].CSuccessRate.toFixed(2)+'</td>';
            groTableTbody += '    <td style="text-align:right;">'+data[i].CJobTotalCount.toLocaleString()+'</td>';
            groTableTbody += '    <td style="text-align:right;">'+data[i].CJobSuccessCount.toLocaleString()+'</td>';
            
            groTableTbody += '    <td style="text-align:right;">'+data[i].BSuccessRate.toFixed(2)+'</td>';
            groTableTbody += '    <td style="text-align:right;">'+data[i].BJobTotalCount.toLocaleString()+'</td>';
            groTableTbody += '    <td style="text-align:right;">'+data[i].BJobSuccessCount.toLocaleString()+'</td>';
            
            groTableTbody += '    <td style="text-align:right;">'+data[i].ASuccessRate.toFixed(2)+'</td>';
            groTableTbody += '    <td style="text-align:right;">'+data[i].AJobTotalCount.toLocaleString()+'</td>';
            groTableTbody += '    <td style="text-align:right;">'+data[i].AJobSuccessCount.toLocaleString()+'</td>';

            groTableTbody += '</tr>';
        }
         
        $("#groupRpaOperWeekGridId tbody").append(groTableTbody);
    }
        
    /*
     * 그리드 초기화
     * @param
     * @return
     */
    function drawGrid(data){
        var groParams = {};
        var growParams = {};

        if (data != null && data != undefined) {
        	if (data.result != null && data.result.groupRpaOperList != null) {
        		groParams = data.result.groupRpaOperList;
        	}
            if (data.result != null && data.result.groupRpaOperWeekList != null) {
            	growParams = data.result.groupRpaOperWeekList;
            }
            if (data.result != null && data.result.robotList != null) {
                makeSelectBoxRobot(data.result.robotList);              
            }
        }
        
        drawGroupRpaOper(groParams);
        drawGroupRpaOperWeek(growParams);
    
        // 로딩 끝
        $('.dimmed').css({ display: 'none' });
        $('.loading').css({ display: 'none' });
        $('.loading').removeClass('show');
    }
    
    /*
     * 검색
     * @param 페이지번호
     * @return
     */
    function searchGroupRpaOperList() {    	
    	if($("#searchStartDe").val() > $("#searchEndDe").val()){
            alert('검색기간 시작일이 종료일보다 클 수 없습니다.');
            return false;
        }
    	else if(idOldDateCheck()) {
    		alert('검색 시작 일자가 너무 과거입니다.\n2019-01-01 이후로 검색해주세요.');
            return false;
        }
        
        var url = '/stats/groupRpaOper/getGroupRpaOperList';
        
        var param = {
                searchCmpnyCd           : $("#searchCmpnyCd").val()
                , searchStartDe         : $("#searchStartDe").val().replace(/-/g, "")
                , searchEndDe           : $("#searchEndDe").val().replace(/-/g, "")
                , searchRobotId         : $("#searchRobotId").val()
                , searchProcessCd       : $("#searchProcessCd").val()
                , searchProcessNm       : $("#searchProcessNm").val()
        };
        
        callAsyncAjax(url, param, "drawGrid");
        
        // 로딩 시작
        $('.dimmed').css({ display: 'block' });
        $('.loading').css({ display: 'block' });
        $('.loading').addClass('show');
    }
    
    /*
     * popup창 닫기
     * @param
     * @return
     */
    function closePOP(){
    	$(".over").remove();
    	searchGroupRpaOperList();
    }
 
    // 위 표 엑셀다운로드
    function outExport(){    	
        dataorexcel = "excel";
        loadingTextChange(); // 엑셀 다운로드 중
           
        var url = '/stats/groupRpaOper/outExportGroupRpaOperList';
        
        var param = {
                searchCmpnyCd           : $("#searchCmpnyCd").val()
                , searchStartDe         : $("#searchStartDe").val().replace(/-/g, "")
                , searchEndDe           : $("#searchEndDe").val().replace(/-/g, "")
                , searchRobotId         : $("#searchRobotId").val()
                , searchProcessCd       : $("#searchProcessCd").val()
                , searchProcessNm       : $("#searchProcessNm").val()
                , excelDownload         : 'Y'
        };
 
        callAsyncAjax(url, param, "exportCallback");
        
        //결재 로딩바 
        $('.dimmed').css({ display: 'block' });
        $('.loading').css({ display: 'block' });
        $('.loading').addClass('show');
    }
    
    // 아래 표 엑셀다운로드
    function outExportForWeek(){       
        // 아래 표 연도 기간 TEXT 4개를 담은 배열 초기화 및 생성
        makeDateTextArray();
        
        dataorexcel = "excel";
        loadingTextChange(); // 엑셀 다운로드 중
           
        var url = '/stats/groupRpaOper/outExportGroupRpaOperWeekList';
        
        var param = {
                searchCmpnyCd           : $("#searchCmpnyCd").val()
                , searchStartDe         : $("#searchStartDe").val().replace(/-/g, "")
                , searchEndDe           : $("#searchEndDe").val().replace(/-/g, "")
                , searchRobotId         : $("#searchRobotId").val()
                , searchProcessCd       : $("#searchProcessCd").val()
                , searchProcessNm       : $("#searchProcessNm").val()
                , dateTextArray         : dateTextArray
                , excelDownload         : 'Y'
        };
 
        callAsyncAjax(url, param, "exportWeekCallback");
        
        //결재 로딩바 
        $('.dimmed').css({ display: 'block' });
        $('.loading').css({ display: 'block' });
        $('.loading').addClass('show');
    }

    // 위의 표 엑셀다운로드 콜백
    function exportCallback(data) {
    	if (data != null && data != undefined) {
            if (data.result != null && data.result.fileNo != null) {
            	$("#fileNo").val(data.result.fileNo);
            	
            	var fileName = "그룹 RPA 운영 실적 요약_" + $("#searchStartDe").val().replace(/-/g, "") + "부터 " + $("#searchEndDe").val().replace(/-/g, "") + "까지";         	
                $("#fileNm").val(fileName);
                
                var frmData = document.downloadFormExel;
                frmData.action = "/file/downloadExport"; 
                frmData.submit();
            }
        }
        
        $('.dimmed').css({ display: 'none' });
        $('.loading').css({ display: 'none' });
        $('.loading').removeClass('show');
 
        dataorexcel = "data";
        loadingTextChange(); // 데이터 로딩 중
    } 
    
    // 아래 표 엑셀다운로드 콜백
    function exportWeekCallback(data) {
        if (data != null && data != undefined) {
            if (data.result != null && data.result.fileNo != null) {
                $("#fileNo").val(data.result.fileNo);
                var fileName = "성공률추이_" + startDateForWeek + "부터 " + endDateForWeek + "까지";

                $("#fileNm").val(fileName);
                
                var frmData = document.downloadFormExel;
                frmData.action = "/file/downloadExport"; 
                frmData.submit();
            }
        }
        
        $('.dimmed').css({ display: 'none' });
        $('.loading').css({ display: 'none' });
        $('.loading').removeClass('show');
 
        dataorexcel = "data";
        loadingTextChange(); // 데이터 로딩 중
    } 
</script>