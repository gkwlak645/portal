<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div id="SavingTimeIssueMntrngMainDiv" class="container-fluid wrap">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <form class="form-inline">
                        
                        <div class="form-group col-md-5 py-sm-2">
                          <label for="schCmpny" class="col-sm-3 col-form-label">회사</label>
                          <div class="col-sm-9">
                              <select id="schCmpny" class="form-control" style="width:60%;max-width:200px;">
                                  <option value=""></option>
                              </select>
                          </div>
                        </div>
                        <div class="form-group col-md-5 py-sm-2" style="margin: 0.3rem 0 0.3rem 0;">
                          <label for="usr" class="col-sm-3 col-form-label">기간</label>             
                          
                          <!-- <div class="col-sm-4">
                              <div class="input-group date" id="startDeDiv" data-target-input="nearest" style="min-width:130px;margin: 0 0 2px 0;">
                                  <input type="text" id="startDe" name="startDe" class="form-control datetimepicker-input" data-target="#startDeDiv"/>
                                  <div class="input-group-append" data-target="#startDeDiv" data-toggle="datetimepicker">
                                      <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                  </div>
                              </div>
                          </div>
                          <div class="col-sm-4">
                              <div class="input-group date" id="endDeDiv" data-target-input="nearest" style="min-width:130px;margin: 0 0 2px 0;">
                                  <input type="text" id="endDe" name="endDe" class="form-control datetimepicker-input" data-target="#endDeDiv"/>
                                  <div class="input-group-append" data-target="#endDeDiv" data-toggle="datetimepicker">
                                      <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                  </div>
                              </div>
                          </div> -->
                          
                          
                          <div class="cus_dataing">
                             <select id="searchYear" class="form-control cus_dataing-year"></select>
                             <label>년</label>
                             
                             <select id="searchMonth" class="form-control cus_dataing-month"></select>
                             <label>월</label>
                          </div>

                        </div>
                        <div class="form-group col-md-5 py-sm-2" style="margin: 0.3rem 0 0.3rem 0;">
                          <label for="usr" class="col-sm-3 col-form-label">프로세스 코드</label>
                          <div class="col-sm-9">
                              <input type="text" class="form-control float-left" value="" id="searchProcessCd" style="min-width: 160px;width:70%;" maxlength="6">
                          </div>
                        </div>
                        <div class="form-group col-md-5 py-sm-2" style="margin: 0.3rem 0 0.3rem 0;">
                          <label for="usr" class="col-sm-3 col-form-label">프로세스 명</label>
                          <div class="col-sm-9">
                              <input type="text" class="form-control float-left" value="" id="searchProcessNm" style="min-width: 160px;width:70%;">
                          </div>
                        </div>
                        <div class="col-md-2 float-right" style="margin-bottom: 10px">
                            <button type="button" id="btnSearch" class="btn btn-info float-right">검색</button>
                        </div>
                    </form> 
                    
                    
                    
                    
                    
                    
                    
                    <!-- <div>
                       <p>
                                                                    ※ 집계 기준</br>
                         1. Portal 기준 프로세스의 상태가 운영중일 때</br>
					     2. '실행주기'가 입력된 프로세스(과제관리 > 프로세스개발)</br>
						 3. '실행주기'와 관련하여 몇 회 수행되는지 입력된 프로세스</br>
						 4. 날짜 기준 : 한 달 전</br>
						 5. 운영 Orchestrator와 Portal이 서로 매핑된 프로세스</br>
						 6. 삭제된 프로세스는 제외</br>
                       </p>
                    </div> -->
                    
                    
                    
                    
                    
                    
                    
                </div>
            </div>
        </div>
    </div>
    
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-body">
                    <div id="dataGrid"></div>
                    <div id="dataGridPager" class="portal-pager"style="text-align:center"></div>
                </div>
            </div>
        </div>
    </div>
</div>


<!-- 로딩바  -->
<div class="dimmed" style="display:none"></div>
<div class="loading" style="display:none">
    <div class="loading-bar"><div></div><div></div><div></div><div></div></div>
    <span class="loading-text">데이터 로딩중...</span>
</div>
<script>

//검색조건 - 시작일자
var startFmtDate;
var processCd;
var processNm;
var expectExcCnt;
var realExcCnt;
var normalAt;
var succesCnt;
var resn;
var cmpnyCd;
var offset;

	$(document.body).ready(function () {            
		
		// 스크롤바 이동하기 위한 설정
        offset = $('#SavingTimeIssueMntrngMainDiv').offset(); 
		
        var params = [];
        if("${txScreenAuthor.untenantAuthor}" == 'Y'){
            params.push({"id" : "schCmpny", "clsCd" : "0024", "selectValue": "${sessionUserInfo.txCmpnyCd}"});    //회사
        }else{
            params.push({"id" : "schCmpny", "clsCd" : "0024", "disable" : "Y", "selectValue": "${sessionUserInfo.txCmpnyCd}"});    //회사
        }

        requestCmmnCd(params);
        
        //년도 정보 추가
        cmmn_makeYear("searchYear", 8);
        //월 정보 추가
        cmmn_makeMonth("searchMonth");
        
        var date = new Date();
        var oneMonthAgo = new Date(date.setMonth(date.getMonth() - 1)); // 한 달 전    

        // getMonth() -> 0 ~ 11이라서 +1로 세팅해야된다.
        $('#searchMonth').val(oneMonthAgo.getMonth() + 1).prop("selected",true);

        searchSavingTimeIssueMntrngList();
	});
    
    /*
     * 이벤트 바인딩
     * @param
     * @return
     */
    function bindEvent(){

        //조회버튼 클릭 이벤트 처리
        $("#btnSearch").on("click",function(){
        	searchSavingTimeIssueMntrngList();
        });
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
            drawPager("dataGridPager", data.result.paginationInfo, "searchSavingTimeIssueMntrngList");
        }

        $("#dataGrid").jsGrid({
              height : "auto"
            , width : "100%"
            , autoload: true
            , sorting : true
            , align : "center"
            , data : params
            , rowClick: function(arg){

            }
            , fields : [
                  {name: "cmpnyNm"        , title : "회사"             , type : "text"   , width : 50}
                , {name: "processCd"      , title : "프로세스 코드"       , type : "text"   , width : 50}
                , {name: "processNm"      , title : "프로세스 명"        , type : "text"   , width : 150}
                
                , {name: "processFreq"     , title : "실행 주기"        , type : "text"   , width : 50}
                , {name: "processExc"      , title : "회"               , type : "text"   , width : 30}             
                
                , {name: "expectExcCnt"   , title : "예상수행횟수(월)"       , type : "text"   , width : 50, align : "right"}
                , {name: "realExcCnt"     , title : "수행횟수"          , type : "text"   , width : 50, align : "right"}
                , {name: "succesCnt"      , title : "성공횟수"          , type : "text"   , width : 50, align : "right"}
                , {name: "failrCnt"       , title : "실패횟수"          , type : "text"   , width : 50, align : "right"}
                , {name: "succesRate"     , title : "성공률"            , type : "text"   , width : 50, align : "right"}
                , {name: "redcnTm"        , title : "예상절감시간(년간)"   , type : "text"   , width : 80, align : "right"}
                , {name: "achvRate"       , title : "달성률"           , type : "text"    , width : 50, align : "right"}
                , {name: "normalAt"       , title : "정상여부"          , type : "text"   , width : 50, 
                    itemTemplate: function(value, item) { 
                        // 정상 여부
                        if(Number(item.normalAt) == 1) { 
                            return "정상";
                        }
                        return "비정상";
                   }}
                , {name: "ETC___"       , title : "사유등록여부", align : "center", type : "text"   , width : 50, 
                	itemTemplate: function(args, item) {  
	                		if(Number(item.achvRate) == 100) {
	                            return "-"
	                        }
	                		
	                		// 등록 팝업창
	                		if(item.registerId == null || item.registerId == "") { 		 
                                return "<span onclick=\"savingTimeResnInsertOrUpdate('"
                                		+item.processCd+"', '"
                                		+item.processNm+"', '"
                                		+item.expectExcCnt+"', '"
                                		+item.realExcCnt+"', '"
                                		+item.succesCnt+"', '"
                                		+item.resn+"', 'true', '"
                                        +item.normalAt+"', '"
                                		+item.cmpnyCd+"')\">[미등록]</span>";
                            }
	                		
	                		// 수정 팝업 창
	                		return "<span onclick=\"savingTimeResnInsertOrUpdate('"
                            +item.processCd+"', '"
                            +item.processNm+"', '"
                            +item.expectExcCnt+"', '"
                            +item.realExcCnt+"', '"
                            +item.succesCnt+"', '"
                            +item.resn+"', 'false', '"
                            +item.normalAt+"', '"
                            +item.cmpnyCd+"')\">[등록]</span>";
                		}
                  }

                //, itemTemplate: function(value, item) { return "<span onclick =\"jobIdClick(this, " + item.id +")\">로그보기</span>"}
            ]
        });
        
        // 로딩 끝
        $('.dimmed').css({ display: 'none' });
        $('.loading').css({ display: 'none' });
        $('.loading').removeClass('show');
    }
    
    function getYYYYMM() {
    	var Month = $("#searchMonth").val() < 10 ? '0' + $("#searchMonth").val() : $("#searchMonth").val();
        var yyyymm = $("#searchYear").val() + Month;
        return yyyymm;
    }
    
    function savingTimeResnInsertOrUpdate(pcd, pnm, eec, rec, sec, res, ioru, nAt, ccd) {
    	processCd = pcd;
        processNm = pnm;
        expectExcCnt = eec;
        realExcCnt = rec;
        succesCnt = sec;
        resn = res;
        cmpnyCd = ccd;
        normalAt = nAt;
        yyyymm = getYYYYMM();
        
        if(yyyymm.length != 6) {
        	alert("날짜 형식이 잘못됐습니다.\nYYYYMM");
        	return false;
        }

        $('html').animate({scrollTop : offset.top}, 600);
        
        // 미등록
        if(ioru == 'true') {
            appendDetailPopup("SavingTimeIssueMntrngMainDiv", "/mntrng/savingTimeIssue/savingTimeIssueInsertDetailPop");
        }
        else {
        	// 등록
        	appendDetailPopup("SavingTimeIssueMntrngMainDiv", "/mntrng/savingTimeIssue/savingTimeIssueUpdateDetailPop");
            $("#resn").val(resn.replaceAll("<br>", "\r\n"));
        }
        
        $("#pcd").val(processCd);
        $("#pnm").val(processNm);
        $("#expectExcCnt").val(expectExcCnt);
        $("#realExcCnt").val(realExcCnt);
        $("#succesCnt").val(succesCnt);
        
        if(realExcCnt >= 1 && realExcCnt == succesCnt) {
            $("#normalAt").prop('disabled', false);
            $("#normalAt").prop('Enabled', true);
        }
    }
    
    /* // 사유 등록창
    function savingTimeResnInsert(pcd, eec, rec, sec, res, ccd) {
    	processCd = pcd;
    	expectExcCnt = eec;
    	realExcCnt = rec;
    	succesCnt = sec;
    	resn = res;
    	cmpnyCd = ccd;
    	
        $('html').animate({scrollTop : offset.top}, 600);
    	
    	appendDetailPopup("SavingTimeIssueMntrngMainDiv", "/mntrng/savingTimeIssue/savingTimeIssueInsertDetailPop");

    	yyyymm = getYYYYMM();

        $("#expectExcCnt").val(expectExcCnt);
        $("#realExcCnt").val(realExcCnt);
        $("#normalAt").val(normalAt);
        $("#succesCnt").val(succesCnt);
        
        if(realExcCnt >= 1 && realExcCnt == succesCnt) {
        	$("#normalAt").prop('disabled', false);
        	$("#normalAt").prop('Enabled', true);
        }
    }
    
    // 사유 수정창
    function savingTimeResnUpdate(pcd, eec, rec, sec, res, ccd){
    	processCd = pcd;
        expectExcCnt = eec;
        realExcCnt = rec;
        succesCnt = sec;
        resn = res;
        cmpnyCd = ccd;
        
        $('html').animate({scrollTop : offset.top}, 600);
    	
        appendDetailPopup("SavingTimeIssueMntrngMainDiv", "/mntrng/savingTimeIssue/savingTimeIssueUpdateDetailPop");
    
        $("#expectExcCnt").val(expectExcCnt);
        $("#realExcCnt").val(realExcCnt);
        $("#normalAt").val(normalAt);
        $("#succesCnt").val(succesCnt);
        $("#resn").val(resn);
    } */
    
    
    /*
     * 검색
     * @param 페이지번호
     * @return
     */
    function searchSavingTimeIssueMntrngList(pageNo) {
        var url = '/mntrng/savingTimeIssue/selectSavingTimeIssueList';
        var currentPageNo = 1;

        //재실행 성공시 msg alert 출력     
        if (pageNo != null && pageNo != undefined && pageNo != "") {
            currentPageNo = pageNo;
        } 
        
        var param = {
        	  cmpnyCd            : $("#schCmpny").val()
            , searchProcessCd    : $.trim($("#searchProcessCd").val())
            , searchProcessNm    : $.trim($("#searchProcessNm").val())
            , yyyymm             : $.trim(getYYYYMM())
            , currentPageNo      : currentPageNo
            , recordCountPerPage : 100
            , pageSize           : 10
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
        searchSavingTimeIssueMntrngList();
    }
    
</script>
