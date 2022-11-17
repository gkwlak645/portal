<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<div class="card card-primary" style="height:100%;">
    <div>
        <div class="row">
            <div class="card-body">
                <div class="form-group col-md-12 py-sm-2">
                    <div class="form-group row">
                        <label class="col-form-label">제목</label>
                        <input type="text" class="form-control" id="inputNoticeSj" placeholder="제목을 입력하여 주세요">
                    </div>
                   </div>
	           
                <div class="form-group col-md-12 py-sm-2">
                    <label class="col-form-label">내용</label>
                    <div boardContent" id="summernote" class="height:320px;"></div>
                </div>
		        
		        <div class="form-group col-md-12 py-sm-2"  style="margin: 0.25rem 0 0.5rem 0;">
                       <label class="col-sm-2 col-form-label">첨부파일 </label>
                       <div class="col-sm-9"><div class="form-check2 row"  id="fileUpload"></div></div>
                   </div>
                   
                   
                <div class="card-body form-group">
	                <div class="float-right" style="margin-top:10px;">
	                    <button type="button" id="registerBtn" class="btn btn-primary"style="margin:5px 0 15px 2px;">저장</button>
	                    <button type="button" id="backListBtn" class="btn btn-primary"style="margin:5px 0 15px 2px;">취소</button>
	                </div>
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
        bbsUpload = new RpaUpload("fileUpload");
        bbsUpload.draw('',true);
    };
    
    function bindEvent(){
    	/* 취소 버튼 누를 시 */
        $("#backListBtn").on("click",function(){
            backList();
        });
        /* 저장 버튼 클릭 시 */
        $("#registerBtn").on("click",function(){
        	var inputTitle = $('#inputNoticeSj').val();
            var inputContent = $('#summernote').summernote('code');
        	if(inputTitle == ""){
        		alert("제목을 입력하세요.");
        		$("#inputNoticeSj").focus();
        		return false;
        	}else if(inputContent == "" || inputContent == "<p><br></p>"){
        		alert("내용을 입력하세요.");
                $("#summernote").summernote({focus: true});
                return false;
        	}
            /* 파일 유무 체크 없으면 0, 있으면 1 */
            if(bbsUpload.upload() == 0){
                fileGrpNo = 0;
            }else{
                fileGrpNo = bbsUpload.upload();
            }
            var url = "/cmmnty/notice/insertNoticeBoard";
            var param = {
                    boardNo : boardNo
                  , boardSj : inputTitle
                  , boardCn : inputContent
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
        $('#summernote').summernote({
            height: 320,
            minHeight: null,           
            maxHeight: null,             
            focus: false,
            disableDragAndDrop: true,
            lang: "ko-KR",
            toolbar: [
                ['style', ['style']],
                ['font', ['bold', 'italic', 'underline', 'clear']],
                ['fontname', ['fontname']],
                ['fontsize', ['fontsize']],
                ['color', ['color']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['height', ['height']],
                ['insert', ['link', 'picture', 'video']],
                ['table', ['table']]
           ]
        });
    }
</script>