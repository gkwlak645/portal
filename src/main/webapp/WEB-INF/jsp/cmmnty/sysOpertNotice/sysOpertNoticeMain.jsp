<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

                    <div id="mainDiv" class="container-fluid wrap">
                        <div class="row" alt="커뮤니티 >시스템작업공지메인">
                            <div class="col-md-12">
                                <div class="card">
                                    <div class="card-header">
                                        <form id="searchForm" name="searchForm" class="form-inline">
                                            <div class="form-group col-md-12">
                                                  <div class="form-group col-md-8">                                               
                                                  <label for="usr" class="col-form-label col-sm-2">등록일</label>                                                
                                                  <div class="col-sm-3"> 
                                                      <div class="input-group date" id="searchStartDeDiv" data-target-input="nearest" style="min-width:124px;margin: 0 0 0 3px;">
                                                          <input type="text" id="searchStartDe" name="startDe" class="form-control datetimepicker-input" data-target="#startDeDiv"/>
                                                          <div class="input-group-append" data-target="#startDeDiv" data-toggle="datetimepicker">
                                                              <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                                          </div>
                                                      </div>
                                                  </div>
                                                  
                                                  <div class="col-sm-3">
                                                      <div class="input-group date" id="searchEndDeDiv" data-target-input="nearest" style="min-width:124px;margin: 0 0 0 3px;">
                                                          <input type="text" id="searchEndDe" name="endDe" class="form-control datetimepicker-input"  data-target="#endDeDiv"/>
                                                          <div class="input-group-append" data-target="#endDeDiv" data-toggle="datetimepicker">
                                                              <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                                          </div>
                                                      </div>
                                                  </div>
                                                  
                                                  <div class="form-group col-sm-2 float-right">
                                                      <button type="button" id="btnSearch" class="btn btn-info float-right">조회</button>
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
<c:if test="${txScreenAuthor.wrtngAuthor eq 'Y'}">
                                            <button type="button" id="btnSave" class="btn btn-primary float-right" style="margin: 5px 0 15px 2px;">등록</button>
</c:if>
                                            <div id="sysOpertNoticeGrid"></div>
                                            <div id="sysOpertNoticeGridPager" class="portal-pager"></div>    
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <script>

//일일미조치_오류_일련번호
var lc_currentPageNo = 1;

$(document.body).ready(function () {
	drawGrid();
	searchList();
});

    /*
     * 페이지 초기화
     * @param
     * @return
     */
    function pageInit() {
    	
    	//메인에서 선택시
    	if("${sonSn}" != null && "${sonSn}" != ""){
            var params = {sonSn: "${sonSn}"};
            getSysOpertNoticeDetailPopGetData(params);
        }
    };
    
    
    function bindEvent(){
    	
    	
    	//감섹영역 > 등록일자 > 시작일 
        $('#searchStartDeDiv').datetimepicker(
            {
                format: 'YYYY-MM-DD'
                , defaultDate: getMonthGapDate(-1)
            }
        );
        
        //감섹영역 > 등록일자 > 종료일
        $("#searchEndDeDiv").datetimepicker(
            {
                format: 'YYYY-MM-DD'
                , defaultDate: (new Date())
            }
        );
        
        $("#btnSave").on('click', function(){
            unManagtErrorReg();
        });
        
      //조회버튼 클릭 이벤트 처리
        $("#btnSearch").on("click",function(){
            searchList();
        });
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
            drawPager("sysOpertNoticeGridPager", data.result.paginationInfo, "searchList");
        }

        $("#sysOpertNoticeGrid").jsGrid({
              height : "auto"
            , width : "100%"
            , autoload: true
            , sorting : true
            , align : "center"
            , data : params
            , rowClick: function(arg){
            	var params = {sonSn: arg.item.sonSn};
            	getSysOpertNoticeDetailPopGetData(params);
            }
            , fields : [
                  {name: "sj"         , title : "공지제목"  , type : "text"  , width : 50, align : "center"}
                , {name: "cn"         , title : "공지내용"  , type : "text", cellRenderer: function(item, value){
                	return $("<td>").append(item.length > 50 ? item.substring(0, 50) + "..." : item)
                } }
                , {name: "cntcSysNm"  , title : "대상시스템" , type : "text"    , width : 50, align : "center"}
                , {name: "regDt"      , title : "등록일"    , type : "text"    , width : 30, align : "center"}
            ]
        });
    }
    
    function searchList(pageNo) {
        if($("#searchStartDe").val() > $("#searchEndDe").val()){
            alert('검색기간 시작일이 종료일보다 클 수 없습니다.');
        }else{
            var url = '/cmmnty/sysOpertNotice/selectSysOpertNoticeList';
            if (pageNo != null && pageNo != undefined && pageNo != "") {
                lc_currentPageNo = pageNo;
            }

            var param = {
            	searchStartDe           : $("#searchStartDe").val().replace(/-/g, "")
                , searchEndDe           : $("#searchEndDe").val().replace(/-/g, "")
                , currentPageNo         : lc_currentPageNo
                , recordCountPerPage    :   10
                , pageSize              :   10
            }; 

            callAsyncAjax(url, param, "drawGrid");
        }
    }
    
    /*
     * 상세: getDATA
     * @param
     * @return
     */
    function getSysOpertNoticeDetailPopGetData(params) {
        callAsyncAjax("/cmmnty/sysOpertNotice/getSysOpertNoticeDetailPopGetData", params, "getSysOpertNoticeDetailPopGetDataCallback");
    }
    
    /*
     * 상세: Layout
     * @param
     * @return
     */
    function getSysOpertNoticeDetailPopGetDataCallback(data) {
        //데이터 존제 유무 확인
        if(data.result == null){
            alert("존재하지 않는 과제개발 입니다.");
            return false;
        }
        
        //데이터 존재 시 호출
        appendDetailPopup("mainDiv", "/cmmnty/sysOpertNotice/sysOpertNoticeDetailPop?registerId=" + data.result.registerId, "sysOpertNoticeDetailPopDrawData", data);
    }
    
    
    /*
     * 등록페이지 pop
     * @param
     * @return
     */
    function unManagtErrorReg() {
        appendDetailPopup("mainDiv", "/cmmnty/sysOpertNotice/sysOpertNoticeRegPop");
    };
    
    /*
     * popup창 닫기
     * @param
     * @return
     */
     function mainPopClose() {
         $(".over").remove();
     }
    
     /*
      * popup창 닫기 Type2
      * @param
      * @return
      */
     function mainPopCloseReload() {
         $(".over").remove();
         searchList();
     }

</script>