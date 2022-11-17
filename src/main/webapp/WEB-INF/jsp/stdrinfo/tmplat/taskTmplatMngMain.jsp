<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt"     uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!-- SEARCH FORM -->
 <div id="taskTmplatMngMain" class="container-fluid wrap">
    <div class="row" alt="기준정보 >과제템플릿관리">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <form class="form-inline py-sm-2">
<c:choose>
            <c:when test="${txScreenAuthor.untenantAuthor eq 'Y'}">
                    <div class="form-group col-md-12 py-sm-2">
                        <label for="searchCombo" class="col-form-label" style="width:80px; margin:0 10px 0 5px;">회사코드</label>
                        <div class="col-sm-4 float-left" style="width: 80%;">
                             <select class="form-control" id="searchCmpnyCd" style="width: 10%;min-width:130px;"></select>
                        </div>
                    </div>
                        
            </c:when>
            <c:otherwise>
                <input type="hidden" id="searchCmpnyCd"  value="${sessionScope.sessionUserInfo.txCmpnyCd}" />
            </c:otherwise>
        </c:choose>
        
                        
                        <div class="form-group col-md-5 py-sm-2">
                          <label for="searchCombo" class="col-form-label" style="width:87px; margin:0 10px 0 5px;">템플릿코드</label>
                          <input type="text" class="form-control" id="tmplatCd" placeholder="템플릿코드" style="" value="" />                              
                        </div>
                        <div class="form-group col-md-5 py-sm-2">
                          <label for="searchCombo" class="col-form-label" style="width:95px; margin:0 10px 0 5px;">템플릿명</label>
                          <input type="text" class="form-control" id="tmplatNm" placeholder="템플릿명" style="" value="" />  
                        </div>
                        <div class="form-group col-md-5 py-sm-2">
                          <label for="searchCombo" class="col-form-label" style="width:80px; margin:0 10px 0 5px;">프로세스코드</label>
                           <div class="col-sm-4 float-left" style="width: 80%;">
                             <select class="form-control" id="searchProcessCd" style="width: 10%;min-width:130px;">
                             </select>
                           </div>
                        </div>
                        <div class="form-group col-md-5 py-sm-2" >
                        <input type = "checkbox" id = "check" checked>
                        <label for="" class="col-form-label" style="width:70px; margin:0 10px 0 5px;">등록일</label>
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
                              <!-- 검색 -->
                              <div style="margin: 0 0 2px 0;">
                                <button type="button" id="searchBtn" class="btn btn-info  float-left">조회</button>
                              </div>
                          </div>
                        </div>                                                                               
                    </form>
                </div>                 
            </div> 
                     
    <div class="row">
        <div class="col-md-12">        
	       <div class= "card">
	           <div class = "card-body">	         
		          <div class="col-sm-12">
	               <c:if test="${txScreenAuthor.wrtngAuthor eq 'Y'}">
		            <button type="button" id="regBtn" class="btn btn-primary float-right" style="margin:5px 0 15px 2px;">등록</button>
		          </c:if>    
		          </div>
		            <div id="taskTmplatGrid"></div>
		              <div id="paging" class="portal-pager"></div>
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
    var PRI_URL = window.location.protocol + "//" + window.location.host
    var cudPage = 1;
    var offset;

    //자동시작 함수
    function pageInit() {
    	// 스크롤바 이동하기 위한 설정
        offset = $('#taskTmplatMngMain').offset();
    	
    	
    	<c:choose>
    	    <c:when test="${txScreenAuthor.untenantAuthor eq 'Y'}">
    	        getProcessCdListByClsCd("searchProcessCd", "");
    	    </c:when>
    	    <c:otherwise>
    	        getProcessCdListByClsCd("searchProcessCd", "${sessionScope.sessionUserInfo.txCmpnyCd}");
    	    </c:otherwise>
    	</c:choose>
    	
<c:if test="${txScreenAuthor.untenantAuthor eq 'Y'}">
    var params = [];
    params.push({"id" : "searchCmpnyCd", "clsCd" : "0024"});    //회사
    requestCmmnCd(params);
</c:if>
    	
    	
    	        
        getTaskTmplatList(cudPage);
    };
   
    function bindEvent(){
    	
    	/* 시작날짜 내보내기 */
    	$('#startDeDiv').datetimepicker({
            format: 'YYYY-MM-DD'
          , defaultDate: getMonthGapDate(-3)
        });
    	
    	/* 마지막날짜 내보내기 */
        $("#endDeDiv").datetimepicker({
            format: 'YYYY-MM-DD'
          , defaultDate: (new Date())
        });
        
        /* 검색버튼 누를 시 검색 및 그리드 작성 */
        $("#searchBtn").on("click",function(){
            $(".pagingClass").remove();
            getTaskTmplatList(cudPage);
        });
        
       /*  엔터 키 누를시 검색 및 그리드 작성 */
        $("#tmplatCd").keyup(function(e){
            if(e.keyCode == 13){
                $(".pagingClass").remove();
                getTaskTmplatList(cudPage); 
            }
        });
       
        //등록페이지로 pop
        $("#regBtn").on("click",function(){
        	popupRegist();
        });
        
        /*시작 일자가 마지막일자보다 클 시*/
        $("#startDe").on("propertychange change paste input", function(){
        	if(unhyphenationPhoneNum($("#startDe").val()) > unhyphenationPhoneNum($("#endDe").val())){
                alert("시작일자가 마지막 일자보다 과거일 수 없습니다.");
                return $("#startDe").val(getMonthGapDate(-3));
                }
        });
        
        /*마지막 일자가 시작 일자보다 작을 시*/
        $("#endDe").on("propertychange change paste input", function(){
            if(unhyphenationPhoneNum($("#startDe").val()) > unhyphenationPhoneNum($("#endDe").val())){
                alert("마지막 일자가  시작일자보다 과거일 수 없습니다.");
                return $("#endDe").val(getMonthGapDate(0)-1); //"-"추가 필요 
            }
        });
        
        //체크박스 클릭시
        $("#check").on("click", function(){        	
        	if ($("input:checkbox[id='check']").is(":checked") == true){
        		$("#startDe").attr("disabled", false);
        		$("#endDe").attr("disabled", false);
        	} else {
                $("#startDe").attr("disabled", true);
                $("#endDe").attr("disabled", true);
        	}   
        });        
    }
    
    // 리스트 부르기
    function getTaskTmplatList(cudPage){
        var url = "/stdrinfo/tmplat/getTaskTmplatMng";
        var processCd = $("#searchProcessCd").val();
        var tmplatNm = $("#tmplatNm").val();
        var tmplatCd = $("#tmplatCd").val();
        var startDt = unhyphenationPhoneNum($("#startDe").val());
        var lastDt = unhyphenationPhoneNum($("#endDe").val());
        var param = new Object();
        var currentPageNo = 1;
        
        if (cudPage != null && cudPage != undefined && cudPage != "") {
            currentPageNo = cudPage;
        }
        
        param.pageInfo = {currentPageNo : currentPageNo};
        
        if ($("input:checkbox[id='check']").is(":checked") == false){
            startDt = "all";
        }
        
        param.tmplatCd = tmplatCd;
        param.tmplatNm = tmplatNm;
        param.processCd = processCd;
        param.startDt = startDt;
        param.lastDt = lastDt;
        param.cmpnyCd = $("#searchCmpnyCd").val();
        
        callAsyncAjax(url, param, "drawGrid");
    }
    
    // 테이블 그리기
    function drawGrid(data){    	
    	
        var pageSize = 10;
        
        if(data != ""){
        	taskTmplatMngList = data.result.taskTmplatMngList;
        	drawPager("paging", taskTmplatMngList.pageInfo, "getTaskTmplatList");
        }
        $("#taskTmplatGrid").jsGrid({
            height : "399",
            width : "100%",
            autoload: true,
            sorting : true,
            align : "left",
            data: data.result.taskTmplatMngList.items,
            rowClick: function(arg){
            	taskTmplatDetail(arg.item.sn);
            }, 
            fields : [ 
            	{name: "processCd" ,title : "프로세스코드", width : 35, align:"left"},  
            	{name: "tmplatCd" ,title : "템플릿코드", width : 40, align:"center"},
            	{name: "oriFileNm" ,title : "템플릿 파일명", width : 100, align:"left"}, 
                {name: "regDt" ,title : "등록일",type : "text", 
                	itemTemplate:function(value){
                    return moment(value).format('YYYY-MM-DD');
                    }, width : 70, align:"left"}, 
                {name: "updtDt" ,title : "수정일",type : "text", 
                    itemTemplate:function(value){
                    if(value != null) {
                    	return moment(value).format('YYYY-MM-DD');
                    }
                    }, width : 70, align:"left"},
                {
                    name: "dwldUrl" ,title : "다운로드 URL", width : 100, align:"left",
                   	itemTemplate:function(_, item){
                           if(item != null) {
                               return PRI_URL + '/file/templateDownloadAtchmnfl?fileGrpNo=' + item.fileGrpNo + '&fileNo=1';
                           }
                   	}
                }, 
                {name: ""            , title : "다운로드"   , type : "text" , width : 40, align : "center",
                    itemTemplate: function(_, item) {
                        return $("<button>").text("다운로드").on("click", function() {
                        	window.location.href = PRI_URL + '/file/downloadUrlAtchmnfl?fileGrpNo=' + item.fileGrpNo + '&fileNo=1';
                        	return false;
                        });
                    }
                }
            ]
        });
    }
    
    /*
     * 등록페이지 팝업
     * @param 
     * @return
     */
    function popupRegist() {
    	// 로딩 시작
        $('.dimmed').css({ display: 'block' });
        $('.loading').css({ display: 'block' });
        $('.loading').addClass('show');
        
    	// 스크롤 이동
        $('html').animate({scrollTop : offset.top}, 600);
        appendDetailPopup("taskTmplatMngMain", "/stdrinfo/tmplat/taskTmplatMngRegPop");
    }
    
    /*
     * 상세페이지 pop
     * @param
     * @return
     */
    function taskTmplatDetail(tmplatSn) {
    	// 로딩 시작
        $('.dimmed').css({ display: 'block' });
        $('.loading').css({ display: 'block' });
        $('.loading').addClass('show');
        
    	// 스크롤 이동
        $('html').animate({scrollTop : offset.top}, 600);
   		appendDetailPopup("taskTmplatMngMain", "/stdrinfo/tmplat/taskTmplatDetailPop");
        detlTmplatSn = tmplatSn;
    };
    
    /*
     * popup창 닫기
     * @param
     * @return
     */
    function closePop() {
        $(".over").remove();
        getTaskTmplatList(cudPage);
    }
        
</script>