<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<div class="card card-primary card-outline" style="height:100%;">
    <div style="width:100%; min-height:500px; overflow:hidden;">
        <div style="width:101%; height:100%; overflow-y:scroll;">
            <div class="card-body pad">
                <div class="mailbox-read-info"> 
	                <div class="mb-3">
	                    <div class="form-group row">
	                        <label class="col-form-label">제목</label>
	                        <div class="col-sm-11">
	                            <input type="text" class="form-control" id="inputFaqSj" placeholder="제목을 입력하여 주세요">
	                        </div>
	                    </div>
                    </div>
                </div>
            </div>
            <div class="card-body pad">
                <div class="mb-2">
                    <label class="col-sm-0 col-form-label">질문</label>
                    <div class="boardContent" id="summernoteFaq" class="height:400px"></div>
                </div>&nbsp;&nbsp;
                <div class="mb-2">
                    <label class="col-sm-0 col-form-label">답변</label>
                    <div class="boardContent" id="summernoteAnswer" class="height:400px"></div>
                </div>
            </div>
	        <div class="card-header">
                <div id="fileUpload"></div>
            </div>
            <div class="card-body form-group">
                <div class="float-right">
                    <button type="button" id="registerBtn" class="btn btn-primary">저장</button>
                    <button type="button" id="backListBtn" class="btn btn-primary">취소</button>
                </div>
            </div>
	    </div>
	</div>
</div>
<script>
    var fileGrpNo =0;
    $(document).ready(function(){
        pageInit();
        bindEvent();
    });
    
    function pageInit(){
        startSummernote();
        faqUpload = new RpaUpload("fileUpload");
        faqUpload.draw('',true);
    };
    
    function bindEvent(){
    	/* 취소 버튼 누를 시 */
        $("#backListBtn").on("click",function(){
            backList();
        });
        /* 저장 버튼 클릭 시 */
        $("#registerBtn").on("click",function(){
        	var inputTitle = $('#inputFaqSj').val();
            var inputContent = $('#summernoteFaq').summernote('code');
            var inputAnswerContent = $('#summernoteAnswer').summernote('code');
        	if(inputTitle == ""){
        		alert("제목을 입력하세요.");
        		$("#inputFaqSj").focus();
        		return false;
        	}else if(inputContent == "" || inputContent == "<p><br></p>"){
        		alert("질문을 입력하세요.");
                $("#summernoteFaq").summernote({focus: true});
                return false;
        	}else if(inputAnswerContent == "" || inputAnswerContent == "<p><br></p>"){
                alert("답변을 입력하세요.");
                $("#summernoteAnswer").summernote({focus: true});
                return false;
            }
            /* 파일 유무 체크 없으면 0, 있으면 1 */
            if(faqUpload.upload() == 0){
                fileGrpNo = 0;
            }else{
                fileGrpNo = faqUpload.upload();
            }
            var url = "/cmmnty/faq/insertFaqBoard";
            var param = {
                    boardNo : boardNo
                  , boardSj : inputTitle
                  , boardCn : inputContent
                  , boardAnswerCn : inputAnswerContent
                  , fileGrpNo : fileGrpNo
            };
            callAsyncAjax(url, param, "backPage");
        });
    }
   /* 되돌아 가기 */ 
    function backPage(){
        backList();
    }
    /* 써머노트 그리기 */
    function startSummernote(){
        $('#summernoteFaq, #summernoteAnswer').summernote({
            height: 500,
            minHeight: null,           
            maxHeight: null,             
            focus: false,
            disableDragAndDrop: true,
            lang: "ko-KR"
        });
    }
</script>