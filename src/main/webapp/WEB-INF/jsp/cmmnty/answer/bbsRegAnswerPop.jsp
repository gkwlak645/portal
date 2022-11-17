<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<div class="card card-primary card-outline" style="height:700px;">
    <div class="card-header">
        <div class="card-tools">
        <%--     <c:if test="${txScreenAuthor eq REG_AUTHOR}"> --%>
                <button type="button" id="registerBtn" class="btn btn-tool">게시글 등록</button>
            <%-- </c:if> --%>
            <button type="button" id="backListBtn" class="btn btn-tool">목록으로</button>
        </div>
    </div>
    <div style="width:100%; min-height:500px; overflow:hidden;">
        <div style="width:101%; height:100%; overflow-y:scroll;">
		    <div class="card-body p-0">
		        <div class="mailbox-read-info">
		            <input type="text" class="form-control" id="boardTitle" placeholder="제목" />
		        </div>
		        <div class="card-body pad">
		            <div class="mb-3">
		                <div id="fileUpload"></div>
		                <div class="boardContent" id="summernote"></div>
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
        $("#backListBtn").on("click",function(){
            backList();
        });
        
        $("#registerBtn").on("click",function(){
        	//파일 유무 체크 없으면 0, 있으면 1
        	if(bbsUpload.upload() == 0){
        		fileGrpNo = 0;
        	}else{
        		fileGrpNo = bbsUpload.upload();
        	}
            var inputTitle = $('#boardTitle').val();
            var inputContent = $('#summernote').summernote('code');
            var url = "/cmmnty/answer/insertBoard";
            var param = {
                    boardNo : boardNo
                  , boardSj : inputTitle
                  , boardCn : inputContent
                  , fileGrpNo : fileGrpNo
            };
            
            callAsyncAjax(url, param, "uploadFile");
        });
    }
/*     function bindEvent(){
        $("#backListBtn").on("click",function(){
            backList();
        });
        
        $("#registerBtn").on("click",function(){
        	var inputTitle = $('#boardTitle').val();
            var inputContent = $('#summernote').summernote('code');
            var url = "/cmmnty/answer/insertBoard";
            var param = {
                    boardCd : boardCode
                  , boardSj : inputTitle
                  , boardCn : inputContent
            };
            
            callAsyncAjax(url, param, "uploadFile");
        });
    } */
    
    function uploadFile(){
    	backList();
    }
/*     function uploadFile(){
    	bbsUpload.upload();
    	backList();
    } */
    
    function startSummernote(){
    	$('#summernote').summernote({
            height: 500,                
            minHeight: null,           
            maxHeight: null,             
            focus: true,
            disableDragAndDrop: true,
            lang: "ko-KR"
        });
    }
</script>