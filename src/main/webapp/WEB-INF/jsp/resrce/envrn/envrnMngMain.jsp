<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div id="envrnMainDiv" class="container-fluid wrap">
    <div class="row"  alt="자원>환경관리">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <form id="searchForm" name="searchForm" class="form-inline" onsubmit="return false">
                    
                       <div class="form-group col-md-5 py-sm-2">
                            <label for="name" class="col-sm-3 col-form-label float-right">회사</label>
                            <select class="col-sm-8" id="schCmpny">
                            </select>
                       </div>
                       
                       <div class="form-group col-md-5 py-sm-2">
                         <label for="name" class="col-sm-3 col-form-label float-right">이름</label>
                         <div class="col-sm-8">
                             <input type="text" class="form-control" id="name">
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
                            </c:choose>
                        </c:when>                        
                    </c:choose>
                <div id="envrnGrid"></div>
                <div id="envrnGridPager" class="portal-pager"></div>
            </div>
        </div>
    </div>
</div>

<script>
var currentPageNo = 1;
var cd = '';

$(document.body).ready(function() {
	searchEnvrnList();
});

    //등록 환경 아이디
    var registerEnvrnId = '';
    var cmpnyCodeReg = "";
    
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
// 	    params.push({"id" : "schCmpny", "clsCd" : "0024"});    //회사
	    requestCmmnCd(params);
	     
        drawGrid();
    };
    
    /*
     * 이벤트 바인딩
     * @param
     * @return
     */
    function bindEvent(){
    	
    	//엔터 검색 이벤트
        $("#name").keyup(function(e){
            if(e.keyCode == 13){
            	searchEnvrnList();
            }
        });
    	
    	//조회버튼 클릭 이벤트 처리
        $("#btnSearch").on("click",function(){
        	searchEnvrnList();
        });
        
        //등록페이지로 pop
        $("#btnReg").on("click",function(){
        	appendDetailPopup("envrnMainDiv", "/resrce/envrn/envrnRegisterPagePop");
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
    		if(data.result.paginationInfo != null) {
		   		params = data.result.resultList;
		   		drawPager("envrnGridPager", data.result.paginationInfo, "searchEnvrnList");
    		}
    	}
        $("#envrnGrid").jsGrid({
              height : "auto"
            , width : "100%"
            , autoload: true
            , sorting : true
            , align : "center"
            , data : params
            , rowClick: function(arg){
                  popupEnvrnDetail(arg.item.id);
              }
            , fields : [
                  {name: "id"                  , title : "아이디"           , type : "text"   , width : 0 , visible : false}
                , {name: "cmpnyName"           , title : "회사명"           , type : "text"   , width : 100, align : "center"}
                , {name: "name"                , title : "이름"            , type : "text"   , width : 80, align : "center"}
                , {name: "description"         , title : "설명"            , type : "text"   , width : 250}
            ]
        });
        
    }
    
    /*
     * 검색
     * @param 페이지번호
     * @return
     */
    function searchEnvrnList(pageNo) {
        var url = '/resrce/envrn/getEnvrnList';
        var currentPageNo = 1;
        if (pageNo != null && pageNo != undefined && pageNo != "") {
        	currentPageNo = pageNo;
        }
        var param = {
        	cmpny : $("#schCmpny").val(),
        	name: $("#name").val(),
            currentPageNo:currentPageNo,
            recordCountPerPage:10,
            pageSize:10
        };
        callAsyncAjax(url, param, "drawGrid");
    }
    
    /*
     * 상세페이지 pop
     * @param
     * @return
     */
    function popupEnvrnDetail(id) {
        appendDetailPopup("envrnMainDiv", "/resrce/envrn/envrnDetailPop");
        getEnvrnDetail("/resrce/envrn/getEnvrnDetail", id); 
    };

    /*
     * 환경  정보 상세 조회
     * @param
     * @return
     */
    function getEnvrnDetail(url, id) {
        var param = {"id" : id};
        callAsyncAjax(url, param, 'drawValue');
    }
    
    
    /*
     * 환경  정보 상세 출력
     * @param
     * @return
     */
    function drawValue(data){
        var envrnValue = data.result;
        console.log(envrnValue);
        
        registerEnvrnId              = envrnValue.id;
        var resultEnvrnId            = envrnValue.id;
        var resultEnvrnName          = envrnValue.name;
        var resultEnvrnDescription   = envrnValue.description;
        var resultCmpnyCd            = envrnValue.cmpnyCd;
        
        $("#detailEnvrnId").val(resultEnvrnId);
        $("#detailEnvrnName").val(resultEnvrnName);
        $("#detailEnvrnDescription").val(resultEnvrnDescription);
        $("#cmpnyCd").val(resultCmpnyCd).prop("selected", true);
        
        cmpnyCodeReg = resultCmpnyCd;
    }

    /*
     * 환경 등록 후 로봇 리스트 화면 POP
     * @param
     * @return
     */
    function getRobotList(data) {

        if (data.responseCode == 'I101') {
        	cd = $("#cmpnyCd").val();
        	
        	//기존 팝업 닫기
            closePOP('');
            console.log("data", data);
        	//로봇리스트 팝업 열기
	        popupEnvrnRobotEnvrn();
        	
	        cmpnyCd = cd;
	        
	        if (data.result.value !== undefined) {
	            registerEnvrnId = data.result.value[0].Id;
	            console.log('id   '+registerEnvrnId);
	        } else {
 	        	checkEnvrnRobotList(data);
	        }
        }
    }
    
    /*
     * 로봇리스트 팝업 생성
     * @param
     * @return
     */
    function popupEnvrnRobotEnvrn() {
    	appendDetailPopup("envrnMainDiv", "/resrce/envrn/envrnRobotRegisterPagePop");
    	getEnvrnRobotList();
    }
    
    /*
     * 환경 로봇 정보 리스트 조회
     * @param
     * @return
     */
    function getEnvrnRobotList() {
        var param = {
        		"cmpnyCd" : cd
        };
        console.log("p1", param);
        callSyncAjax("/resrce/envrn/getRobotList", param, "drawRobotTable");
    }
    
    /*
     * 로봇 리스트에 해당 환경이 매핑되어 있는 경우 체크표시
     * @param
     * @return
     */
    function checkEnvrnRobotList(data) {
    	
        var robotId = [];
        console.log("data.result", data.result);
   		$.each(data.result,function(index,item){
   			robotId.push(item.RobotId);
   		});
   	    
        $('input[name=gridCheckbox]').each(function(){
        	
     	    var rid = parseInt($(this).val());
     		var index = robotId.indexOf(rid);
     		
     	    if (index > -1) {
                $(this).prop("checked",true);
            }
        });
   		
    }

    /*
     * 로봇 환경 정보 상세 출력
     * @param
     * @return
     */
	function drawRobotTable(data) {
    	
		var params = {};
		if (data != null && data != undefined) {
	        params = data.result.resultList;
	        console.log(params);
		}
		   
		$("#envrnRobotGrid").jsGrid({
		    height : "auto"
		  , width : "100%"
		  , autoload: true
		  , sorting : true
		  , align : "center"
		  , data : params
		  , fields : [
		        {   
		            headerTemplate: function() {
		                return $("<input id='allCheck' style='width:18px;height:18px;'>").attr("type", "checkbox").on("click", function () {allSelect();});
		            }
		          , itemTemplate: function(_, data) {
		                var id = data.id;
		                return $("<input name='gridCheckbox' class='gridCheckbox' style='width:18px;height:18px;'>").attr("type", "checkbox").val(id);
		            }
		          , align : 'center'
		          , width: 50
		          , sorting : false
		        }  
		      , {name: "name"                , title : "이름"            , type : "text"       , width : 80, align : "center"}
		      , {name: "type"                , title : "형식"            , type : "text"       , width : 80, align : "center"}
		      , {name: "robotDescription"    , title : "설명"            , type : "text"        , width : 200}
		    ]
		});
	
	}

    /*
     * checkbox 전체 선택
     * @param
     * @return
     */
    function allSelect() {
    	if ($("#allCheck").prop("checked")) {
    		  $('input[name=gridCheckbox]').prop("checked",true);
    	} else {
    		  $('input[name=gridCheckbox]').prop("checked",false);
    	}
    }

    /*
     * popup창 닫기
     * @param
     * @return
     */
    function closePOP(data) {
        console.log('close    '+data);
        $(".over").remove();
        searchEnvrnList();
    }

</script>
