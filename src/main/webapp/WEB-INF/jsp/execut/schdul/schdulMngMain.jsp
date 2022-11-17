<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div id="triggerMainDiv" class="container-fluid wrap">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <form id="searchForm" name="searchForm" class="form-inline">
                        <div class="form-group col-md-10">
                          <label for="name" class="col-sm-4 col-form-label">트리거명</label>
                          <div class="col-sm-8">
                              <input type="text" class="form-control" id="name">
                          </div>
                        </div>
                        <div class="col-md-2">
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
                <div class="card-header">
                    <c:choose>
                        <c:when test="${txScreenAuthor != null}">
                            <c:choose>
                                <c:when test="${txScreenAuthor.wrtngAuthor eq 'Y'}">
                                    <button type="button" id="btnReg" class="btn btn-info float-right">등록</button>
                                </c:when>
                                <c:otherwise>
                                    <div style="height:30px;"></div>
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                            <div style="height:30px;"></div>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="card-body">
                    <div id="triggerGrid"></div>
                    <div id="triggerGridPager" class="portal-pager"></div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>

    /*
     * 페이지 초기화
     * @param
     * @return
     */
    function pageInit() {
        drawGrid();
    };
    
    /*
     * 이벤트 바인딩
     * @param
     * @return
     */
    function bindEvent(){
        
        //조회버튼 클릭 이벤트
        $("#btnSearch").on("click",function(){
            searchTriggerList();
        });
        
        //등록버튼 클릭 이벤트
        $("#btnReg").on("click",function(){
            appendDetailPopup("triggerMainDiv", "/resrce/trigger/triggerRegisterPop");
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
            params = data.result.resultList;
            drawPager("triggerGridPager", data.result.paginationInfo, "searchTriggerList");
        }
        
        $("#triggerGrid").jsGrid({
            height : "auto"
            , width : "100%"
            , autoload: true
            , sorting : true
            , align : "center"
            , data : params
            , fields : [
                  {name: "id"                  , title : "아이디"           , type : "text"   , width : 0 , visible : false}
                , {name: "name"                , title : "이름"             , type : "text"   , width : 80}
                , {name: "processName"         , title : "프로세스"          , type : "text"   , width : 80}
                , {name: "environmentName"     , title : "환경"             , type : "text"   , width : 100}
                , {name: "typeName"            , title : "형식"             , type : "text"   , width : 40}
                , {name: "cronDetail"          , title : "트리거 세부 정보"     , type : "text"   , width : 80}
                , {name: "jobPriorityName"     , title : "작업우선순위"       , type : "text"   , width : 60}
                , {name: "nextOccurrence"      , title : "다음 런타임"        , type : "text"   , width : 60}
            ]
        });
        
    }
    
    /*
     * 검색
     * @param
     * @return
     */
    function searchTriggerList(pageNo) {
        var url = '/resrce/trigger/getTriggerList';
        var currentPageNo = 1;
        if (pageNo != null && pageNo != undefined && pageNo != "") {
            currentPageNo = pageNo;
        }
        var param = {
            name: $("#name").val(),
            currentPageNo:currentPageNo,
            recordCountPerPage:10,
            pageSize:10
        };
        callAsyncAjax(url, param, "drawGrid");
    }

    /*
     * 상세페이지 pop
     * @param
     * @return
     */
    function popupTriggerDetail(id) {
        appendDetailPopup("triggerMainDiv", "/resrce/trigger/triggerDetailPagePop");
        getRobotDetail("/resrce/trigger/getTriggerDetail", id);      
    };
    
    /*
     * 로봇 정보 상세 조회
     * @param
     * @return
     */
    function getTriggerDetail(url, id) {
        var param = {"triggerId" : id};
        callAsyncAjax(url, param, "printTriggerDetail");
    }
    
    /*
     * 상세 페이지 데이터 출력
     * @param
     * @return
     */
    function printTriggerDetail(data) {

        var robotValue = data.result;
        var resultDeviceId          = robotValue.deviceId;
        var resultDeviceName        = robotValue.deviceName;
        var resultName              = robotValue.name;
        var resultRobotDescription  = robotValue.robotDescription;
        var resultRobotId           = robotValue.robotId;
        var resultType              = robotValue.type;
        var resultUserName          = robotValue.userName;
        
        $("#deviceId").val(resultDeviceId);
        $("#deviceName").val(resultDeviceName);
        $("#robotName").val(resultName);
        $("#robotDescription").val (resultRobotDescription);
        $("#robotId").val(resultRobotId);
        $("#robotType").val(resultType);
        $("#userName").val(resultUserName);
    }

    /*
     * popup창 닫기
     * @param
     * @return
     */
    function closePOP(){
        $(".over").remove();
    }
    
</script>
