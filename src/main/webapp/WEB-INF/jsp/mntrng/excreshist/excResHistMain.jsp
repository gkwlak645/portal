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
var offset;

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
        	startFmtDate = (new Date()).getDate() -7
        }
        
        //그리드 초기화
        drawGrid();
        
     // 스크롤바 이동하기 위한 설정
        offset = $('#retryMainDiv').offset();  
    };
    
    /*
     * 이벤트 바인딩
     * @param
     * @return
     */
    function bindEvent(){

        //조회버튼 클릭 이벤트 처리
        $("#btnSearch").on("click",function(){
        	searchExcResList();
        });
        
        $('#startDeDiv').datetimepicker({
            format: 'YYYY-MM-DD'
          , defaultDate: (new Date()).setDate(startFmtDate)
        });
        
        $("#endDeDiv").datetimepicker({
            format: 'YYYY-MM-DD'
          , defaultDate: (new Date())
        });
        
        searchExcResList();
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
            drawPager("dataGridPager", data.result.paginationInfo, "searchExcResList");
        }

        $("#dataGrid").jsGrid({
              height : "auto"
            , width : "100%"
            , autoload: true
            , sorting : true
            , align : "center"
            , data : params
            , rowClick: function(arg){
            	popupDetail(arg.item.id);
            }
            , fields : [
                  {name: "id"               , title : "아이디"         , type : "text"   , width : 0 , visible : false }
                , {name: "cmpnyName"        , title : "회사"          , type : "text"   , width : 50}
                , {name: "processCd"        , title : "프로세스코드"          , type : "text"   , width : 50}
                , {name: "processName"      , title : "프로세스명"        , type : "text"   , width : 150}
                , {name: "robotName"        , title : "로봇"           , type : "text"   , width : 90}
                , {name: "environmentName"  , title : "환경"          , type : "text"   , width : 90}
                , {name: "stateName"        , title : "상태"          , type : "text"   , width : 50}
                , {name: "startTime"      , title : "시작시간"         , type : "text"   , width : 90}
                , {name: "endTime"        , title : "종료시간"         , type : "text"   , width : 90}
                , {name: "source"       , title : "소스"          , type : "text"   , width : 50}
                , {name: "targetAt"        , title : "대상여부"          , type : "text"   , width : 50}
                , {name: "retry"        , title : "재실행"          , type : "text"   , width : 50, align : "center" , itemTemplate: function(value, item) {
                    var reExcBtn = '';
                    if(item.targetAt == 'Y')
                    	reExcBtn += '<span onclick =\"reExcClick(this, " + item.id +")\">[재실행]</span>';
                    return $(reExcBtn).on("click", function(){
                    	if(confirm('선택한 작업을 재실행하시겠습니까?')){
                    		reExcute(item);
                    	}
                    	return false;
                    });
                }}
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
    function searchExcResList(pageNo) {
    	//alert(JSON.stringify(pageNo));
        var url = '/mntrng/excreshist/getExcResList';
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
     */
    function popupDetail(id) {
    	// 로딩 시작
        $('.dimmed').css({ display: 'block' });
        $('.loading').css({ display: 'block' });
        $('.loading').addClass('show');
    	
    	// 스크롤 이동
        $('html').animate({scrollTop : offset.top}, 600);

        //상세 페이지 div 생성
        appendDetailPopup("retryMainDiv", "/mntrng/excreshist/excResDetailPop");
		jobId = id;

    };
    
    /*
     * 재실행 이벤트
     * @param 
     * @return
     */
    function reExcute(item) {

		var url = '/mntrng/excreshist/reExcute';
		
		var param = {"strategy":"1"};
		
		param.id        =   Number(item.id)
		
		callSyncAjax(url, param, "searchExcResList");
        
    };
    
    /*
     * popup창 닫기
     * @param
     * @return
     */
    function closePOP(){
        $(".over").remove();
        searchExcResList();
    }
    
</script>
