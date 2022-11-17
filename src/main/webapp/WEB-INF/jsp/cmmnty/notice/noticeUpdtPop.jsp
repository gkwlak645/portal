<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt"     uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<div class="card card-primary" style="height:100%;">
    <div>
        <div class="row">
            <div class="card-body">
                <div class="form-group col-md-12 py-sm-2">
                    <div class="form-group row">
                        <label class="col-form-label">제목</label>
                        <input type="text" class="form-control" id="detailNoticeSJ" >
                    </div>
                   </div>
               
                <div class="form-group col-md-12 py-sm-2">
                    <label class="col-form-label">내용</label>
                    <div class="boardContent" id="summernote" class="height:320px"></div>
                </div>
                
                <div class="form-group col-md-12 py-sm-2"  style="margin: 0.25rem 0 0.5rem 0;">
                       <label class="col-sm-2 col-form-label">첨부파일 </label>
                       <div class="col-sm-9"><div id="atchFile"></div></div>
	            </div>
	            <div class="card-body form-group">
	                <div class="float-right" style="margin-top:10px;">
	                    <button type="button" id="updtBtn" class="btn btn-primary">저장</button>
	                    <button type="button" id="deleteBtn" class="btn btn-primary">삭제</button>
	                    <button type="button" id="backListBtn" class="btn btn-primary">취소</button>
	                </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var bbsUpload = new RpaUpload("atchFile");
    var boardSn = "";
    $(document).ready(function(){
        pageInit();
        bindEvent();
    });
    
    function pageInit(){
        startSummernote();
    }
    
    function bindEvent(){
        /*목록으로 나 취소 누를 시 공지사항 메인 페이지 이동*/
        $("#backListBtn").on("click",function(){
            backList();
        });
        
        /*공지사항 수정페이지 저장 버튼 누를 시 수정*/
        $("#updtBtn").on("click",function(){
            var grpNo = bbsUpload.upload();
            var url = "/cmmnty/notice/updtNotice";
            var noticeSj = $("#detailNoticeSJ").val();
            var noticeCN = $('#summernote').summernote('code');
            if(noticeSj == ""){
                alert("제목을 입력하세요.");
                $("#inputNoticeSj").focus();
                return false;
            }else if(noticeCN == "" || noticeCN == "<p><br></p>"){
                alert("내용을 입력하세요.");
                $("#summernote").summernote({focus: true});
                return false;
            }
            if(grpNo == 0){
                fileGrpNo = 0;
            }else {
                fileGrpNo = $("#fileGrpNo").val();
            }
            var param = {
                    "boardNo" : boardNo
                  , "boardSn" : boardSn
                  , "boardSj" : noticeSj
                  , "boardCn" : noticeCN
                  , "fileGrpNo" : fileGrpNo
            };
            callAsyncAjax(url, param, "backList");
        });
        
        /*공자시항 수정 페이지 삭제 버튼 누를 시 게시글 삭제*/
        $("#deleteBtn").on("click",function(){
            var check = confirm("게시글을 삭제하시겠습니까?");
            if(!check){
                return false;
            }
            var url = "/cmmnty/notice/deleteNotice";
            var param = {
                    "boardNo" : boardNo
                  , "boardSn" : boardSn
                  , "fileGrpNo" : $("#fileGrpNo").val()
            };
            callAsyncAjax(url, param, "backList");
        });
         
    } 
    
    /*공지사항 수정 페이지 섬머 노트 그리기*/
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
    
    /*공지사항 게시글 수정페이지 정보 넣기*/
    function detailUpdtNotice(data){
        var result = data.result.getNotice
        boardSn = result.boardSn;
        $("#detailNoticeSJ").val(result.boardSj);
        $("#summernote").summernote('code', result.boardCn);
        
        if(result == undefined || result == ""){             
            fileGrpNoVal = 0;
        }else{
            fileGrpNoVal=result.fileGrpNo;
        }        
        bbsUpload.draw(fileGrpNoVal, true);
    }
</script>