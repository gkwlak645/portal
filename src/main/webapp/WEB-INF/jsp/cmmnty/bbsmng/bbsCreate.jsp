<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="card card-primary" id = "cardDiv">
    <div class="card-header">
        <h3 class="card-title">등록</h3>
    </div>
    <div class="card-body" alt="커뮤니티>게시판관리 등록">
        <div class="row">
            <div class="col-md-12">
                <div class="form-inline">
                        <div id="cmmnClsCdGrid"></div>                    
                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                            <label class="col-sm-4 col-form-label" for="inputDescription">게시판유형 <b style="color:red;padding-left:10px;">*</b></label>
                            <div class="col-sm-8">
                            <select class="form-control float-left" id="boardCd">
                             <option selected disabled>유형선택</option>
                             <option value="1">공지사항</option>
                             <option value="2">Q&A</option>
                             <option value="3">FAQ</option>
                             <option value="4">일반게시판</option>                                
                            </select>
                            <input type="hidden" id="boardTy">
                            </div>
                        </div>
                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                            <label for="inputDescription" class="col-sm-4 col-form-label">게시판번호 <b style="color:red;padding-left:10px;">*</b></label>
                            <div class="col-sm-8">
                                <input type="text" id="boardNo" class="form-control" disabled>
                            </div>
                        </div>
                        <div class="form-group col-md-12 py-sm-2"   style="margin: 0.25rem 0 0.5rem 0;">
                            <label for="inputDescription" class="col-sm-2 col-form-label">게시판URL<b style="color:red;padding-left:10px;">*</b></label>
                            <div class="col-sm-9"style="padding-left: 4px;">
                                <input type="text" id="boardUrl" class="form-control" style="width:100%" disabled>
                            </div>
                        </div>                   
                        
                        
                        
                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                            <label class="col-sm-4 col-form-label" for="inputDescription">게시판명 <b style="color:red;padding-left:10px;">*</b></label>
                            <div class="col-sm-8">
                                <input type="text" id="boardNm" class="form-control">
                            </div>
                        </div>
                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                            <label for="inputDescription" class="col-sm-4 col-form-label">사용여부 <b style="color:red;padding-left:10px;">*</b></label>
                            <div class="col-sm-8">
                                <select class="form-control float-left" id="useAt">
		                            <option value="Y">사용</option>
		                            <option value="N">미사용</option>
		                        </select>
                            </div>
                        </div>
                                            
                       <div class="form-group col-md-12 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                            <label class="col-sm-2 col-form-label" for="inputDescription">설명</label>
                            <div class="col-sm-9" style="padding-left: 4px;">
                                <textarea id="boardDc" class="form-control" rows="5" style="width:100%;" ></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="float-right" style="margin:15px 0 15px 2px;">
                        <button type="button" class="btn btn-primary" id="RegisterIdea">저장</button>
                        <button type="button" class="btn btn-primary" id="cancel">취소</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div> 
<script>
    $(document).ready(function() {
        //페이지 초기화
        pageInit();
        //이벤트 바인딩
        bindEvent();
    });
  
	/*
	 * 이벤트 바인딩
	 * @param
	 * @return
	 */
	function bindEvent(){
		$("#boardCd").on("change", function(){		
		    var url = '/cmmnty/bbsmng/selectBoardTyproperty';  
		    var param = {
		      boardCd : $("#boardCd").val() 	  
		    }	  	
		    callAsyncAjax(url, param, "boardtyProperty");
	    });
		  
		//취소시 back
	    $("#cancel").on("click", function() {
	        alert("취소");
	        callBack();
	    });
		  
		//저장클릭
	    $("#RegisterIdea").on("click", function() {
   	        alert("저장");
            Register();
            callBack();
	    });
	}
	  
	function boardtyProperty(data){
		console.log(data);
	    $("#boardNo").val(data.result.boardList.boardNo);
	    $("#boardTy").val(data.result.boardList.boardTy);
		$("#boardUrl").val(data.result.boardList.boardUrl);
     }
	  
	function Register() {
	    var url = '/cmmnty/bbsmng/insertBoardManage';
	    var param = new Object();
	    param.boardCd     = $("#boardCd").val();
	    param.boardTy     = $("#boardTy").val();
	    param.boardNo     = $("#boardNo").val();
	    param.boardUrl    = $("#boardUrl").val()+$("#boardNo").val();
	    param.boardNm     = $("#boardNm").val();
	    param.boardDc     = $("#boardDc").val();
	    param.useAt       = $("#useAt").val();
	    callSyncAjax(url, param, null);
	}
</script>