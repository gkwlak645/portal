<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="card card-primary" id = "cardDiv">
    <div class="card-body2" alt="커뮤니티>게시판관리 등록">
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
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                    </div>
                    <div class="form-group col-md-12 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                        <label class="col-sm-2 col-form-label" for="inputDescription">제목<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-9" style="padding-left: 4px;">
                            <textarea id="requstSj" class="form-control" rows="2" style="width:100%;" ></textarea>
                        </div>
                    </div>              
                    <div class="form-group col-md-12 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                        <label class="col-sm-2 col-form-label" for="inputDescription">내용<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-9" style="padding-left: 4px;">
                            <textarea id="requstCn" class="form-control" rows="5" style="width:100%;" ></textarea>
                        </div>
                    </div>
                   <div class="form-group col-md-12 py-sm-2"  style="margin: 0.25rem 0 0.5rem 0;">
                   <label class="col-sm-2 col-form-label">첨부파일 </label>
                   <table>                   
                   <tbody>                   
                   <tr>
                       <td>
                       <div class="form-check2 row"  id="fileUpload"></div>                       
                       </td>                     
                   </tr>  
                   </tbody>
                   </table>                     
                   </div>
               </div>
                   <div class="float-right" style="margin:15px 0 15px 2px;">
                       <button type="button" class="btn btn-primary" id="RegisterIdea">저장</button>
                       <button type="button" class="btn btn-primary" id="cancel">닫기</button>
                   </div>
               </div>
            </div>
        </div>
    </div>


<script>

    $(function() {
    	
        bindEvent();
                
        hlpUpload = new RpaUpload("fileUpload");
        hlpUpload.draw(0,true);
        
        var params = [];
        params.push({"id" : "searchCombo3", "clsCd" : "0058"});
        requestCmmnCd(params);
        
    });
  
	/*
	 * 이벤트 바인딩
	 * @param
	 * @return
	 */
	function bindEvent(){
		
		//닫기 클릭시
	    $("#cancel").on("click", function() {
	    	$('#insert2').hide();
	    	$('.card-body2').hide();
	    	$('#insert').show();
	        $('.card-body').show();
	        $(".over").remove();
	    });
		  
		//저장 클릭시
	    $("#RegisterIdea").on("click", function() {
	    	var inputTitle = $('#requstSj').val();
	    	var inputContent = $('#requstCn').val();
	    	var searchCombo3 = $('#searchCombo3').val();
	    	
	    	if(inputTitle == ""){
                alert("제목을 입력하세요.");
                $("#requstSj").focus();
                return false;
                
            } else if (inputContent == ""){
                alert("내용을 입력하세요.");
                $("#requstCn").focus();
                return false;
                
            } else {
            	
                if(hlpUpload.upload() == 0) {
                    fileGrpNo = 0;
                }
                else {
                    fileGrpNo = hlpUpload.upload();
                }
	            
                if (searchCombo3 == '') {
	            	alert("요청구분을 선택하세요.");
	            	return false;
	            }
                
            	Register();
            	alert("등록 완료");
                location.reload(true);
            }            
	    });		
	}
	
	function Register() {
	    var url = '/hlpdsk/requst/insertHlpdsk';
	    var param = new Object();
	    param.requstSe = $("#searchCombo3").val();
	    param.requstSj = $("#requstSj").val();
	    param.requstCn = $("#requstCn").val().replace(/\n/g, "<br>");
	    // $("#jobDc").val().replace(/\n/g, "<br>")
	    // Enter도 인식하여 들어감
	    
	    param.requstFileGrpNo = fileGrpNo;
	    callSyncAjax(url, param, null);
	}
</script>