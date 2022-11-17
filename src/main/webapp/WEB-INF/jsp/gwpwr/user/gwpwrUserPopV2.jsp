<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="modal-dialog modal-lg">
    <div class="modal-content">
        <div class="modal-header">
            <h4 class="modal-title">사원검색</h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <div class="modal-body" >
            <form name="searchForm" class="form-horizontal">
                <div class="col-sm-12 row">
                    <div class="col-sm-5" style="margin: 0.25rem 0 0.3rem 0;">
                        <div class="form-group row">
                            <label for="inputUserId" class="col-sm-5 col-form-label">아이디</label>
                            <div class="col-sm-7">
                                <input type="hidden" class="form-control" id="gwpwrCmpnyCd" style="width:80%;" />
                                <input type="text" class="form-control" id="gwpwrUserId" style="width:80%;" placeholder="아이디" />
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-7" style="margin: 0.25rem 0 0.3rem 0;">
                        <div class="form-group row">
                            <label for="inputEmpNm2" class="col-sm-3 col-form-label">성명</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control float-left" id="gwpwrUserNm" style="width:50%;" placeholder="성명" />
                                <input type="button" id="btnSearchGwpwrUser" class="btn btn-info float-left" value="검색" />
                            </div>
                        </div>  
                    </div>
                </div>
            </form>
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
		
		//페이지 초기화
	    pageInit();
	    
		//이벤트 바인딩
	    bindEvent();
	});
	
    /*
     * 페이지 초기화
     * @param
     * @return
     */
	function pageInit() {
    	
        //그리드 초기화
        drawGwpwrGrid();
	}
    
    /*
     * 이벤트 바인딩
     * @param
     * @return
     */
    function bindEvent(){
    	
        //조회버튼 클릭 이벤트 처리
        $("#btnSearchGwpwrUser").on("click",function(){
            searchGwpwrUserList();
        });
        
        $("#gwpwrUserId, #gwpwrUserNm").keyup(function(e){
            if(e.keyCode == 13){
            	searchGwpwrUserList();
            }
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
                  {name: "gwpwrId"          , title : "아이디"         , type : "text"   , width : 80}
                , {name: "userNm"           , title : "성명"          , type : "text"   , width : 80}
                , {name: "cmpnyNm"          , title : "회사"          , type : "text"   , width : 100}
                , {name: "deptCd"           , title : "부서"          , type : "text"   , width : 0, visible: false}
                , {name: "deptNm"           , title : "부서"          , type : "text"   , width : 150}
                , {name: "mbtlnum"          , title : "전화번호"       , type : "text"   , width : 120}
                , {name: "email"            , title : "이메일"         , type : "text"   , width : 200}
            ]
        });
        
    }
    
    /*
     * 검색
     * @param 페이지번호
     * @return
     */
    function searchGwpwrUserList(pageNo) {

        var url = '/gwpwr/user/getGwpwrUserListV2';
        var currentPageNo = 1;
        if (pageNo != null && pageNo != undefined && pageNo != "") {
            currentPageNo = pageNo;
        }

        var param = {
        	gwpwrCmpnyCd: $("#gwpwrCmpnyCd").val(),	
            gwpwrId: $("#gwpwrUserId").val(),
            userNm: $("#gwpwrUserNm").val(),
            currentPageNo:currentPageNo,
            recordCountPerPage:5,
            pageSize:10
        };
        callAsyncAjax(url, param, "drawGwpwrGrid");
    }

</script>