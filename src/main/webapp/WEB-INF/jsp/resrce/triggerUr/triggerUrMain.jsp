<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt"     uri="http://java.sun.com/jsp/jstl/fmt" %>
<!--  템플릿 바디 -->
<div id="divModal" class="modal fade" tabindex="-1" role="dialog"></div>
                    <div id="mainDiv" class="container-fluid wrap">
					    <div class="row">
					        <div class="col-md-12">
					            <div class="card">
					                <div class="card-header">
					                    <form class="form-inline">					                       
					                        <div class="form-group col-md-12">
					                             <label id=""class="col-sm-2" >이름</label>
					                             <div class="col-sm-10">
					                               <input type="text" class="form-control  float-left" id="searchKwrd" name="searchKwrd" style="min-width:210px;" value="" placeholder="이름" />
					                             </div>
					                        </div>
					                        
					                        <div class="form-group col-md-6">
                                                 <label id="name" class="col-sm-4">상태</label>
                                                 <div class="col-sm-8">
                                                  <select class="form-control float-left" id="searchState" style="width:60%;max-width:210px;">
                                                  </select>
                                               </div>
                                            </div>
					                        <div class="form-group col-md-6">
					                             <label id="name" class="col-sm-4">형식</label>
					                             <div class="col-sm-8 float-left">
					                              <select class="form-control float-left" id="searchTy" style="width:60%;max-width:210px;">
					                              </select>
					                              <button type="button" id="btnSearch" class="btn btn-info float-left">조회</button>
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
					                    <button type="button" id="btnReg" class="btn btn-primary float-right" style="margin:5px 0 15px 2px;">등록</button>
					                    <button type="button" id="btnInstantStart" class="btn btn-primary float-right" style="margin:5px 0 15px 2px;">즉시시작</button>
</c:if>
					                    <div id="triggerUrGrid"></div>
                                        <div id="triggerUrGridPager" class="portal-pager"></div>                                        
					                </div>
					                <!--  -->
					            </div>
			                   <!--20201123 툴팁 추가-->
				                <div class="add_file_list" style="position: relative;display: none;left:0px;top:0px">
				                   <ul>
				                       <li><a class="btn-txt" id="btnSelectMenu1" name="btnSelectMenu" href="javascript:">편집</a></li>
				                       <li><a class="btn-txt" id="btnSelectMenu2" name="btnSelectMenu" href="javascript:">사용</a></li>
				                       <li><a class="btn-txt" id="btnSelectMenu3" name="btnSelectMenu" href="javascript:">사용안함</a>
				                       <li><a class="btn-txt" id="btnSelectMenu4"name="btnSelectMenu" href="javascript:">제거</a></li>
			                       </ul>
		                       </div>
					        </div>
					    </div>
					</div>
					
<script type="text/javascript">
var lc_currentPageNo = 1;
var lc_select_schdule_id = 0;
var lc_loading_id = 0;
//일일미조치_오류_일련번호

$(document.body).ready(function () { 
	
});

    /*
     * 페이지 초기화
     * @param
     * @return
     */
    function pageInit() {
    	console.log("pageInit()")
    	
        //그리드 초기화
        drawGrid();
    };
    
    function bindEvent(){
    	let params = [];
        params.push({"id" : "searchState", "clsCd" : "0051"});    //트리거 상태
        params.push({"id" : "searchTy", "clsCd" : "0052"});    //트리거 형식
        requestCmmnCd(params);
                  
    	$("#btnReg").on('click', function(){
    		showRegPop();
        });
    	
    	$("#btnSearch").on('click', function(){
    		searchList();
        });
    	
    	$("#btnInstantStart").on('click', function(){
    		appendDetailPopupType2("divModal", "/resrce/triggerUr/triggerUrInstantStartPop");
        });
    	searchList();
    }
    
    
    
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
            
            drawPager("triggerUrGridPager", data.result.paginationInfo, "searchList");
        }

        $("#triggerUrGrid").jsGrid({
            height : "auto"
	            , width : "100%"
	            , autoload: true
	            , sorting : true
	            , align : "center"
	            , data : params
	            , rowClick: function(arg){
	                //unManagtErrorDetail();
	            }
	            , fields : [
	                  {name: "Name"         , title : "이름"       , type : "text"    , align : "center"} 
	                , {name: "PackageName"            , title : "프로세스"    , type : "text"    , width : 80, align : "center"}
	                , {name: "EnvironmentName"            , title : "환경"       , type : "text"    , width : 80, align : "center"}
	                , {name: "occrrncSeNm"        , title : "형식"    , type : "text"    , width : 35, align : "center"
	                		, itemTemplate:function(value,item){
	                			return item.QueueDefinitionId == null ? "시간" : "큐"
	                		}
	                	}
	                , {name: "tyNm"               , title : "트리거세부정보"       , type : "text"    , width : 110, align : "center"
	                		, itemTemplate:function(value,item){
	                			return triggerDetailInfo(item);
	                				
	                		} 
	                	}
	                , {name: "unmanagtDe"          , title : "다음런타임"    , type : "text"    , width : 60, align : "center"
	                		, itemTemplate:function(value,item){
	                				return nextRuntime(item);
	                			}
	                	}
	                , {name: "processSn"            , title : "다음이후 중지"       , type : "text", width : 40    , align : "center"
	                	, itemTemplate:function(value,item){
            					return stopProcessExpression(item);
            				}
	                	}
//                    , {name: "managtTyNm"         , title : "즉시시작"        , type : "text"    , width : 50, align : "center", itemTemplate:function(value,item){return '<input type="button" onclick="alert(\'ccc\')" class="btn btn-outline-primary icon" style="padding:3px 2px 4px 4px;margin:0px;line-height: 0.9;font-size:8px;" value="▶">'}}
	                , {	name: "managtTyNm2"         , title : ""        , type : "text"    , width : 20, align : "center"
	                	, itemTemplate:function(value,item){
	                		const sViewType = item.QueueDefinitionId == null ? "T" : "Q"
	                		return '<div><input type="button" onclick="viewSubMenu(this, '+ item.Id+',  '+ item.Enabled+', \''+ sViewType +'\')" class="btn btn-outline-success" id="" name="" value=":" style="padding: 0 5px 3px 4px;width:22px;line-height: 18px;"></div>'
	                	}
	                }
	            ]
	        });
            
            //Enabled: true	사용여부
            //QueueDefinitionId: 31 값이 있으면 큐
            
            //QueueDefinitionName: "Yearly_Report" 큐 세부정보
            //StartProcessCronSummary: "매분" 타임 세부정보
            
            //StartProcessNextOccurrence 다음 시작시간
            //StopProcessExpression 다음시간 이후 중지 일/시/분
            
            
        
        
    }

    
    
    function searchList(pageNo){
    	var url = '/resrce/triggerUr/selectTriggerUrList';
        if (pageNo != null && pageNo != undefined && pageNo != "") {
            lc_currentPageNo = pageNo;
        }
        
        var param = {
        		searchKwrd: $("#searchKwrd").val()	
            , searchState: $("#searchState").val()
			, searchTy: $("#searchTy").val()
            , currentPageNo         : lc_currentPageNo
            , recordCountPerPage    :   10
            , pageSize              :   10
        };
        callAsyncAjax(url, param, "drawGrid");
    }
    
    function setEnabled(params){
    	var url = '/resrce/triggerUr/setEnabled';
    	callAsyncAjax(url, params, "setEnabledCallback");
    }
    
    function setEnabledCallback(data){
    	searchList(lc_currentPageNo);
    }
    
    function deleteProcessSchedules(params){
    	var url = '/resrce/triggerUr/deleteProcessSchedules';
    	callAsyncAjax(url, params, "deleteProcessSchedulesCallback");
    }
    
    function deleteProcessSchedulesCallback(data){
    	searchList();
    }
    
    /*
     * 등록페이지 pop
     * @param
     * @return
     */
    function showRegPop() {
        appendDetailPopup("mainDiv", "/resrce/triggerUr/triggerUrRegisterPop");
    };
    
    
	function viewSubMenu(obj, iId, bEnabled, sViewType){
		
		
		const oObj = $(obj);
		let oSubMenu = $(".add_file_list");
		//console.log(oObj.offset().top);
		//console.log(oObj.offset().left);
		//console.log(oObj.position().top);
		if(oObj.hasClass("jq_click")){
			oObj.removeClass("jq_click");
			oSubMenu.hide()
			return false;
		}else{
			oObj.addClass("jq_click")
		}
		
		
		
		const windowHeight = $(window).height();
		oSubMenu.attr("data-item", iId).show();
		oSubMenu.attr("data-viewType", sViewType).show();
		if(bEnabled){
			$("#btnSelectMenu2").addClass("disabled");
			$("#btnSelectMenu3").removeClass("disabled");
		}
		else{
			$("#btnSelectMenu2").removeClass("disabled");
			$("#btnSelectMenu3").addClass("disabled");
		}
		
		if(oObj.offset().top + 170 < windowHeight){
			oSubMenu.offset({top: oObj.offset().top + 23, left: oObj.offset().left - 91});
		}
		else{
			oSubMenu.offset({top: oObj.offset().top - 114, left: oObj.offset().left - 91});
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
	
	
	$(document).on("click", "a[name=btnSelectMenu]", function(e) {
		const oObj = $(e.target);
		if(oObj.hasClass("disabled")){
			return false;
		}
		//
		
		console.log("-" + oObj.attr("id"))
		const sId = oObj.attr("id")
		const oParent = oObj.closest(".add_file_list");
		const triggerId = parseInt(oParent.attr("data-item"));
		const viewType = oParent.attr("data-viewtype");
		
		if(sId == "btnSelectMenu1"){
			lc_select_schdule_id = parseInt(triggerId);
			console.log("lc_select_schdule_id: " + lc_select_schdule_id);
			
			if(viewType == "T"){//타임 스케줄
				//callSyncAjax
				//스케줄 정보 가져오기
				appendDetailPopup("mainDiv", "/resrce/triggerUr/triggerUrDetailTimePop");
			}
			else{//QUEUE 스케줄
				//callSyncAjax
				//스케줄 정보 가져오기
				appendDetailPopup("mainDiv", "/resrce/triggerUr/triggerUrDetailQueuePop");
			}
		}
		else if(sId == "btnSelectMenu2"){
			//POST https://dwrpadev.dongwon.com/odata/ProcessSchedules/UiPath.Server.Configuration.OData.SetEnabled
			
			let aId = [];	aId.push(triggerId);
			setEnabled({scheduleIds: aId, enabled: true});
		}
		else if(sId == "btnSelectMenu3"){
			//POST https://dwrpadev.dongwon.com/odata/ProcessSchedules/UiPath.Server.Configuration.OData.SetEnabled
			let aId = [];	aId.push(triggerId);
			setEnabled({scheduleIds: aId, enabled: false});
		}
		else if(sId == "btnSelectMenu4"){
			if(confirm("선택한 항목을 삭제하시겠습니까?")){
				deleteProcessSchedules({scheduleId: triggerId});
			}
			//DELETE	https://dwrpadev.dongwon.com/odata/ProcessSchedules(120)
		}
		oParent.hide();
		return false
		
	});
	
	
	function stopProcessExpression(item){
		let sStr = "";
		let sTime = item.StopProcessExpression;
		if(item.StopProcessExpression == ""){
			sStr = "해당없음";
		}
		else{
			let iTime = parseInt(sTime);
			
			let iDayCnt = parseInt(iTime / (60 * 60 * 24));
			let iDayRemain = iTime % (60 * 60 * 24);
			if(iDayCnt > 0){
				sStr = iDayCnt + "일 "; 
			}
			
			let iHhCnt = 0;
			let iHhRemain = 0;
			if(iDayRemain > 0){
				iHhCnt = parseInt(iDayRemain / (60 * 60));
				iHhRemain = iDayRemain % (60 * 60);
				
				if(iHhCnt > 0){
					sStr += iHhCnt + "시간 "; 
				}
			}
			
			let iMmCnt = 0;
			let iMmRemain = 0;
			if(iHhRemain > 0){
				iHhCnt = parseInt(iHhRemain / 60);
				iHhCnt += iHhRemain % (60) > 0 ? 1 : 0;
				
				if(iHhCnt > 0){
					sStr += iHhCnt + "분"; 
				}
			}
			
			
			
			
			console.log("iDayCnt: " + iDayCnt);
			console.log("iDayRemain: " + iDayRemain);
		}
		return '<span style="display: block;    text-decoration: none;    text-overflow: ellipsis;    white-space: nowrap;    overflow: hidden;" title="'+ sStr +'">' + sStr + '</span>'
	}
	
	function nextRuntime(item){
		let sStr = "";
		
		if(item.Enabled){
			if(item.QueueDefinitionName == null){
				if(item.StartProcessNextOccurrence != null){
					let sDateTime = item.StartProcessNextOccurrence;
					let originalDate = new Date(sDateTime.replace("T", " ").replace("Z", ""));
			        originalDate.setHours( originalDate.getHours() + 9 );
			        sStr = moment(originalDate).format('YYYY-MM-DD HH:mm:ss');
				}
			}
			else{
				sStr = "헤당없음";
			}
		}
		else{
			sStr = "사용안함";
		}
		
        
        return '<span style="display: block;    text-decoration: none;    text-overflow: ellipsis;    white-space: nowrap;    overflow: hidden;" title="'+ sStr +'">' + sStr + '</span>'
         
	}
	
	function triggerDetailInfo(item){
		let sStr = "";
		if(item.QueueDefinitionName == null){
			sStr = item.StartProcessCronSummary;
		}
		else{
			sStr = item.QueueDefinitionName;
		}
		
		return '<span style="display: block;    text-decoration: none;    text-overflow: ellipsis;    white-space: nowrap;    overflow: hidden;" title="'+ sStr +'">' + sStr + '</span>'
	}

	function mainPopClose() {
        $(".over").remove();
    }
	
	function mainPopCloseReload() {
        $(".over").remove();
        searchList();
    }
	
	function mainModalClose(sDivId) {
		$("#" + sDivId).modal('hide');
		$("#" + sDivId).html("");
    }
	
	function mainModalCloseReload(sDivId) {
		$("#" + sDivId).modal('hide');
		$("#" + sDivId).html("");
		searchList();
    }
	
	
	
</script>
					    <!--  템플릿 바디 끝 -->
					    
