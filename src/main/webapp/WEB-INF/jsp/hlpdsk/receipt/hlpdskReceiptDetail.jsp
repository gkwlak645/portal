<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="card card-primary" id = "cardDiv">
    <div class="card-header" id="insert3">
        <h3 class="card-title">요청</h3>
    </div>
    <div class="card-body3" alt="커뮤니티>게시판관리 등록">
        <div class="row">
            <div class="col-md-12" id="t1">
                <div class="form-inline">
                        <div id="cmmnClsCdGrid"></div>                    
                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                            <label class="col-sm-4 col-form-label" for="inputDescription">요청구분 <b style="color:red;padding-left:10px;">*</b></label>
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
                            <label class="col-sm-2 col-form-label" for="inputDescription">요청제목<b style="color:red;padding-left:10px;">*</b></label>
                            <div class="col-sm-9" style="padding-left: 4px;">
                                <textarea id="requstSj2" class="form-control" rows="2" style="width:100%;" ></textarea>
                            </div>
                        </div>              
                        <div class="form-group col-md-12 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                            <label class="col-sm-2 col-form-label" for="inputDescription">요청내용<b style="color:red;padding-left:10px;">*</b></label>
                            <div class="col-sm-9" style="padding-left: 4px;">
                                <textarea id="requstCn2" class="form-control" rows="5" style="width:100%;" ></textarea>
                                <input type="hidden" id="requstSn2">
                            </div>
                        </div>
                       <div class="form-group col-md-12 py-sm-2"  style="margin: 0.25rem 0 0.5rem 0;">
                       <label class="col-sm-2 col-form-label">첨부파일 </label>
                       <div class="col-sm-9"><div class="form-check2 row"  id="fileUpload"></div></div>
                       </div>
                       <div class="form-group col-md-12 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                            <label class="col-sm-2 col-form-label" for="inputDescription">요청자</label>
                            <div class="col-sm-9" style="padding-left: 4px;">
                                <input type="text" id=userNm class="form-control"  style="width:80%;" disabled />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
    <div class="card-header" id="insert3">
        <h3 class="card-title">처리결과</h3>
    </div>
    <div class="card-body3" alt="커뮤니티>게시판관리 등록"> 
        <div class="row">
            <div class="col-md-12">
                <div class="form-inline">
                        <div id="cmmnClsCdGrid"></div>
                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                        </div>
                        <div class="form-group col-md-12 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">                        
                           <label class="col-sm-2 col-form-label">처리상태<b style="color:red;padding-left:10px;">*</b></label>
                           <select class="form-control float-left" id="sttusCd">
                           </select>                              
                        </div>             
                        <div class="form-group col-md-12 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                            <label class="col-sm-2 col-form-label" for="inputDescription">처리내용<b style="color:red;padding-left:10px;">*</b></label>
                            <div class="col-sm-9" style="padding-left: 4px;">
                                <textarea id="requstCn3" class="form-control" rows="5" style="width:100%;"></textarea>
                                <input type="hidden" id="processCn">
                            </div>
                        </div>
                        <div class="form-group col-md-12" style="margin: 0.25rem 0 0.5rem 0;">
	                        <label for="processTm" class="col-sm-2 col-form-label">처리시간<b style="color:red;padding-left:10px;">*</b></label>
	                        <div class="col-sm-9">
	                            <input type="text" id="processTm" class="form-control float-left" style="width:120px;margin-right: 3px;" maxlength="4" decimalNumberType1>H
	                        </div>
                    	</div>
                        
                       <div class="form-group col-md-12 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                           <label class="col-sm-2 col-form-label">관련파일 </label>
                       <div class="col-sm-9">
                           <div class="form-check2 row" id="fileUpload2">
                           </div>
                       </div>
                       </div>
                    </div>
                    <div class="float-right" style="margin:15px 0 15px 2px;" id="btn">
                        <button type="button" class="btn btn-primary" id="updateBtn2">저장</button>
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
        
        hlpUpload2 = new RpaUpload("fileUpload2");
        
        $("#t1").find("*").prop("disabled", true);
        
        var params = [];
        params.push({"id" : "searchCombo3", "clsCd" : "0036"});
        params.push({"id" : "sttusCd", "clsCd" : "0041"});
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
        
        //저장하기 버튼
        $("#updateBtn2").on("click", function() {
            var check = confirm("게시글을 저장 하시겠습니까?");
            if(!check){
                return false;
            }
            
            const oSttusCd = $("#sttusCd");
            const oRequstCn3 = $("#requstCn3");
            const oProcessTm = $("#processTm");
            
            if(oSttusCd == "04"){
            	if($.trim(oSttusCd.val()) == ""){
                    alert("처리상태를 선택해 주십시오.");
                    oSttusCd.focus();
                    return false;
                }
                else if($.trim(oRequstCn3.val()) == ""){
                    alert("처리내용을 입력해 주십시오.");
                    oSttusCd.focus();
                    return false;
                }
                else if($.trim(oProcessTm.val()) == ""){
                	alert("처리시간을 입력해 주십시오.");
                	oProcessTm.focus();
                    return false;
                }
                else if($.trim(oProcessTm.val()) == "0"){
                	alert("0이상의 값을 입력해 주십시오.");
                	oProcessTm.focus();
                    return false;
                }
            }
            
            if (hlpUpload2.upload() == 0) {
            	processFileGrpNo = 0;
            } else {
            	processFileGrpNo = hlpUpload2.upload();
            }
            updateDetail();
            alert("저장 완료");
            location.reload(true);
        });
    }   

    function updateDetail() {    	
        var url_5 = "/hlpdsk/receipt/updatereceipthlpdsk";
        var param = new Object();
        var date = new Date();
        var y = date.getFullYear()-2000;
        var m = date.getMonth()+1;
        var d = date.getDate();
        if (m < 10) {
        	m = "0"+m;
        }
        var now = y + "-" + m + "-" + d;
        
        if ($("#sttusCd").val() != '01') {
        	param.processDe = now.toString();
        }
        param.requstSn = $("#requstSn2").val();	
        param.processSttusCd = $("#sttusCd").val();
        param.processCn = $("#requstCn3").val();
        param.processTm = $("#processTm").val().replace(/,/, '');
        param.processFileGrpNo = processFileGrpNo;
        callSyncAjax(url_5, param, null);
    }    

</script>