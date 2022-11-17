<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div id="retryMainDiv" class="container-fluid wrap">
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
                        <div class="form-group col-md-5 py-sm-2" style="margin: 0.3rem 0 0.3rem 0;">
                          <label for="usr" class="col-sm-3 col-form-label">기간</label>
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
        
        params.push({"id" : "cmbState", "clsCd" : "0015"});
        //params.push({"id" : "cmbJobPriority", "clsCd" : "0010"});
        params.push({"id" : "cmbSource", "clsCd" : "0016"});
        requestCmmnCd(params);
        
        
        if("${mainInitAt}" != null && "${mainInitAt}" != ""){
        	startFmtDate = (new Date()).getDate()
        }else{
        	startFmtDate = (new Date()).getDate() -31
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
        	searchMntrngList();
        });
        
        $('#startDeDiv').datetimepicker({
            format: 'YYYY-MM-DD'
          , defaultDate: (new Date()).setDate(startFmtDate)
        });
        
        $("#endDeDiv").datetimepicker({
            format: 'YYYY-MM-DD'
          , defaultDate: (new Date())
        });
        
        searchMntrngList();
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
            drawPager("dataGridPager", data.result.paginationInfo, "searchMntrngList");
        }

        $("#dataGrid").jsGrid({
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
                  {name: "id"               , title : "아이디"         , type : "text"   , width : 0 , visible : false }
                , {name: "cmpnyNm"        , title : "회사"          , type : "text"   , width : 50}
                , {name: "processCd"        , title : "프로세스 코드"          , type : "text"   , width : 80}
                , {name: "processNm"      , title : "프로세스 명"        , type : "text"   , width : 150}
                , {name: "expectExcCnt"        , title : "예상수행횟수"           , type : "text"   , width : 50}
                , {name: "realExcCnt"  , title : "수행횟수"          , type : "text"   , width : 50}
                , {name: "succesCnt"        , title : "성공횟수"          , type : "text"   , width : 50}
                , {name: "failCnt"      , title : "실패횟수"         , type : "text"   , width : 50}
                , {name: "succesRate"        , title : "성공률"         , type : "text"   , width : 50}
                , {name: "processSttus"        , title : "프로세스 상태"          , type : "text"   , width : 80}
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
    function searchMntrngList(pageNo) {
    	//alert(JSON.stringify(pageNo));
        var url = '/mntrng/devbotmntrng/selectMntrngList';
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
            startDe: $("#startDe").val().replace(/-/g, ""),
            endDe: $("#endDe").val().replace(/-/g, ""),
            searchProcessCd: $("#searchProcessCd").val(), 
            searchProcessNm: $("#searchProcessNm").val(),	
            currentPageNo:currentPageNo,
            recordCountPerPage:100,
            pageSize:10
        }; 
        
        callAsyncAjax(url, param, "drawGrid");
        
        // 로딩 시작
        $('.dimmed').css({ display: 'block' });
        $('.loading').css({ display: 'block' });
        $('.loading').addClass('show');
    }
    
/*     
     * 상세페이지 팝업
     * @param 
     * @return
     
    function popupDetail(id) {

        //상세 페이지 div 생성
        appendDetailPopup("retryMainDiv", "/mntrng/excreshist/excResDetailPop");
		jobId = id;

    }; */
    
    /*
     * popup창 닫기
     * @param
     * @return
     */
    function closePOP(){
        $(".over").remove();
        searchMntrngList();
    }
    
</script>
