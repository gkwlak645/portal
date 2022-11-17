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
                                         	
                          <div class="form-group col-md-6">
	                          <label for="searchLevel" class="col-sm-4 col-form-label">JOB 상태</label>
	                          <div class="col-sm-8">
	                              <select id="searchSuccessAt" class="form-control"  style="min-width: 160px;width:70%;">
	                                  <option value=""></option>
	                              </select>
	                          </div>
                          </div>
                          
                          
                       	<div class="form-group col-md-6">
                       		<label for="tyCd" class="col-sm-4 col-form-label">사유</label>
                        	<div class="col-sm-8 float-left">
	                           	<select id="searchResn" class="form-control float-left"  style="min-width: 160px;width:70%;">
	                            	<option value=''>선택</option>
	                            </select>
                           </div>
                    	</div>

                    	<div class="form-group col-md-6">
                            <div class="col-sm-8 float-left">
                                <button type="button" id="btnSearch" class="btn btn-info float-left">조회</button>
                           </div>
                        </div>
                    </form> 
                    
                    <font style="color:#1266FF;">※ 어제까지 수행 완료된 JOB만 집계됩니다. 금일 수행된 JOB은 집계되지 않습니다.</font>
                    
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-body">
                <button type="button" id="btnOutExport" class="btn btn-primary float-right" style="margin: 5px 0 15px 2px;">엑셀 다운로드</button>
                    <div id="jobMngGrid"></div>
                    <div id="jobMngGridPager" class="portal-pager"></div>
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
var nowPage = 1;
var offset;
var moveScroll;

$(document.body).ready(function () {   
	loadingTextChange();
	searchJobMngList();
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
            params.push({"id" : "searchCmpnyCd", "clsCd" : "0024", "selectValue": "${sessionUserInfo.txCmpnyCd}"});
        }else{
            params.push({"id" : "searchCmpnyCd", "clsCd" : "0024", "disable" : "Y", "selectValue": "${sessionUserInfo.txCmpnyCd}"});
        }
                
        params.push({"id" : "searchResn"        , "clsCd" : "0060"});    //사유
        params.push({"id" : "searchSuccessAt"   , "clsCd" : "0061"});    //JOB 상태

        requestCmmnCd(params);
        
        searchRobotList();
    };
    
    // yyyymmdd → yyyy-mm-dd로 변환하여 return
    function getYYYYMMDD(dt) {
        return dt.substr(0, 4) + '-' + dt.substr(4, 2) + '-' + dt.substr(6, 2);
    }
    
    // d가 date인지 검사
    function isValidDate(d) {
          return d instanceof Date && !isNaN(d);
    }
    
    /*
     * 이벤트 바인딩
     * @param
     * @return
     */
    function bindEvent(){

        //조회버튼 클릭 이벤트 처리
        $("#btnSearch").on("click",function(){
        	searchJobMngList();
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
    }
    
    /*
     * 검색
     * @param 페이지번호
     * @return
     */
    function searchRobotList() {
        var url = '/mntrng/jobmng/getRobotList';

        var param = {
            cmpnyCd: $("#searchCmpnyCd").val()
        }; 
        
        callAsyncAjax(url, param, "makeSelectBoxRobot");
    }
    
    function makeSelectBoxRobot(data) {
        var robotList = {};
        var saveRobotId = ($("#searchRobotId").val() == null || $("#searchRobotId").val().length == 0) ? "null" : $("#searchRobotId").val();
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
            drawPager("jobMngGridPager", data.result.paginationInfo, "searchJobMngList");
        }

        $("#jobMngGrid").jsGrid({
              height : "auto"
            , width : "100%"
            , autoload: true
            , sorting : true
            , align : "left"
            , data : params
            , rowClick: function(arg){
                // 로딩 시작
                $('.dimmed').css({ display: 'block' });
                $('.loading').css({ display: 'block' });
                $('.loading').addClass('show');
                
                jobMngDetail(arg.item);
            }
            , fields : [
                  {name: "cmpnyNm"      , title : "회사"          , type : "text" , width : 30, align : "left"}
                , {name: "robotNm"      , title : "로봇"          , type : "text" , width : 30, align : "left"}
                , {name: "jobId"        , title : "JOB ID"       , type : "text" , width : 30, align : "right"}
                , {name: "processCd"    , title : "프로세스 코드"	 , type : "text" , width : 30, align : "left"}
                , {name: "processNm"    , title : "프로세스명"      , type : "text" , width : 80, align : "left"}
                , {name: "startTimeAdd" , title : "시작 시간"       , type : "text" , width : 40, align : "left"}
                , {name: "endTimeAdd"   , title : "종료 시간"       , type : "text" , width : 40, align : "left"} 
                , {name: "successAt"    , title : "JOB 상태"      , type : "text" , width : 20, align : "left",
                	itemTemplate: function(value, item) {
                		if(item.successAt == 0) return '실패';  
                        else if(item.successAt == 1) return '성공';  
                        return '';  
                	}	
                  }
                , {name: "resnNm"	    , title : "사유"          , type : "text"	, width : 30, align : "left"}
            ]
        });
        
        // 로딩 끝
        $('.dimmed').css({ display: 'none' });
        $('.loading').css({ display: 'none' });
        $('.loading').removeClass('show');
    }
    
    // yyyy.mm.dd. 오전 12:00 형식에서 yyyymmdd로 수정
    function getConvertedYMD(dt) {
    	if(dt.indexOf(".") == -1) {
    		return dt;
    	}
    	var dtarray = dt.split('.');
    	return dtarray[0] + dtarray[1] + dtarray[2]; 
    } 
    
    
    /*
     * 검색
     * @param 페이지번호
     * @return
     */
    function searchJobMngList(pageNo) {    	
    	if($("#searchStartDe").val() > $("#searchEndDe").val()){
            alert('검색기간 시작일이 종료일보다 클 수 없습니다.');
        }else{
            
        	//myStorage.setItem("cmpnyCd", $("#searchCmpnyCd").val());

        	var url = '/mntrng/jobmng/getJobMngList';
            currentPageNo = 1;
            if (pageNo != null && pageNo != undefined && pageNo != "") {
                currentPageNo = pageNo;
            }
            
            nowPage = currentPageNo;
         
            var sdt = getConvertedYMD($("#searchStartDe").val());
            var edt = getConvertedYMD($("#searchEndDe").val());
 
            // sdt에 "-"가 없다면 yyyy-mm-dd로 변환해야함
            if(sdt.indexOf("-") == -1) {
            	$('#searchStartDe').datepicker({format:"yyyy-mm-dd"}).datepicker("setDate", new Date(2020,10,01) );
            }
            
            // edt에 "-"가 없다면 yyyy-mm-dd로 변환해야함
            if(edt.indexOf("-") == -1) {
            	$('#searchEndDeDiv').setValue(new Date(getYYYYMMDD(edt)));
            }

            var param = {
                    searchCmpnyCd           : $("#searchCmpnyCd").val()
                    , searchStartDe         : sdt.replace(/-/g, "")
                    , searchEndDe           : edt.replace(/-/g, "")
                    , searchRobotId         : $("#searchRobotId").val()
                    , searchResn            : $("#searchResn").val()
                    , searchSuccessAt       : $("#searchSuccessAt").val()
                    , searchProcessCd       : $("#searchProcessCd").val()
                    , searchProcessNm       : $("#searchProcessNm").val()
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
    }
    
    /*
     * 상세페이지 팝업
     * @param 
     * @return
     */
    function jobMngDetail(item) {   	
    	dataorexcel = "data";
        loadingTextChange(); // 데이터 로딩 중

        // 스크롤바 이동하기 위한 설정
        offset = $('#jobMngMainDiv').offset(); 
        moveScroll = $(document).scrollTop();
     
    	// 스크롤 이동
        $('html').animate({scrollTop : offset.top}, 10);
    	
        //상세 페이지 div 생성
        appendDetailPopup("jobMngMainDiv", "/mntrng/jobmng/jobMngDetailPop");
        
        // 보여줄 상세 팝업창 각종 정보들 칸에 세팅
        $("#detailCmpnyNm").val(item.cmpnyNm);
        $("#detailJobId").val(item.jobId);
        $("#detailSearchStartDe").val(item.startTimeAdd);
        $("#detailSearchEndDe").val(item.endTimeAdd);
        $("#detailProcessCd").val(item.processCd);
        $("#detailProcessNm").val(item.processNm);
        $("#detailRobotName").val(item.robotNm);

        getSuccessAt = item.successAt;
        getResn = item.resn;
        getCmpnyCd = item.cmpnyCd;        
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
    	searchJobMngList(nowPage);
    }
 
    //엑셀다운로드
    function outExport(){
        dataorexcel = "excel";
        loadingTextChange(); // 엑셀 다운로드 중
           
        var url = '/mntrng/jobmng/outExportJobMngList';
        
        var param = {
                searchCmpnyCd           : $("#searchCmpnyCd").val()
                , searchStartDe         : $("#searchStartDe").val().replace(/-/g, "")
                , searchEndDe           : $("#searchEndDe").val().replace(/-/g, "")
                , searchRobotId         : $("#searchRobotId").val()
                , searchResn            : $("#searchResn").val()
                , searchSuccessAt       : $("#searchSuccessAt").val()
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

    //엑셀다운로드 콜백
    function exportCallback(data) {
    	if (data != null && data != undefined) {
            if (data.result != null && data.result.totalCount != null) {
                if(data.result.totalCount > 10000) {
                	alert("엑셀로 다운로드할 수 있는 최대 JOB의 개수는 10,000개입니다.\n날짜 간격을 줄여주세요.");
                }
            }          
            else if (data.result != null && data.result.fileNo != null) {
            	$("#fileNo").val(data.result.fileNo);
                $("#fileNm").val("JOB이력관리");
                
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