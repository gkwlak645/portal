<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div id="mainDiv" class="container-fluid wrap">
    <div class="row" alt="과제 >과제아이디어">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <form id="searchForm" name="searchForm" class="form-inline">
                        <div class="form-group col-md-6">                                             
                           <label for="usr" class="col-form-label col-sm-2">년도</label>                                                
                           <div class="col-sm-10 float-right"> 
                             <select id="searchYear" class="form-control float-left" style="width:40%;"></select>
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
                    <div id="cntrbtRank"></div>
                    <div id="cntrbtRankPager" class="portal-pager"></div>
                </div>
            </div>
        </div>
    </div>
</div>



<script>
var lc_currentPageNo = 1;
                
/*
 * 페이지 초기화
 * @param
 * @return
 */
function pageInit() {
	//그리드 초기화
    drawGrid();
    cmmn_makeYear("searchYear", 5);
    searchList();
};

function bindEvent(){
	//검색
	$('#btnSearch').on('click', function() {
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
        drawPager("cntrbtRankPager", data.result.paginationInfo, "searchList");
    }
    
    $("#cntrbtRank").jsGrid({
          height : "auto"
        , width : "100%"
        , autoload: true
        , sorting : true
        , align : "center"
        , data : params
        , rowClick: function(arg){ 
        	var params = {cntrbtYear: $("#searchYear").val(), userId: arg.item.userId}; 
            getCntrbtRankDetailPopGetData(params);
        }
        , fields : [
              {name: "cntrbtrank"         , title : "랭킹"       , type : "text"    , width : 40, align : "center"} 
            , {name: "cmpnyNm"            , title : "회사"       , type : "text"    , width : 40, align : "center"}
            , {name: "deptNm"             , title : "부서"       , type : "text"    , width : 70, align : "center"}
            , {name: "usernm"             , title : "성명"       , type : "text"    , width : 50, align : "center"}
            , {name: "cntrbtscore"        , title : "기여점수"    , type : "text"    , width : 40, align : "center"
                ,itemTemplate:function(value){
                    return value.toFixed(2);
                }   
            }
        ]
    });
}


function searchList(pageNo) {
     var url = '/cmmnty/cntrbtRank/selectCntrbtRankList';
     if (pageNo != null && pageNo != undefined && pageNo != "") {
         lc_currentPageNo = pageNo;
     }

     var param = {
    	   cntrbtYear            : $("#searchYear").val()
         , currentPageNo         : lc_currentPageNo
         , recordCountPerPage    :   10
         , pageSize              :   10
     }; 

     callAsyncAjax(url, param, "drawGrid");
}


/*
 * 상세: getDATA
 * @param
 * @return
 */
function getCntrbtRankDetailPopGetData(params) {
    callAsyncAjax("/cmmnty/cntrbtRank/getCntrbtRankDetailPopGetData", params, "getCntrbtRankDetailPopGetDataCallback");
}

/*
 * 상세: Layout
 * @param
 * @return
 */
function getCntrbtRankDetailPopGetDataCallback(data) {
    //데이터 존제 유무 확인
    if(data.result == null){
        alert("존재하지 않는 자료입니다.");
        return false;
    }
    
    //데이터 존재 시 호출
    appendDetailPopup("mainDiv", "/cmmnty/cntrbtRank/cntrbtRankDetailPop?registerId=" + data.result.registerId, "cntrbtRankDetailPopDrawData", data);
}



/*
 * popup창 닫기
 * @param
 * @return
 */
function closePop() {
    $(".over").remove();
}
                
</script>