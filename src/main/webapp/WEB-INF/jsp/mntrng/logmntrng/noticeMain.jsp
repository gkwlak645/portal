<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt"     uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!-- SEARCH FORM -->
 <div id="noticeBoardMain" class="container-fluid wrap">
    <div class="row" alt="커뮤니티 >공지사항">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <form class="form-inline py-sm-2">
                        <div class="form-group col-md-7  py-sm-2">
                          <label for="usr" class="col-form-label" style="width:70px; margin:0 10px 0 5px;">날짜</label>
                          <div class="col-sm-4 float-left" style="min-width: 134px;"> 
                              <div class="input-group date" id="startDeDiv" data-target-input="nearest" style="min-width:130px;margin: 0 0 2px 0;">
                                  <input type="text" id="startDe" name="startDe" class="form-control datetimepicker-input" data-target="#startDeDiv"/>
	                                  <div class="input-group-append" data-target="#startDeDiv" data-toggle="datetimepicker">
	                                      <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                  </div>
                              </div>
                          </div>
                          <div class="col-sm-4  float-left" style="min-width: 134px;">
                              <div class="input-group date" id="endDeDiv" data-target-input="nearest" style="min-width:130px;margin: 0 0 2px 0;">
                                  <input type="text" id="endDe" name="endDe" class="form-control datetimepicker-input" data-target="#endDeDiv"/>
                                  <div class="input-group-append" data-target="#endDeDiv" data-toggle="datetimepicker">
                                      <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                  </div>
                              </div>
                          </div>
                        </div>
                        <div class="form-group col-md-4"></div>
                        <div class="form-group col-md-12 py-sm-2" style="margin: 0.25rem 0.1rem 0.3rem 0.1rem;min-width: 460px;" >
                          <label for="searchCombo" class="col-form-label" style="width:70px; margin:0 10px 0 5px;">제목</label>
                          <div> 
                              <div class="col-sm-4 float-left" style="width: 74%;margin: 0 0 2px 0;">
                                    <select class="form-control" id="searchCombo" style="width: 54%;min-width:130px;">
                                    <option value="subject" selected>제목</option>
                                    <option value="content">내용</option>
                                </select>
                              </div>
                          </div>
                          <div class="col-sm-7 float-left" >
                              <div style="margin: 0 0 2px 0;">
                                  <input type="text" class="form-control float-left" id="inputNoticeSearch" placeholder="검색어"style="width:56%;" value="" /><button type="button" id="btnSearch" class="btn btn-info  float-left">조회</button>
                              </div></div>
                        </div>                                                                                      
                    </form>
                </div>                 
            </div> 
        </div>                 
    </div>   
        
    
                     
    <div class="row">
        <div class="col-md-12">        
	       <div class= "card">
	           <c:if test="${txScreenAuthor.redngAuthor eq 'Y'}">
	           <div class = "card-body">
		          <div class="col-sm-12">
		            <button type="button" id="regBtn" class="btn btn-primary float-right" style="margin:5px 0 15px 2px;">등록</button>
		          </div>
		       </c:if>    
		            <div id="answerSearchGrid"></div>
		            <div id="paging" class="portal-pager"></div>
	            </div>	        
            </div>
        </div>
    </div> 
</div>
<!-- page script -->
<script>
    var boardNo = "";
    var cudPage = 1;  
    var searchTerm = "N";
    function pageInit() { 
        boardNo = "${boardNo}";
        getNoticeList2(cudPage);
    };
    
    function bindEvent(){
    	/* 시작날짜 내보내기 */
    	$('#startDeDiv').datetimepicker({
            format: 'YYYY-MM-DD'
          , defaultDate: getMonthGapDate(-3)
        });
    	
    	/* 마지막날짜 내보내기 */
        $("#endDeDiv").datetimepicker({
            format: 'YYYY-MM-DD'
          , defaultDate: (new Date())
        });
        
        /* 검색버튼 누를 시 검색 및 그리드 작성 */
        $("#searchBtn").on("click",function(){
            $(".pagingClass").remove();
            getNoticeList();
        });
        
       /*  엔터 키 누를시 검색 및 그리드 작성 */
        $("#inputNoticeSearch").keyup(function(e){
            if(e.keyCode == 13){
                $(".pagingClass").remove();
                getNoticeList(); 
            }
        });
       
        /* 등록페이지 이동 */
        $("#regBtn").on("click", function(){
            var url = "/cmmnty/notice/noticeRegPop";
            var divId = "noticeBoardMain";
            appendDetailPopup(divId, url);
        });
        
        /*시작 일자가 마지막일자보다 클 시*/
        $("#startDe").on("propertychange change paste input", function(){
        	if(unhyphenationPhoneNum($("#startDe").val()) > unhyphenationPhoneNum($("#endDe").val())){
                alert("시작일자가 마지막 일자보다 과거일 수 없습니다.");
                return $("#startDe").val(getMonthGapDate(-3));
                }
        });
        
        /*마지막 일자가 시작 일자보다 작을 시*/
        $("#endDe").on("propertychange change paste input", function(){
            if(unhyphenationPhoneNum($("#startDe").val()) > unhyphenationPhoneNum($("#endDe").val())){
                alert("마지막 일자가  시작일자보다 과거일 수 없습니다.");
                return $("#endDe").val(getMonthGapDate(0)-1); //"-"추가 필요 
            }
        }); 
    }
    
    /*공지사항 게시글 리스트 가져오기*/
    function getNoticeList(cudPage){
        var url = "/cmmnty/notice/getNotice";
        var searchCombo = $("#searchCombo").val();
        var noticeSearch = $("#inputNoticeSearch").val();
        var startDt = unhyphenationPhoneNum($("#startDe").val());
        var lastDt = unhyphenationPhoneNum($("#endDe").val());
        var param = new Object();
        var currentPageNo = 1;
        
        if (cudPage != null && cudPage != undefined && cudPage != "") {
            currentPageNo = cudPage;
        }
        
        if (searchCombo == "subject"){
        	param.boardSj = noticeSearch;
        } else if (searchCombo == "content"){
        	param.boardCn = noticeSearch;
        }
        param.boardNo = boardNo;
        param.pageInfo ={currentPageNo : currentPageNo};
        param.startDt = startDt;
        param.lastDt = lastDt;
        callAsyncAjax(url, param, "drawGrid");
        searchTerm = "Y";
    }
    
    /*공지사항 검색 조건 없는 게시글 리스트*/
    function getNoticeList2(pageNum){
        var url = "/cmmnty/notice/getNotice";
        var param = new Object();
        param.pageInfo ={currentPageNo : pageNum};
        param.boardNo = boardNo;
        callAsyncAjax(url, param, "drawGrid");
    }
    
    /*공지사항 게시글 그리드 그리기*/
    function drawGrid(data){
        var pageSize = 10;
        console.log(data);
        if(data != ""){
        	noticeList = data.result.noticeList;
        	if(searchTerm == "Y"){
        		drawPager("paging", noticeList.pageInfo, "getNoticeList");
        	}else{
        		drawPager("paging", noticeList.pageInfo, "getNoticeList2");
        	}
        	
        }
        $("#answerSearchGrid").jsGrid({
            height : "399",
            width : "100%",
            autoload: true,
            sorting : true,
            rowClick: function(arg){
                var boardRegId = arg.item.registerId;
                var boardRdcnt = arg.item.numOfHit;
                var boardSn = arg.item.boardSn;
                var getBoardNo = boardNo;
                
                detailNoticePageMove(boardRegId, getBoardNo);
                noticeDetail(getBoardNo, boardSn, boardRdcnt);
            },
            data: noticeList.items,
    
            fields : [ 
                {name: "boardSn" ,title : "순번",type : "text", width : 50, align:"center"}, 
                {name: "boardSj" ,title : "제목", itemTemplate:function(value,item){
                    var result = value;
                    if(item.fileGrpNo != null && item.fileGrpNo != 0){
                        result += " &nbsp;&nbsp;<i class='fas fa-chart-area'></i>"; 
                    }
                    return result; }, width : 200}, 
                {name: "registerId" ,title : "글쓴이", type : "text", width : 50, align:"center"}, 
                {name: "regDt" ,title : "작성일", itemTemplate:function(value){
                    return moment(value).format('YYYY-MM-DD HH:mm');
                 }, width : 80, align:"center"}, 
                {name: "numOfHit" ,title : "조회수", type : "text", width : 50, align:"center"} 
            ]
        });
    }

    /*공지사항 메인페이지로 이동*/
    function backList(){
        $(".over").remove();
        getNoticeList2(cudPage);
        searchTerm="N";
    }
    
    
    /*공지사항 게시글 상세페이지로 이동*/
    function detailNoticePageMove(registerId, valBoardNo){
    	var detailMoveUrl = "/cmmnty/notice/noticeDetailPop";
    	var divId = "noticeBoardMain";
    	var params = new Object();
    	params.registerId = registerId;
    	params.boardNo = valBoardNo;
        appendNoticeDetailPopup(divId, detailMoveUrl, params);
    }
    
    /*공지사항 게시글 상세 정보*/
    function noticeDetail(valBoardNo, boardSn, boardRdcnt){
    var detailNoticeUrl = "/cmmnty/notice/getNoticeDetailNumOfHit";
    var param = {    "boardNo"    :  valBoardNo
                   , "boardSn"    :  boardSn
                   , "numOfHit"   :  boardRdcnt};
    callAsyncAjax(detailNoticeUrl, param, "detailNotice");
    }
    
    /*공지사항 게시글 상세페이지 그리기*/
    function appendNoticeDetailPopup(divId, url, params){
        var html = "";
        html += '<div id="overPage2" class="over"></div>';
        $("#" + divId).append(html);
        $.ajax({
            url : url,
            dataType : "html",
            type : "GET",
            data : params,
            async : false,
            success : function(result){
                $("#overPage2").html(result);
            }
        });
    }
</script>