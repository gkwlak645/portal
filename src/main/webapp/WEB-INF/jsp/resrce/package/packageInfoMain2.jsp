<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div id="packageLibraryMainDiv" class="container-fluid wrap">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <form class="form-inline">
                        <div class="form-group col-md-10 py-sm-2">
                        <input type="radio" name="checkRadio" id="package" value="package" checked>패키지 &nbsp;&nbsp;&nbsp;
                        <input type="radio" name="checkRadio" id="library" value="library">라이브러리
                        </div>
                        <div class="form-group col-md-10 py-sm-2">
                            <div class="col-sm-2">
                                <label id="checkPackage">패키지 명</label>
                                <label id="checkLibrary">라이브러리 명</label>
                            </div>
                            <div class="col-sm-8">
                                  <input type="text" class="form-control  float-left" id="txtSearchKwrd" name="searchKwrd" style="width:200px;" value="" />
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
                <div class="card-header">
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
                
                    <div id="packageLibraryRequstGrid"></div>
                    <div id="packageLibraryRequstGridPager" class="portal-pager"></div>
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
        searchPackageLibraryList();
        
        $("#checkLibrary").hide();
    };
    
    /*
     * 이벤트 바인딩
     * @param
     * @return
     */
    function bindEvent(){

        //조회버튼 클릭 이벤트 처리
        $("#btnSearch").on("click",function(e){
        	searchPackageLibraryList();
        });
        
        //등록버튼 클릭 이벤트
        $("#btnReg").on("click",function(){
            appendDetailPopup("taskRequstMainDiv", "/task/requst/taskRequstRegisterPop");
        });
        
        $('input:radio[name="checkRadio"]').on("change" , function(){
        	radioVal = $('input:radio[name="checkRadio"]:checked').val();
            if(radioVal == "package"){
            	$("#checkLibrary").hide();
            	$("#checkPackage").show();
            }else{
            	$("#checkLibrary").show();
            	$("#checkPackage").hide();
            }
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
            drawPager("packageLibraryRequstGridPager", data.result.paginationInfo, "searchPackageLibraryList");
        }
        
        $("#packageLibraryRequstGrid").jsGrid({
              height : "auto"
            , width : "100%"
            , autoload: true
            , sorting : true
            , align : "center"
            , data : params
            , fields : [
                  {name: ""            , title : " " , type : "text" , width : 0 , visible : false}
                , {name: "identifier"  , title : "패키지명"   , type : "text" , width : 100}
                , {name: "description" , title : "설명"  , type : "text" , width : 200, align : "center" }
                , {name: "lastupdated" , title : "게시일"   , type : "text" , width : 80, align : "center"}
                , {name: ""            , title : "버전정보"   , type : "text" , width : 80, align : "center",
                	itemTemplate: function(_, item) {
                	    return $("<button class='btn btn-outline-primary'style='padding:2px;min-width:74px;'>").text("버전정보").on("click", function() {
                	        appendDetailPopup("packageLibraryMainDiv", "/resrce/package/packageVerMng");
                	        packageLibrayVerList(item.identifier);
                	    });}}
                , {name: ""            , title : "이력보기"  , type : "text" , width : 80, align : "center", 
                	itemTemplate: function(_, item) {
                        return $("<button class='btn btn-outline-secondary' style='padding:2px;min-width:74px;'>").text("이력보기").on("click", function() {
                            appendDetailPopup("packageLibraryMainDiv", "/resrce/package/packageHistInqire");
                            packageLibrayList(item.identifier);
                        });}}
            ]
        });
        
    }
    
    /*
     * 검색
     * @param 페이지번호
     * @return
     */
    function searchPackageLibraryList(pageNo) {
        //조회조건 유효성 검사

        var url = '/resrce/package/getPackageLibraryList';
        var currentPageNo = 1;
        if (pageNo != null && pageNo != undefined && pageNo != "") {
            currentPageNo = pageNo;
        }

        var param = {
        	checked : $('input:radio[name="checkRadio"]:checked').val(),
            searchKwrd: $("#txtSearchKwrd").val(),
            currentPageNo:currentPageNo,
            recordCountPerPage:10,
            pageSize:10
        };
        
        callAsyncAjax(url, param, "drawGrid");
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
