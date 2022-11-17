<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
                    <!--  템플릿 바디 -->
                    <div id="mainDiv" class="container-fluid wrap">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="card">
                                    <div class="card-header">
                                        <form class="form-inline">
                                            <div class="form-group col-lg-12">
                                                 <label class="col-lg-1" for="searchProcessCd">프로세스 코드</label>
                                                 <div class="col-lg-5 input_ty2"><!-- 확인버튼 같이 있는 인풋 유형 .input_ty2 추가 -->
                                                    <input type="text" class="form-control float-left" id="searchProcessCd"/>
                                                    <button type="button" class="btn btn-info float-left" id="btnSearch">검색</button>
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
                                        <div class="card-top_btn"><!-- 상단 버튼 위치 div 추가 -->
<c:if test="${txScreenAuthor.wrtngAuthor eq 'Y'}">					                	
					                    <button type="button" id="btnReg" class="btn btn-primary float-right" style="margin:5px 0 15px 2px;">등록</button>
					                    <button type="button" id="btnResveStart" class="btn btn-primary float-right" style="margin:5px 0 15px 2px;">예약시작</button>
					                    <button type="button" id="btnInstantStart" class="btn btn-primary float-right" style="margin:5px 0 15px 2px;">즉시시작</button>
</c:if>
                                        </div>
                                        <div id="GridTrggerAr"></div>
                                        <div id="GridTrggerArPager" class="portal-pager"></div>
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
var getPage = 1;
var IsDisableClick = false;

$(document.body).ready(function () { 
	console.log("ready");
    offset = $('#mainDiv').offset();  
});
function pageInit() {
	console.log("pageInit()")
	
    //그리드 초기화
    drawGrid();
};

function searchList(pageNo){
    let currentPageNo = 1;
    if (pageNo != null && pageNo != undefined && pageNo != "" && $.isNumeric(pageNo)) {
        currentPageNo = pageNo; 
    }
    //alert(currentPageNo);
    getPage = currentPageNo;
    var param = {
    	searchProcessCd: $("#searchProcessCd").val(),
        currentPageNo:currentPageNo,
        recordCountPerPage:10,
        pageSize:10
    }; 
    
    if(!IsDisableClick) {
    	startLoading();
    }

    callAsyncAjax("/resrce/triggerAr/selectTriggerArList", param, "drawGrid");
}

function deleteRoutinePlanCallback(){
	alert("삭제 되었습니다.");
	searchList();
}

function startLoading() {
	$('.dimmed').css({ display: 'block' });
    $('.loading').css({ display: 'block' });
    $('.loading').addClass('show');
}

function endLoading() {
	// 로딩 끝
    $('.dimmed').css({ display: 'none' });
    $('.loading').css({ display: 'none' });
    $('.loading').removeClass('show');
}

function bindEvent(){
	console.log("bindEvent()");

	$("#btnInstantStart").on('click', function(){
		startLoading();
		appendDetailPopup("mainDiv", "/resrce/triggerAr/triggerArInstantStartPop");
		endLoading();
    });
	
	$("#btnResveStart").on('click', function(){
		startLoading();
		appendDetailPopup("mainDiv", "/resrce/triggerAr/triggerArResveStartPop");
	    endLoading();
    });
	
	$("#btnReg").on('click', function(){
		// 스크롤 이동
        $('html').animate({scrollTop : offset.top}, 600);
	    startLoading();
	    appendDetailPopup("mainDiv", "/resrce/triggerAr/triggerArTriggerPop");
		//endLoading();
    });
	
	$("#btnSearch").on('click', function(){
		searchList();
    });
	
	searchList();
}
                   
                    
                                      
/*
    * 그리드 초기화
    * @param
    * @return
    */
function drawGrid(data){

    //var params = new Array();
/*
    for(var i = 0 ; i < 10 ; i++){
        params[i] = {
            'trgCheck' : '<input type="radio" name="radio choice" class="custom-radio" style="width:18px;height:18px;">',
            'trgType' : '예약',
            'trgName' : 'F90500_유가공_주문집계현',
            'trgProcess' : 'F90500_유가공_주문집계',
            'trgSet' : 'F_002',
            'trgInfo' : '2020-12-12 5:30:00 PM',
            'trgTime' : '2020-12-31 11:22:33'
        };
    }
*/    

		var params = {};
		if (data != null && data != undefined) {
			if (data.result != null && data.result.resultList != null) {
		        params = data.result.resultList;
			}
		    drawPager("GridTrggerArPager", data.result.paginationInfo, "searchList");
		}

    $("#GridTrggerAr").jsGrid({
        height : "auto",
        width : "100%",
        autoload: true,
        sorting : true,
        align : "center",
        data : params ,
        rowClick: function(arg){
            //unManagtErrorDetail();

        },
        fields : [
            {name: "cmpnyNm"          , title : "회사명"       , type : "text"    , width : 20, align : "center"},
            {name: "processCd"        , title : "프로세스코드"   , type : "text"    , width : 20, align : "center"},
            {name: "processNm"        , title : "프로세스명"    , type : "text"    , width : 100},
            {name: "robotNm"          , title : "로봇명"       , type : "text"    , width : 30},
            {name: "schduleText"      , title : "트리거 세부정보" , type : "text"    , width : 100},
            {name: ""                 , title : "수정"        , type : "text"    , width : 35, align : "center", itemTemplate: function(value, item) {            	            	
	            	if(item.disableAt == 0) {
	            		return "<button type=\"button\" class=\"btn btn-primary\" style=\"margin:5px 0 15px 2px;\" onclick =\"triggerUpdateClick('"+ item.processCd +"', " + item.schduleNo +", "+ item.botNo+")\">수정</button>";             		
	            	}
	            	else if(item.disableAt == 1) {
	            		return "<button type=\"button\" class=\"btn btn-primary\" style=\"margin:5px 0 15px 2px;\" disabled>수정</button>";                      
                    }

	            	return "수정 불가능";         	
	            }
            },
            
            {name: "", title : "삭제"        , type : "text"    , width : 35, align : "center", itemTemplate: function(value, item) { 
	            	if(item.disableAt == 0) {
	                    return "<button type=\"button\" class=\"btn btn-primary\" style=\"margin:5px 0 15px 2px;\" onclick =\"triggerDelClick('"+ item.processCd +"', " + item.schduleNo +", "+ item.botNo+")\">삭제</button>"   
	                }
	                else if(item.disableAt == 1) {
	                    return "<button type=\"button\" class=\"btn btn-primary\" style=\"margin:5px 0 15px 2px;\" disabled>삭제</button>"                      
	                }         	
            	
	            	return "삭제 불가능";           	
	            }
            },
            
            {name: "", title : "Disable", type : "text", width : 30, align : "right", 
            	itemTemplate: function(value, item) { 
            		// processCd, schduleNo, botNo, disableAt            		
            		var disableCheck = '';
            		var makeId = item.processCd + item.schduleNo + item.botNo + item.disableAt;
            		
            		if(item.disableAt == 0) {
            			// Disable 미적용
            			disableCheck = 
                            '<div class="col-sm-12 custom-control custom-switch float-right">' + 
                                '<input id="' + makeId + '" type="checkbox" class="custom-control-input float-right">';
            		}
            		else if(item.disableAt == 1) {
            			// Disable 적용된 상태
                        disableCheck = 
                            '<div class="col-sm-12 custom-control custom-switch float-right">' + 
                                '<input id="' + makeId + '" type="checkbox" class="custom-control-input float-right" checked>';                           
            		}
            		else {
            			return "Disable 불가능";
            		}
            		
            		disableCheck += 
	                    '<label id="' + makeId + '" class="custom-control-label float-right" for="customSwitch" ' + 
	                    'onClick="disabledClick(\'' + item.processCd + '\', \'' + item.schduleNo + '\', \'' + item.botNo + '\', \'' + item.disableAt + '\', \'' + makeId + '\')"></label>' + 
	                '</div>';
            		
            		return disableCheck;	
            	}
            }
        ]
    });
    
    /*  
    <div class="col-sm-12 custom-control custom-switch float-right">
       <input id="customSwitch2" type="checkbox" class="custom-control-input float-right">
       <label id="customSwitch2-label" class="custom-control-label  float-right" for="customSwitch2">다음 트리거 사용안함</label>
    </div>
    */
    
    if(!IsDisableClick) {
    	endLoading();
    }
    
    IsDisableClick = false;
}

function disableCallback(data){
	if (data != null && data != undefined) {
        if (data.result != null && data.result.isError != null && data.result.isError.length != 0) {
            alert(data.result.isError);
        	return false;
        }  
    }
	
    //alert("Disable 상태로 설정하였습니다.");
    searchList(getPage);
}

function notDisableCallback(data){
	if (data != null && data != undefined) {
        if (data.result != null && data.result.isError != null && data.result.isError.length != 0) {
            alert(data.result.isError);
            return false;
        }  
    }
	
    //alert("Disable 상태를 해제하였습니다.");
    searchList(getPage);
}

function isNullString(str) {
	if(str.length == 0 || str == null || str == "") {
		return true;
	}
	return false;
}

function disabledClick(pcd, schdno, botno, disable, Id) {
	if(isNullString(pcd) || isNullString(schdno) || isNullString(botno) || isNullString(disable)) {
		alert("Disable 상태를 수정할 수 없습니다.\n담당자에게 DESK로 문의하세요.");
		return false;
	}
	
	IsDisableClick = true;
    var user = "${txUserId}";

	var param = {
            processCd: pcd
            , schduleNo: schdno
            , botNo: botno
            , userId : user
    }; 
	
    if(disable == 0) {
    	// 현재 Disable이 아닌 상태에서 Disable로 바꾸고 싶을 때    	
    	if(confirm("Disable 상태로 설정하시겠습니까?")){   
            callSyncAjax("/resrce/triggerAr/convertTodisable", param, "disableCallback");
        }
    }
    else {
    	// 현재 Disable인 상태에서 Disable이 적용되지 않게 바꾸고 싶을 때
        if(confirm("Disable 상태를 해제하시겠습니까?")){   
            callSyncAjax("/resrce/triggerAr/convertToNotdisable", param, "notDisableCallback");
        }
    }

    /* var trueorfalse = !$('input:checkbox[id="customSwitch"]').is(":checked");
    $('input:checkbox[id="customSwitch"]').prop("checked", trueorfalse); //단일건 */
    
    return false;
}

function openTriggerArSchdPopUp(data) {
    appendDetailPopup("mainDiv", "/resrce/triggerAr/triggerArTriggerUpdatePop");
    old_triggerAr_info = data;
}
    
function selectInfoForUpdateCallback(data){
	if (data != null && data != undefined) {
        if (data.result != null && data.result.resultList != null) {
        	startLoading();
        	openTriggerArSchdPopUp(data.result.resultList[0]);
        	return false;
        }
    }
	
	alert("Trigger AR 스케줄 수정창을 불러올 수 없습니다.");
}
    
// Trigger AR 스케줄 수정 팝업창
function triggerUpdateClick(sProcessCd, iSchduleNo, iBotNm){
	//alert("Trigger AR 스케줄을 수정하실 경우 Disable 상태가 해제되니,\nDisable 상태를 원하시는 경우 수정 후 다시 설정해주시기 바랍니다.");
	
	// 스크롤 이동
    $('html').animate({scrollTop : offset.top}, 600);
	
	var param = {
            processCd: sProcessCd
            , schduleNo: iSchduleNo
            , botNo: iBotNm
    }; 
        
    callSyncAjax("/resrce/triggerAr/triggerArSelectInfoForUpdate", param, "selectInfoForUpdateCallback");
}

function triggerDelClick(sProcessCd, iSchduleNo, iBotNm){
	if(confirm("삭제 하시겠습니까?")){
		var param = {
				processCd: sProcessCd
				, schduleNo: iSchduleNo
				, botNo: iBotNm
		    }; 
		    
		callAsyncAjax("/resrce/triggerAr/deleteRoutinePlan", param, "deleteRoutinePlanCallback");
	}
}

/*
    * popup창 닫기
    * @param
    * @return
    */
function closePop() {
    $(".over").remove();
}


function closeReloadPop() {
    $(".over").remove();
    searchList();
}

function viewSubMenu(obj){
    const oObj = $(obj);
    //console.log(oObj.offset().top);
    //console.log(oObj.offset().left);
    //console.log(oObj.position().top);
    if(oObj.hasClass("jq_click")){
        oObj.removeClass("jq_click");
        $(".add_file_list").hide()
        return false;
    }else{
        oObj.addClass("jq_click")
    }
    
    const windowHeight = $(window).height();
    $(".add_file_list").show();
    if(oObj.offset().top + 170 < windowHeight){
        $(".add_file_list").offset({top: oObj.offset().top + 23, left: oObj.offset().left - 91});
    }
    else{
        $(".add_file_list").offset({top: oObj.offset().top - 114, left: oObj.offset().left - 91});
    }
    
    oObj.addClass("jq_click")
    return false;
}    

$(document).click(function(e) {
    if(!$(e.target).hasClass("btn-outline-success") && $(e.target).closest(".add_file_list").length < 1) 
    { 
        $(".add_file_list").hide() 
        $(".jq_click").removeClass("jq_click");
        //console.log("hide")
    } 
});
</script>
                    
<!--  템플릿 바디 끝 -->