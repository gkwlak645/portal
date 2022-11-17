<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%--
읽기보기: ${txScreenAuthor.redngAuthor}
쓰기수정 보기: ${txScreenAuthor.wrtngAuthor}
전체 테넌트 보기: ${txScreenAuthor.untenantAuthor}
접수권한 보기: ${txScreenAuthor.resveAuthor2}

회사 코드:${sessionUserInfo.txCmpnyCd}
테넌트 아이디: ${sessionUserInfo.txTenantId}
CmmnUserVO(txUserId=testuser1, txEmpNo=210015, txEmpNm=운영자, txPstCd=04, txPstNm=대리, txDeptCd=0104010000, txDeptNm=개발1팀, txCmpnyCd=A, txCmpnyNm=동원건설산업, txRoleUserAt=Y, txTenantId=7, txUserCls=null)
 --%>

<div id="taskIdeaMainDiv" class="container-fluid wrap">
    <div class="row" alt="과제 >과제아이디어등록">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <form class="form-inline">
                        <div class="form-group col-md-7">
                          <label for="usr" class="col-form-label" style="width:70px;">등록일자</label>
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
                        <div class="form-group col-md-4"></div>
                        <div class="form-group col-md-7">
                            <label for="usr" class="col-form-label" style="width:70px;">진행상태</label>
                            <div class="col-sm-4 float-left">
                                <div class="form-group row">
                                    <select id="prgrSttus" class="form-control"  style="min-width: 184px;">
                                      <option value=""></option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="form-group col-md-4">
                            <label for="usr" class="col-form-label" style="width:80px;">검토대상여부</label>
                            <div class="col-sm-4 float-left">
                                <div class="form-group row">
                                    <select id="searchReviewTrgetAt" class="form-control"  style="min-width: 184px;"></select>
                                </div>
                            </div>
                        </div>
                        <div class="form-group col-md-7">
                            <label for="usr" class="col-form-label" style="width:70px;">구분</label>
                            <div class="col-sm-4 float-left">
                                <div class="form-group row">
                                    <select id="searchRpaClsCd" class="form-control"  style="min-width: 184px;"></select>
                                </div>
                            </div>
                        </div>
                        <div class="form-group col-md-4">
                            <label for="usr" class="col-form-label" style="width:80px;">업무분류</label>
                            <div class="col-sm-4 float-left">
                                <div class="form-group row">
                                    <select id="searchJobClsCd" class="form-control"  style="min-width: 184px;"></select>
                                </div>
                            </div>
                        </div>
                        
                        <div class="form-group col-md-7">
                            <label for="usr" class="col-form-label" style="width:70px;">회사</label>
                            <div class="col-sm-4 float-left">
                                <select id="cmpnyCd" class="form-control"  style="min-width: 184px;">
                                  <option value=""></option>
                                </select>
                          </div>
                        </div>
                        
                        <div class="form-group col-md-4">
                            <label for="usr" class="col-form-label" style="width:80px;" >등록자</label>
                            <div class="col-sm-4 float-left">
                                <div class="form-group row">
                                    <input type="text" class="form-control" id="registerNm" name="registerNm"  style="min-width: 134px;">                        
                                </div>
                            </div>
                        </div>
                        <div class="form-group col-md-7">
                            <label for="usr" class="col-form-label" style="width:70px;">제목</label>
                             <div class="col-sm-9">
                              <input type="text" class="form-control float-left" id="sj" name="sj"   style="width:70%;min-width: 134px;"><button type="button" id="btnSearch" class="btn btn-info  float-left">조회</button>
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
                    <button type="button" id="btnSave" class="btn btn-primary float-right" style="margin:5px 0 15px 2px;">등록</button>
                </c:if>
                    <div id="taskIdeaGrid"></div>
                    <div id="taskIdeaGridPager" class="portal-pager"></div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
var currentPageNo = 1;
//일일미조치_오류_일련번호
$(document.body).ready(function () {
     //getProcessCdListByClsCd('processCd');
	searchList();
});


function bindEvent(){
	//감섹영역 > 등록일자 > 시작일 
    $('#startDeDiv').datetimepicker(
    	{
            format: 'YYYY-MM-DD'
            , defaultDate: getMonthGapDate(-1)
        }
    );
    
    //감섹영역 > 등록일자 > 종료일
    $("#endDeDiv").datetimepicker(
    	{
    	    format: 'YYYY-MM-DD'
            , defaultDate: (new Date())
        }
    );
     
     var params = [];
<c:choose>
     <c:when test="${txScreenAuthor.untenantAuthor eq 'Y'}">
          params.push({"id" : "cmpnyCd", "clsCd" : "0024"});    //회사
     </c:when>
     <c:otherwise>
           params.push({"id" : "cmpnyCd", "clsCd" : "0024", "disable" : "Y", "selectValue": "${sessionUserInfo.txCmpnyCd}"});    //회사
     </c:otherwise>
</c:choose>
     
     params.push({"id" : "prgrSttus", "clsCd" : "0039"});    //상테
     //params.push({"id" : "tyCd"          , "clsCd" : "0016"});    //오류유형
     requestCmmnCd(params);
     
     //조회버튼 클릭 이벤트 처리
     $("#btnSearch").on("click",function(){
         searchList();
     });
}

    /*
     * 페이지 초기화
     * @param
     * @return
     */
    function pageInit() {
        //그리드 초기화
        drawGrid();
        
        $("#btnSave").on('click', function(){
        	popReg();
        });
        
        var params = [];
        params.push({"id" : "searchRpaClsCd", "clsCd" : "0042"});    //RPA구분
        params.push({"id" : "searchJobClsCd", "clsCd" : "0040"});    //업무분류
        params.push({"id" : "searchReviewTrgetAt", "clsCd" : "0021"} );
        requestCmmnCd(params);

    };
    
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
            drawPager("taskIdeaGridPager", data.result.paginationInfo, "searchList");
        }
        
        $("#taskIdeaGrid").jsGrid({
              height : "auto"
            , width : "100%"
            , autoload: true
            , sorting : true
            , align : "center"
            , data : params
            , rowClick: function(arg){
            	var params = {
                        ideaSn                 : arg.item.ideaSn
                      };
          	    popDetailGetData(params);
          	  
            }
            , fields : [
                  {name: "ideaSn"         , title : "등록번호"       , type : "text"    , width : 110, align : "center"} 
                , {name: "ideaSj"            , title : "제목"          , type : "text"    , width : 200}
                , {name: "cmpnyNm"         , title : "등록회사"       , type : "text"    , width : 100, align : "center"}
//                , {name: "deptNm"        , title : "등록부서"    , type : "text"    , width : 100, align : "center"}
                , {name: "registerNm"               , title : "등록자"       , type : "text"    , width : 80, align : "center"}
                , {name: "regDt"          , title : "등록일"    , type : "text"    , width : 80, align : "center"}
                , {name: "prgrSttusNm"            , title : "진행상태"       , type : "text"    , width : 80, align : "center"}
                , {name: "reviewTrgetNm"         , title : "검토대상"        , type : "text"    , width : 70, align : "center"}
            ]
        });
        
    }
    
    /*
     * 검색
     * @param 페이지번호
     * @return
     */
    function searchList(pageNo) {
        if($("#startDe").val() > $("#endDe").val()){
            alert('검색기간 시작일이 종료일보다 클 수 없습니다.');
        }else{
            var url = '/task/idea/selectTaskIdeaList';
            if (pageNo != null && pageNo != undefined && pageNo != "") {
                currentPageNo = pageNo;
            }

            var param = {
                startDe                 : $("#startDe").val().replace(/-/g, "")
                , endDe                 : $("#endDe").val().replace(/-/g, "")
                , prgrSttus             : $("#prgrSttus").val()
                , cmpnyCd               : $("#cmpnyCd").val()
                , registerNm            : $("#registerNm").val()
                , sj                    : $("#sj").val()
                , searchReviewTrgetAt   : $("#searchReviewTrgetAt").val()
                , searchRpaClsCd        : $("#searchRpaClsCd").val()
                , searchJobClsCd        : $("#searchJobClsCd").val()
                , currentPageNo         : currentPageNo
                , recordCountPerPage    :   50
                , pageSize              :   10
            }; 

            callAsyncAjax(url, param, "drawGrid");
        }
    }
    
    
    /*
     * 상세페이지 DATA
     * @param
     * @return
     */
    function popDetailGetData(params) {
        var detailNoticeUrl = "/task/idea/getTaskIdeaDetail";
        callAsyncAjax(detailNoticeUrl, params, "popDetail");
        
        
    }
    
    /*
     * 상세페이지 pop
     * @param
     * @return
     */
    function popDetail(data) {
    	//데이터 존제 유무 확인
    	if(data.result == null){
    		alert("존재하지 않는 과제아이디어 입니다.");
    		return false;
    	}
    	
    	//데이터 존재 시 호출
    	appendDetailPopup("taskIdeaMainDiv", "/task/idea/taskIdeaDetailPop?registerId=" + data.result.registerId, "popDetailDrawData", data);
    }    
    
    /*
     * 상세페이지 pop에 데이터 표시
     * @param
     * @return
     */
    function popDetailDrawData(data){
    	
    	//데이터 화면에 출력
    	var aResult = data.result
    	var params = [];
    	var oValDisabled = "";
    	for (var sKey in aResult) {
    		if(sKey == "fqCd"){
    			params.push({"id" : "view_fqCd", "clsCd" : "0017", "selectValue": aResult[sKey]});    //빈도
    		}
    		else if(sKey == "jobClsCd"){
    			params.push({"id" : "view_jobClsCd", "clsCd" : "0040", "selectValue": aResult[sKey]});
    		}
    		else if(sKey == "rpaClsCd"){
                params.push({"id" : "view_rpaClsCd", "clsCd" : "0042", "selectValue": aResult[sKey]});
            }
    		else if(sKey == "reviewTrgetAt"){
    			var sDisable = "Y";
    			<c:if test="${txScreenAuthor.resveAuthor2 eq 'Y'}">
    			sDisable = "N";
    			</c:if>
                params.push({"id" : "view_reviewTrgetAt", "clsCd" : "0021", "disable" : sDisable, "selectValue": aResult[sKey], "emptyOption": "Y"} );
            }
    		else if(sKey == "jobTm"){
                $("#view_" + sKey).val(addCommas(aResult[sKey]));
            }
    		else if(sKey == "prgrSttus"){
    			var oVal = aResult[sKey];
    			oValDisabled = aResult[sKey];
    			if(oVal == "01"){//등록 상태일 때 버튼 노출
                    $("#setReviewCompleteBtn").show();
                    $("#saveBtn").show();
                    $("#regCancelBtn").show();
                }
            }
    		else{
    			$("#view_" + sKey).val(aResult[sKey])
    		}
    	}
    	requestCmmnCd(params);
    	
    	<c:if test="${txScreenAuthor.resveAuthor2 eq 'Y'}">
    	   $("#reviewOpinDiv").show();
    	</c:if>
    	
    	if(oValDisabled == "03"){
    		$("#reviewOpinDiv").show();
    	}
    	
    	
    	if(oValDisabled != "01"){
    		$("#view_reviewTrgetAt").attr("disabled", true);
    	}
    	
    	
    	
    	if(aResult == undefined || aResult == ""){             
    		fileGrpNo = 0;
        }else{
        	fileGrpNo= aResult.fileGrpNo;
        } 
    	bbsUploadDraw(fileGrpNo);        
    	
        //bbsUpload.draw(aResult.fileGrpNo, true);   	
    }
    
    
    
    /*
     * 등록페이지 pop
     * @param
     * @return
     */
    function popReg() {
    	appendDetailPopup("taskIdeaMainDiv", "/task/idea/taskIdeaRegPop");
    };
    
    /*
     * popup창 닫기
     * @param
     * @return
     */
    function mainPopClose() {
        $(".over").remove();
        //searchTaskIdeaList()
    }
    
    function mainPopCloseReload() {
        $(".over").remove();
        searchList();
    }
    
    function mainPopCloseReloadType2() {
        $(".over").remove();
        searchList(currentPageNo);
    }

</script>