<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<div class="card card-primary" style="height:700px;">
    <div class="card-header">
        <div class="card-tools">
        <c:if test="${flag}">
            <button type="button" id="updateBtn" class="btn btn-tool">수정</button>
            <button type="button" id="deleteBtn" class="btn btn-tool">삭제</button>
        </c:if>
            <button type="button" id="backListBtn" class="btn btn-tool">목록으로</button>
        </div>
    </div>
    <div style="width:100%; min-height:500px; overflow:hidden;">
        <div style="width:101%; height:100%; overflow-y:scroll;">
		    <div class="card-body">
		        <div class="mailbox-read-info">
		            <h5 id="boardSjDetail"></h5>
		            <h6 id="title">
			            <span id="registerIdDetail"></span>&nbsp;
			            <span id="numOfHitDetail"></span>
			            <span id="regDtDetail" class="mailbox-read-time float-right"></span>
		            </h6>
		        </div>
		        <div class="mailbox-read-message" style="min-height:500px;">
			        <div id="boardCnDetail" style="min-height:300px;"></div>
			        <div id="atchFile">
	                    <ul class="mailbox-attachments d-flex align-items-stretch clearfix"></ul>
	                </div>
                </div>
		    </div>
			<div class="card-footer">
                <div class="note-editor">
                    <div class="note-handle row">
                        <textarea class="note-codable" id="answerCn" aria-multiline="true" style="width:94%; height:85px; resize:none;"></textarea>
                        <button type="button" class="btn btn-primary" id="regAnswer" style="height:85px; right:0%; bottom:0%; position:absolute;">댓글 달기</button>
                    </div>
                </div>
            </div>
		    <table class="table table-bordered" id="answerTable" style="background-color:#ffffff;"></table>
	    </div>
    </div>
</div>
<script>
    var grpNo = "0";
    $(document).ready(function(){
    	pageInit();
    	bindEvent();
    });
    
    function pageInit(){
    	detailBoard();
    	bbsUpload = new RpaUpload("atchFile");
    }
    
    function bindEvent(){
    	$("#backListBtn").on("click",function(){
    		backList();
    	});
    	
    	$("#updateBtn").on("click",function(){
    		var url = "/cmmnty/answer/bbsAnswerUpdtPop"
            $.ajax({
                url : url,
                dataType : "html",
                type : "GET",
                async : false,
                success : function(result){
                    $("#overPage").html(result);
                }
            });
    	});
    	
    	$("#deleteBtn").on("click",function(){
    		var check = confirm("게시글을 삭제하시겠습니까?");
    		if(!check){
    			return false;
    		}
    		var url = "/cmmnty/answer/boardDelete";
    		var param = {
    				boardNo : boardNo
    			  , boardSn : answerBsn
    			  , fileGrpNo : grpNo
    		};
    		callAsyncAjax(url, param, "backList");
    	});
    	
    	$("#regAnswer").on("click",function(){
    		var url = "/cmmnty/answer/insertAnswer";
            var param = {
            		"boardNo" : boardNo
                  , "answerCn" : $("#answerCn").val()
                  , "boardSn" : answerBsn
            };
            $("#answerCn").val("");
            callAsyncAjax(url, param, "getAnswers");
    	});
    	
    	$(document).on("click","#replyAnswer",function(){
    	    var cls = $(this).parent().parent().attr("class");
    	    var reply = cls + "reply";
    	    $("."+reply).toggle(
   	    		function(){
   	    			$("."+reply).children().find("textarea").focus();
   	    		}
    	    );
    	});
    	
    	$(document).on("click","#replyAnswerCancel",function(){
    	    var cls = $(this).parent().parent().attr("class");
    	    $("."+cls).toggle();
    	});
    	
    	$(document).on("click","#regAnswerReply",function(){
    		var AnswerNumber = $(this).parent().parent().children().find("[type=hidden]").val();
    		var replyContent = $(this).parent().parent().children().find("textarea").val();
    		
    		var url = "/cmmnty/answer/insertAnswer";
    		var param = {
    				"boardNo" : boardNo
    			  , "upAnswerSn" : AnswerNumber
    			  , "boardSn" : answerBsn
    			  , "answerCn" : replyContent
    		};
    		callAsyncAjax(url, param, "getAnswers");
    	});
    	
    	$(document).on("click","#deleteAnswer",function(){
    		var deleteNo = $(this).parent().parent().children().find("[type=hidden]").val();
    		var url = "/cmmnty/answer/deleteAnswer";
    		var param = {
    				"boardNo" : boardNo
	    		  , "upAnswerSn" : deleteNo
    		};
    		callAsyncAjax(url, param, "getAnswers");
    	});
    	
    	$(document).on("click","#deleteReply",function(){
    		var deleteNo = $(this).parent().parent().children().find("[type=hidden]").val();
    		var url = "/cmmnty/answer/deleteReply";
    		var param = {
    				"boardNo" : boardNo
    			  , "answerSn" : deleteNo
    		};
    		callAsyncAjax(url, param, "getAnswers");
    	});
    }
    
    function detailBoard(){
    	var url = "/cmmnty/answer/boardAnswerDetailPop";
    	 var param = {
    			 "boardNo" : boardNo
               , "boardSn" : answerBsn
               , "numOfHit" : answerNOH
         };
         callAsyncAjax(url, param, "drawValue");
    }
    
    function drawValue(data){
        var answerValue = data.result.answerValue;
        
        $("#boardSjDetail").html("<b>"+answerValue.boardSj+"</b>");
        $("#boardCnDetail").summernote('code',answerValue.boardCn);
        $("#boardCnDetail").summernote('destroy');
        $("#registerIdDetail").text(answerValue.registerId);
        $("#regDtDetail").text(moment(answerValue.regDt).format('YYYY-MM-DD HH:mm'));
        $("#numOfHitDetail").html("조회 : "+answerValue.numOfHit);
        
        
        if(answerValue.fileGrpNo != "0" && answerValue.fileGrpNo != null){
            grpNo = answerValue.fileGrpNo; /*수정*/
        	var url = "/file/getAtchmnflList";
        	var param = {
        			fileGrpNo : grpNo
        	};
        	callAsyncAjax(url, param, "getAtchFile");
        }
        
        getAnswers();
    }
    
    function getAnswers(){
    	var url = "/cmmnty/answer/getAnswers";
    	var param = {
    			"boardNo" : boardNo
    		  , "boardSn" : answerBsn
    	};
    	callAsyncAjax(url, param, "drawTable");
    }
    
    function drawTable(data){
    	var answerList = data.result.answerList.items;
    	var html = "";
    	html += '<colgroup>';
    	html +=    '<col width="5%" />';
    	html +=    '<col width="5%" />';
   		html +=    '<col width="5%" />';
	    html +=    '<col width="65%" />';
		html +=    '<col width="10%" />';
		html +=    '<col width="10%" />';
		html += '</colgroup>';
    	$.each(answerList,function(index,item){
    		if(item.upAnswerSn == item.answerSn){
		    	html += "<tr class='answer"+index+"'>";
		    	html +=    "<td colspan='2' style='width:10%; vertical-align:middle; text-align:center;'>";
		    	html +=        item.registerId + "<input type='hidden' value='"+item.answerSn+"'>";
		    	html +=    "</td>";
		    	html +=    "<td colspan='2' style='width:70%; vertical-align:middle;'>"+item.answerCn+"</td>";
		    	html +=    "<td style='width:10%; vertical-align:middle; text-align:center;'>"+moment(item.regDt).format('YYYY-MM-DD HH:mm')+"</td>";
		    	html +=    "<td style='width:10%; vertical-align:middle; text-align:center;'>";
		    	html +=       "<button type='button' class='btn btn-primary' id='replyAnswer'>답글</button>&nbsp;";
		    	html +=       "<button type='button' class='btn btn-primary' id='deleteAnswer'>삭제</button>";
		    	html +=    "</td>";
		    	html += "<tr>";
		    	html += "<tr class='answer"+index+"reply' style='display:none;'>";
		    	html +=    "<td style='width:5%; background-color:rgba(0,0,0,.03)'>";
		    	html +=       "<input type='hidden' value='"+item.answerSn+"'>";
		    	html +=    "</td>";
		    	html +=    "<td colspan='2' style='width:10%; vertical-align:middle; text-align:center;'>${txUserId}</td>";
		    	html +=    "<td colspan='2' style='width:75%;'><textarea class='note-codable col-sm-12' aria-multiline='true' style='width:100%; resize:none;'></textarea></td>";
		    	html +=    "<td style='width:10%; vertical-align:middle; text-align:center;'>";
		    	html +=       "<button type='button' class='btn btn-primary' id='regAnswerReply'>저장</button>&nbsp;";
		    	html +=       "<button type='button' class='btn btn-primary' id='replyAnswerCancel'>취소</button>";
		    	html +=    "</td>";
		    	html += "<tr>";
    		}else{
    			html += "<tr class='answer"+index+"'>";
                html +=    "<td style='width:5%; background-color:rgba(0,0,0,.03)'>";
                html +=       "<input type='hidden' value='"+item.answerSn+"'>";
                html +=    "</td>";
                html +=    "<td colspan='2' style='width:10%; vertical-align:middle; text-align:center;'>"+item.registerId+"</td>";
                html +=    "<td style='width:65%; vertical-align:middle;'>"+item.answerCn+"</td>";
                html +=    "<td style='width:10%; vertical-align:middle; text-align:center;'>"+moment(item.regDt).format('YYYY-MM-DD HH:mm')+"</td>";
                html +=    "<td style='width:10%; vertical-align:middle; text-align:center;'>";
                html +=       "<button type='button' class='btn btn-primary' id='deleteReply'>삭제</button>&nbsp;";
                html +=    "</td>";
                html += "<tr>";
    		}
    	});
    	
    	$("#answerTable").html(html);
    }
    /*resonseVO 리턴형이라 result 추가*/
    function getAtchFile(fileInfoList){
    	var html = "";
    	var fileGrpNo = fileInfoList.result[0].fileGrpNo;
    	var szUnit = "byte";
    	var convertSz = 0;
    	
    	html += '<input type="hidden" id="fileGrpNo" name="fileGrpNo" value="'+fileGrpNo+'" />';
    	$.each(fileInfoList.result, function(index,item){
            html += '<li id="upload'+index+'">';
            html +=     '<span class="mailbox-attachment-icon"><i class="far fa-file-pdf"></i></span>';
            html +=     '<div class="mailbox-attachment-info">';
            html +=         '<a href="#" class="mailbox-attachment-name"><i class="fas fa-paperclip"></i>'+item.oriFileNm+'</a>';
            html +=         '<span class="mailbox-attachment-size clearfix mt-1">';
            if(item.fileSz < 1024){
            	convertSz = item.fileSz;
            }else if(item.fileSz/1024 < 1024){
            	var tmp = item.fileSz/1024;
            	szUnit = "KB";
            	convertSz = tmp.toString().substring(0,tmp.toString().indexOf(".")+2);
            }else{
            	var tmp = (item.fileSz/1024)/1024;
            	szUnit = "MB";
            	convertSz = tmp.toString().substring(0,tmp.toString().indexOf(".")+2);
            }
            html +=             '<span>'+ convertSz+szUnit +'</span>';
            html +=             '<input type="hidden" id="fileNo'+index+'" name="fileNo" value="'+item.fileNo+'" />';
            html +=             '<a href="#" class="btn btn-default btn-sm float-right" id="btnDownFile'+index+'">';
            html +=                 '<i class="fas fa-cloud-download-alt"></i>';
            html +=             '</a>';
            html +=         '</span>';
            html +=     '</div>';
            html += '</li>';
        });
    	
    	$("#atchFile ul").html(html);
    	
    	$("#atchFile ul [id^='btnDownFile']").on("click", function(){
            downloadFile(fileGrpNo, $(this).closest("li").attr("id"));
        });
    	
    }
    
    function downloadFile(fileGrpNo, liId) {
        var fileNo = $("#"+liId+" input[id^='fileNo']").val();
        $("#downloadFileGrpNo").val(fileGrpNo);
        $("#downloadFileNo").val(fileNo);
        $("#downloadForm").submit();
    }
</script>