<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<div class="card card-primary card-outline" style="height:100%;">
    <div style="width:100%; min-height:500px; overflow:hidden;">
        <div style="width:101%; height:100%; overflow-y:scroll;">
            <div class="card-body pad">
                <div class="mailbox-read-info"> 
                    <div class="mb-3">
                        <h3 id="faqSJ"></h3>
                        <span id="regId"></span>&nbsp;
                        <span id="regDtDeta il" class="mailbox-read-time float-right"></span>
                    </div>
                </div>
            </div>
	        <div class="card-body pad">
	            <h3> 질문 </h3>
	            <div class="mb-2">
	                <div id="faqCN" style="min-height:300px;"></div>
	            </div>
	            <h3> 답변 </h3>
	            <div class="mb-2">
                    <div id="faqAnswerCN" style="min-height:300px;"></div>
                </div>
	            <div class="card-header">
	                <div id="atchFile">
	                    <ul class="mailbox-attachments d-flex align-items-stretch clearfix"></ul>
	                </div>
	            </div>
	            <div class="card-body form-group">
	                <div class="float-right">
	                    <c:choose>
			                <c:when test="${txScreenAuthor.wrtngAuthor eq 'Y'}">
			                    <button type="button" id="updtBtn" class="btn btn-primary">수정</button>
			                    <button type="button" id="deleteBtn" class="btn btn-primary">삭제</button>
			                    <button type="button" id="backListBtn" class="btn btn-primary">취소</button>
			                </c:when>
			                <c:otherwise>
			                   <button type="button" id="backListBtn" class="btn btn-primary">목록으로</button>
			                </c:otherwise>
		                </c:choose>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
</div>
<script>
    var bbsUpload = new RpaUpload("atchFile");
	var boardDetailSn = "";
	var grpNo ="";
	$(document).ready(function(){
	    pageInit();
	    bindEvent();
	});
	
	function pageInit(){
		startSummernote();
	}
	
	function bindEvent(){
	    /*목록으로 나 취소 누를 시 FAQ 메인 페이지 이동*/
	    $("#backListBtn").on("click",function(){
	        backList();
	    });
	    
	    /*수정 버튼 누를 시 수정*/
	    $("#updtBtn").on("click",function(){
	    	var url = "/cmmnty/faq/faqUpdtPop"
            $.ajax({
                url : url,
                dataType : "html",
                type : "GET",
                async : false,
                success : function(result){
                    $("#overPage2").html(result);
                }
	        });

	    	noticeDetailUpdt(boardNo, boardDetailSn);
	    });
	    
	    /*삭제 버튼 누를 시 게시글 삭제*/
	    $("#deleteBtn").on("click",function(){
	        var check = confirm("게시글을 삭제하시겠습니까?");
	        if(!check){
	            return false;
	        }
	        var url = "/cmmnty/faq/deleteFaq";
	        var param = {
	                "boardNo" : boardNo
	              , "boardSn" : boardDetailSn
	              , "fileGrpNo" : grpNo
	        };
	        callAsyncAjax(url, param, "backList");
	    });
	     
	} 
	
    /*FAQ 상세페이지 섬머 노트 그리기*/
	function startSummernote(){
		$('#summernote').summernote({
		    height: 500,                
		    minHeight: null,           
		    maxHeight: null,             
		    focus: false,
		    disableDragAndDrop: true,
		    lang: "ko-KR"
		});
	}
    
    /*FAQ 게시글 정보 넣기*/
	function detailFaq(data){
		var result = data.result.getFaq
		boardDetailSn = result.boardSn;
		$("#faqSJ").text(result.boardSj);
		$("#regId").html("글쓴이 : <b>" + result.registerId + "</b>");
		$("#regDtDetail").text("등록일 : " + moment(result.regDt).format('YYYY-MM-DD HH:mm'));
		$("#faqCN").summernote('code', result.boardCn);
		$("#faqCN").summernote('destroy');
		$("#faqAnswerCN").summernote('code', result.boardAnswerCn);
		$("#faqAnswerCN").summernote('destroy');
		
		if(result.fileGrpNo != "0" && result.fileGrpNo != null){
            grpNo = result.fileGrpNo; 
            var url = "/file/getAtchmnflList";
            var param = {
                    fileGrpNo : grpNo
            };
            callAsyncAjax(url, param, "getAtchFile");
           
        }
	}
    
    /*파일 다운로드 영역*/
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
    
    /*다운로드*/

    function downloadFile(fileGrpNo, liId) {
       var fileNo = $("#"+liId+" input[id^='fileNo']").val();
       $("#downloadFileGrpNo").val(fileGrpNo);
       $("#downloadFileNo").val(fileNo);
       $("#downloadForm").submit();
    }  

    
    /*수정페이지 값넣기 */
    function noticeDetailUpdt(boardNo,boardDetailSn){
        var detailupdtUrl = "/cmmnty/faq/getFaqDetail";
    	var param = {    "boardNo"    :  boardNo
    	               , "boardSn"    :  boardDetailSn
    	            };
    	callAsyncAjax(detailupdtUrl, param, "detailUpdtFaq");
    }    
</script>
