<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div id="expectRealProcessMainDiv" class="container-fluid wrap">
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
                              <label for="searchProcessSttus" class="col-sm-4 col-form-label">프로세스 상태</label>
                                <div class="col-sm-8 float-left">
                                   <select id="searchProcessSttus" class="form-control float-left"  style="min-width: 160px;width:70%;">
                                      <option value=''>전체</option>
                                   </select>
                                </div>
                          </div>
                          
                          
                          <div class="form-group row col-sm-6">                      
                              <label for="searchDevOperBot" class="col-sm-4 col-form-label">개발운영 BOT</label>
                                <div class="col-sm-8 float-left">
                                   <select id="searchDevOperBot" class="form-control float-left"  style="min-width: 160px;width:70%;">
                                      <option value=''>전체</option>
                                   </select>
                                </div>
                          </div>
                          
                          <div class="form-group row col-sm-6">                      
                              <label for="searchExeFreq" class="col-sm-4 col-form-label">실행주기</label>
                                <div class="col-sm-8 float-left">
                                   <select id="searchExeFreq" class="form-control float-left"  style="min-width: 160px;width:70%;">
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
                    <!-- <font style="color:#1266FF;">※ [모니터링] - [JOB이력관리]의 JOB을 기반으로 집계됩니다.</font> -->             
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-body">
                
	                <!-- <font id="textTime" class="float-left text-warning"  style="margin-left:10px;"></font> -->
	                
	                <button type="button" id="btnOutExport" class="btn btn-primary float-right" style="margin: 5px 0 15px 2px;">엑셀 다운로드</button>
                
		                <div id="expectRealProcGrid"></div>
	                    <div id="expectRealProcGridPager" class="portal-pager"></div>          
                         
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

var currentPageNo = 1;
var nowPage = 1;

$(document.body).ready(function () {   
	/* alert("8월 중순 오픈 예정입니다.");
	window.location.replace("/main/siteMain");
	return false; */
	
	loadingTextChange();
	searchExpectRealProcList();
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

        // 프로세스 상태
        params.push({"id" : "searchProcessSttus", "clsCd" : "0037"});

        // 개발 BOT 또는 운영 BOT
        params.push({"id" : "searchDevOperBot", "clsCd" : "0049"});
        
        // 실행주기
        params.push({"id" : "searchExeFreq", "clsCd" : "0017"});
            
        
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
        	searchExpectRealProcList();
        });
        
        $('#searhcStartDeDiv').datetimepicker({
            format: 'YYYY-MM-DD'
          , defaultDate: (new Date()).setDate((new Date()).getDate() - 1)
        });
        
        $("#searchEndDeDiv").datetimepicker({
            format: 'YYYY-MM-DD'
          , defaultDate: (new Date()).setDate((new Date()).getDate() - 1)
        });
      
        //엑셀다운로드
        $("#btnOutExport").on('click', function(){
            outExport();
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
        
    // 20210805 형식으로 문자열 return
    function getYYYYMMDD(tempDate) {
    	var dt = new Date(tempDate);
    	var year = dt.getFullYear();
        var month = ("0" + (1 + dt.getMonth())).slice(-2);
        var day = ("0" + dt.getDate()).slice(-2);
    	return year + month + day;
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

    /*
     * 검색
     * @param 페이지번호
     * @return
     */
    function searchRobotList() {
        var url = '/stats/expectRealProcess/getRobotList';

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
    
    /*
     * 그리드 초기화
     * @param
     * @return
     */
    function drawGrid(data){
        var params = {};
        
        if (data != null && data != undefined) {
            if (data.result != null && data.result.resultList != null) {
            	params = data.result.resultList;
            }
           
            if (data.result != null && data.result.robotList != null) {
                makeSelectBoxRobot(data.result.robotList);              
            }
            
            drawPager("expectRealProcGridPager", data.result.paginationInfo, "searchExpectRealProcList");
        }
        
        
        $("#expectRealProcGrid").jsGrid({
            height : "auto"
          , width : "100%"
          , autoload: true
          , sorting : true
          , align : "left"
          , data : params
          , rowClick: function(arg){

          }
          , fields : [
                {name: "cmpnyNm"            , title : "회사"              , type : "text" , width : 30, align : "left"}
              , {name: "processCd"          , title : "코드"              , type : "text" , width : 20, align : "left"}
              , {name: "processNm"          , title : "명"               , type : "text" , width : 90, align : "left"}
              , {name: "processStatus"      , title : "상태"              , type : "text" , width : 20, align : "left"}
              , {name: "belongingDate"      , title : "귀속일"             , type : "text" , width : 30, align : "left"}
              , {name: "expectFreq"         , title : "실행주기"           , type : "text" , width : 30, align : "left"}
              , {name: "oneRedcnTm"         , title : "(예상)절감시간(건당)"  , type : "text" , width : 50, align : "right"}
              , {name: "expectSuccessCount" , title : "(예상)성공횟수"       , type : "text" , width : 30, align : "right"}
              , {name: "expectRedcnTm"      , title : "(예상)절감시간"       , type : "text" , width : 30, align : "right"}
              , {name: "realSuccessCount"   , title : "(실제)성공횟수"       , type : "text" , width : 30, align : "right"}
              , {name: "realRedcnTm"        , title : "(실제)절감시간"       , type : "text" , width : 30, align : "right"}
              , {name: "successRate"        , title : "실행성공률"          , type : "text" , width : 30, align : "right"}
              , {name: "bot"                , title : "BOT"              , type : "text" , width : 20, align : "left"}
          ]
        });

        
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
    function searchExpectRealProcList(pageNo) {    	
    	if($("#searchStartDe").val() > $("#searchEndDe").val()){
            alert('검색기간 시작일이 종료일보다 클 수 없습니다.');
            return false;
        }
    	
    	if(idOldDateCheck()) {
    		alert('검색 시작 일자가 너무 과거입니다.\n2019-01-01 이후로 검색해주세요.');
            return false;
        }
        
        var url = '/stats/expectRealProcess/getExpectRealProcessList';
        
        currentPageNo = 1;
        if (pageNo != null && pageNo != undefined && pageNo != "") {
            currentPageNo = pageNo;
        }
        
        nowPage = currentPageNo;  
        
        var param = {
                searchCmpnyCd           : $("#searchCmpnyCd").val()
                , searchStartDe         : $("#searchStartDe").val().replace(/-/g, "")
                , searchEndDe           : $("#searchEndDe").val().replace(/-/g, "")
                , searchRobotId         : $("#searchRobotId").val()
                , searchProcessCd       : $("#searchProcessCd").val()
                , searchProcessNm       : $("#searchProcessNm").val()
                , searchProcessSttus    : $("#searchProcessSttus").val()
                , searchDevOperBot      : $("#searchDevOperBot").val()        
                , searchExeFreq         : $("#searchExeFreq").val()
                , currentPageNo         : currentPageNo
                , recordCountPerPage    : 20
                , pageSize              : 10
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
    	searchExpectRealProcList();
    }
 
    // 위 표 엑셀다운로드
    function outExport(){    	
        dataorexcel = "excel";
        loadingTextChange(); // 엑셀 다운로드 중
           
        var url = '/stats/expectRealProcess/outExportExpectRealProcessList';
        
        var param = {
                searchCmpnyCd           : $("#searchCmpnyCd").val()
                , searchStartDe         : $("#searchStartDe").val().replace(/-/g, "")
                , searchEndDe           : $("#searchEndDe").val().replace(/-/g, "")
                , searchRobotId         : $("#searchRobotId").val()
                , searchProcessCd       : $("#searchProcessCd").val()
                , searchProcessNm       : $("#searchProcessNm").val()
                , searchProcessSttus    : $("#searchProcessSttus").val()
                , searchDevOperBot      : $("#searchDevOperBot").val()
                , searchExeFreq         : $("#searchExeFreq").val()
                , excelDownload         : 'Y'
        };
 
        callAsyncAjax(url, param, "exportCallback");
        
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
            	
            	var fileName = "예상실제비교_프로세스_" + $("#searchStartDe").val().replace(/-/g, "") + "부터 " + $("#searchEndDe").val().replace(/-/g, "") + "까지";         	
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