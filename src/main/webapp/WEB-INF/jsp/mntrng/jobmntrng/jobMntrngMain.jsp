<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div id="jobMainDiv" class="container-fluid wrap">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <form class="form-inline">
                        
                        <div class="form-group col-md-5 py-sm-2">
                          <label for="schCmpny" class="col-sm-2 col-form-label">회사</label>
                          <div class="col-sm-10">
                              <select id="schCmpny" class="form-control" style="width:60%;max-width:200px;">
                                  <option value=""></option>
                              </select>
                          </div>
                        </div>
                        <div class="form-group col-md-5 py-sm-2" style="margin: 0.3rem 0 0.3rem 0;">
                          <label for="usr" class="col-sm-2 col-form-label">기간</label>
                          <div class="col-sm-4">
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
                          </div>
                        </div>
                        <div class="form-group col-md-5 py-sm-2" style="margin: 0.3rem 0 0.3rem 0;">
                          <label for="usr" class="col-sm-2 col-form-label">상태</label>
                          <div class="col-sm-10">
                              <select id="cmbState" class="form-control" style="width:60%;max-width:200px;">
                                  <option value="">- 선택 -</option>
                              </select>
                          </div>
                        </div>
                        <!-- <div class="form-group col-md-5 py-sm-2" style="margin: 0.3rem 0 0.3rem 0;">
                          <label for="usr" class="col-sm-2 col-form-label">우선순위</label>
                          <div class="col-sm-10">
                              <select id="cmbJobPriority" class="form-control" style="width:60%;max-width:200px;">
                                  <option value="">- 선택 -</option>
                              </select>
                          </div>
                        </div> -->
                        <div class="form-group col-md-5 py-sm-2" style="margin: 0.3rem 0 0.3rem 0;">
                          <label for="usr" class="col-sm-2 col-form-label">소스</label>
                          <div class="col-sm-10">
                              <select id="cmbSource" class="form-control" style="width:60%;max-width:200px;">
                                  <option value="">- 선택 -</option>
                              </select>
                          </div>
                        </div>
                        <div class="col-md-2 float-right" style="margin-bottom: 10px">
                            <button type="button" id="btnSearch" class="btn btn-info float-right">조회</button>
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
                    <div id="jobGrid"></div>
                    <div id="jobGridPager" class="portal-pager"style="text-align:center"></div>
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

    /*
     * 페이지 초기화
     * @param
     * @return
     */
    function pageInit() {

        var params = [];
        if("${txScreenAuthor.untenantAuthor}" == 'Y'){
            params.push({"id" : "schCmpny", "clsCd" : "0024"});    //회사
        }else{
            params.push({"id" : "schCmpny", "clsCd" : "0024", "disable" : "Y", "selectValue": "${sessionUserInfo.txCmpnyCd}"});    //회사
        }
        
        params.push({"id" : "cmbState", "clsCd" : "0015"});
        //params.push({"id" : "cmbJobPriority", "clsCd" : "0010"});
        params.push({"id" : "cmbSource", "clsCd" : "0016"});
        requestCmmnCd(params);
        
        
        if("${mainInitAt}" != null && "${mainInitAt}" != ""){
        	startFmtDate = (new Date()).getDate()
        }else{
        	startFmtDate = (new Date()).getDate() -7
        }
        
        //그리드 초기화
        drawGrid();
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
        
        $('#startDeDiv').datetimepicker({
            format: 'YYYY-MM-DD'
          , defaultDate: (new Date()).setDate(startFmtDate)
        });
        
        $("#endDeDiv").datetimepicker({
            format: 'YYYY-MM-DD'
          , defaultDate: (new Date())
        });
        
        searchJobList();
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
            drawPager("jobGridPager", data.result.paginationInfo, "searchJobList");
        }
        
        var headerIcon = '<svg class="bi bi-arrow-clockwise" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">';
        headerIcon += '<path fill-rule="evenodd" d="M3.17 6.706a5 5 0 0 1 7.103-3.16.5.5 0 1 0 .454-.892A6 6 0 1 0 13.455 5.5a.5.5 0 0 0-.91.417 5 5 0 1 1-9.375.789z"/>';
        headerIcon += '<path fill-rule="evenodd" d="M8.147.146a.5.5 0 0 1 .707 0l2.5 2.5a.5.5 0 0 1 0 .708l-2.5 2.5a.5.5 0 1 1-.707-.708L10.293 3 8.147.854a.5.5 0 0 1 0-.708z"/>';
        headerIcon += '</svg>';

        $("#jobGrid").jsGrid({
              height : "auto"
            , width : "100%"
            , autoload: true
            , sorting : true
            , align : "left"
            , data : params
            , rowClick: function(arg){
                //popupDetail(arg.item.id);
            }
            , fields : [
                  {name: "id"               , title : "아이디"         , type : "text"   , width : 0 , visible : false}
                , {name: "cmpnyName"        , title : "회사"          , type : "text"   , width : 60}
                , {name: "processName"      , title : "프로세스"        , type : "text"   , width : 170}
                , {name: "robotName"        , title : "로봇"           , type : "text"   , width : 90}
                /* , {name: "userName"         , title : "사용자"          , type : "text"   , width : 150} */
                /* , {name: "machineName"      , title : "머신"           , type : "text"   , width : 100} */
                /* , {name: "environmentName"  , title : "환경"          , type : "text"   , width : 100} */
                /* , {name: "typeName"         , title : "형식"          , type : "text"   , width : 80} */
                , {name: "stateName"        , title : "상태"          , type : "text"   , width : 60  ,align : "left"}
                /* , {name: "jobPriorityName"  , title : "우선순위"        , type : "text"   , width : 80} */
                , {name: "startTimeDc"      , title : "시작됨"         , type : "text"   , width : 50  ,align : "left"}
                , {name: "endTimeDc"        , title : "종료됨"         , type : "text"   , width : 50  ,align : "left"}
                , {name: "sourceName"       , title : "소스"          , type : "text"   , width : 80 ,align : "left"}
                , {   
<%--                	
                    headerTemplate: function() {
                        return $(headerIcon).on("click", function(){searchJobList()});
                    }
--%>
						title : "중지"
                  , itemTemplate: function(value, item) {
                        var itemIcon = '';
                        //1 실행중, 0 보류중
                        if(item.stateCd == '1' || item.stateCd == '0'){
                        	itemIcon += '<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-x-circle" fill="currentColor" xmlns="http://www.w3.org/2000/svg">';
                            itemIcon += '<path fill-rule="evenodd" d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>';
                            itemIcon += '<path fill-rule="evenodd" d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"/>';     
                            itemIcon += '</svg>';	
                        } 
                        
                        return $(itemIcon).on("click", function(){
                        	if(confirm('선택한 작업을 종료하시겠습니까?')){
                        		stopJob(item.cmpnyCd,item.id);
                        	}
                        });
                    }
                  , align : 'center'
                  , width: 50
                  , sorting : false
                  }
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

        var url = '/mntrng/jobmntrng/getJobList';
        var currentPageNo = 1;
        /* if (pageNo != null && pageNo != undefined && pageNo != "" && typeof pageNo == Number) {
            currentPageNo = pageNo;
        } */
        
        if (pageNo != null && pageNo != undefined && pageNo != "") {
            currentPageNo = Number(pageNo);
        }
        
        
        var param = {
        	cmpnyCd: $("#schCmpny").val(),
            startDe: $("#startDe").val().replace(/-/g, ""),
            endDe: $("#endDe").val().replace(/-/g, ""),
            state: $("#cmbState").val(),
            jobPriority: $("#cmbJobPriority").val(),
            source: $("#cmbSource").val(),
            currentPageNo:currentPageNo,
            recordCountPerPage:100,
            pageSize:10
        }; 
        
        callAsyncAjax(url, param, "drawGrid");
        
        // 로딩 시작
        $('.dimmed').css({ display: 'block' });
        $('.loading').css({ display: 'block' });
        $('.loading').addClass('show');
    }
    
    
    /*
     * job 실행중지
     * @param 
     * @return
     */
    function stopJob(cmpnyCd,id) {
    	 var url = '/mntrng/jobmntrng/stopJob';
	       
	       var param = {"strategy":"2"};
	       
	       param.cmpnyCd         =   cmpnyCd
	       param.id              =   Number(id)
	
	       callSyncAjax(url, param, "searchJobList");
    };
    
    
    /*
     * 상세페이지 팝업
     * @param 
     * @return
     */
    function popupDetail(id) {

        //상세 페이지 div 생성
        appendDetailPopup("jobMainDiv", "/mntrng/jobmntrng/jobDetailPop");

        //상세 페이지 데이터 조회
        getDetailData(id);

    };
    

</script>
