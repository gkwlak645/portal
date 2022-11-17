<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="container-fluid wrap">
    <div class="row">
        <div class="col-md-12" alt="모니터링 >로그">
            <div class="card">
                <div class="card-header">
                    <form class="form-inline py-sm-2">
                        <div class="form-group col-md-7  py-sm-2" >
                          <label for="usr" class="col-form-label" style="width:70px; margin:0 10px 0 5px;">기간</label>
                          <div class="col-sm-4 float-left" style="min-width: 134px;"> 
                              <div class="input-group date" id="startDeDiv" data-target-input="nearest"style="min-width:130px;margin: 0 0 2px 0;">
                                  <input type="text" id="startDe" name="startDe" class="form-control datetimepicker-input" data-target="#startDeDiv"/>
                                  <div class="input-group-append" data-target="#startDeDiv" data-toggle="datetimepicker">
                                      <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                  </div>
                              </div>
                          </div>
                          <div class="col-sm-4  float-left" style="min-width: 134px;">
                              <div class="input-group date" id="endDeDiv" data-target-input="nearest"style="min-width:130px;margin: 0 0 2px 0;">
                                  <input type="text" id="endDe" name="endDe" class="form-control datetimepicker-input" data-target="#endDeDiv"/>
                                  <div class="input-group-append" data-target="#endDeDiv" data-toggle="datetimepicker">
                                      <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                  </div>
                              </div>
                          </div>
                        </div>
                        <div class="form-group col-md-4 py-sm-2" style="margin: 0.5rem 0.1rem 0.5rem 0.1rem;min-width:320px;">
                            <label for="usr" class="col-form-label" style="width:70px; margin:0 10px 0 5px;">디바이스</label>
                            <div>
                                <div class="form-group row">
                                    <input type="text" class="form-control" id="deviceName" name="deviceName" style="width: 70%;">
                                </div>
                            </div>
                        </div>
                        <div class="form-group col-md-7  py-sm-2"style="margin: 0.5rem 0.1rem 0.5rem 0.1rem;" >
                            <label for="usr" class="col-form-label" style="width:70px; margin:0 10px 0 5px;">프로세스</label>
                            <div class="col-sm-4 float-left" style="min-width: 134px;">
                              <input type="hidden" id="gwpwrUserId" name="gwpwrUserId">
                              <input type="text" class="form-control float-left" id="processName" name="processName" />
                              <div id="divSearchUser" class="modal fade" tabindex="-1" role="dialog"></div>
                              <div class="col-sm-8">
                                  <select id="cmpnyCd" class="form-control">
                                      <option value=""></option>
                                  </select>
                              </div>
                              <button type="button" class="btn btn-outline-primary float-left" id="btnSearchUser">사원 검색</button>
                              <button type="button" class="btn btn-outline-primary float-left" id="btnSearchDept">부서 검색</button>
                          </div>
                        </div>
                        
                        <div class="form-group col-md-4 py-sm-2" style="margin: 0.5rem 0.1rem 0.5rem 0.1rem;">
                            <label for="usr" class="col-form-label" style="width:70px; margin:0 10px 0 5px;" >사용자</label>
                             <div class="col-sm-4 float-left" style="min-width: 134px;">
                              <input type="text" class="form-control" id="windowsIdentity" name="windowsIdentity"><button type="button" id="btnSearch" class="btn btn-info  float-left">조회</button>
                        
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
                    <div id="logGrid"></div>
                    <div id="logGridPager" class="portal-pager"></div>
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
       params.push({"id" : "cmpnyCd", "clsCd" : "0024"});    //회사
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
        	searchLogList();
        });
        
        $('#startDeDiv').datetimepicker({
            format: 'YYYY-MM-DD'
          , defaultDate: (new Date()).setDate((new Date()).getDate() -7)
        });
        
        $("#endDeDiv").datetimepicker({
            format: 'YYYY-MM-DD'
          , defaultDate: (new Date())
        });
        
        $("#btnSearchUser").on("click",function(){
            openGwpwrUserPopup("divSearchUser", "callbackSearchUser");
        });
        
        $("#btnSearchDept").on("click",function(){
            openGwpwrDeptPopup("divSearchUser", "callbackSearchDept");
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
            drawPager("logGridPager", data.result.paginationInfo, "searchLogList");
        }
        $("#logGrid").jsGrid({
              height : "auto"
            , width : "100%"
            , autoload: true
            , sorting : true
            , align : "center"
            , data : params
            , fields : [
                  {name: "id"               , title : "아이디"         , type : "text"   , width : 0 , visible : false}
                , {name: "timeStamp"        , title : "시간"          , type : "text"   , width : 100}
                , {name: "levelName"        , title : "레벨"          , type : "text"   , width : 40}
                , {name: "processName"      , title : "프로세스"       , type : "text"   , width : 80}
                , {name: "deviceName"       , title : "머신"          , type : "text"   , width : 80}
                , {name: "windowsIdentity"  , title : "사용자"         , type : "text"   , width : 150}
                , {name: "message"          , title : "메시지"         , type : "text"   , width : 250}
            ]
        });
        
    }
    
    /*
     * 검색
     * @param 페이지번호
     * @return
     */
    function searchLogList(pageNo) {

        var url = '/mntrng/logmntrng/getLogList';
        var currentPageNo = 1;
        if (pageNo != null && pageNo != undefined && pageNo != "") {
            currentPageNo = pageNo;
        }

        var param = {
            startDe: $("#startDe").val().replace(/-/g, ""),
            endDe: $("#endDe").val().replace(/-/g, ""),
            deviceName: $("#deviceName").val(),
            processName: $("#processName").val(),
            windowsIdentity: $("#windowsIdentity").val(),
            currentPageNo:currentPageNo,
            recordCountPerPage:10,
            pageSize:10
        };
        callAsyncAjax(url, param, "drawGrid");
    }
    
    /*
     * 사원검색 콜백 함수
     * @param
     * @return
     */
    function callbackSearchUser(data) {
    	$("#gwpwrUserId").val(data.gwpwrId);
    	$("#processName").val(data.userNm);
    }
    
    /*
     * 부서검색 콜백 함수
     * @param
     * @return
     */
    function callbackSearchDept(data) {
        $("#processName").val(data.deptNm);
    }

</script>
