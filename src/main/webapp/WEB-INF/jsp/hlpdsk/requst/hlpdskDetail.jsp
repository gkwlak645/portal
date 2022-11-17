<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="card card-primary" id = "cardDiv">
    <div class="card-header" id="insert3">
        <h3 class="card-title">상세창</h3>
    </div>
    <div class="card-body3" alt="커뮤니티>게시판관리 등록">
        <div class="row">
            <div class="col-md-12">
                <div class="form-inline">
                        <div id="cmmnClsCdGrid"></div>                    
                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                            <label class="col-sm-4 col-form-label" for="inputDescription">카테고리 <b style="color:red;padding-left:10px;">*</b></label>
                            <div class="col-sm-8">
                            <select class="form-control float-left" id="searchCombo3">                              
                            </select>
                            <input type="hidden" id="boardTy">
                            <input type="hidden" id="processSttusCd" value="">
                            </div>
                        </div>
                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                        </div>
                        <div class="form-group col-md-12 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                            <label class="col-sm-2 col-form-label" for="inputDescription">제목<b style="color:red;padding-left:10px;">*</b></label>
                            <div class="col-sm-9" style="padding-left: 4px;">
                                <textarea id="requstSj2" class="form-control" rows="2" style="width:100%;" ></textarea>
                            </div>
                        </div>              
                        <div class="form-group col-md-12 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                            <label class="col-sm-2 col-form-label" for="inputDescription">내용<b style="color:red;padding-left:10px;">*</b></label>
                            <div class="col-sm-9" style="padding-left: 4px;">
                                <textarea id="requstCn2" class="form-control" rows="5" style="width:100%;" ></textarea>
                                <input type="hidden" id="requstSn2">
                            </div>
                        </div>
                       <div class="form-group col-md-12 py-sm-2"  style="margin: 0.25rem 0 0.5rem 0;">
                       <label class="col-sm-2 col-form-label">첨부파일 </label>
                       <div class="col-sm-9"><div class="form-check2 row"  id="fileUpload"></div></div>
                       </div>
                    </div>
                    
                    
                    
                    
                    <div class="float-right" style="margin:15px 0 15px 2px;" id="btn">
                        <button type="button" class="btn btn-primary" id="updateBtn">저장</button>
                        <button type="button" class="btn btn-primary" id="deleteBtn">삭제</button>
                        <button type="button" class="btn btn-primary" id="cancel">닫기</button>
                    </div>
                    
                    
                    
                    
                    
                </div>
            </div>
        </div>
        
    <!-- <div class="card-header" id="insert3">
        <h3 class="card-title">처리결과</h3>
    </div>
    <div class="card-body3" alt="커뮤니티>게시판관리 등록"> 
        <div class="row">
            <div class="col-md-12" id="t2">
                <div class="form-inline">
                        <div id="cmmnClsCdGrid"></div>
                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                        </div>             
                        <div class="form-group col-md-12 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                            <label class="col-sm-2 col-form-label" for="inputDescription">처리내용<b style="color:red;padding-left:10px;">*</b></label>
                            <div class="col-sm-9" style="padding-left: 4px;">
                                <textarea id="requstCn3" class="form-control" rows="5" style="width:100%;" disabled></textarea>
                                <input type="hidden" id="processCn">
                            </div>
                        </div>
                       <div class="form-group col-md-12 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;" id="t1">
	                       <label class="col-sm-2 col-form-label">관련파일 </label>
	                       <div class="col-sm-9">
	                           <div class="form-check2 row"  id="fileUpload2">
	                           </div>
	                       </div>
                       </div>
                       <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">                        
                           <label class="col-sm-4 col-form-label" class="col-form-label">처리일자</label>
                           <input type="text" class="form-control" id="processDe" placeholder="" style="" value="" />                              
                       </div>
                       <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">                        
                           <label class="col-sm-4 col-form-label" class="col-form-label">처리자</label>
                           <input type="text" class="form-control" id="userNm" placeholder="" style="" value="" />                              
                       </div>  
                       <div class="form-group col-md-12 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">                        
                            <label class="col-sm-2 col-form-label" class="col-form-label">처리상태</label>
                           <input type="text" class="form-control" id="sttusCd" placeholder="" style="" value="" />                              
                       </div>
                    </div>
                    <div class="float-right" style="margin:15px 0 15px 2px;" id="btn">
                        <button type="button" class="btn btn-primary" id="updateBtn">저장</button>
                        <button type="button" class="btn btn-primary" id="deleteBtn">삭제</button>
                        <button type="button" class="btn btn-primary" id="cancel">닫기</button>
                    </div>
                </div>
            </div>
        </div>
    </div> -->

<script>

    $(function() {
        
        bindEvent();
        
        hlpUpload = new RpaUpload("fileUpload");
        hlpUpload.draw('',true);
        
        /* hlpUpload2 = new RpaUpload("fileUpload2");
        hlpUpload2.draw('',true); */
        
        /* $("#requstCn3").prop("disabled", true);
        $("#t2").find('input').prop("disabled", true); */

        var params = [];
        params.push({"id" : "searchCombo3", "clsCd" : "0058"});
        requestCmmnCd(params);

    });  

	function bindEvent(){
		
		//닫기 클릭시
	    $("#cancel").on("click", function() {
	    	$('#insert3').hide();
	    	$('.card-body3').hide();
	    	$('#insert').show();
	        $('.card-body').show();
	        $(".over").remove();	        
	    });
		
        //삭제하기 버튼
        $("#deleteBtn").on("click", function() {
            var check = confirm("게시글을 삭제 하시겠습니까?");
            if(!check){
                return false;
            }
            var url_3 = "/hlpdsk/requst/deleteHlpdsk";
            var param ={
                requstSn: $("#requstSn2").val()
            }
            callAsyncAjax(url_3, param, null);            
            alert("삭제 완료");
            location.reload(true);
        });
        
        //저장하기 버튼
        $("#updateBtn").on("click", function() {
            var check = confirm("게시글을 저장 하시겠습니까?");
            if(!check){
                return false;
            }
            if(hlpUpload.upload() == 0){
                fileGrpNo = 0;
            }else{
                fileGrpNo = hlpUpload.upload();
            }
            updateDetail();
            alert("저장 완료");
            location.reload(true);
        });
	}	

    function updateDetail() {
        var url_4 = "/hlpdsk/requst/updateHlpdsk";
        var param = new Object();
        param.requstSe = $("#searchCombo3").val();
        param.requstSn = $("#requstSn2").val();
        param.requstSj = $("#requstSj2").val();
        param.requstCn = $("#requstCn2").val();
        param.requstFileGrpNo = fileGrpNo;
        callSyncAjax(url_4, param, null);
    }    

</script>