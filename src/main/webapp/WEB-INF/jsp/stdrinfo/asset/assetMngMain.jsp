<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<div id="assetMainDiv" class="container-fluid wrap">
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
                          <label for="scAssetName" class="col-sm-3 col-form-label">Asset 명</label>
                          <div class="col-sm-8">
                              <input type="text" name="scAssetName" class="form-control float-left" id="scAssetName" style="width:80%;">
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
                    <div id="assetGrid"></div>
                    <div id="assetGridPager" class="portal-pager"></div>
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
var offset;

    /*
     * 페이지 초기화
     * @param
     * @return
     */
    function pageInit() {
    	// 스크롤바 이동하기 위한 설정
        offset = $('#assetMainDiv').offset();

        var params = [];
        if("${txScreenAuthor.untenantAuthor}" == 'Y'){
            params.push({"id" : "schCmpny", "clsCd" : "0024"});    //회사
        }else{
            params.push({"id" : "schCmpny", "clsCd" : "0024", "disable" : "Y", "selectValue": "${sessionUserInfo.txCmpnyCd}"});    //회사
        }
        //params.push({"id" : "schCmpny", "clsCd" : "0024"});    //회사
        requestCmmnCd(params);
        
        drawGrid();
        searchAssetList();
        
    };
    
    /*
     * 이벤트 바인딩
     * @param
     * @return
     */
    function bindEvent(){
        
        $("#scAssetName").keyup(function(e){
            if(e.keyCode == 13){
                searchAssetList();
            }
        });
        
        //조회버튼 클릭 이벤트 처리
        $("#btnSearch").on("click",function(){
            searchAssetList();
        });
        
        //등록버튼 클릭 이벤트 처리
        $("#btnReg").on("click", function(){
        	// 로딩 시작
            $('.dimmed').css({ display: 'block' });
            $('.loading').css({ display: 'block' });
            $('.loading').addClass('show');
            
            // 스크롤 이동
            $('html').animate({scrollTop : offset.top}, 600);
            
            assetId = "";
            appendDetailPopup("assetMainDiv", "/stdrinfo/asset/assetRegistPop");
        
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
            drawPager("assetGridPager", data.result.paginationInfo, "searchAssetList");
        }
        
        $("#assetGrid").jsGrid({
              height : "auto"
            , width : "100%"
            , autoload: true
            , sorting : true
            , align : "center"
            , data : params
            , rowClick: function(arg){
                  popupDetail(arg.item.cmpnyCd, arg.item.id);
                  orgName = arg.item.name;
              }
            , fields : [
                  {name: "id"               , title : "아이디"         , type : "text"   , width : 0 , visible : false}
                , {name: "cmpnyName"        , title : "회사"          , type : "text"   , width : 100, align : "center" }
                , {name: "name"             , title : "Asset명"      , type : "text"   , width : 130}
                , {name: "description"      , title : "설명"          , type : "text"   , width : 170}
                , {name: "valueTypeName"    , title : "형식"          , type : "text"   , width : 100, align : "center" }
                , {name: "value"            , title : "값"            , type : "text"   , width : 200}
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
    function searchAssetList(pageNo) {
    	// 로딩 시작
        $('.dimmed').css({ display: 'block' });
        $('.loading').css({ display: 'block' });
        $('.loading').addClass('show');

        var url = '/stdrinfo/asset/getAssetList';
        var currentPageNo = 1;
        if (pageNo != null && pageNo != undefined && pageNo != "") {
            currentPageNo = pageNo;
        }
        var param = {
            cmpny: $("#schCmpny").val(),
            name: $("#scAssetName").val(),
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
    function popupDetail(assetCmpnyCd, id) { 
    	// 로딩 시작
        $('.dimmed').css({ display: 'block' });
        $('.loading').css({ display: 'block' });
        $('.loading').addClass('show');

        // 스크롤 이동
        $('html').animate({scrollTop : offset.top}, 600);
        
        //상세 페이지 div 생성
        appendDetailPopup("assetMainDiv", "/stdrinfo/asset/assetRegistPop");

        //상세 페이지 데이터 조회
        cmpnyCd = assetCmpnyCd;
        assetId = id;
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
