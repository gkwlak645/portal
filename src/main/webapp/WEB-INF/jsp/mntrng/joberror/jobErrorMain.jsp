<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div id="jobErrorMainDiv" class="container-fluid wrap">
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
                               <span class="col-sm-4">
                                     <input type="radio" name="searchChkDe" value="occrrncDe" style="margin-left:0;" checked>발생일  &nbsp; 
                                   <input type="radio" name="searchChkDe" value="managtDe" style="margin-left:0;">조치일
                               </span>
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
	                           <label for="searchTyCd" class="col-sm-4 col-form-label">로봇명</label>
                                 <div class="col-sm-8 float-left">
                                    <select id="searchRobotName" class="form-control float-left"  style="min-width: 160px;width:70%;">
                                       <option value=''>전체</option>
                                    </select>
                                 </div>
                           </div>
                           
                           <div class="form-group col-md-6">
	                           <label for="searchOccrrncSeCd" class="col-sm-4 col-form-label">오류발생구분</label>
	                           <div class="col-sm-8">
	                               <select id="searchOccrrncSeCd" class="form-control"  style="min-width: 160px;width:70%;">
	                                   <option value=""></option>
	                               </select>
	                           </div>
	                       </div>
                           <div class="form-group col-md-6">
                           		<label for="searchTyCd" class="col-sm-4 col-form-label">오류유형</label>
                           		<div class="col-sm-8 float-left">
                               		<select id="searchTyCd" class="form-control float-left"  style="min-width: 160px;width:70%;">
                                   		<option value=''>선택</option>
                               		</select>
                           		</div>
                           	</div>
                           	<div class="form-group col-md-6">
	                           <label for="searchLevel" class="col-sm-4 col-form-label">State</label>
	                           <div class="col-sm-8">
	                               <select id="searchState" class="form-control"  style="min-width: 160px;width:70%;">
	                                   <option value=""></option>
	                               </select>
	                           </div>
                           </div>
                       	<div class="form-group col-md-6">
                       		<label for="tyCd" class="col-sm-4 col-form-label">조치상태</label>
                        	<div class="col-sm-8 float-left">
	                           	<select id="searchSttusCd" class="form-control float-left"  style="min-width: 160px;width:70%;">
	                            	<option value=''>선택</option>
	                            </select>
                           		<button type="button" id="btnSearch" class="btn btn-info float-left">조회</button>
                           </div>
                    	</div>
                    </form> 
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-body">
                <button type="button" id="btnOutExport" class="btn btn-primary float-right" style="margin: 5px 0 15px 2px;">엑셀 다운로드</button>
                    <div id="jobErrorGrid"></div>
                    <div id="jobErrorGridPager" class="portal-pager"></div>
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
var currentPageNo = 1;

var dataorexcel = 'data';
var offset;
var moveScroll;

$(document.body).ready(function () {   
	loadingTextChange();
	searchJobList();
});
    

    /*
     * 페이지 초기화
     * @param
     * @return
     */
    function pageInit() {
	
    	//그리드 초기화
    	drawGrid();

        var params = [];
        
        if("${txScreenAuthor.untenantAuthor}" == 'Y'){
            params.push({"id" : "searchCmpnyCd", "clsCd" : "0024"});    //회사
        }else{
            params.push({"id" : "searchCmpnyCd", "clsCd" : "0024", "disable" : "Y", "selectValue": "${sessionUserInfo.txCmpnyCd}"});    //회사
        }
        params.push({"id" : "searchOccrrncSeCd"   , "clsCd" : "0025"});    //오류발생구분
        
        var aIncludeList = [];        aIncludeList["4"] = "";        aIncludeList["5"] = "";        aIncludeList["6"] = "";
        params.push({"id" : "searchState"   , "clsCd" : "0015", "includeList": aIncludeList});    //State
        
        params.push({"id" : "searchSttusCd"   , "clsCd" : "0031"});    //조치상태
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
        	searchJobList();
        });
        
        $('#searhcStartDeDiv').datetimepicker({
            format: 'YYYY-MM-DD'
          , defaultDate: (new Date()).setDate((new Date()).getDate())
        });
        
        $("#searchEndDeDiv").datetimepicker({
            format: 'YYYY-MM-DD'
          , defaultDate: (new Date())
        });
        
      //오류발생구분 change 이벤트
        $("#searchOccrrncSeCd").on("change",function(){
            var occrrncSeCd = $('#searchOccrrncSeCd').val(); 

            var params = [];
            if(occrrncSeCd != ''){
            	params.push({"id" : "searchTyCd" , "clsCd" : occrrncSeCd});
            	requestCmmnCd(params);
            }else{
            	$("#searchTyCd").html("<option value=''>선택</option>");
            }
        });
        
      
        //엑셀다운로드
        $("#btnOutExport").on('click', function(){
            outExport();
        });
        
        $("#searchCmpnyCd").on("change",function(){
            searchRobotList();      
        });
    }
    
    /*
     * 검색
     * @param 페이지번호
     * @return
     */
    function searchRobotList() {
        var url = '/mntrng/joberror/getRobotList';

        var param = {
            cmpnyCd: $("#searchCmpnyCd").val()
        }; 
        
        callAsyncAjax(url, param, "makeSelectBoxRobot");
    }
    
    function makeSelectBoxRobot(data) {
        var robotList = {};
        var saveRobotName = $("#searchRobotName").val().length == 0 ? "null" : $("#searchRobotName").val();
        var template = '<option value="전체">전체</option>';

        if (data.result != null && data.result.robotList != null) {
            robotList = data.result.robotList;  
            //<option value=""></option>
            var len = robotList.length;
            for(var i=0; i<len; i++) {             
                template += '<option value=' + robotList[i].name + '>' + robotList[i].name + '</option>';
            }

            $("#searchRobotName").html(template);  

            var isExists = 0 != $('#searchRobotName option[value='+saveRobotName+']').length;
            
            if(isExists) {
                $("#searchRobotName").val(saveRobotName).attr("selected", "selected");
            }
            else {
                $("#searchRobotName").val("전체").attr("selected", "selected");
            }
            
            return false;
        }

        $("#searchRobotName").html(template); 
        $("#searchRobotName").val("전체").attr("selected", "selected");
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
            drawPager("jobErrorGridPager", data.result.paginationInfo, "searchJobList");
        }

        $("#jobErrorGrid").jsGrid({
              height : "auto"
            , width : "100%"
            , autoload: true
            , sorting : true
            , align : "left"
            , data : params
            , rowClick: function(arg){
                //jobErrorDetail(arg.item.id);
            }
            , fields : [
                  {name: "", title : "", type : "hidden", width : 0, itemTemplate: function(value, item) { 
                	         return '<div id="' + item.id + '"/>';
                	    }
                  }
            	, {name: "cmpnyNm"      , title : "회사"         , type : "text" , width : 30 , align : "left"}
                , {name: "robotName"    , title : "로봇"         , type : "text" , width : 30 , align : "left"}
                , {name: "occrrncDt"    , title : "발생일시"      , type : "text" , width : 40, align : "left"}
                , {name: "processCd"    , title : "프로세스코드"	, type : "text" , width : 30, align : "left", itemTemplate: function(value, item) { return '<span style="display: block;    text-decoration: none;    text-overflow: ellipsis;    white-space: nowrap;    overflow: hidden;" title="'+ value +'" onclick="jobErrorDetail('+ item.id +')">' + value + '</span>'}}
                , {name: "processNm"    , title : "프로세스명"     , type : "text" , width : 80, itemTemplate: function(value, item) { return '<span style="display: block;    text-decoration: none;    text-overflow: ellipsis;    white-space: nowrap;    overflow: hidden;" title="'+ value +'" onclick="jobErrorDetail('+ item.id +')">' + value + '</span>'}}
                , {name: "stateNm"      , title : "State"       , type : "text" , width : 25, align : "left"}
                , {name: "sourceNm"     , title : "실행구분"       , type : "text" , width : 60, align : "left", itemTemplate: function(value, item) { return '<span style="display: block;    text-decoration: none;    text-overflow: ellipsis;    white-space: nowrap;    overflow: hidden;" title="'+ value +'">' + value + '</span>'}} 
                , {name: "info"         , title : "오류내용"      , type : "text" 	, width : 50, itemTemplate: function(value, item) { return '<span style="display: block;    text-decoration: none;    text-overflow: ellipsis;    white-space: nowrap;    overflow: hidden;" title="'+ value +'">' + value + '</span>'}}
                , {name: "sttusNm"		, title : "조치상태"      , type : "text"	, width : 25, align : "left"}
                , {name: "ETC___"       , title : "로그보기"      , type : "text"	, width : 25, align : "left", itemTemplate: function(value, item) { return "<span onclick =\"jobIdClick(this, " + item.id +")\">로그보기</span>"}}
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
    function searchJobList(pageNo) {
    	
    	if($("#searchStartDe").val() > $("#searchEndDe").val()){
            alert('검색기간 시작일이 종료일보다 클 수 없습니다.');
        }else{
        	var url = '/mntrng/joberror/getJobErrorList';
            currentPageNo = 1;
            if (pageNo != null && pageNo != undefined && pageNo != "") {
                currentPageNo = pageNo;
            }

            var param = {
           		searchCmpnyCd           : $("#searchCmpnyCd").val()
                , searhChkDe            : $('input:radio[name="searchChkDe"]:checked').val()
                , searchStartDe         : $("#searchStartDe").val().replace(/-/g, "")
                , searchRobotName       : $("#searchRobotName").val()
                , searchEndDe           : $("#searchEndDe").val().replace(/-/g, "")
                , searchProcessCd       : $("#searchProcessCd").val()
                , searchOccrrncSeCd     : $("#searchOccrrncSeCd").val()
                , searchTyCd     		: $("#searchTyCd").val()
                , searchState     		: $("#searchState").val()
                , searchSttusCd     	: $("#searchSttusCd").val()
                , currentPageNo         : currentPageNo
                , recordCountPerPage    :   20
                , pageSize              :   10
            }; 

            callAsyncAjax(url, param, "drawGrid");
            
            // 로딩 시작
            $('.dimmed').css({ display: 'block' });
            $('.loading').css({ display: 'block' });
            $('.loading').addClass('show');
        }
    }
    
    /*
     * 상세페이지 팝업
     * @param 
     * @return
     */
    function jobErrorDetail(id) {
    	dataorexcel = "data";
        loadingTextChange(); // 데이터 로딩 중
        // 로딩 시작
        $('.dimmed').css({ display: 'block' });
        $('.loading').css({ display: 'block' });
        $('.loading').addClass('show');

        // 스크롤바 이동하기 위한 설정
        offset = $('#jobErrorMainDiv').offset(); 
        
        moveScroll = $(document).scrollTop();
     
    	// 스크롤 이동
        $('html').animate({scrollTop : offset.top}, 10);
    	
        //상세 페이지 div 생성
        appendDetailPopup("jobErrorMainDiv", "/mntrng/joberror/jobErrorDetailPop");
        jboErrorSn = id;
        
        //상세 페이지 데이터 조회
        //getDetailData(id);
    };
    
    /*
     * popup창 닫기
     * @param
     * @return
     */
    function closePOP(){
    	// 스크롤 이동
        $('html').animate({scrollTop : moveScroll}, 10);
    	$(".over").remove();
        searchJobList();
    }
    
    function jobIdClick(oObj, jobId, event){
    	location.href="/mntrng/trnscerror/trnscErrorMain?jobId=" + jobId;	
    	return false
    }
    
    
  //엑셀다운로드
    function outExport(){
        dataorexcel = "excel";
        loadingTextChange(); // 엑셀 다운로드 중
           
        var url = '/mntrng/joberror/outExportJobErrorList';

        var param = {
                searchCmpnyCd           : $("#searchCmpnyCd").val()
                , searhChkDe            : $('input:radio[name="searchChkDe"]:checked').val()
                , searchStartDe         : $("#searchStartDe").val().replace(/-/g, "")
                , searchEndDe           : $("#searchEndDe").val().replace(/-/g, "")
                , searchProcessCd       : $("#searchProcessCd").val()
                , searchOccrrncSeCd     : $("#searchOccrrncSeCd").val()
                , searchTyCd            : $("#searchTyCd").val()
                , searchState           : $("#searchState").val()
                , searchSttusCd         : $("#searchSttusCd").val()
                , excelDownload         : 'Y'
        }; 
 
        callAsyncAjax(url, param, "exportCallback");
        
        //결재 로딩바 
        $('.dimmed').css({ display: 'block' });
        $('.loading').css({ display: 'block' });
        $('.loading').addClass('show');
    }

  //엑셀다운로드 콜백
    function exportCallback(data) {
        $("#fileNo").val(data.result.fileNo);
        $("#fileNm").val("JOB오류관리");
        
        var frmData = document.downloadFormExel;
        frmData.action = "/file/downloadExport"; 
        frmData.submit() ;
        
        $('.dimmed').css({ display: 'none' });
        $('.loading').css({ display: 'none' });
        $('.loading').removeClass('show');

        
        dataorexcel = "data";
        loadingTextChange(); // 데이터 로딩 중
    }

  
  
  
</script>
