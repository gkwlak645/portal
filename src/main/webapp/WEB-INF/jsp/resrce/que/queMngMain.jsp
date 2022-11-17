<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
    
<div id="queMainDiv" class="container-fluid wrap">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <form class="form-inline" onSubmit="return false;">
                        <div class="form-group col-md-5 py-sm-2">
                          <label for="schCmpny" class="col-sm-3 col-form-label">회사</label>
                          <div class="col-sm-8">
                              <select id="schCmpny" class="form-control" style="width:80%;">
                                  <option value=""></option>
                              </select>
                          </div>
                        </div>                        
                        <div class="form-group col-md-5 py-sm-2">
                          <label for="schQueName" class="col-sm-3 col-form-label">큐 명</label>
                          <div class="col-sm-8">
                              <input type="text" name="schQueName" class="form-control float-left" id="schQueName" style="width:80%;">
                          </div>
                        </div>
                        <div class="form-group col-md-2">
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
                     <c:choose>
                        <c:when test="${txScreenAuthor != null}">
                            <c:choose>
                                <c:when test="${txScreenAuthor.wrtngAuthor eq 'Y'}">
                                    <button type="button" id="btnReg" class="btn btn-primary float-right" style="margin:5px 0 15px 2px;">등록</button>
                                </c:when>
                                <c:otherwise></c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:otherwise></c:otherwise>
                    </c:choose>  
                    <div id="queGrid"></div>
                    <div id="queGridPager" class="portal-pager"></div>
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

        var params = [];
        if("${txScreenAuthor.untenantAuthor}" == 'Y'){
            params.push({"id" : "schCmpny", "clsCd" : "0024"});    //회사
        }else{
            params.push({"id" : "schCmpny", "clsCd" : "0024", "disable" : "Y", "selectValue": "${sessionUserInfo.txCmpnyCd}"});    //회사
        }
        //params.push({"id" : "schCmpny", "clsCd" : "0024"});    //회사
        requestCmmnCd(params);
        
        drawGrid();
        searchQueList();
    };
    
    /*
     * 이벤트 바인딩
     * @param
     * @return
     */
    function bindEvent(){
    	
    	$("#schQueName").keyup(function(e){
            if(e.keyCode == 13){
                searchQueList();
            }
        });
        
        //조회버튼 클릭 이벤트 처리
        $("#btnSearch").on("click",function(){
            searchQueList();
        });
        
        //등록버튼 클릭 이벤트 처리
        $("#btnReg").on("click", function(){
        	queId = "";
        	appendDetailPopup("queMainDiv", "/resrce/que/queRegistPop");
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
            drawPager("queGridPager", data.result.paginationInfo, "searchQueList");
        }
        
        $("#queGrid").jsGrid({
              height : "auto"
            , width : "100%"
            , autoload: true
            , sorting : true
            , align : "center"
            , data : params
            , rowClick: function(arg){ 
                  popupDetail(arg.item.cmpnyCd,arg.item.id);
              }
            , fields : [
                  {name: "id"               , title : "아이디"                 , type : "text"   , width : 0 , visible : false}
                , {name: "releaseId"        , title : "릴리즈(프로세스)아이디"     , type : "text"   , width : 0 , visible : false}
                , {name: "cmpnyName"        , title : "회사"                  , type : "text"   , width : 100, align : "center" }
                , {name: "name"             , title : "Queue명"               , type : "text"   , width : 100, align : "center" }
                , {name: "description"      , title : "설명"                  , type : "text"   , width : 200}
                , {name: "releaseName"      , title : "프로세스명"              , type : "text"   , width : 100}
            ]
        });
        
    }
    
    /*
     * 검색
     * @param 페이지번호
     * @return
     */
    function searchQueList(pageNo) {
        var url = '/resrce/que/getQueList';
        var currentPageNo = 1;
        if (pageNo != null && pageNo != undefined && pageNo != "") {
            currentPageNo = pageNo;
        }
        var param = {
            cmpny: $("#schCmpny").val(),
            name: $("#schQueName").val(),
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
    function popupDetail(cmpny,id) { 

        //상세 페이지 div 생성
        appendDetailPopup("queMainDiv", "/resrce/que/queRegistPop");

        //상세 페이지 데이터 조회
        cmpnyCd = cmpny;
        queId = id;
    };
    
    
    /*
     * popup창 닫기
     * @param
     * @return
     */
    function closePOP() {
        $(".over").remove();
    }

 
</script>
