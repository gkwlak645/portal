<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div id="jobMainDiv" class="container-fluid wrap">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <form class="form-inline">
                        
                        <div class="form-group col-md-5 py-sm-2">
                          <label for="schCmpny" class="col-sm-2 col-form-label">회사</label>
                          <div class="col-sm-10">
                              <select id="schCmpny" class="form-control" style="width:60%;max-width:200px;">
                                  <option value=""></option>
                              </select>
                          </div>
                        </div>
                        <div class="form-group col-md-5 py-sm-2" style="margin: 0.3rem 0 0.3rem 0;">
                          <label for="usr" class="col-sm-2 col-form-label">기간</label>
                          <div class="col-sm-4">
                              <div class="input-group date" id="startDeDiv" data-target-input="nearest" style="min-width:130px;margin: 0 0 2px 0;">
                                  <input type="text" id="startDe" name="startDe" class="form-control datetimepicker-input" data-target="#startDeDiv"/>
                                  <div class="input-group-append" data-target="#startDeDiv" data-toggle="datetimepicker">
                                      <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                  </div>
                              </div>
                          </div>
                          <div class="col-sm-4">
                              <div class="input-group date" id="endDeDiv" data-target-input="nearest" style="min-width:130px;margin: 0 0 2px 0;">
                                  <input type="text" id="endDe" name="endDe" class="form-control datetimepicker-input" data-target="#endDeDiv"/>
                                  <div class="input-group-append" data-target="#endDeDiv" data-toggle="datetimepicker">
                                      <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                  </div>
                              </div>
                          </div>
                        </div>
                        <div class="form-group col-md-5 py-sm-2" style="margin: 0.3rem 0 0.3rem 0;">
                          <label for="usr" class="col-sm-2 col-form-label">전송여부</label>
                          <div class="col-sm-10">
                              <select id="sendYn" class="form-control float-left" style="width:60%;max-width:200px;">
                                  <option value="">- 선택 -</option>
                              </select><button type="button" id="btnSearch" class="btn btn-info float-left">조회</button>
                              
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
                    <div id="jobGrid"></div>
                    <div id="jobGridPager" class="portal-pager"style="text-align:center"></div>
                </div>
            </div>
        </div>
    </div>
</div>



<script>

//검색조건 - 시작일자
var startFmtDate;

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
        
        params.push({"id" : "sendYn", "clsCd" : "0054"});
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
        	searchJobList();
        });
        
        $('#startDeDiv').datetimepicker({
            format: 'YYYY-MM-DD'
          , defaultDate: (new Date()).setDate(startFmtDate)
        });
        
        $("#endDeDiv").datetimepicker({
            format: 'YYYY-MM-DD'
          , defaultDate: (new Date())
        });
        
        searchJobList();
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
            drawPager("jobGridPager", data.result.paginationInfo, "searchJobList");
        }
        
        var headerIcon = '<svg class="bi bi-arrow-clockwise" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">';
        headerIcon += '<path fill-rule="evenodd" d="M3.17 6.706a5 5 0 0 1 7.103-3.16.5.5 0 1 0 .454-.892A6 6 0 1 0 13.455 5.5a.5.5 0 0 0-.91.417 5 5 0 1 1-9.375.789z"/>';
        headerIcon += '<path fill-rule="evenodd" d="M8.147.146a.5.5 0 0 1 .707 0l2.5 2.5a.5.5 0 0 1 0 .708l-2.5 2.5a.5.5 0 1 1-.707-.708L10.293 3 8.147.854a.5.5 0 0 1 0-.708z"/>';
        headerIcon += '</svg>';

        $("#jobGrid").jsGrid({
              height : "auto"
            , width : "100%"
            , autoload: true
            , sorting : true
            , align : "center"
            , data : params
            , rowClick: function(arg){
                //popupDetail(arg.item.id);
            }
            , fields : [
                  {name: "resvNo"               , title : "예약번호"        , type : "text"   , width : 0 , visible : false}
                , {name: "cmpnyNm"        , title : "회사"         , type : "text"   , width : 80}
                , {name: "processCd"      , title : "프로세스코드"     , type : "text"   , width : 50 ,align : "center"}
                , {name: "processNm"      , title : "프로세스명"     , type : "text"   , width : 200}
                , {name: "dateYmshm"        , title : "예약시간"         , type : "text"   , width : 80  ,align : "center"}
                , {name: "sendYn"        , title : "전송여부"         , type : "text"   , width : 80  ,align : "center"}
                , {title: "삭제"   
                  , itemTemplate: function(value, item) {
                        var itemIcon = '';
                        if(item.sendYn == 'N'){
                        	itemIcon += '<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-x-circle" fill="currentColor" xmlns="http://www.w3.org/2000/svg">';
                            itemIcon += '<path fill-rule="evenodd" d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>';
                            itemIcon += '<path fill-rule="evenodd" d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"/>';     
                            itemIcon += '</svg>';	
                        } 
                        
                        return $(itemIcon).on("click", function(){
                        	if(confirm('선택한 작업을 삭제하시겠습니까?')){
                        		delResve(item.cmpnyCd,item.resvNo);
                        	}
                        });
                    }
                  , align : 'center'
                  , width: 50
                  , sorting : false
                  }
            ]
        });
        
    }
    
    /*
     * 검색
     * @param 페이지번호
     * @return
     */
    function searchJobList(pageNo) {

        var url = '/resrce/resveAr/getResveList';
        var currentPageNo = 1;
        if (pageNo != null && pageNo != undefined && pageNo != "") {
            currentPageNo = pageNo;
        }

        var param = {
        	cmpnyCd: $("#schCmpny").val(),
            startDe: $("#startDe").val().replace(/-/g, ""),
            endDe: $("#endDe").val().replace(/-/g, ""),
            sendYn: $("#sendYn").val(),
            jobPriority: $("#cmbJobPriority").val(),
            source: $("#cmbSource").val(),
            currentPageNo:currentPageNo,
            recordCountPerPage:10,
            pageSize:10
        }; 
        
        callAsyncAjax(url, param, "drawGrid");
    }
    
    
    /*
     * job 실행중지
     * @param 
     * @return
     */
    function delResve(cmpnyCd,resvNo) {
    	 var url = '/resrce/resveAr/delResveAr';
	     var param = {
	    	cmpnyCd: cmpnyCd
	    	, resvNo: Number(resvNo)
		  };
	       callSyncAjax(url, param, "delResveCallback");
    };
    
    function delResveCallback(data){
    	alert("삭제 되었습니다.");
    	searchJobList();
    }

</script>
