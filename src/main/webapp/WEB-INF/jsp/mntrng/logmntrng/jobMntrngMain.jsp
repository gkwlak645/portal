<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div id="jobMainDiv" class="container-fluid wrap">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <form class="form-inline">
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
                        <div class="form-group col-md-5 py-sm-2" style="margin: 0.3rem 0 0.3rem 0;">
                          <label for="usr" class="col-sm-2 col-form-label">우선순위</label>
                          <div class="col-sm-10">
                              <select id="cmbJobPriority" class="form-control" style="width:60%;max-width:200px;">
                                  <option value="">- 선택 -</option>
                              </select>
                          </div>
                        </div>
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

<script>

    /*
     * 페이지 초기화
     * @param
     * @return
     */
    function pageInit() {

    	//그리드 초기화
        drawGrid();

        var params = [];
        params.push({"id" : "cmbState", "clsCd" : "0015"});
        params.push({"id" : "cmbJobPriority", "clsCd" : "0010"});
        params.push({"id" : "cmbSource", "clsCd" : "0016"});
        requestCmmnCd(params);
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
          , defaultDate: (new Date()).setDate((new Date()).getDate() -7)
        });
        
        $("#endDeDiv").datetimepicker({
            format: 'YYYY-MM-DD'
          , defaultDate: (new Date())
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
            drawPager("jobGridPager", data.result.paginationInfo, "searchJobList");
        }

        $("#jobGrid").jsGrid({
              height : "auto"
            , width : "100%"
            , autoload: true
            , sorting : true
            , align : "center"
            , data : params
            , rowClick: function(arg){
                popupDetail(arg.item.id);
            }
            , fields : [
                  {name: "id"               , title : "아이디"         , type : "text"   , width : 0 , visible : false}
                , {name: "processName"      , title : "프로세스"        , type : "text"   , width : 100}
                , {name: "robotName"        , title : "로봇"           , type : "text"   , width : 80}
                , {name: "userName"         , title : "사용자"          , type : "text"   , width : 150}
                , {name: "machineName"      , title : "머신"           , type : "text"   , width : 100}
                , {name: "environmentName"  , title : "환경"          , type : "text"   , width : 100}
                , {name: "typeName"         , title : "형식"          , type : "text"   , width : 80}
                , {name: "stateName"        , title : "상태"          , type : "text"   , width : 80}
                , {name: "jobPriorityName"  , title : "우선순위"        , type : "text"   , width : 80}
                , {name: "startTimeDc"      , title : "시작됨"         , type : "text"   , width : 80}
                , {name: "endTimeDc"        , title : "종료됨"         , type : "text"   , width : 80}
                , {name: "sourceName"       , title : "소스"         , type : "text"   , width : 80}
            ]
        });
        
    }
    
    /*
     * 검색
     * @param 페이지번호
     * @return
     */
    function searchJobList(pageNo) {

        var url = '/mntrng/jobmntrng/getJobList';
        var currentPageNo = 1;
        if (pageNo != null && pageNo != undefined && pageNo != "") {
            currentPageNo = pageNo;
        }

        var param = {
            startDe: $("#startDe").val().replace(/-/g, ""),
            endDe: $("#endDe").val().replace(/-/g, ""),
            state: $("#cmbState").val(),
            jobPriority: $("#cmbJobPriority").val(),
            source: $("#cmbSource").val(),
            currentPageNo:currentPageNo,
            recordCountPerPage:10,
            pageSize:10
        };
        
        callAsyncAjax(url, param, "drawGrid");
    }
    
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
