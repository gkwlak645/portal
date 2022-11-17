<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt"     uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- SEARCH FORM -->
<div class="card wrap" id="answerBoardMain" style="height:700px;">
    <div class="card-header">
        <form name="searchForm" class="form-horizontal">
            <div class="row">
                <div class="col-sm-5">
                    <div class="form-group row">
                        <label for="inputBoardSj" class="col-sm-3 col-form-label float-right">제목</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" id="inputBoardSj" placeholder="제목" />
                        </div>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="form-group row">
                        <label for="inputBoardCn" class="col-sm-3 col-form-label float-right">내용</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" id="inputBoardCn" placeholder="내용" />
                        </div>
                    </div>
                </div>
                <div class="col-sm-3">
                   <div class="form-group row float-right">
                       <input type="button" id="searchBtn" class="btn btn-info btn-flat" value="검색" />
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div class="card-body">
        <div class="col-sm-12">
            <button type="button" id="regBtn" class="btn btn-info float-right">등록</button>
        </div>
        <div id="answerSearchGrid"></div>
        <div id="paging" style="text-align:center"></div>
    </div>
</div>

<!-- page script -->
<script>
    var boardNo = "";
    var searchSj = "";
    var searchCn = "";
    var answerList = "";
    var cudPage = 1;
    var answerBsn = "";
    var answerNOH = "";
    
    function pageInit() { 
    	boardNo = "${boardNo}";
    	getAnswerList("","",cudPage);
    };
    
    function bindEvent(){
        $("#searchBtn").on("click",function(){
            $(".pagingClass").remove();
            searchSj = $("#inputBoardSj").val();
            searchCn = $("#inputBoardCn").val();
            cudPage = 1;
            getAnswerList(searchSj,searchCn, cudPage);
        });
        
        $("#inputBoardSj, #inputBoardCn").keyup(function(e){
            if(e.keyCode == 13){
                $(".pagingClass").remove();
                searchSj = $("#inputBoardSj").val();
                searchCn = $("#inputBoardCn").val();
                cudPage = 1;
                getAnswerList(searchSj,searchCn, cudPage); 
            }
        });

        $("#regBtn").on("click",function(){
            var url = "/cmmnty/answer/bbsRegAnswerPop";
            appendDivReg(url);
        });
        
        $(document).on("click",".pagingClass",function(){
            if($(this).text() == "처음"){
                cudPage = 1;
            }else if($(this).text() == "이전"){
                cudPage = answerList.pageInfo.currentPageNo-1;
            }else if($(this).text() == "다음"){
                cudPage = answerList.pageInfo.currentPageNo+1;
            }else if($(this).text() == "마지막"){
                cudPage = answerList.pageInfo.totalPageCount;
            }else{
                cudPage = $(this).text();
            }
            
            getAnswerList(searchSj,searchCn, cudPage);
        });
        
    }
    
    function getAnswerList(search1, search2, pageNum){
    	var url = "/cmmnty/answer/getBoard";
    	var param = {
    			boardNo : boardNo
    		  , boardSj : search1
    		  , boardCn : search2
    		  , pageInfo : {
    			  currentPageNo: pageNum
    		  }
    	};
    	callAsyncAjax(url, param, "drawGrid");
    }

    function drawGrid(data){
        var pageSize = 10;
        if(data != ""){
            answerList = data.result.answerList;
            pageSize = answerList.pageInfo.recordCountPerPage;
            if(answerList.pageInfo.totalRecordCount > answerList.pageInfo.recordCountPerPage){
                pagingGrid(answerList.pageInfo,"paging");
            }
        }
        console.log(answerList);
        $("#answerSearchGrid").jsGrid({
            height : "500",
            width : "100%",
            autoload: true,
            sorting : true,
            paging : true,
            pageSize: pageSize,
            rowClick: function(arg){
            	answerBsn = arg.item.boardSn;
            	answerNOH = arg.item.numOfHit;
            	detailPageMove(arg.item.registerId);
            },
            data: answerList.items,
    
            fields : [ 
                {name: "boardSn" ,title : "순번",type : "text", width : 50, align:"center"}, 
                {name: "boardSj" ,title : "제목", 
                	   itemTemplate:function(value,item){
                		   var result = value;
                		   console.log(item.checkImg);
                		   if(item.checkImg != null && item.fileGrpNo != 0){
                			   result += " &nbsp;&nbsp;<i class='note-icon-picture'></i>";
                		   }
                		   if(item.fileGrpNo != null && item.fileGrpNo != 0){
                			   result += " &nbsp;&nbsp;<i class='fas fa-save'></i>";
                		   }
                		   if(item.totalAnswer != null && item.fileGrpNo != 0){
                			   result += " &nbsp;&nbsp;["+ item.totalAnswer +"]" ;
                		   }
                		   return result;
                }, width : 200}, 
                {name: "registerId" ,title : "글쓴이", type : "text", width : 50, align:"center"}, 
                {name: "regDt" ,title : "작성일", 
                	itemTemplate:function(value){
                        return moment(value).format('YYYY-MM-DD HH:mm');
                 }, width : 80, align:"center"}, 
                {name: "numOfHit" ,title : "조회수", type : "text", width : 50, align:"center"} 
            ]
        });
    }
    
    function appendDivReg(url){
        var html = "";
        html += '<div id="overPage" class="over"></div>';
        $("#answerBoardMain").append(html);
        
        $.ajax({
            url : url,
            dataType : "html",
            type : "get",
            success : function(result){
                $("#overPage").html(result);
            }
        });
    }
    
    function backList(){
        $(".over").remove();
        getAnswerList(searchSj,searchCn, cudPage);
    }
    
    function detailPageMove(regId){
    	var param = { "regId" : regId };
        var url = "/cmmnty/answer/bbsAnswerDetailPop";
        var html = "";
        html += '<div id="overPage" class="over"></div>';
        $("#answerBoardMain").append(html);
        
        $.ajax({
            url : url,
            dataType : "html",
            data : param,
            type : "GET",
            async : false,
            success : function(result){
                $("#overPage").html(result);
            }
        });
    };
    
    function pagingGrid(param,id){
        var result = "";
        if(param.currentPageNo > param.pageSize){
            result += '<a class="'+id+'Class" href="#">처음</a>&nbsp;&nbsp;';
        }
        if(param.currentPageNo != 1){
            result += '<a class="'+id+'Class" href="#">이전</a>&nbsp;&nbsp;';
        }
        for(var i = param.firstPageNoOnPageList ; i <= param.lastPageNoOnPageList ; i++){
            if(param.currentPageNo == i){
                result += '<a class="'+id+'Class" href="#"><strong>'+i+'</strong></a>&nbsp;&nbsp;';
            }else{
                result += '<a class="'+id+'Class" href="#">'+i+'</a>&nbsp;&nbsp;';
            }
        }
        if(param.currentPageNo != param.totalPageCount){
            result += '<a class="'+id+'Class" href="#">다음</a>&nbsp;&nbsp;';
        }
        if(param.currentPageNo <= (param.totalPageCount - (param.totalPageCount % param.pageSize))){
            result += '<a class="'+id+'Class" href="#">마지막</a>';
        }
            
        $("#"+id).html(result);
    };
    
</script>