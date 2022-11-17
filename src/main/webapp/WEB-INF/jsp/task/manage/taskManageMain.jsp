<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div id="taskManageMainDiv" class="container-fluid wrap">
    <div class="row" alt="과제 >과제운영메인">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <form id="searchForm" name="searchForm" class="form-inline">
                        <div class="form-group col-sm-6">
                            <label for="usr" class="col-form-label col-sm-3 ">회사</label>
                            <div class="col-sm-9">
                              <select id="searchCmpny" class="form-control" style="width: 60%; max-width: 196px;">
                                  <option value=""></option>
                              </select>
                            </div>
                        </div>

                        <div class="form-group col-sm-6">
                            <label for="usr" class="col-form-label col-sm-3">프로세스코드</label>
                            <div class="col-sm-9">
                                <input type="text" name="assetCd" class="form-control" value="" id="assetCd" style="width: 60%; max-width: 196px;">
                            </div>
                        </div>

                        <div class="form-group col-sm-6">
                            <label for="usr" class="col-form-label col-sm-3">프로세스명</label>
                            <div class="col-sm-9 float-left">
                                <input type="text" name="assetName" class="form-control float-left" id="searchAssetName" style="width: 60%; max-width: 196px;">
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
                    <div id="unmanagtErrorGrid"></div>
                    <div id="unmanagtErrorGridPager" class="portal-pager"></div>
                </div>
            </div>
        </div>
    </div>
</div>


<!-- 로딩바  -->
<div class="dimmed" style="display:none"></div>
<div class="loading" style="display:none">
    <div class="loading-bar"><div></div><div></div><div></div><div></div></div>
    <span class="loading-text">데이터 로딩 중...</span>
</div>


<script>
//일일미조치_오류_일련번호
var currentPageNo = 1;
var offset;

$(document.body).ready(function() {
	// 스크롤바 이동하기 위한 설정
    offset = $('#taskManageMainDiv').offset(); 
});

function bindEvent(){
    var params = [];
	<c:choose>
		<c:when test="${txScreenAuthor.untenantAuthor eq 'Y'}">
		     params.push({"id" : "searchCmpny", "clsCd" : "0024"});    //회사
		</c:when>
		<c:otherwise>
		      params.push({"id" : "searchCmpny", "clsCd" : "0024", "disable" : "Y", "selectValue": "${sessionUserInfo.txCmpnyCd}"});    //회사
		</c:otherwise>
	</c:choose>

    requestCmmnCd(params);
    
    //조회버튼 클릭 이벤트 처리
    $("#btnSearch").on("click",function(){
        searchList();
    });
    
    $("#assetCd, #searchAssetName").keyup(function(e){
        if(e.keyCode == 13){
        	searchList();
        }
    });
    
    $("#btnSave").on('click', function(){
        popReg();
    });
    
    $(document).on("click", "span.jq_view_task", function() {
        var params = {devlopSn: $(this).closest('td').attr('item_data')};
        popTaskDetailGetData(params);
    });

    $(document).on("click", "span.jq_view_process", function() {
        var processCd = $(this).closest('td').attr('item_data')
        if(processCd == "-" ){
            alert("등록된 프로세스가 없습니다.");
        }else{
            var params = {processCd : processCd};
            popTaskManageProcessDetailGetData(params);
        }
    });
    
    searchList();
    
}


/*
 * 페이지 초기화
 * @param
 * @return
 */
function pageInit() {
    var params = [];
    params.push({"id" : "searchCmpny", "clsCd" : "0024"});    //회사
    requestCmmnCd(params);
    drawGrid();
};


/*
 * 그리드 초기화
 * @param
 * @return
 */
function drawGrid(data) {

    var params = new Array();
    
    if (data != null && data != undefined) {
        if (data.result.resultList != null) {
            params = data.result.resultList;
        }
        drawPager("unmanagtErrorGridPager", data.result.paginationInfo, "searchList");
    }
    
    $("#unmanagtErrorGrid").jsGrid({
        height : "auto",
        width : "100%",                             
        autoload : true,
        sorting : true,
        align : "left",
        data : params,
//         rowClick : function(arg) {
//             unManagtErrorDetail();
//         },
        fields : [ {
            name : "taskCd",
            title : "과제코드",
            type : "text",
            width : 40,
            align : "left"
        }, {
            name : "taskNm",
            title : "과제명",
            type : "text",
            width : 100,
            cellRenderer: function(item, value){
            return $("<td item_data =" + value.devlopSn + ">").append('<span class="jq_view_task">' + item + '</span><input hidden="hidden" type="button" class="btn btn-outline-primary icon jq_add_process" style="padding:0 1.9px;margin:0 0 3px 5px;line-height: 0.9;" value="+" id=' + value.devlopSn + '>');
            }
        }, {
            name : "cmpnyNm",
            title : "회사",
            type : "text",
            width : 60,
            align : "left"
        }, {
            name : "processCd",
            title : "프로세스코드",
            type : "text",
            width : 60,
            align : "left",
            cellRenderer: function(item, value){
            return $("<td item_data =" + value.processCd + ">").append('<span class="jq_view_process">' + item + '</span><input hidden="hidden" type="button" class="btn btn-outline-primary icon jq_add_process" style="padding:0 1.9px;margin:0 0 3px 5px;line-height: 0.9;" value="+" id=' + value.processCd + '>');
            }
        }, {
            name : "processNm",
            title : "프로세스명",
            type : "text",
            width : 100
        }, {
            name : "processSttusNm",
            title : "상태",
            type : "text",
            width : 30,
            align : "left"
        } ]
        , onRefreshed: function (args) {
            gridMerge();
        }
    });

}



function searchList(pageNo) {
    var url = '/task/manage/selectTaskManageList';
    if (pageNo != null && pageNo != undefined && pageNo != "") {
        currentPageNo = pageNo;
    }
    var param = {
          assetName             : $("#searchAssetName").val()
        , searchCmpny           : $("#searchCmpny").val()
        , assetCd               : $("#assetCd").val()
        , currentPageNo         : currentPageNo
        , recordCountPerPage    :   50
        , pageSize              :   10
    }; 

    callAsyncAjax(url, param, "drawGrid");
}


function gridMerge(){
    var gridRow = $("#unmanagtErrorGrid div.jsgrid-grid-body table.jsgrid-table tr");
    var iGridRow = gridRow.length;
    var iRowCount = 0;
    if(iGridRow > 0){
        var sChkText = "";
        var iRowCount = 0;
        for(var i = iGridRow - 1; i >= 0; i--){
            var sTemp = gridRow.eq(i).find("td").eq(0).html()
            
            if(sChkText != sTemp){
                if(i != iGridRow - 1){
                    gridRow.eq(i+1).find("td").eq(0).attr("rowspan", iRowCount);
                    gridRow.eq(i+1).find("td").eq(1).attr("rowspan", iRowCount);
                    gridRow.eq(i+1).find("td").eq(2).attr("rowspan", iRowCount);
                }
                sChkText = sTemp
                iRowCount = 1;
            }
            else if(i == 0){
                if(iRowCount > 1){
                    gridRow.eq(0).find("td").eq(0).attr("rowspan", iRowCount);
                    gridRow.eq(0).find("td").eq(1).attr("rowspan", iRowCount);
                    gridRow.eq(0).find("td").eq(2).attr("rowspan", iRowCount);
                }
            }
            
            if(i != 0){
                var sTemp2 = gridRow.eq(i-1).find("td").eq(0).html()
                if(sTemp == sTemp2){
                    gridRow.eq(i).find("td.jsgrid-cell").eq(0).remove();
                    gridRow.eq(i).find("td.jsgrid-cell").eq(0).remove();
                    gridRow.eq(i).find("td.jsgrid-cell").eq(0).remove();
                    
                    iRowCount++;
                }
            }
        }
    }

}

/*
 * 과제운영 > 과제 상세: getDATA
 * @param
 * @return
 */
function popTaskDetailGetData(params) {
	// 로딩 시작
     $('.dimmed').css({ display: 'block' });
     $('.loading').css({ display: 'block' });
     $('.loading').addClass('show');
	// 스크롤 이동
     $('html').animate({scrollTop : offset.top}, 600);
    callAsyncAjax("/task/manage/getTaskManageDetail", params, "popTaskDetailCallback");
}

/*
 * 과제개발 > 과제 상세 pop: Layout
 * @param
 * @return
 */
function popTaskDetailCallback(data) {
    //데이터 존제 유무 확인
    if(data.result == null){
        alert("존재하지 않는 과제개발 입니다.");
        return false;
    }
    //데이터 존재 시 호출
   appendDetailPopup("taskManageMainDiv", "/task/manage/taskManageDetailPop?registerId=" + data.result.registerId, "popTaskDetailDrawData", data);
}


/*
 * 과제개발 > 과제 상세 pop: Data표시
 * @param
 * @return
 */
function popTaskDetailDrawData(data){
    //데이터 화면에 출력
    var aResult = data.result
    var params = [];
    for (var sKey in aResult) {
        if(sKey == "cmpnyCd"){
            params.push({"id" : "cmpnyCd", "clsCd" : "0024", "disable" : "N", "selectValue": aResult[sKey]} );
        }
        /* else if(sKey == "clsCd"){
            params.push({"id" : "clsCd", "clsCd" : "0045", "selectValue": aResult[sKey]});
        } */
        else if(sKey == "clsCd"){
            params.push({"id" : "clsCd", "clsCd" : "0040", "selectValue": aResult[sKey]});
        }
        else if(sKey == "fqCd"){
            params.push({"id" : "fqCd", "clsCd" : "0017", "selectValue": aResult[sKey]});    //빈도
        }
        else if(sKey == "processCnt"){
            //프로세스가 등록 되어 있으면 삭제 불가
            if(parseInt(aResult[sKey]) > 0 ){
                $("#deleteBtn").hide();
            }
        }
        else{
            $("#" + sKey).val(aResult[sKey])
        }
    }
    requestCmmnCd(params);      
    
    $('.dimmed').css({ display: 'none' });
    $('.loading').css({ display: 'none' });
    $('.loading').removeClass('show');
}


 /*
  * 과제운영 > 프로세스 상세: getDATA
  * @param
  * @return
  */
function popTaskManageProcessDetailGetData(params) {
	// 로딩 시작
      $('.dimmed').css({ display: 'block' });
      $('.loading').css({ display: 'block' });
      $('.loading').addClass('show');
	// 스크롤 이동
      $('html').animate({scrollTop : offset.top}, 600);
    callAsyncAjax("/task/manage/getTaskManageProcessDetail", params, "popTaskProcessDetailCallback");   
}


 /*
  * 과제개발 > 프로세스 상세 pop: Layout
  * @param
  * @return
  */
function popTaskProcessDetailCallback(data) {
     //데이터 존제 유무 확인
    if(data.result == null){
        alert("존재하지 않는 과제개발 입니다.");
        return false;
    }
     //데이터 존재 시 호출
    appendDetailPopup("taskManageMainDiv", "/task/manage/taskManageProcessDetailPop?registerId=" + data.result.registerId, "popTaskProcessDetailDrawData", data);
}
 
/*
 * 과제개발 > 프로세스 상세 pop: Data표시
 * @param
 * @return
 */
function popTaskProcessDetailDrawData(data){
     
    //데이터 화면에 출력
    var aResult = data.result
    var params = [];
    for (var sKey in aResult) {
        if(sKey == "cmpnyCd"){
            params.push({"id" : "cmpnyCd", "clsCd" : "0024", "disable" : "N", "selectValue": aResult[sKey]} ); // 회사명
        }
        else if(sKey == "clsCd"){
            params.push({"id" : "clsCd", "clsCd" : "0040", "selectValue": aResult[sKey]}); // 업무분류
        }
        else if(sKey == "cmpnyCdPrc"){
            params.push({"id" : "cmpnyCdPrc", "clsCd" : "0024", "selectValue": aResult[sKey]});    //빈도명
        }
        else if(sKey == "fqCd"){
            params.push({"id" : "fqCd", "clsCd" : "0017", "selectValue": aResult[sKey]});    //빈도명
        }
        else if(sKey == "jobClsCd"){
            params.push({"id" : "jobClsCd", "clsCd" : "0040", "selectValue": aResult[sKey]}); // 업무분류
        }
        else if(sKey == "rpaClsCd"){
            params.push({"id" : "rpaClsCd", "clsCd" : "0042", "selectValue": aResult[sKey]}); // PRA 분류
        }
        else if(sKey == "fqCdPrc"){
            params.push({"id" : "fqCdPrc", "clsCd" : "0017", "selectValue": aResult[sKey]});    //빈도명
        }
        else if(sKey == "jobDc"){
            //$("#" + sKey).val(aResult[sKey].replaceAll("<br>", "\r\n"));
        	$("#" + sKey).val(aResult[sKey].replace(/<br>/gi, "\r\n"));
        }
        else if(sKey == "processSttus"){
            params.push({"id" : "processSttus", "clsCd" : "0037", "selectValue": aResult[sKey]});    //프로세스 상태
        }
        else if(sKey == "insideDevlopAt"){
            
            if(aResult[sKey] == null){
                params.push({"id" : "insideDevlopAt", "clsCd" : "0047"});    //빈도
            }else{
                params.push({"id" : "insideDevlopAt", "clsCd" : "0047", "selectValue": aResult[sKey]});    //빈도
            }
        
        }
        else if(sKey == "processCnt"){
            //프로세스가 등록 되어 있으면 삭제 불가
            if(parseInt(aResult[sKey]) > 0 ){
                $("#deleteBtn").hide();
            }
        }
        else if(sKey == "chargerlist"){
            drawChargerList(aResult[sKey])
        }
        else if(sKey == "redcntmlist"){
            drawRedcnTmList(aResult[sKey])
        }
        else if(sKey == "butelist"){
            drawButeList(aResult[sKey])
        }
        else if(sKey == "schtextlist"){
            drawSchtextList(aResult[sKey])
        }
        else if(sKey == "calendarlist"){
            drawCalendarlist(aResult[sKey])
        }
        else if(sKey == "cntclist"){
            drawCntcSysList(aResult[sKey])
        }
        else if(sKey == "fileGrpNo"){
            var sTempFileGrpNo = aResult[sKey]
            if(sTempFileGrpNo != "" && sTempFileGrpNo != "0" && sTempFileGrpNo != null){
                oRpaUploadUpload.draw(sTempFileGrpNo,true);
            }
            else{
                oRpaUploadUpload.draw('',true);
            }
        }
        else if(sKey == "processFileGrpNo"){
            var sTempFileGrpNo = aResult[sKey]
            if(sTempFileGrpNo != "" && sTempFileGrpNo != "0" && sTempFileGrpNo != null){
                oRpaUploadUpload2.draw(sTempFileGrpNo,true);
            }
            else{
                oRpaUploadUpload2.draw('',true);
            }
        }
        else if(sKey == "executSe"){
            params.push({"id" : "executSe", "clsCd" : "0043", "selectValue": aResult[sKey]});    //실행구분
        }
        else if(
                sKey == "redcnTm" || sKey == "expectRedcnAmt" || sKey == "executCntReg" || sKey == "executTm" || sKey == "expectDevlopCt"  || sKey == "rto"
                     || sKey == "jobTm" || sKey == "processJobTm"
                ){
            $("#" + sKey).val(addCommas(aResult[sKey]));
        }
        else{
            $("#" + sKey).val(aResult[sKey])
        }
    }
    requestCmmnCd(params);      
    
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
    $(".over").remove();
}
    
function mainPopClose() {
    $(".over").remove();
}
    

    

</script>