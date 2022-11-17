<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="card card-primary" id="cardDiv">
    <div class="card-header">
        <h3 class="card-title">과제템플릿 등록</h3>
    </div>
    <div class="card-body"style="height:704px; overflow:auto;">
            <div class="row">
                <div class="col-md-12">
                    <div class="form-inline">
                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                            <label class="col-sm-3 col-form-label">프로세스코드<b style="color:red;padding-left:10px;">*</b></label>
                          <div> 
                            <div class="col-sm-4 float-left" style="width: 74%;margin: 0 0 2px 0;">
                                <select class="form-control" id="processCdReg" style="width: 54%;min-width:130px;">
                                </select>
                            </div>
                          </div>                          
                        </div>
                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                            <label class="col-sm-3 col-form-label">프로세스명</label>
                            <div class="col-sm-9">
                                <input type="text" id="processNmReg" class="form-control" style="width:80%;margin-right: 3px;" readonly="readonly">
                            </div>
                        </div>   
                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                            <label class="col-sm-3 col-form-label">템플릿코드<b style="color:red;padding-left:10px;">*</b></label>
                            <div class="col-sm-9">
                                <input type="text" id="tmplatCdReg" class="form-control" style="width:80%;margin-right: 3px;">
                            </div>
                        </div>
                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                            <label class="col-sm-3 col-form-label">템플릿명<b style="color:red;padding-left:10px;">*</b></label>
                            <div class="col-sm-9">
                                <input type="text" id="tmplatNmReg" class="form-control" style="width:80%;margin-right: 3px;" required>
                            </div>
                        </div>   
                        <div class="form-group col-md-9 py-sm-2" style="margin: 0.25rem 0 0.1rem 0;">
	                         <label  class="col-sm-2 col-form-label">첨부파일<b style="color:red;padding-left:10px;">*</b></label>
	                         <div class="col-sm-10"style="padding-left: 4px;" id="fileUpload" onchange=""></div>
                        </div>
<!--                         
                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                            <label class="col-sm-3 col-form-label">다운로드 URL</label>
                            <div class="col-sm-9">
                                <input type="text" id="downloadURLReg" class="form-control" style="width:80%;margin-right: 3px;" readonly>
                            </div>
                        </div>
 -->
                    </div>
                </form>
	                <div class="float-right">
	                    <button type="button" class="btn btn-primary" id="registBtn">등록</button>
	                    <button type="button" class="btn btn-primary" id="closeBtn">닫기</button>
	                </div>
                </div>
            </div>
        </div>
    </div>
</div>
    
<script>

    var fileGrpNo =0;
    var tmplatUpload = '';
    $(document).ready(function() {
    
        //페이지 초기화
        pageInit();
        
        //이벤트 바인딩
        bindEvent();
    });
    
    /*
     * 페이지 초기화
     * @param
     * @return
     */
    function pageInit() {
        
    	tmplatUpload = new RpaUpload("fileUpload");
    	tmplatUpload.draw(0 ,true);
    	$("#btnAdd").hide();
    	$("input[name=delFile]").hide();
    	getProcessCdListByClsCd("processCdReg", "${sessionScope.sessionUserInfo.txCmpnyCd}");
    	
    	// 로딩 끝
        $('.dimmed').css({ display: 'none' });
        $('.loading').css({ display: 'none' });
        $('.loading').removeClass('show');
    }
    
    /*
     * 이벤트 바인딩
     * @param
     * @return
     */
    function bindEvent() {

        $("#registBtn").on("click", function() {
        	var url = "/stdrinfo/tmplat/insertCheck";
            var param = {
            		tmplatCd : $('#tmplatCdReg').val()
            		, cmpnyCd    : "${sessionScope.sessionUserInfo.txCmpnyCd}"
            };
            callAsyncAjax(url, param, "insertCheck");
        });
        
        $("#closeBtn").on("click", function() {
        	closePop();
        });
        
        $("#processCdReg").on("change", function(){
        	var oObj = $(this);
        	if(oObj.val() == ""){
        		$("#processNmReg").val("");
        	}
        	else{
        		var sText = oObj.find("option:selected").text();
        		$("#processNmReg").val(sText.substring(sText.indexOf(")") + 1));
        	}
        });
        
        
        
    }
    
    //---------------------------------------------------------파일 업로드 함수 ---------------------------------------------------------
    
    function makeUrl() {
    	var url = "/stdrinfo/tmplat/getMaxFileGrpNo";
        var param = {};
        callAsyncAjax(url, param, "makeUrlCallback");
    }
    
    function makeUrlCallback(data) {
    	console.log(data);
    	var maxFileGrpNo = data.result.maxFileGrpNo.fileGrpNo;
    	var url = "http://localhost:8080"
    	var str = url + "/file/downloadUrlAtchmnfl?fileGrpNo=" + maxFileGrpNo + "&fileNo=1";
    	$("#downloadURLReg").val(str);
    }
    
    //---------------------------------------------------------파일 업로드 함수 ---------------------------------------------------------
    
    /*
     * 과제템플릿 등록 중복체크
     * @param
     * @return
     */
    function insertCheck(data) {
    	console.log(data.result);
    	if(data.result.count.tmplatCd == '0') {
    		registTmplat();
    	} else {
    		alert("이미 등록된 템플릿 코드입니다.");
    	}
    }
    
    /*
     * 과제템플릿 등록
     * @param
     * @return
     */
    function registTmplat() {
	    var processCd = $('#processCdReg').val();
	    var processNm = $('#processNmReg').val();
	    var tmplatCd = $('#tmplatCdReg').val();
	    var tmplatNm = $('#tmplatNmReg').val();
	    var downloadURL = $('#downloadURLReg').val();
	    if(processCd == "") {
	        alert("프로세스코드를 선택하세요.");
	        $("#processCd").focus();
	        return false;
	    } else if(tmplatCd.length > 4) {
	    	alert("템플릿코드를 4글자 이하로 입력하세요.");
            $("#tmplatCdReg").focus();
            return false;
	    } else if($.trim(tmplatCd) == "") {
            alert("템플릿코드를 입력하세요.");
            $("#tmplatCdReg").focus();
            return false;
        } else if(tmplatNm == "") {
	        alert("템플릿명을 입력하세요.");
	        $("#tmplatNm").focus();
            return false;
	    }
	    fileGrpNo = tmplatUpload.upload();
	    if(fileGrpNo == -1 || fileGrpNo == 0) {
	    	/* 파일 유무 체크 없으면 0, 있으면 1 */
	    	alert("첨부파일을 선택하세요.");
            return false;
	    }
	    
	    var url = "/stdrinfo/tmplat/insertTaskTmplat";
	    var param = {
	            tmplatCd   : tmplatCd
              , tmplatNm   : tmplatNm
              , processCd  : processCd
              , processNm  : processNm
              , fileGrpNo  : fileGrpNo
              , cmpnyCd    : "${sessionScope.sessionUserInfo.txCmpnyCd}"
	    };
	    callAsyncAjax(url, param, backPage());
    }
    
    /* 되돌아 가기 */ 
    function backPage(){
        closePop();
    }

</script>