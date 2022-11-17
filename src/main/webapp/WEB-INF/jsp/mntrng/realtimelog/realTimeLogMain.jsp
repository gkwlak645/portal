<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

				<!--  템플릿 바디 -->        				                    
				<div id="realTimeLogMainDiv" class="container-fluid wrap">				    
                    <div class="row">
				        <div class="col-md-12">
				            <div class="card">
				                <div class="card-header">
				                    <form class="form-inline">

				                        <div class="form-group col-md-6">
					                       <label for="usr" class="col-sm-3 col-form-label">프로세스명</label>
	                                       <div class="col-sm-9">
	                                         <input type="text" class="form-control float-left" value="" id="searchProcessNm" style="min-width: 150px;width:100%;" maxlength="30">
	                                       </div>
                                        </div>

                                        <div class="form-group col-md-4">
                                            <label for="usr" class="col-sm-3 col-form-label">LEVEL</label>
                                             <div class="col-sm-9">
                                              <select class="form-control float-left" id="searchLevel"style="width:100%;" >
                                                <option value=""></option>
                                              </select>                                                                         
                                            </div>
                                        </div>
  
                                        <div class="form-group col-md-2">                                       
                                        </div> 
                                        
                                        <div class="form-group col-md-6">
                                           <label for="usr" class="col-sm-3 col-form-label">Message</label>
                                           <div class="col-sm-9">
                                             <input type="text" class="form-control float-left" value="" id="searchMessage" style="min-width: 150px;width:100%;" maxlength="30">
                                           </div>
                                        </div>
   
                                        <div class="form-group col-md-6">
                                              <label for="usr" class="col-sm-2 col-form-label">기간</label>
					                          <div class="col-sm-4">
					                              <div class="input-group date" id="startDeDiv" data-target-input="nearest" style="min-width:100px;margin: 0 0 2px 0;" >
					                                  <input type="text" id="startDe" name="startDe" class="form-control datetimepicker-input" data-target="#startDeDiv"/>
					                                  <div class="input-group-append" data-target="#startDeDiv" data-toggle="datetimepicker">
					                                      <div class="input-group-text"><i class="fa fa-calendar"></i></div>
					                                  </div>
					                              </div>
					                          </div>
					                          <div class="col-sm-4">
					                              <div class="input-group date" id="endDeDiv" data-target-input="nearest" style="min-width:100px;margin: 0 0 2px 0;" >
					                                  <input type="text" id="endDe" name="endDe" class="form-control datetimepicker-input" data-target="#endDeDiv"/>
					                                  <div class="input-group-append" data-target="#endDeDiv" data-toggle="datetimepicker">
					                                      <div class="input-group-text"><i class="fa fa-calendar"></i></div>
					                                  </div>
					                              </div>
					                          </div>
                                        </div> 
    
                                            
                                         <div class="form-group col-md-6">
                                           <label for="usr" class="col-sm-3 col-form-label">로봇명</label>
                                           <div class="col-sm-9">
                                             <select class="form-control float-left" id="searchRobotName"style="width:100%;" >
                                                <option value=""></option>
                                              </select>
                                           </div>
                                        </div>

                                        <div class="form-group col-md-4">
                                        <button type="button" id="btnSearch" class="btn btn-info float-left">조회 및 갱신</button>
                                        </div>
                                        <div class="form-group col-md-2">                                       
                                        </div> 


                                        <!-- <div class="form-group col-md-4">
                                        </div>
                                        <div class="form-group col-md-2">                                       
                                        </div>  -->

                                        
                                        <!-- <div class="form-group col-md-12">
                                           <div class="col-sm-9">
                                             <button type="button" id="btnSearch" class="btn btn-info float-left">조회 및 갱신</button>                                           
                                           </div>
                                        </div> -->
                           
				                    </form> 
				                </div>
				            </div>
				        </div>
			        
				    </div>
				    		  
                    <div class="row">
                    
                        <div class="col-md-12">
                            
                            <div class="card">
                            
                                <div class="card-body">
                                
                                    <div><button type="button" id="btnOutExport" class="btn btn-primary float-right" style="margin: 5px 0 15px 2px;">엑셀 다운로드</button></div>                              
                                    
                                    <div id="realTimeLogGrid"></div>
                                    
                                    <div id="realTimeLogGridPager" class="portal-pager"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    
                </div>
<!--  템플릿 바디 끝 -->    

<!-- 로딩바  -->
<div class="dimmed" style="display:none"></div>
<div class="loading" style="display:none">
    <div class="loading-bar"><div></div><div></div><div></div><div></div></div>
    <span class="loading-text">데이터 로딩 중...</span>
</div>

<!-- 엑셀 다운로드 FORM -->                    
<form id="downloadFormExel" name="downloadFormExel" method="post">
    <input type="hidden" id="fileNo" name="fileNo" value="" />
    <input type="hidden" id="fileNm" name="fileNm" value="" />
</form>

<script>

	var currentPageNo = 1;
	var startFmtDate;
	var offset;
	var dataorexcel = 'data';
	var moveScroll;
	
	$(document.body).ready(function () { 	
		loadingTextChange();
		searchRealTimeLogList();
		bindEvent();
		
		// 스크롤바 이동하기 위한 설정
		offset = $('#realTimeLogMainDiv').offset();  
	});
	
	function loadingTextChange() {
        if(dataorexcel == 'data') {
            $(".loading-text")[0].innerHTML = "데이터 로딩 중...";
        }else {
            $(".loading-text")[0].innerHTML = "엑셀 다운로드 중...";
        }
    }

    /*
     * 페이지 초기화
     * @param
     * @return
     */
    function pageInit() {
        //그리드 초기화
        drawGrid();
        
        // 콤보박스 초기화
        var params = [];
        params.push({"id" : "searchLevel"   , "clsCd" : "0013"}); //Level
        
        startFmtDate = (new Date()).getDate()
         
        requestCmmnCd(params);
    };
    
    /*
     * 이벤트 바인딩
     * @param
     * @return
     */
    function bindEvent(){

        //조회버튼 클릭 이벤트 처리
        $("#btnSearch").off().on("click",function(){
        	searchRealTimeLogList();
        });
        
        $('#startDeDiv').datetimepicker({
            format: 'YYYY-MM-DD'
          , defaultDate: (new Date()).setDate(startFmtDate)
        });

        $("#endDeDiv").datetimepicker({
            format: 'YYYY-MM-DD'
          , defaultDate: (new Date())
        });
        
        //엑셀다운로드
        $("#btnOutExport").off().on('click', function(){
            outExport();
        });
    }
    
    function makeSelectBoxRobot(robotList) {
    	var saveRobotName = $("#searchRobotName").val();
    	var template = '<option value="전체">전체</option>';
    	
    	//<option value=""></option>
    	for(var i=0; i<robotList.length; i++) {      		
    		template += '<option value=' + robotList[i].name + '>' + robotList[i].name + '</option>';
    	}
    	
    	$("#searchRobotName").html(template);  	
    	
    	if(saveRobotName != null && saveRobotName != "") {
    		$("#searchRobotName").val(saveRobotName).attr("selected", "selected");
    	}
    }
    
    /*
     * 그리드 초기화
     * @param
     * @return
     */
    function drawGrid(data){
        var params = new Array();
        
        if (data != null && data != undefined) {
            if (data.result != null && data.result.resultList != null) {
                params = data.result.resultList;
            }
            if (data.result != null && data.result.robotList != null) {
            	makeSelectBoxRobot(data.result.robotList);           	
            }
            drawPager("realTimeLogGridPager", data.result.paginationInfo, "searchRealTimeLogList");
        }
        
        $("#realTimeLogGrid").jsGrid({
              height : "auto"
            , width : "100%"
            , autoload: true
            , sorting : true
            , align : "left"
            , data : params
            , rowClick: function(args){
            	detailRealTimeLog(args.item);
            }
            , fields : [ 
            	  {name: "robotname"  , title : "로봇명"   , type : "text"  , width : 25, align : "left" }
                , {name: "processNm"  , title : "프로세스명"   , type : "text"  , width : 60, align : "left" }
                , {name: "occrrncDt"  , title : "발생시간"     , type : "text" , width : 30, align : "center"  }
                , {name: "levelNm"    , title : "LEVEL"     , type : "text"  , width : 15, align : "center"}
                , {name: "message"    , title : "Message"   , type : "text"  , width : 100, align : "left"}
            ]
        });
        
        // 로딩 끝
        $('.dimmed').css({ display: 'none' });
        $('.loading').css({ display: 'none' });
        $('.loading').removeClass('show');
    }
    
    function dateDiffDay() {
    	const date1 = $("#startDe").val();
        const startDateArr = date1.split('-');
        const startDate = new Date(startDateArr[0], startDateArr[1]-1, startDateArr[2]);
                
        const date2 = $("#endDe").val();
        const endDateArr = date2.split('-');
        const endDate = new Date(endDateArr[0], endDateArr[1]-1, endDateArr[2]);

        const elapsedMSec = startDate.getTime() - endDate.getTime();
        const elapsedDay = elapsedMSec / 1000 / 60 / 60 / 24; 
        
        var dateDiff = Math.abs(Math.ceil(elapsedDay));
        
        return dateDiff;
    }

    /*
     * 검색
     * @param 페이지번호
     * @return
     */
    function searchRealTimeLogList(pageNo) {
    	if($("#startDe").val() > $("#endDe").val()){
            alert('검색기간 시작일이 종료일보다 클 수 없습니다.');
            $("#startDe").val($.datepicker.formatDate('yy-mm-dd', new Date()));
        }
    	else if(dateDiffDay() >= 30) {
    		alert('기간 간격은 30일 이하로 설정해주세요.');
    	}
    	else {
    		dataorexcel = "data";
            loadingTextChange(); // 데이터 로딩 중
            
    		// 로딩 시작
            $('.dimmed').css({ display: 'block' });
            $('.loading').css({ display: 'block' });
            $('.loading').addClass('show');
            
            var url = '/mntrng/realtimelog/getRealTimeLogList';
            
            currentPageNo = 1;
            
            if (pageNo != null && pageNo != undefined && pageNo != "") {
                currentPageNo = pageNo;
            } 

            var param = {
                   searchMessage       : $("#searchMessage").val()
                 , searchProcessNm     : $("#searchProcessNm").val()
                 , searchLevel         : $("#searchLevel").val()
                  <c:if test="${paramJobKey != null && paramJobKey != ''}">
                   , paramJobKey         : "${paramJobKey}"
                  </c:if>
                , searchRobotName     : $("#searchRobotName").val()
                , startDe: $("#startDe").val().replace(/-/g, "")
                , endDe: $("#endDe").val().replace(/-/g, "")
                , currentPageNo       : currentPageNo
                , recordCountPerPage  : 100
                , pageSize            : 10
            };

            callAsyncAjax(url, param, "drawGrid");
    	}
    }
    
    // 실시간 로그 행 클릭
    function detailRealTimeLog(item) {
    	dataorexcel = "data";
        loadingTextChange(); // 데이터 로딩 중
        
        moveScroll = $(document).scrollTop();
     
        // 로딩 시작
        $('.dimmed').css({ display: 'block' });
        $('.loading').css({ display: 'block' });
        $('.loading').addClass('show');

        // 스크롤 이동
        $('html').animate({scrollTop : offset.top}, 5);
     
        appendDetailPopup("realTimeLogMainDiv", "/mntrng/realtimelog/realTimeLogDetailPop"); // 해당 시간대의 프로세스 모두 출력하는 PopUp 창
        
        detailcmpny = item.cmpnyNm;
        detailprocessNm = item.processNm;
        detailoccrrncDt = item.occrrncDt;
        detailmessage = item.message;
        detailrawmessage = item.rawmessage;
    }
    
    function getToday(){
        var date = new Date();
        var year = date.getFullYear();
        var month = ("0" + (1 + date.getMonth())).slice(-2);
        var day = ("0" + date.getDate()).slice(-2);
        return year + month + day;
    }
    
    //엑셀다운로드
    function outExport(){
    	if(dateDiffDay() != 0) {
    		alert("엑셀 다운로드는 하루치(특정 날짜)만 가능합니다.\n시작 날짜와 끝 날짜를 같게 해주세요.");
    		return false;
    	}
    	
        dataorexcel = "excel";
        loadingTextChange(); // 엑셀 다운로드 중
           
        var url = '/mntrng/realtimelog/outExportRealTimeLog';

        var param = {
        		  searchMessage       : $("#searchMessage").val()
                , searchProcessNm     : $("#searchProcessNm").val()
                , searchLevel         : $("#searchLevel").val()
                 <c:if test="${paramJobKey != null && paramJobKey != ''}">
                  , paramJobKey         : "${paramJobKey}"
                 </c:if>
               , searchRobotName     : $("#searchRobotName").val()
               , startDe : $("#startDe").val().replace(/-/g, "")
               , endDe : $("#endDe").val().replace(/-/g, "")
        	   , excelDownload : 'Y'
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
            if (data.result != null && data.result.isDownload != null) {
                if(data.result.isDownload == false) {
                	alert("날짜 조회 기간을 더 짧게 조정하세요.\n다운로드할 행의 개수가 너무 많습니다.\n다운로드할 수 있는 행의 개수는 최대 10,000개입니다.");
                }
                
                $('.dimmed').css({ display: 'none' });
                $('.loading').css({ display: 'none' });
                $('.loading').removeClass('show');
                
                return false;
            }   
        }
    	
    	
        $("#fileNo").val(data.result.fileNo);
        $("#fileNm").val(getToday() + "_실시간로그");
        var frmData = document.downloadFormExel;
        frmData.action = "/file/downloadExport"; 
        frmData.submit();
        
        $('.dimmed').css({ display: 'none' });
        $('.loading').css({ display: 'none' });
        $('.loading').removeClass('show');
    }

    /*
     * popup창 닫기
     * @param
     * @return
     */
    function closePop() {
    	// 스크롤 이동
        $('html').animate({scrollTop : moveScroll}, 5);
        $(".over").remove();      
    }
</script>