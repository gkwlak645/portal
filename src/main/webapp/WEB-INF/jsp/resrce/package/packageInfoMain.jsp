<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div id="packageLibraryMainDiv" class="container-fluid wrap">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <form class="form-inline" onSubmit="return false;">
                        <div class="form-group col-md-12 py-sm-2">
                            <input type="radio" name="checkRadio" id="package" value="package" checked>패키지 &nbsp;&nbsp;&nbsp;
                            <input type="radio" name="checkRadio" id="library" value="library">라이브러리
                        </div>
                        <div class="form-group col-md-5">
                             <label id="checkPackage" class="col-sm-2">패키지 명</label>
                             <label id="checkLibrary"class="col-sm-2">라이브러리 명</label>
                             <div class="col-sm-10">
                               <input type="text" class="form-control  float-left" id="txtSearchKwrd" name="searchKwrd" style="width:200px;" value="" />
                             </div>
                        </div>
                        <div class="form-group col-md-5" id="cmpnyDiv">
                             <label id="name" class="col-sm-2">회사</label>
                             <div class="col-sm-10 float-left">
                              <select class="form-control float-left" id="cmpnyCd" style="width:60%;max-width:200px;">
                              </select>
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


<!-- 로딩바  -->
<div class="dimmed" style="display:none"></div>
<div class="loading" style="display:none">
    <div class="loading-bar"><div></div><div></div><div></div><div></div></div>
    <span class="loading-text">로딩 중...</span>
</div>

<script>
var cd = '';
    /*
     * 페이지 초기화
     * @param
     * @return
     */
    function pageInit() {

        var params = [];
     if("${txScreenAuthor.untenantAuthor}" == 'Y'){
         params.push({"id" : "cmpnyCd", "clsCd" : "0024"});    //회사
     }else{
         params.push({"id" : "cmpnyCd", "clsCd" : "0024", "disable" : "Y", "selectValue": "${sessionUserInfo.txCmpnyCd}"});    //회사
     }
//         params.push({"id" : "cmpnyCd", "clsCd" : "0024"});    //회사
        requestCmmnCd(params);
        
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

        //엔터 검색 이벤트
        $("#txtSearchKwrd").keyup(function(e){
            if(e.keyCode == 13){
                searchPackageLibraryList();
            }
        });
        
        //조회버튼 클릭 이벤트 처리
        $("#btnSearch").on("click",function(e){
            searchPackageLibraryList();
        });
        
        //등록버튼 클릭 이벤트
        $("#btnReg").on("click",function(){
            appendDetailPopup("packageLibraryMainDiv", "/resrce/package/packageRegPop");
            packageLibraryView();
        });
        
        $('input:radio[name="checkRadio"]').on("change" , function(){
            radioVal = $('input:radio[name="checkRadio"]:checked').val();
            if(radioVal == "package"){
                $("#checkLibrary").hide();
                $("#checkPackage").show();
                $("#cmpnyDiv").show();
                searchPackageLibraryList();
            }else{
                $("#checkLibrary").show();
                $("#checkPackage").hide();
                $("#cmpnyDiv").hide();
                searchPackageLibraryList();
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
        console.log("params", params);
        console.log($('input:radio[name="checkRadio"]:checked').val());
        cd = $("#cmpnyCd option:checked").val();
        
        if($('input:radio[name="checkRadio"]:checked').val() == 'package'){
            $("#packageLibraryRequstGrid").jsGrid({
                height : "auto"
              , width : "100%"
              , autoload: true
              , sorting : true
              , align : "left"
              , data : params
              , fields : [
                    {name: "cmpnyCd"    , title : "" , type : "text" , width : 0, align : "left", visible : false}
                  , {name: "cmpnyNm"    , title : "회사명"   , type : "text" , width : 60, align : "left",
                      itemTemplate:function(value){
                          var str = '';
                          if(value == null || value == ""){
                              str = $("#cmpnyCd option:checked").text();
                          } else {
                              str = value;
                          }
                              return str;
                      }}
                  , {name: "Id"  , title : "이름"   , type : "text" , width : 120}
                  , {name: "Description" , title : "설명"  , type : "text" , width : 180, align : "left" }
                  , {name: "Published"    , title : "게시일"  , type : "text" , width : 60, align : "left",
                      itemTemplate:function(value){
                          return moment(value).format('YYYY-MM-DD');
                    }}
                  , {name: ""            , title : "버전정보"   , type : "text" , width : 80, align : "center",
                      itemTemplate: function(_, item) {
                          return $("<button class='btn btn-outline-primary'style='padding:2px;min-width:74px;'>").text("버전정보").on("click", function() {
                              cmpny = cd;
                              appendDetailPopup("packageLibraryMainDiv", "/resrce/package/packageVerMng");
                              packageLibrayVerList(item.Id, item.cmpnyCd);
                          });}}
                  , {name: ""            , title : "이력보기"  , type : "text" , width : 80, align : "center", 
                      itemTemplate: function(_, item) {
                          return $("<button class='btn btn-outline-secondary' style='padding:2px;min-width:74px;'>").text("이력보기").on("click", function() {
                              appendDetailPopup("packageLibraryMainDiv", "/resrce/package/packageHistInqire");
                              packageLibrayList(item.Id, item.cmpnyCd);
                          });}}        
              ]
          });
        } else {
            $("#packageLibraryRequstGrid").jsGrid({
                height : "auto"
              , width : "100%"
              , autoload: true
              , sorting : true
              , align : "left"
              , data : params
              , fields : [
                    {name: ""            , title : " " , type : "text" , width : 0 , visible : false}
                  , {name: "Id"  , title : "이름"   , type : "text" , width : 100}
                  , {name: "Description" , title : "설명"  , type : "text" , width : 200, align : "left" }
                  , {name: "Published"    , title : "게시일"  , type : "text" , width : 80, align : "left",
                      itemTemplate:function(value){
                          return moment(value).format('YYYY-MM-DD');
                    }}
                  , {name: ""            , title : "버전정보"   , type : "text" , width : 80, align : "center",
                      itemTemplate: function(_, item) {
                          return $("<button class='btn btn-outline-primary'style='padding:2px;min-width:74px;'>").text("버전정보").on("click", function() {
                              appendDetailPopup("packageLibraryMainDiv", "/resrce/package/packageVerMng");
                              packageLibrayVerList(item.Id, cd);
                          });}}
                  , {name: ""            , title : "이력보기"  , type : "text" , width : 80, align : "center", 
                      itemTemplate: function(_, item) {
                          return $("<button class='btn btn-outline-secondary' style='padding:2px;min-width:74px;'>").text("이력보기").on("click", function() {
                              appendDetailPopup("packageLibraryMainDiv", "/resrce/package/packageHistInqire");
                              packageLibrayList(item.Id, cd);
                          });}}
              ]
          });
        }
        
        
        $('.dimmed').css({ display: 'none' });
        $('.loading').css({ display: 'none' });
        $('.loading').removeClass('show');
        
    }
    
   
    
    /*
     * 검색
     * @param 페이지번호
     * @return
     */
    function searchPackageLibraryList(pageNo) {
        //조회조건 유효성 검사

        var url = '';
        if($('input:radio[name="checkRadio"]:checked').val() == 'package'){
            url = '/resrce/package/getPackageList';
        } else {
            url = '/resrce/package/getLibraryList';
        }
        
        var currentPageNo = 1;
        if (pageNo != null && pageNo != undefined && pageNo != "") {
            currentPageNo = pageNo;
        }
        
        var skip = (Number(currentPageNo)-1)*10;
        var param = {
            cmpnyCd : $("#cmpnyCd").val(),
            searchKwrd: $("#txtSearchKwrd").val(),
            skip : skip,
            currentPageNo : currentPageNo,
            recordCountPerPage : 10,
            pageSize : 10
        };
        
        callAsyncAjax(url, param, "drawGrid");
      //로딩바 
        $('.dimmed').css({ display: 'block' });
        $('.loading').css({ display: 'block' });
        $('.loading').addClass('show');
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
