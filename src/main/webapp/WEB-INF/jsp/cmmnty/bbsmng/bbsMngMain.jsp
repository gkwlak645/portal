<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
 <div class="container-fluid wrap">
    <div class="row" alt="커뮤니티>게시판관리">
        <div class="col-md-12">
            <div class="card">
                <div class="card-body" style="margin-top:2px;height:auto; min-height:50px">
                    <form name="searchForm" class="form-inline">
                        <div class="form-group col-md-9" style="margin-bottom:0.2rem;">
                            <label for="name" class="col-sm-2 col-form-label">조회대상</label>
                            <div class="form-group col-sm-8">
	                            <label for="inputDescription" hidden="hidden"></label>
	                            <select class="form-control" id="inputUseAt1" style="min-width:150px; margin:0 5px 2px 0;">
	                                <option selected disabled>조회조건선택</option>
	                                <option value="bbsName">게시판명</option>
	                                <option value="TY">유형</option>
	                            </select>
                                <select class="form-control" id="inputUseAt2"  style="min-width:160px;margin:0 10px 0 0;">
	                                <option selected disabled>유형선택</option>
	                                <option value="0">전체</option>
	                                <option value="1">공지사항</option>
	                                <option value="2">Q&A</option>
	                                <option value="3">FAQ</option>
	                                <option value="4">일반게시판</option>
                                </select>
                                <input hidden="hidden"><!-- form 으로 인하여 enter키 입력시 submit실행 되어 추가 함 -->
                                <div class="form-group">
                                    <input type="text" class="form-control" id="nameVal" >
                                </div>
                                <!-- <button type="button" id="btnSearch" class="btn btn-info float-rigth">전체검색</button> -->
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
                    <button type="button" id="btnRegister" class="btn btn-primary float-right" style="margin:5px 0 15px 2px;">등록</button>
                                        
                    <div id="deviceGrid"></div>
                    <div id="robotGridPager" class="portal-pager"></div>
                </div>
            </div>
        </div>
    </div> 
</div>

<script>
    
    /*
     * 이벤트 pageInit
     * @param
     * @return
     */
    function pageInit() {
        getBoardList();
        $("#inputUseAt2").css("display", "none");
        $("#nameVal").css("display","none");
    };
    
    /*
     * 이벤트 바인딩
     * @param
     * @return
     */
    function bindEvent(){
        $("#inputUseAt1").on("change", function(){
        	if($("#inputUseAt1").val() == "bbsName"){
                $("#nameVal").val("").css("display","none");
                $("#inputUseAt2").show();
            }
        });
        
        $("#inputUseAt1").on("change", function(){
            if($("#inputUseAt1").val() == "TY"){
                $("#nameVal").show();
                $("#inputUseAt2").hide();
            }
        });
        
        $("#inputUseAt2").on("change", function(){
        	if($("#inputUseAt2").val() == "0"){
        		getBoardList();
        	}else{
                getBoardType(); 
        	}
        });
        
         //검색버튼 클릭 이벤트 처리
        $("#btnSearch").on("click",function(){
        	getBoardList();
        }); 
         
        $("#nameVal").keyup(function(e){
            if(e.keyCode == 13){
            	getBoardList(); 
            }
        });
         
        //등록페이지로 pop
        $("#btnRegister").on("click",function(){
            var url = "/cmmnty/bbsmng/bbsCreate"
            appendDivDetailGet(url);
        });
    }
     
    /*
     * 게시판 관리 조회
     * @param
     * @return
     */
    function getBoardList(pageNo){
        var url = "/cmmnty/bbsmng/getBoardList";
        var currentPageNo = 1;
        if (pageNo != null && pageNo != undefined && pageNo != "") {
            currentPageNo = pageNo;
        }
        var param = {
        		boardTy: $("#nameVal").val()
        	  , pageInfo:{
        		    currentPageNo:currentPageNo
        	        }
        		};
        callAsyncAjax(url, param, "drawGrid");
    }
    
    function getBoardType(pageNo){
        var url = "/cmmnty/bbsmng/getBoardType";
        var currentPageNo = 1;
        var data = $("#inputUseAt2").val(); 
        if (pageNo != null && pageNo != undefined && pageNo != "") {
            currentPageNo = pageNo;
        } 
        var param = {
        	"boardCd"  : data
          , "pageInfo" : {
        	    currentPageNo:currentPageNo
        	    }
            };
        callAsyncAjax(url, param, "drawGrid2");
    }
  
    function appendBoardType(data){
    	var boardType = data.result.boardType;
    	var html = "";
    	$.each(boardType,function(index,item){
    		html += "<option value='"+item.boardTy+"'>"+item.boardDc+"</option>";
    	});
    	$("#inputBoardTy").append(html);
    }
    
    
    function drawGrid(data){
    	var pageSize = 10;
        var params = {};
            if (data != null && data != undefined) {
                drawPager("robotGridPager", data.result.boardList.pageInfo, "getBoardList");      
            }  
        $("#deviceGrid").jsGrid({
              height : "auto"
            , width : "100%"
            , sorting : true
            , rowClick: function(arg){
                detailPageMove(arg.item.boardNo);
            }
            , align : "center"
            , data : data.result.boardList.items
            , fields : [
                  {name: "boardNo"       , title : "번호"       , type : "text"   , width : 20, align:"center" }
                , {name: "boardTy"       , title : "유형"       , type : "text"   , width : 30}
                , {name: "boardNm"       , title : "게시판명"     , type : "text"   , width : 90}
                , {name: "registerId"    , title : "등록자"      , type : "text"   , width : 20, align:"center"}
                , {name: "regDt"         , title : "생성일"      , type : "text"   , width : 30, align:"center",
                	itemTemplate:function(value){return moment(value).format('YYYY-MM-DD')}}
            ]
        });
    }

    
    function drawGrid2(data){
        var pageSize = 10;
        var params = {};
            if (data != null && data != undefined) {
                drawPager("robotGridPager", data.result.boardList.pageInfo, "getBoardType");      
            }  
        $("#deviceGrid").jsGrid({
              height : "auto"
            , width : "100%"
            , sorting : true
            , rowClick: function(arg){
                detailPageMove(arg.item.boardNo);
            }
            , align : "center"
            , data : data.result.boardList.items
            , fields : [
                  {name: "boardNo"       , title : "번호"       , type : "text"   , width : 20, align:"center" }
                , {name: "boardTy"       , title : "유형"       , type : "text"   , width : 30}
                , {name: "boardNm"       , title : "게시판명"     , type : "text"   , width : 90}
                , {name: "registerId"    , title : "등록자"      , type : "text"   , width : 20, align:"center"}
                , {name: "regDt"         , title : "생성일"      , type : "text"   , width : 30, align:"center",
                    itemTemplate:function(value){return moment(value).format('YYYY-MM-DD')}}
            ]
        });
    }
    /*
     * 상세페이지 이동
     */
    function detailPageMove(boardNo){
        var url = "/cmmnty/bbsmng/bbsDetail";
        appendDivDetailGet(url); 
        var id = boardNo;       
        var url_2 = "/cmmnty/bbsmng/getProperty";
        var param = {
        		boardNo : id
        };
               callAsyncAjax(url_2, param, "getProper");
    };
    
    function getProper(data){
    	 $("#deleteCd").val(data.result.boardList[0].boardCd); 
    	 $("#boardTy").val(data.result.boardList[0].boardTy); 
         $("#boardNo").val(data.result.boardList[0].boardNo);   
    	 $("#boardUrl").val(data.result.boardList[0].boardUrl); 
         $("#boardNm").val(data.result.boardList[0].boardNm);    
         $("#boardDc").val(data.result.boardList[0].boardDc);
         $("#useAt").val(data.result.boardList[0].useAt);
    }
    
    function appendDivDetailGet(url){
        var html = "";
        html += '<div id="overPage2" class="over"></div>';
        $(".wrap").append(html);
        $.ajax({
            url : url,
            dataType : "html",
            type : "GET",
            async : false,
            success : function(result){
                $("#overPage2").html(result);
            }
        });
   }
   
   /*  function appendDivDetailPost(url,id){
        var param = {"id" : id};
        callAsyncAjax(url, param, "drawValue");
    } */
   
	function callBack(){
	    $(".over").remove();
	    getBoardList();
	    $("#inputUseAt1").val("조회조건선택").attr("selected", "selected");
	}  
</script>