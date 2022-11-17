<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div id="mappMainDiv" class="container-fluid wrap">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <form class="form-inline">
                        
                        <div class="form-group col-md-5 py-sm-2">
                          <label for="schCmpny" class="col-sm-3 col-form-label">회사</label>
                          <div class="col-sm-9">
                              <select id="schCmpny" class="form-control" style="width:60%;max-width:200px;">
                                  <option value=""></option>
                              </select>
                          </div>
                        </div>
                        <div class="form-group col-md-5 py-sm-2">
	                    	<label for="searchProcessState" class="col-sm-3 col-form-label">프로세스 상태</label>
	                        <div class="col-sm-9">
	                            <select id="searchProcessState" class="form-control"  style="width:60%;max-width:200px;">
	                                <option value=""></option>
	                            </select>
	                        </div>
	                    </div>
                        <div class="form-group col-md-5 py-sm-2" style="margin: 0.3rem 0 0.3rem 0;">
                          <label for="usr" class="col-sm-3 col-form-label">프로세스 코드</label>
                          <div class="col-sm-9">
                              <input type="text" class="form-control float-left" value="" id="searchProcessCd" style="min-width: 160px;width:70%;" maxlength="6">
                          </div>
                        </div>
                        <div class="form-group col-md-5 py-sm-2" style="margin: 0.3rem 0 0.3rem 0;">
                          <label for="usr" class="col-sm-3 col-form-label">프로세스 명</label>
                          <div class="col-sm-9">
                              <input type="text" class="form-control float-left" value="" id="searchProcessNm" style="min-width: 160px;width:70%;">
                          </div>
                        </div>
                        <div class="col-md-2 float-right" style="margin-bottom: 10px">
                            <button type="button" id="btnSearch" class="btn btn-info float-right">검색</button>
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
                    <div id="dataGrid"></div>
                    <div id="dataGridPager" class="portal-pager"style="text-align:center"></div>
                </div>
            </div>
        </div>
    </div>
</div>


<!-- 로딩바  -->
<div class="dimmed" style="display:none"></div>
<div class="loading" style="display:none">
    <div class="loading-bar"><div></div><div></div><div></div><div></div></div>
    <span class="loading-text">데이터 로딩중...</span>
</div>
<script>

//검색조건 - 시작일자
var processCd;
var refDivCd;
var tenantIdForSelectPop;
var cmpnyCdForSelectPop;

    /*
     * 페이지 초기화
     * @param
     * @return
     */
    function pageInit() {

        var params = [];
        if("${txScreenAuthor.untenantAuthor}" == 'Y'){
            params.push({"id" : "schCmpny", "clsCd" : "0024"});    //회사
        }else{
            params.push({"id" : "schCmpny", "clsCd" : "0024", "disable" : "Y", "selectValue": "${sessionUserInfo.txCmpnyCd}"});    //회사
        }
        
        params.push({"id" : "searchProcessState"   , "clsCd" : "0057"});    //오류발생구분
        
        requestCmmnCd(params);
        
        
        if("${mainInitAt}" != null && "${mainInitAt}" != ""){
        	startFmtDate = (new Date()).getDate()
        }else{
        	startFmtDate = (new Date()).getDate() -7
        }
        
        //그리드 초기화
        drawGrid();
    };
    
    /*
     * 이벤트 바인딩
     * @param
     * @return
     */
    function bindEvent(){

        //조회버튼 클릭 이벤트 처리
        $("#btnSearch").on("click",function(){
        	searchProMappList();
        });
        
        //오류발생구분 change 이벤트
        $("#searchProcessState").on("change",function(){
            var occrrncSeCd = $('#searchProcessState').val(); 

            var params = [];
            if(occrrncSeCd != ''){
            	params.push({"id" : "searchTyCd" , "clsCd" : occrrncSeCd});
            	requestCmmnCd(params);
            }else{
            	$("#searchTyCd").html("<option value=''>선택</option>");
            }
        });
        
        searchProMappList();
    }
    
    /*
     * 그리드 초기화
     * @param
     * @return
     */
    function drawGrid(data){
    	//alert(JSON.stringify(data));
        var params = {};
        if (data != null && data != undefined) {
        	if (data.result != null && data.result.resultList != null) {
                params = data.result.resultList;
        	}
            drawPager("dataGridPager", data.result.paginationInfo, "searchProMappList");
        }

        $("#dataGrid").jsGrid({
              height : "auto"
            , width : "100%"
            , autoload: true
            , sorting : true
            , align : "center"
            , data : params
            , rowClick: function(arg){
            	//proMapping(arg.item.processCd);
            }
            , fields : [
                  {name: "releasesId"               , title : "아이디"         , type : "text"   , width : 0 , visible : false }
                , {name: "cmpnyNm"        , title : "회사"          , type : "text"   , width : 60}
                , {name: "processCd"        , title : "프로세스코드"          , type : "text"   , width : 60, itemTemplate: function(value, item) {
                	var proCd = '';
                	proCd += '<span style="display: block;    text-decoration: none;    text-overflow: ellipsis;    white-space: nowrap;    overflow: hidden;" title="'+ value +'" onclick="proMapping('+ item.processCd +')">' + value + '</span>';
                	return $(proCd).on("click", function(){
                		proMapping(item , 0);
                	})}}
                , {name: "processNm"      , title : "프로세스명"        , type : "text"   , width : 180, itemTemplate: function(value, item) {
                	var proCd = '';
                	proCd += '<span style="display: block;    text-decoration: none;    text-overflow: ellipsis;    white-space: nowrap;    overflow: hidden;" title="'+ value +'" onclick="proMapping('+ item.processCd +')">' + value + '</span>';
                	return $(proCd).on("click", function(){
                		proMapping(item , 0);
                	})}}
                , {name: "processSttus"        , title : "프로세스상태"           , type : "text"   , width : 60}
                , {name: "orcProcessCd"        , title : "매핑"          , type : "text"   , width : 50, align : "center" , itemTemplate: function(value, item) {
                    var proSttus = '';
                    if(item.orcProcessCd == '1'){
                    	proSttus += '<span ">[등록]</span>';                    	
                    }else{
                    	proSttus += '<span ">[삭제]</span>';
                    }
                    return $(proSttus).on("click", function(){
                    	if(item.orcProcessCd == '1'){
		           			proMapping(item , 1);		  
		           			debugger;
                    	}else{
	                    	if(confirm('매핑 데이터를 삭제하시겠습니까?')){
	                    		mappDelete(item);
	                    	}
	                    	return false;
                    	}
                    });
                }}
            ]
        });
        
        // 로딩 끝
        $('.dimmed').css({ display: 'none' });
        $('.loading').css({ display: 'none' });
        $('.loading').removeClass('show');
    }
    
    /*
     * 검색
     * @param 페이지번호
     * @return
     */
    function searchProMappList(pageNo) {
    	//alert(JSON.stringify(pageNo));
        var url = '/mntrng/pousermapp/getProMappList';
        var currentPageNo = 1;

        //재실행 성공시 msg alert 출력
        if (pageNo != null && pageNo != undefined && pageNo != "") {
        	if(typeof pageNo != Number && pageNo.result != null){
        		alert(JSON.stringify(pageNo.result.msg).replace(/\"/gi,""));
        	}else{
            currentPageNo = pageNo;        		
        	}
        }
        
        var param = {
        	cmpnyCd: $("#schCmpny").val(),
        	searchProcessState: $("#searchProcessState").val(),
            searchProcessCd: $("#searchProcessCd").val(), 
            searchProcessNm: $("#searchProcessNm").val(),	
            currentPageNo:currentPageNo,
            recordCountPerPage:10,
            pageSize:10
        }; 
        
        callAsyncAjax(url, param, "drawGrid");
        
        // 로딩 시작
        $('.dimmed').css({ display: 'block' });
        $('.loading').css({ display: 'block' });
        $('.loading').addClass('show');
    }
    
    /*
     * 프로세스 맵핑
     * @param 
     * @return
     */
    function proMapping(item, divCd) {
    	
		processCd = item.processCd;
		tenantIdForSelectPop = item.tenantId;
		refDivCd = divCd;
		cmpnyCdForSelectPop = item.cmpnyCd;
        appendDetailPopup("mappMainDiv", "/mntrng/pousermapp/poUserMappDetailPop");
		
    };
    
    /*
     * 프로세스 매핑 삭제
     * @param 
     * @return
     */
    function mappDelete(item) {
    	
 		var url = '/mntrng/pousermapp/proDelete';
		
		var param = {"processCd":item.processCd};
		
		callSyncAjax(url, param, "searchProMappList");
        
    };
    
    /*
     * popup창 닫기
     * @param
     * @return
     */
    function closePOP(data){
    	if(data != null){
    		alert(JSON.stringify(data.result.msg).replace(/\"/gi,""));
    	}
        $(".over").remove();
        searchProMappList();
    }
    
</script>
