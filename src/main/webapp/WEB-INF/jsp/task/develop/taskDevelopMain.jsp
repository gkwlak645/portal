<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
                    <!--  템플릿 바디 -->
                    <div id="taskDevelopMainDiv" class="container-fluid wrap">
                        <div class="row" alt="과제 >과제아이디어메인">
                            <div class="col-md-12">
                                <div class="card">
                                    <div class="card-header">
                                        <form id="searchForm" name="searchForm" class="form-inline">
                                            <div class="form-group row  col-sm-6">
                                                <label for="usr" class="col-sm-3 col-form-label">회사</label>
                                                <div class="col-sm-9">
                                                    <select class="form-control" id="searchCmpnyCd" style="width: 60%; max-width: 196px;"></select>
                                                </div>
                                            </div>

                                            <div class="form-group row col-sm-6">
                                                <label for="usr" class="col-sm-3 col-form-label">과제코드</label>
                                                <div class="col-sm-9">
                                                    <input type="text" class="form-control float-left" value="" id="searchTaskCd" style="width: 60%; max-width: 196px;">
                                                </div>
                                            </div>

                                            <div class="form-group row  col-sm-6">
                                                <label for="usr" class="col-sm-3 col-form-label">과제명</label>
                                                <div class="col-sm-9">
                                                    <input type="text" class="form-control float-left" id="searchTaskNm" style="width: 63%; max-width: 196px;">
                                                    <button type="button" id="btnSearch" class="btn btn-info">조회</button>
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
                                        <button type="button" id="btnOutExport" class="btn btn-primary float-right" style="margin: 5px 0 15px 2px;">엑셀 다운로드</button>
                                        <div id="taskDevelopGrid"></div>
                                        <div id="taskDevelopGridPager" class="portal-pager"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

<!-- 로딩바  -->
<div class="dimmed" style="display:none"></div>
<div class="loading" style="display:none">
    <div class="loading-bar"><div></div><div></div><div></div><div></div></div>
    <span class="loading-text">엑셀 다운로드 중...</span>
</div>

<!-- 엑셀 다운로드 FORM -->                    
<form id="downloadFormExel" name="downloadFormExel" method="post">
    <input type="hidden" id="fileNo" name="fileNo" value="" />
    <input type="hidden" id="fileNm" name="fileNm" value="" />
</form>

<script>
    var offset;
    var currentPageNo = 1;
    var dataorexcel = 'data';
    loadingTextChange();

    $(document.body).ready(function () {
    	dataorexcel = 'data';
        searchList();
        // 스크롤바 이동하기 위한 설정
        offset = $('#taskDevelopMainDiv').offset();  
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
    };
    
    
    function bindEvent(){
         var params = [];
    <c:choose>
         <c:when test="${txScreenAuthor.untenantAuthor eq 'Y'}">
              params.push({"id" : "searchCmpnyCd", "clsCd" : "0024"});    //회사
         </c:when>
         <c:otherwise>
               params.push({"id" : "searchCmpnyCd", "clsCd" : "0024", "disable" : "Y", "selectValue": "${sessionUserInfo.txCmpnyCd}"});    //회사
         </c:otherwise>
    </c:choose>
         //params.push({"id" : "tyCd"          , "clsCd" : "0016"});    //오류유형
         requestCmmnCd(params);
         
         //조회버튼 클릭 이벤트 처리
         $("#btnSearch").on("click",function(){
             searchList();
         });
         
         
         $("#searchTaskCd, #searchTaskNm").keyup(function(e){
             if(e.keyCode == 13){
                 searchList();
             }
         });
         
         $("#btnSave").on('click', function(){
             popReg();
         });
         
         $("#btnOutExport").on('click', function(){
             outExport();
         });
         
         
         $(document).on("click", ".jq_add_process", function() {
        	     if(confirm("해당 버튼은 프로세스 추가 등록 버튼입니다.\n프로세스 정보 조회는 프로세스 코드를 클릭해주세요.")) {
	        		 var params = {devlopSn: $(this).attr('id')};
	                 popProcessReg(params);
                 
                 }
        	 }
         );
         
         $(document).on("click", "span.jq_view_task", function() {
        	    var params = {devlopSn: $(this).closest('td').attr('item_data')};
        	    popTaskDetailGetData(params);
             }  
         
             
         );
         
         $(document).on("click", ".jq_view_process", function() {
        	 var oTemp = $(this)
        	 var params = 
        		    {    
        			    devlopSn: oTemp.attr('item_data')
        			    , processNo: oTemp.attr('item_data2')
        			    , status: oTemp.attr('item_data3')
        			};
             popProcessDetailGetData(params);
          });
         
         $(document).on("click", ".jq_not_view_process", function() {
             alert("결재중입니다.");
         });
    }

    

    /*
     * 그리드 초기화
     * @param
     * @return
     */
    function drawGrid(data) {

        var params = new Array();

        if (data != null && data != undefined) {
            if (data.result != null && data.result.resultList != null) {
                params = data.result.resultList;
            }
            
            drawPager("taskDevelopGridPager", data.result.paginationInfo, "searchList");
        }

        $("#taskDevelopGrid").jsGrid({
            height : "auto",
            width : "100%",                             
            autoload : true,
            sorting : true,
            align : "left",
            data : params,
//          rowClick : function(arg) {
//              //unManagtErrorDetail();
//              var aaa = 1; 
//          },
            fields : [ {
                name : "taskCd",
                title : "과제코드",
                type : "text",
                width : 40,
                align : "left",cellRenderer: function(item, value){
                    return $("<td>").append(item);  
                }
                
            }, {
                name : "taskNm",
                title : "과제명",
                type : "text",
                width : 130,
                cellRenderer: function(item, value){
                	
                	
                	
<c:choose>
    <c:when test="${txScreenAuthor.wrtngAuthor eq 'Y'}">
        return $("<td item_data =" + value.devlopSn + ">").append('<span class="jq_view_task">' + item + '</span><input type="button" class="btn btn-outline-primary icon jq_add_process" style="padding:0 1.9px;margin:0 0 3px 5px;line-height: 0.9;" value="+" id=' + value.devlopSn + '>');
    </c:when>
    <c:otherwise>
        return $("<td item_data =" + value.devlopSn + ">").append('<span class="jq_view_task">' + item + '</span><input type="button" class="btn btn-outline-primary icon" style="padding:0 1.9px;margin:0 0 3px 5px;line-height: 0.9;" value="+" id=' + value.devlopSn + '>');
    </c:otherwise>
</c:choose>
                      
                }
            }, {
                name : "cmpnyNm",
                title : "회사",
                type : "text",
                width : 60,
                align : "left"
            }
            , {
                name : "jobChrgDeptNm",
                title : "업무담당부서",
                type : "text",
                width : 70,
                align : "left"
            }
            , {
                name : "processCd",
                title : "프로세스코드",
                type : "text",
                width : 50,
                align : "left",
                cellRenderer: function(item, value){
                	return item == undefined ? $("<td>") : $("<td class='" + ( value.processSttus != 'P1' ?  "jq_view_process" : "jq_not_view_process") +"' item_data =" + value.devlopSn + " item_data2 =" + value.processNo + " item_data3 =" + value.processSttus + ">")
                			.append("<span >"  +item + "</span>");
                    
                }
            }, {
                name : "processNm",
                title : "프로세스명",
                type : "text",
                width : 130,
                cellRenderer: function(item, value){
                	return item == undefined ? $("<td>") : $("<td class='" + ( value.processSttus != 'P1' ?  "jq_view_process" : "jq_not_view_process") +"' item_data =" + value.devlopSn + " item_data2 =" + value.processNo + " item_data3 =" + value.processSttus + ">")
                            .append("<span>"  +item + "</span>");
                }
            }
            , {
                name : "processSttusNm",
                title : "상태",
                type : "text",
                width : 60,
                align : "left"
            } ]
            , onRefreshed: function (args) {
                gridMerge();
            }
        });
        
        $('.dimmed').css({ display: 'none' });
        $('.loading').css({ display: 'none' });
        $('.loading').removeClass('show');
    }
    
    function gridMerge(){
//      var gridRow = $("#taskDevelopGrid div.jsgrid-grid-body table.jsgrid-table tr");
//        gridRow.eq(0).find("td").eq(0).attr("rowspan", "2");
//        gridRow.eq(0).find("td").eq(1).attr("rowspan", "2");
//        gridRow.eq(0).find("td").eq(2).attr("rowspan", "2");
//        gridRow.eq(1).find("td.jsgrid-cell").eq(0).remove();
//        gridRow.eq(1).find("td.jsgrid-cell").eq(1).remove();
//        gridRow.eq(1).find("td.jsgrid-cell").eq(0).remove();
        
        //gridRow.eq(0).find("td").eq(0).attr("rowspan", "2");
        
        //gridRow.eq(0).find("td").eq(0).html()
        var gridRow = $("#taskDevelopGrid div.jsgrid-grid-body table.jsgrid-table tr");
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
                        gridRow.eq(i+1).find("td").eq(3).attr("rowspan", iRowCount);
                    }
                    sChkText = sTemp
                    iRowCount = 1;
                }
                else if(i == 0){
                    if(iRowCount > 1){
                        gridRow.eq(0).find("td").eq(0).attr("rowspan", iRowCount);
                        gridRow.eq(0).find("td").eq(1).attr("rowspan", iRowCount);
                        gridRow.eq(0).find("td").eq(2).attr("rowspan", iRowCount);
                        gridRow.eq(0).find("td").eq(3).attr("rowspan", iRowCount);
                    }
                }
                
                if(i != 0){
                    var sTemp2 = gridRow.eq(i-1).find("td").eq(0).html()
                    if(sTemp == sTemp2){
                        gridRow.eq(i).find("td.jsgrid-cell").eq(0).remove();
                        gridRow.eq(i).find("td.jsgrid-cell").eq(0).remove();
                        gridRow.eq(i).find("td.jsgrid-cell").eq(0).remove();
                        gridRow.eq(i).find("td.jsgrid-cell").eq(0).remove();
                        
                        iRowCount++;
                    }
                }
            }
        }

    }
    
    function searchList(pageNo) {
    	// 로딩 시작
        dataorexcel = 'data';
        loadingTextChange();
        $('.dimmed').css({ display: 'block' });
        $('.loading').css({ display: 'block' });
        $('.loading').addClass('show');
        
        if($("#startDe").val() > $("#endDe").val()){
            alert('검색기간 시작일이 종료일보다 클 수 없습니다.');
        }else{
        	
            var url = '/task/develop/selectTaskDevelopList';
            if (pageNo != null && pageNo != undefined && pageNo != "") {
                currentPageNo = pageNo;
            }

            var param = {
                searchCmpnyCd               : $("#searchCmpnyCd").val()
                , searchTaskCd              : $("#searchTaskCd").val()
                , searchTaskNm              : $("#searchTaskNm").val()
                , currentPageNo             : currentPageNo
                , recordCountPerPage        : 50
                , pageSize                  : 10
            }; 

            callAsyncAjax(url, param, "drawGrid");
        }  
    }
    
    function outExport(){
    	var url = '/task/develop/outExportTaskDevelopList';

        var param = {
            searchCmpnyCd               : $("#searchCmpnyCd").val()
            , searchTaskCd              : $("#searchTaskCd").val()
            , searchTaskNm              : $("#searchTaskNm").val()
        }; 

        callAsyncAjax(url, param, "exportCallback");    
        
        //결재 로딩바 
        dataorexcel = 'excell';
        loadingTextChange();
        $('.dimmed').css({ display: 'block' });
        $('.loading').css({ display: 'block' });
        $('.loading').addClass('show');
    }
    
    
    function exportCallback(data) {
        $("#fileNo").val(data.result.fileNo);
        $("#fileNm").val("프로세스개발");
        
        var frmData = document.downloadFormExel;
        frmData.action = "/file/downloadExport"; 
        frmData.submit() ;
        
        $('.dimmed').css({ display: 'none' });
        $('.loading').css({ display: 'none' });
        $('.loading').removeClass('show');
    }
    

    /*
     * 과제개발 > 과제 등록 pop
     * @param
     * @return
     */
    function popReg() {
    	 
    	 // 로딩 시작
         dataorexcel = 'data';
         loadingTextChange();
         $('.dimmed').css({ display: 'block' });
         $('.loading').css({ display: 'block' });
         $('.loading').addClass('show');
         
         // 스크롤 이동
         $('html').animate({scrollTop : offset.top}, 600);
      
         appendDetailPopup("taskDevelopMainDiv", "/task/develop/taskDevelopRegPop");
         
         
    }; 
    
    /*
     * 과제개발 > 과제 상세: getDATA
     * @param
     * @return
     */
    function popTaskDetailGetData(params) {
    	// 스크롤 이동
         $('html').animate({scrollTop : offset.top}, 600);
    	 
        callAsyncAjax("/task/develop/getTaskDevelopDetail", params, "popTaskDetailCallback");
        
        // 로딩 시작
        dataorexcel = 'data';
        loadingTextChange();
        $('.dimmed').css({ display: 'block' });
        $('.loading').css({ display: 'block' });
        $('.loading').addClass('show');
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
        appendDetailPopup("taskDevelopMainDiv", "/task/develop/taskDevelopDetailPop?registerId=" + data.result.registerId, "popTaskDetailDrawData", data);
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
            else if(sKey == "clsCd"){
                params.push({"id" : "clsCd", "clsCd" : "0040", "selectValue": aResult[sKey]});
            }
            else if(sKey == "fqCd"){
                params.push({"id" : "fqCd", "clsCd" : "0017", "selectValue": aResult[sKey]});    //빈도
            }
            else if(sKey == "jobTm"){
                $("#" + sKey).val(addCommas(aResult[sKey]));
            }
            else if(sKey == "jobDc"){
                //$("#" + sKey).val(aResult[sKey].replaceAll("<br>", "\r\n"));
            	$("#" + sKey).val(aResult[sKey].replace(/<br>/gi, "\r\n"));
                
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
        
     // 로딩 끝
        $('.dimmed').css({ display: 'none' });
        $('.loading').css({ display: 'none' });
        $('.loading').removeClass('show');
    }

    /*
     * 과제개발 > 과제 프로세스 등록
     * @param
     * @return
     */
    function popProcessReg(params) {

     callAsyncAjax("/task/develop/getTaskDevelopDetail", params, "popProcessRegCallback");
//      appendDetailPopup("taskDevelopMainDiv", "/task/develop/taskProcessRegPop");
        
	  // 로딩 시작
	     dataorexcel = 'data';
	     loadingTextChange();
	     $('.dimmed').css({ display: 'block' });
	     $('.loading').css({ display: 'block' });
	     $('.loading').addClass('show');
        
    }
     
    /*
     * 과제개발 > 과제 프로세스 등록 pop: Layout
     * @param
     * @return
     */
    function popProcessRegCallback(data) {
        //데이터 존재 유무 확인
        if(data.result == null){
            alert("존재하지 않는 과제개발 입니다.");
            return false;
        }
        
        //데이터 존재 시 호출
        appendDetailPopup("taskDevelopMainDiv", "/task/develop/taskProcessRegPop?registerId=" + data.result.registerId, "popProcessRegDrawData", data);
        
     
    }    
    
    /*
     * 과제개발 > 과제 프로세스 등록 pop: Data표시
     * @param
     * @return
     */
    function popProcessRegDrawData(data){
        //데이터 화면에 출력
        var aResult = data.result
        var params = [];
        for (var sKey in aResult) {
            if(sKey == "taskCd"){
                getTaskCdListByClsCd('taskCd');
                $("#taskCd option").filter(function(){
                    return this.text == aResult[sKey];
                }).attr('selected', true);
                
                $("#processCd").val(aResult[sKey]);
            }
            else if(sKey == "cmpnyCd"){
                params.push({"id" : "cmpnyCd", "clsCd" : "0024", "disable" : "N", "selectValue": aResult[sKey]} );
                params.push({"id" : "cmpnyCdReg", "clsCd" : "0024", "disable" : "N", "selectValue": aResult[sKey]} );
            }
            else if(sKey == "clsCd"){
                params.push({"id" : "clsCd", "clsCd" : "0040", "selectValue": aResult[sKey]});
            }
            else if(sKey == "fqCd"){
                params.push({"id" : "fqCd", "clsCd" : "0017", "selectValue": aResult[sKey]});    //빈도
            }
            else if(sKey == "jobChargerNm"){
                $("#jobChargerNm").val(aResult[sKey]);
                $("#jobChargerNmReg").val(aResult[sKey]);
            }
            else if(sKey == "jobChrgDeptNm"){
                $("#jobChrgDeptNm").val(aResult[sKey]);
                $("#jobChrgDeptNmReg").val(aResult[sKey]);
            }
            else if(sKey == "taskNm"){
            	$("#" + sKey).val(aResult[sKey])
            	$("#sj").val(aResult[sKey] + " 개발의 건")
            }
            else{
                $("#" + sKey).val(aResult[sKey])
            }
        }
        params.push({"id" : "fqCdReg", "clsCd" : "0017"});    //프로세스빈도
        params.push({"id" : "rpaClsCd", "clsCd" : "0042"});    //RPA분류코드
        params.push({"id" : "jobClsCd", "clsCd" : "0040"});    //업무분류
        params.push({"id" : "insideDevlopAt", "clsCd" : "0047", "selectValue": "Y"});    //내부개발여부
        params.push({"id" : "executSe", "clsCd" : "0049"});    //실행구분

        requestCmmnCd(params);      
        
     // 로딩 끝
        $('.dimmed').css({ display: 'none' });
        $('.loading').css({ display: 'none' });
        $('.loading').removeClass('show');
    }
    
    
    /*
     * 과제개발 > 프로세스  상세: getData
     * @param
     * @return
     */
    function popProcessDetailGetData(params) {
    	// 스크롤 이동
         $('html').animate({scrollTop : offset.top}, 600);
    	 
        callAsyncAjax("/task/develop/getTaskDevelopProcessDetail", params, "popProcessDetailGetDataCallback");
        
        
        $(".class") // 여기
        
        // 로딩 시작
        dataorexcel = 'data';
        loadingTextChange();
        $('.dimmed').css({ display: 'block' });
        $('.loading').css({ display: 'block' });
        $('.loading').addClass('show');
    }
    
    /*
     * 과제개발 > 프로세스 상세 : Layout
     * @param
     * @return
     */
    function popProcessDetailGetDataCallback(data, params) {
        //데이터 존제 유무 확인
        if(data.result == null){
            alert("존재하지 않는 과제개발 입니다.");
            return false;
        }
        
        //데이터 존재 시 호출
        if(params.status == "P2" || params.status == "P3" || params.status == "P4"){
        	appendDetailPopup("taskDevelopMainDiv", "/task/develop/taskProcessTemporaryDetailPop?registerId=" + data.result.registerId, "popProcessTemporaryDetailDrawData", data);
        }else{
        	appendDetailPopup("taskDevelopMainDiv", "/task/develop/taskProcessDetailPop?registerId=" + data.result.registerId, "popProcessDetailDrawData", data);
        }
        
        
    } 
    
    
     /*
     * popup창 닫기
     * @param
     * @return
     */
    function mainPopClose() {
        $(".over").remove();
    }
    
    function mainPopCloseReload() {
        $(".over").remove();
        searchList();
    }
    
    function mainPopCloseReloadType2() {
        $(".over").remove();
        searchList(currentPageNo);
    }
    
    $(document)
    .on("focus", ".jq_redcnTmRedcnTm", function() {
        //부서 입력 여부 
        var oThis = $(this);
        //var sThisID = $(this).attr("id")
        //sThisID = sThisID.replace("redcnTmRedcnTm", "");
        
        //if($("#chrgDeptNm" + sThisID).val() == ""){
        //  alert("사원을 입력해 주십시오");
        //  return false;
        //}
        var x = oThis.val();
        x = removeCommas(x);
        oThis.val(x);
    }).on("focusout", ".jq_redcnTmRedcnTm", function() {
        var x = $(this).val();
        var sum = 0;
        if(x && x.length > 0) {
            if(!$.isNumeric(x)) {
                x = x.replace(/[^0-9]/g,"");
            }
            x = addCommas(x);
            $(this).val(x);
        }
        
//        if(x == ""){
//          alert("절감시간을 입력해 주십시오.");
//          setTimeout(() => $(this).focus(), 300);
//          return false;
//        }
        
         
        //계산식
        $(".jq_redcnTmRedcnTm").each(function(){ 
                sum += Number(removeCommas($(this).val())); 
        });
        $("#redcnTmSum").val(addCommas(sum));
    }).on("keyup", ".jq_redcnTmRedcnTm", function() {
        $(this).val($(this).val().replace(/[^0-9]/g,""));
    });
    
    $(document)
    .on("focus", ".jq_contributeRate", function() {
        var x = $(this).val();
        x = removeCommas(x);
        $(this).val(x);
    }).on("focusout", ".jq_contributeRate", function() {
        var x = $(this).val();
        var sum = 0;
        if(x && x.length > 0) {
            if(!$.isNumeric(x)) {
                x = x.replace(/[^0-9]/g,"");
            }
            x = addCommas(x);
            $(this).val(x);
        }
        
//        if(x == ""){
//            alert("기여도를 입력해 주십시오.");
//            setTimeout(() => $(this).focus(), 300);
//            return false;
//        }
        
         
        //계산식
        $(".jq_contributeRate").each(function(){ 
                sum += Number(removeCommas($(this).val())); 
        });
        
//        if(sum != 100){
//        	setTimeout(() => alert("기여도 합계가 100% 되어야합니다."), 400);	
//        }
        $("#contributeSum").val(sum);
    }).on("keyup", ".jq_contributeRate", function() {
        $(this).val($(this).val().replace(/[^0-9]/g,""));
    });
    
    $(document)
    .on("click", ".jq_cntcSysChackbox", function() {
        if($(".jq_cntcSysChackbox").length == $(".jq_cntcSysChackbox:checked").length){
            $("#cntcSysAll").prop("checked", true)
        }
        else{
            $("#cntcSysAll").prop("checked", false)
        }
    });
     
</script>

                    <!--  템플릿 바디 끝 -->
