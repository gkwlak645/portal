<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="modal-dialog modal-lg">
    <div class="modal-content">
        <div class="modal-header">
            <h4 class="modal-title">업무시스템 검색</h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <div class="modal-body" >
            <div class="col-md-12">
                                <div class="card">
                                    <div class="card-header">
                                        <form id="searchForm" name="searchForm" class="form-inline">
                                            <div class="form-group row  col-sm-6">
                                                <label for="usr" class="col-sm-4 col-form-label">분류</label>
                                                <div class="col-sm-8">
                                                    <select class="form-control" id="searchPopCntcSysClsCd" style="width: 60%; max-width: 196px;"></select>
                                                </div>
                                            </div>

                                            <div class="form-group row col-sm-6">
                                                <label for="usr" class="col-sm-4 col-form-label">회사</label>
                                                <div class="col-sm-8">
                                                    <select class="form-control" id="searchPopCmpnyCd" style="width: 60%; max-width: 196px;"></select>
                                                </div>
                                            </div>

                                            <div class="form-group row  col-sm-6">
                                                <label for="usr" class="col-sm-4 col-form-label">시스템코드</label>
                                                <div class="col-sm-8">
                                                    <input type="text" id="searchPopCntcSysCd" class="form-control" style="width: 60%; max-width: 196px;">
                                                </div>
                                            </div>
                                            <div class="form-group row  col-sm-6">
                                                <label for="usr" class="col-sm-4 col-form-label">시스템명</label>
                                                <div class="col-sm-8">
                                                    <input type="text" id="searchPopCntcSysNm"class="form-control float-left" style="width: 60%; max-width: 196px;">
                                                    <button type="button" id="btnSearchPop" class="btn btn-info">조회</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
            <div class="card-body">
                <div id="gwpwrGrid"></div>
                <div id="gwpwrGridPager" class="portal-pager"></div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-primary" id="btnGwpwrSelect">선택</button>
            <button type="button" class="btn btn-primary" data-dismiss="modal" id="btnGwpwrClose">닫기</button>
        </div>
    </div>
</div>

<script>

    $(document).ready(function() {
    	 var params = [];
 	     params.push({"id" : "searchPopCmpnyCd", "clsCd" : "0024"});    //회사
    	 params.push({"id" : "searchPopCntcSysClsCd", "clsCd" : "0035"});    //연계시스템 분류
    	 requestCmmnCd(params);
    	      
        
        //페이지 초기화
        pageInit();
        
        //이벤트 바인딩
        bindEvent();
        
        //searchGwpwrUserList();
    });
    
    /*
     * 페이지 초기화
     * @param
     * @return
     */
    function pageInit() {
        
    	if($("#cmpnyCdReg").val() != null) {
    		$("#searchPopCmpnyCd").val($("#cmpnyCdReg").val()).prop('selected',true);
    	}
    	   	
        //그리드 초기화
        drawGwpwrGrid();
        
        searchGwpwrUserList();
    }
    
    /*
     * 이벤트 바인딩
     * @param
     * @return
     */
    function bindEvent(){
        
        //조회버튼 클릭 이벤트 처리
        $("#btnSearchPop").on("click",function(){
            searchGwpwrUserList();
        });
    }
    
    /*
     * 그리드 초기화
     * @param
     * @return
     */
    function drawGwpwrGrid(data){

        var params = {};
        if (data != null && data != undefined) {
            if (data.result != null && data.result.resultList != null) {
                params = data.result.resultList;
            }
            drawPager("gwpwrGridPager", data.result.paginationInfo, "searchGwpwrUserList");
        }
        
        $("#gwpwrGrid").jsGrid({
              height : "auto"
            , width : "100%"
            , autoload: true
            , sorting : true
            , align : "center"
            , data : params
            , selectData : null
            , rowClick : function(args) {
                    $(".jsgrid-row, .jsgrid-alt-row").removeClass("highlight");
                    var gRow = this.rowByItem(args.item);
                    gRow.addClass("highlight");
                    this.selectData = args.item;
                }
	        , fields : [
	                {name: "cntcSysClsNm"       , title : "분류"           , type : "text"   , width : 30}
	                , {name: "cmpnyNm"             , title : "회사"           , type : "text"   , width : 30}
	                , {name: "cntcSysCd"           , title : "시스템코드"        , type : "text"   , width : 30, align:"center"}
	                , {name: "cntcSysNm"           , title : "시스템명"           , type : "text"   , width : 30}
	                , {name: "sysDc"               , title : "설명"         , type : "text"   , width : 30}
	                , {name: "useAt"               , title : "사용여부"            , type : "text"   , width : 30, align:"center"}
	            ]
        });
    }
    
    /*
     * 검색
     * @param 페이지번호
     * @return
     */
    function searchGwpwrUserList(pageNo) {
    	
    	
    	
        var url = '/task/develop/selectCntcSysList';
        var currentPageNo = 1;
        if (pageNo != null && pageNo != undefined && pageNo != "") {
            currentPageNo = pageNo;
        }
        
        var aObj = $(".jq_cntcSysChackbox");
        var aCntcSys = [];
        $.each(aObj, function(index, item) {
            aCntcSys.push($(item).val());
        });
        
        var param = {
                devlopSn : $("#taskCd").val()
                , processNo: $("#processNo").val()
                , searchPopCntcSysClsCd: $("#searchPopCntcSysClsCd").val()
                , searchPopCmpnyCd: $("#searchPopCmpnyCd").val()
                , searchPopCntcSysCd: $("#searchPopCntcSysCd").val()
                , searchPopCntcSysNm: $("#searchPopCntcSysNm").val()
                , cntcSysList : aCntcSys
                , currentPageNo:currentPageNo
                , recordCountPerPage:10
                , pageSize:10
            }
        callAsyncAjax(url, param, "drawGwpwrGrid");
    }

</script>