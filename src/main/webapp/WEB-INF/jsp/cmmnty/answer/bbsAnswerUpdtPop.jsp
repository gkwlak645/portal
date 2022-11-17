<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<div class="card card-primary card-outline" style="height:700px;">
    <div class="card-header">
        <div class="card-tools">
            <button type="button" id="updateBtn" class="btn btn-tool">수정완료</button>
            <button type="button" id="backListBtn" class="btn btn-tool">이전으로</button>
        </div>
    </div>
    <div style="width:100%; min-height:500px; overflow:hidden;">
        <div style="width:101%; height:100%; overflow-y:scroll;">
		    <div class="card-body p-0">
		        <div class="mailbox-read-info">
		            <input type="text" class="form-control" id="boardTitle" />
		        </div>
		        <div class="card-body pad">
		            <div id="atchFile"></div>
		            <div class="mb-3">
		                <div class="boardContent" id="summernote"></div>
		            </div>
		       </div>
		    </div>
       </div>
    </div>
</div>

<script>
    var regId = "";
    var bbsUpload = new RpaUpload("atchFile"); 
	$(document).ready(function(){
	    pageInit();
	    bindEvent();
	});
	
	function pageInit(){
	    updateBoard();
	};
	
	function bindEvent(){
		$("#backListBtn").on("click",function(){
			backDetailPage();
		});
		
		$("#updateBtn").on("click",function(){
		    var grpNo = bbsUpload.upload();
		    if(grpNo == 0){
                fileGrpNo = 0;
		    }
			var updateTitle = $('#boardTitle').val();
			var updateContent = $('#summernote').summernote('code');
			var url = "/cmmnty/answer/updateBoard";
			var param = {
					boardNo : boardNo
				  , boardSn : answerBsn
				  , boardSj : updateTitle
				  , boardCn : updateContent
				  , fileGrpNo : $("#fileGrpNo").val() /*up-load쪽 fileGrpNo받음*/
			};
			callAsyncAjax(url, param, "uploadFile");
		});
/* 	function bindEvent(){
		$("#backListBtn").on("click",function(){
			backDetailPage();
		});
		
		$("#updateBtn").on("click",function(){
			var updateTitle = $('#boardTitle').val();
			var updateContent = $('#summernote').summernote('code');
			var url = "/cmmnty/answer/updateBoard";
			var param = {
					boardCd : boardCode
				  , boardSn : answerBsn
				  , boardSj : updateTitle
				  , boardCn : updateContent
				  , fileGrpNo : $("#fileGrpNo").val()
			};
			callAsyncAjax(url, param, "uploadFile");
		}); */
	}
	function backDetailPage(){
		var param = { "regId" : regId };
        var url = "/cmmnty/answer/bbsAnswerDetailPop"
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
	}
	function updateBoard(){
        var url = "/cmmnty/answer/boardAnswerUpdatePop";
        var param = {
        		"boardNo" : boardNo
              , "boardSn" : answerBsn
        };
        callAsyncAjax(url, param, "drawValue");
    }
	
	function drawValue(data){
        var boardValue = data.result.boardValue;
        
        regId = boardValue.registerId;
        
        $("#boardTitle").val(boardValue.boardSj);
        $('#summernote').summernote({
            height: 500,                
            minHeight: null,           
            maxHeight: null,             
            focus: true,
            disableDragAndDrop: true,
            lang: "ko-KR"
        });
        $('#summernote').summernote('code', boardValue.boardCn);
        
        console.log("boardValue"+JSON.stringify(boardValue));
        
       if(boardValue == undefined || boardValue == ""){             
            fileGrpNoVal = 0;
        }else{
            fileGrpNoVal=boardValue.fileGrpNo;
        }        
        bbsUpload.draw(fileGrpNoVal, true);
        
        /* if(boardValue.fileGrpNo != "0" && boardValue.fileGrpNo != null){
            var url = "/file/selectAtchmnfl";
            var param = {
                fileGrpNo : grpNo
            };
            callAsyncAjax(url, param, "getAtchFile");
        } */
	}

	/* function getAtchFile(fileInfoList){
        bbsUpload = new RpaUpload("atchFile");
		console.log(fileInfoList[0].fileGrpNo);
		bbsUpload.draw(fileInfoList[0].fileGrpNo, true);
	 } */
         
	 function uploadFile(){
	    backDetailPage();
     }
	 /* function uploadFile(){
	    bbsUpload.upload();
	    backDetailPage();
     } */
</script>