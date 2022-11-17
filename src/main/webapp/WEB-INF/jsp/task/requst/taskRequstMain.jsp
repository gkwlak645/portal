<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div id="taskRequstMainDiv" class="container-fluid wrap">
    <div class="row">
        <div class="col-md-12" alt="과제 >과제요청">
            <div class="card">
                <div class="card-header">
                    <form class="form-inline py-sm-2">
                        <div class="form-group col-md-7  py-sm-2">
                          <label for="usr" class="col-form-label" style="width:70px; margin:0 10px 0 5px;">기간</label>
                          <div class="col-sm-4 float-left" style="min-width: 134px;"> 
                              <div class="input-group date" id="startDeDiv" data-target-input="nearest" style="min-width:130px;margin: 0 0 2px 0;">
                                  <input type="text" id="startDe" name="startDe" class="form-control datetimepicker-input" data-target="#startDeDiv"/>
                                  <div class="input-group-append" data-target="#startDeDiv" data-toggle="datetimepicker">
                                      <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                  </div>
                              </div>
                          </div>
                          <div class="col-sm-4  float-left" style="min-width: 134px;">
                              <div class="input-group date" id="endDeDiv" data-target-input="nearest" style="min-width:130px;margin: 0 0 2px 0;">
                                  <input type="text" id="endDe" name="endDe" class="form-control datetimepicker-input" data-target="#endDeDiv"/>
                                  <div class="input-group-append" data-target="#endDeDiv" data-toggle="datetimepicker">
                                      <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                  </div>
                              </div>
                          </div>
                        </div>
                        <div class="form-group col-md-4 py-sm-2" style="margin: 0.5rem 0.1rem 0.5rem 0.1rem;min-width:500px;">
                            <label for="usr" class="col-form-label" style="width:70px; margin:0 10px 0 5px;">상태</label>
                            <div class="col-sm-8" >
                                <div class="form-group row">
                                    <div class="form-check-inline">
                                        <input class="custom-checkbox" style="width:18px;height:18px;"  type="checkbox" id="rdoSttus1" value="C09" />
                                        <label class="form-check-label">요청</label>
                                    </div>
                                    <div class="form-check-inline">
                                        <input class="custom-checkbox" style="width:18px;height:18px;"  type="checkbox" id="rdoSttus2" value="C10" />
                                        <label class="form-check-label">접수</label>
                                    </div>
                                    <div class="form-check-inline">
                                        <input class="custom-checkbox" style="width:18px;height:18px;"  type="checkbox" id="rdoSttus3" value="C03" />
                                        <label class="form-check-label">반려</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="form-group col-md-12 py-sm-2" style="margin: 0.25rem 0.1rem 0.3rem 0.1rem;min-width: 460px;" >
                          <label for="usr" class="col-form-label" style="width:70px; margin:0 10px 0 5px;">구분</label>
                          <div> 
                              <div class="col-sm-4 float-left" style="width: 74%;margin: 0 0 2px 0;">
                                    <select id="cmbSearchIem" name="searchIem"  class="form-control">
                                      <option value="1">과제명</option>
                                      <option value="2">담당부서</option>
                                      <option value="3">요청자</option>
                                    </select>
                              </div>
                          </div>
                          <div class="col-sm-7 float-left" >
                              <div style="margin: 0 0 2px 0;">
                                  <input type="text" class="form-control float-left" id="txtSearchKwrd" name="searchKwrd" style="width:56%;" value="" /><button type="button" id="btnSearch" class="btn btn-info  float-left">조회</button>
                              </div>
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
                    <c:choose>
                        <c:when test="${txScreenAuthor != null}">
                            <c:choose>
                                <c:when test="${txScreenAuthor.wrtngAuthor eq 'Y'}">
                                    <button type="button" id="btnReg" class="btn btn-primary float-right" style="margin:5px 0 15px 2px;">등록</button>
                                </c:when>
                                <c:otherwise>
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                        </c:otherwise>
                    </c:choose>
                
                
                    <div id="taskRequstGrid"></div>
                    <div id="taskRequstGridPager" class="portal-pager"></div>
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
        
        //그리드 조회
        searchTaskRequstList();
    };
    
    /*
     * 이벤트 바인딩
     * @param
     * @return
     */
    function bindEvent(){

        //조회버튼 클릭 이벤트 처리
        $("#btnSearch").on("click",function(e){
        	searchTaskRequstList();
        });
        
        $('#startDeDiv').datetimepicker({
            format: 'YYYY-MM-DD'
          , defaultDate: getMonthGapDate(-3)
        });
        
        $("#endDeDiv").datetimepicker({
            format: 'YYYY-MM-DD'
          , defaultDate: (new Date())
        });

        //등록버튼 클릭 이벤트
        $("#btnReg").on("click",function(){
            appendDetailPopup("taskRequstMainDiv", "/task/requst/taskRequstRegisterPop");
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
            drawPager("taskRequstGridPager", data.result.paginationInfo, "searchTaskRequstList");
        }
        $("#taskRequstGrid").jsGrid({
              height : "auto"
            , width : "100%"
            , autoload: true
            , sorting : true
            , align : "center"
            , data : params
            , rowClick: function(arg){
                popupTaskRequstDetail(arg.item.taskNo);
            }
            , fields : [
                  {name: "taskNo"         , title : "과제번호" , type : "text" , width : 0 , visible : false}
                , {name: "taskNm"         , title : "과제명"   , type : "text" , width : 150}
                , {name: "chrgDeptNm"     , title : "요청부서"  , type : "text" , width : 80, align : "center"}
                , {name: "chargerUserNm"  , title : "요청자"   , type : "text" , width : 80, align : "center"}
                , {name: "requstDe"       , title : "요청일"   , type : "text" , width : 80, align : "center", itemTemplate : function(value) {return hyphenationDe(value)}}
                , {name: "sttusNm"        , title : "진행상태"  , type : "text" , width : 80, align : "center"}
            ]
        });
        
    }
    
    /*
     * 검색
     * @param 페이지번호
     * @return
     */
    function searchTaskRequstList(pageNo) {
    	
    	//조회조건 유효성 검사
    	if (!validateSearchConditions()) {
    		return;
    	}

        var url = '/task/requst/getTaskRequstList';
        var currentPageNo = 1;
        if (pageNo != null && pageNo != undefined && pageNo != "") {
            currentPageNo = pageNo;
        }

        var sttusArray = [];
        $("input[id^=rdoSttus]").each(function(idx, item) {
            if ($(this).is(":checked")) {
            	sttusArray.push({sttus:$(this).val()});
            }
        });

        var param = {
            startDe: $("#startDe").val().replace(/-/g, ""),
            endDe: $("#endDe").val().replace(/-/g, ""),
            searchIem: $("#cmbSearchIem").val(),
            searchKwrd: $("#txtSearchKwrd").val(),
            searchSttusList: sttusArray,
            currentPageNo:currentPageNo,
            recordCountPerPage:10,
            pageSize:10
        };
        
        callAsyncAjax(url, param, "drawGrid");
    }
    
    /*
     * 조회조건 유효성 검사
     * @param
     * @return
     */
    function validateSearchConditions() {
    	
    	if ($("#startDe").val() != "" && $("#endDe").val() != "") {
    		if (Number(unhyphenationDe($("#startDe").val())) > Number(unhyphenationDe($("#endDe").val()))) {
    			alert("조회기간의 시작일과 종료일을 확인하세요.");
    			$("#startDe").focus();
    			return false;
    		}
    	}
    	
    	return true;
    }
    
    /*
     * 과제요청 상세 화면 열기
     * @param
     * @return
     */
    function popupTaskRequstDetail(taskNo) {
        appendDetailPopup("taskRequstMainDiv", "/task/requst/taskRequstDetailPop");
        getTaskRequstDetail("/task/requst/getTaskRequstDetail", taskNo);   
    }
    
    /*
     * 로봇 정보 상세 조회
     * @param
     * @return
     */
    function getTaskRequstDetail(url, taskNo) {
        var param = {"taskNo" : taskNo};
        callAsyncAjax(url, param, "printTaskRequstDetail");
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
