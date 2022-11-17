<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt"     uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                                <input type="text" class="form-control" id="detailFaqSJ">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        <div class="card-body pad">
            <div class="mb-2">
            <label class="col-sm-0 col-form-label">질문</label>
                <div class="boardContent" id="summernoteFaq" class="height:400px"></div>
            </div>
            <div class="mb-2">
            <label class="col-sm-0 col-form-label">답변</label>
                <div class="boardContent" id="summernoteFaqAnswer" class="height:400px"></div>
            </div>
        </div>
            <div class="card-header">
                <div id="atchFile"></div>
            </div>
            <div class="card-body form-group">
                <div class="float-right">
                    <button type="button" id="updtBtn" class="btn btn-primary">저장</button>
                    <button type="button" id="deleteBtn" class="btn btn-primary">삭제</button>
                    <button type="button" id="backListBtn" class="btn btn-primary">취소</button>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var bbsUpload = new RpaUpload("atchFile");
    var boardSn  = "";
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
            var url = "/cmmnty/faq/updtFaq";
            var faqSj = $("#detailFaqSJ").val();
            var faqCN = $('#summernoteFaq').summernote('code');
            var faqAnswerCn = $("#summernoteFaqAnswer").summernote('code');
            if(faqSj == ""){
                alert("제목을 입력하세요.");
                $("#inputFaqSj").focus();
                return false;
            }else if(faqCN == "" || faqCN == "<p><br></p>"){
                alert("내용을 입력하세요.");
                $("#summernoteFaq").summernote({focus: true});
                return false;
            }else if(faqAnswerCn == "" || faqAnswerCn == "<p><br></p>"){
                alert("내용을 입력하세요.");
                $("#summernoteFaqAnswer").summernote({focus: true});
                return false;
            }
            
            if(grpNo == 0){
                fileGrpNo = 0;
            }else {
                fileGrpNo = $("#fileGrpNo").val();
            }
            var param = {
                    "boardNo" : boardNo
                  , "boardSn"  : boardSn
                  , "boardSj"  : faqSj
                  , "boardCn"  : faqCN
                  , "boardAnswerCn" : faqAnswerCn
                  , "fileGrpNo"   : fileGrpNo
            };
            callAsyncAjax(url, param, "backList");
        });
        
        /*공자시항 수정 페이지 삭제 버튼 누를 시 게시글 삭제*/
        $("#deleteBtn").on("click",function(){
            var check = confirm("게시글을 삭제하시겠습니까?");
            if(!check){
                return false;
            }
            var url = "/cmmnty/faq/deleteFaq";
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
        $('#summernoteFaq, #summernoteFaqAnswer').summernote({
            height: 500,                
            minHeight: null,           
            maxHeight: null,             
            focus: false,
            disableDragAndDrop: true,
            lang: "ko-KR"
        });
    }
    
    /*공지사항 게시글 수정페이지 정보 넣기*/
    function detailUpdtFaq(data){
    	console.log(JSON.stringify(data));
        var result = data.result.getFaq;
    	boardSn = result.boardSn;
        $("#detailFaqSJ").val(result.boardSj);
        $("#summernoteFaq").summernote('code', result.boardCn);
        $("#summernoteFaqAnswer").summernote('code', result.boardAnswerCn);
        
        if(result == undefined || result == ""){             
            fileGrpNoVal = 0;
        }else{
            fileGrpNoVal=result.fileGrpNo;
        }        
        bbsUpload.draw(fileGrpNoVal, true);
    }
</script>