<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


                    <!--  템플릿 바디 -->
                    <div id="loginListMntrngMain" class="container-fluid wrap">                        
                        <div class="row">
                            <div class="col-md-12">
                                <div class="card">
                                    <div class="card-header">
                                        <form id="searchForm" name="searchForm" class="form-inline">                                            
                                            <div class="form-group row col-sm-6">
                                                <label for="usr" class="col-sm-4 col-form-label">회사</label>
                                                <div class="col-sm-8">
                                                    <select id="searchCmpnyCd" class="form-control float-left"  style="min-width: 80px;width:60%;">
					                                   <option value=""></option>
					                               </select> 
                                                </div>                                                
                                            </div>
                                            <div class="form-group row  col-sm-6">
                                                <label for="usr" class="col-sm-4 col-form-label">권한</label>
                                                <div class="col-sm-8">
                                                    <select class="form-control float-left" id="searchRole"style="width:60%;" >
                                                        <option value=""></option>
                                                    </select>
                                                </div>
                                            </div>
                                            

                                            <div class="form-group row  col-sm-6">
                                                <label for="usr" class="col-sm-4 col-form-label">ID</label>
                                                <div class="col-sm-8">
                                                    <input type="text" name="" class="form-control" id="searchId" style="width: 60%; max-width: 196px;">
                                                </div>
                                            </div>
                                            <div class="form-group row  col-sm-6">
                                                <label for="usr" class="col-sm-4 col-form-label">이름</label>
                                                <div class="col-sm-8">
                                                    <input type="text" name=""class="form-control float-left" id="searchName" style="width: 60%; max-width: 196px;">
                                                    <button type="button" id="btnSearch" class="btn btn-info">조회</button>
                                                </div>
                                            </div>
                                        </form>
                                        
                                          
                                    </div>
                                </div>
                            </div>
                            
						    <div class="col-md-7">
						        <div class="card card-default">
						            <div class="card-body" style="height:600px; overflow:auto;">
						            <div><button type="button" id="btnOutExport" class="btn btn-primary float-right" style="margin: 5px 0 15px 2px;">엑셀 다운로드</button></div>
						              <div id="LoginListGrid"></div>
                                      <div id="LoginListGridPager" class="portal-pager"></div>
						           </div>
						       </div>
						    </div>
						    <div class="col-md-5">
						        <div class="card card-default">
						            <div class="card-body" style="height:292px;">	               
                                        <div id="LoginCountPerCmpGrid"></div>
						            </div>
						        </div>
						        <div class="card card-default">
                                    <div class="card-body" style="height:292px;">
                                        <div id="loginCountPerRoleGrid"></div>
                                    </div>
                                </div>
			                 </div>
                        </div>
	                </div>
	                <!--  템플릿 바디 끝 -->    

<!-- 로딩바  -->
<div class="dimmed" style="display:none"></div>
<div class="loading" style="display:none">
    <div class="loading-bar"><div></div><div></div><div></div><div></div></div>
    <span class="loading-text"></span>
</div>

<!-- 엑셀 다운로드 FORM -->                    
<form id="downloadFormExel" name="downloadFormExel" method="post">
    <input type="hidden" id="fileNo" name="fileNo" value="" />
    <input type="hidden" id="fileNm" name="fileNm" value="" />
</form>

<script>

var currentPageNo = 1;

var dataorexcel = 'data';

    $(document.body).ready(function () { 
    	loadingTextChange();
    	
        var params = [];

        if("${txScreenAuthor.untenantAuthor}" == 'Y'){
            //params.push({"id" : "searchCmpnyCd", "clsCd" : "0024", "selectValue": "${sessionUserInfo.txCmpnyCd}"});    //회사
            params.push({"id" : "searchCmpnyCd", "clsCd" : "0024"});    //회사

        }else{
            params.push({"id" : "searchCmpnyCd", "clsCd" : "0024", "disable" : "Y", "selectValue": "${sessionUserInfo.txCmpnyCd}"});    //회사
        }
                
        requestCmmnCd(params);
        
        searchPortalLoginList();
    });
       
    /*
     * 이벤트 바인딩
     * @param
     * @return
     */
    function bindEvent() {
        // 회사 조회
        $("#btnSearch").on("click",function(){
        	searchPortalLoginList();
        });      
        
        //엑셀다운로드
        $("#btnOutExport").on('click', function(){
            outExport();
        });
    }
    
    function getToday(){
        var date = new Date();
        var year = date.getFullYear();
        var month = ("0" + (1 + date.getMonth())).slice(-2);
        var day = ("0" + date.getDate()).slice(-2);
        return year + month + day;
    }

    function loadingTextChange() {
        if(dataorexcel == 'data') {
            $(".loading-text")[0].innerHTML = "데이터 로딩 중...";
        }else {
            $(".loading-text")[0].innerHTML = "엑셀 다운로드 중...";
        }
    }
    
    //엑셀다운로드
    function outExport(){
    	
        dataorexcel = "excel";
        loadingTextChange(); // 엑셀 다운로드 중
        //결재 로딩바 
        $('.dimmed').css({ display: 'block' });
        $('.loading').css({ display: 'block' });
        $('.loading').addClass('show');
        
        var url = '/author/loginlistmntrng/outExportLoginList';

        var param = {
                searchCmpnyCd           : $("#searchCmpnyCd").val()
                , searchRoleCd          : $("#searchRole").val()
                , searchId              : $("#searchId").val()
                , searchName            : $("#searchName").val()
                , excelDownload         : 'Y'
            };
 
        callAsyncAjax(url, param, "exportCallback");
    }

    //엑셀다운로드 콜백
    function exportCallback(data) {
        $("#fileNo").val(data.result.fileNo);
        $("#fileNm").val(getToday() + "_Portal_접속가능명단");
        var frmData = document.downloadFormExel;
        frmData.action = "/file/downloadExport"; 
        frmData.submit();
        
        $('.dimmed').css({ display: 'none' });
        $('.loading').css({ display: 'none' });
        $('.loading').removeClass('show');
    }

    
    function makeSelectBoxRole(roleList) {
        var saveRoleName = $("#searchRole").val();
        var template = '<option value="전체">전체</option>';
        
        //<option value=""></option>
        for(var i=0; i<roleList.length; i++) {             
            template += '<option value=' + roleList[i].roleCd + '>' + roleList[i].roleNm + '</option>';
        }
        
        $("#searchRole").html(template);   
        
        if(saveRoleName != null && saveRoleName != "") {
            $("#searchRole").val(saveRoleName).attr("selected", "selected");
        }
    }
    
    /*
     * 테이블 초기화
     * @param
     * @return
     */
    function drawTable(data){
        var params = {};
        var loginCountPerCmpList = {};
        var loginCountPerRoleList = {};

        // 데이터 존재 여부에 따른 조건 처리 
        if (data != null && data != undefined) {        
            if (data.result != null && data.result.resultList != null) {
            	params = data.result.resultList;
            }
            drawPager("LoginListGridPager", data.result.paginationInfo, "searchPortalLoginList");
            
            // 회사별 인원수
            if (data.result != null && data.result.loginCountPerCmpList != null) {
            	loginCountPerCmpList = data.result.loginCountPerCmpList;
            }
            
            // 역할별 인원수
            if (data.result != null && data.result.loginCountPerRoleList != null) {
            	loginCountPerRoleList = data.result.loginCountPerRoleList;
            }
            
            // 역할 리스트
            if (data.result != null && data.result.roleList != null) {
            	makeSelectBoxRole(data.result.roleList);
            }
        }        
        
        $("#LoginListGrid").jsGrid({
            height : "auto"
          , width : "100%"
          , autoload: true
          , sorting : true
          , align : "left"
          , data : params
          , rowClick: function(arg){
              //jobErrorDetail(arg.item.id);
          }
          , fields : [
                {name: "cmpNm"     , title : "회사"   , type : "text" , width : 30 , align : "left"}
              , {name: "name"      , title : "이름"   , type : "text" , width : 40, align : "left"}
              , {name: "id"        , title : "ID"    , type : "text" , width : 30, align : "left"}
              , {name: "roleNm"    , title : "권한"   , type : "text" , width : 30, align : "left"}
          ]
      });
        
        // height가 auto가 아니라 100%이면 스크롤바 생김(jsgrid)
        // 회사별 인원수
        $("#LoginCountPerCmpGrid").jsGrid({
            height : "100%"
          , width : "100%"
          , autoload: true
          , sorting : true
          , align : "left"
          , data : loginCountPerCmpList
          , rowClick: function(arg){
              //jobErrorDetail(arg.item.id);
          }
          , fields : [
                {name: "cmpNm"     , title : "회사"   , type : "text" , width : 30, align : "left", 
                    itemTemplate: function(value, item) { 
                    	if(item.cmpNm == '총 인원 수') {
                            return '<span style="font-weight:bold;">' + value + '</span>'
                    	}
                    	
                    	return value;
                       }
                   }
              , {name: "cmpCount"  , title : "인원수"  , type : "text" , width : 30, align : "left", 
            	  itemTemplate: function(value, item) { 
            		  if(item.cmpNm == '총 인원 수') {
                          return '<span style="font-weight:bold;">' + value + '</span>'
                      }
                      return value;
            	  }
              }
          ]
      });
        
        
        // height가 auto가 아니라 100%이면 스크롤바 생김(jsgrid)
        // 역할별 인원수
        $("#loginCountPerRoleGrid").jsGrid({
            height : "100%"
          , width : "100%"
          , autoload: true
          , sorting : true
          , align : "left"
          , data : loginCountPerRoleList
          , rowClick: function(arg){
              //jobErrorDetail(arg.item.id);
          }
          , fields : [
                {name: "roleNm"     , title : "권한"   , type : "text" , width : 30, align : "left", 
                    itemTemplate: function(value, item) { 
                        if(item.roleNm == '총 인원 수') {
                            return '<span style="font-weight:bold;">' + value + '</span>'
                        }
                        
                        return value;
                       }
                   }
              , {name: "roleCount"  , title : "인원수"  , type : "text" , width : 30, align : "left", 
                  itemTemplate: function(value, item) { 
                      if(item.roleNm == '총 인원 수') {
                          return '<span style="font-weight:bold;">' + value + '</span>'
                      }
                      
                      return value;
                     }
                 }
          ]
      });
        
        
        // 로딩 끝
        $('.dimmed').css({ display: 'none' });
        $('.loading').css({ display: 'none' });
        $('.loading').removeClass('show');
    }
    
    function searchPortalLoginList(pageNo) {
    	
    	//로딩바 
    	dataorexcel = "data";
        loadingTextChange(); // 엑셀 다운로드 중
        $('.dimmed').css({ display: 'block' });
        $('.loading').css({ display: 'block' });
        $('.loading').addClass('show');
    	
    	var url = '/author/loginlistmntrng/searchPortalLoginList';

    	currentPageNo = 1;
        if (pageNo != null && pageNo != undefined && pageNo != "") {
            currentPageNo = pageNo;
        }

        var param = {
            searchCmpnyCd           : $("#searchCmpnyCd").val()
            , searchRoleCd          : $("#searchRole").val()
            , searchId              : $("#searchId").val()
            , searchName            : $("#searchName").val()
            , currentPageNo         : currentPageNo
            , recordCountPerPage    :   10
            , pageSize              :   5
        }; 
        
        callAsyncAjax(url, param, "drawTable");
    }
    
    

</script>    
	                
	                
	                