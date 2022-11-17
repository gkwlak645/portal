<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--  템플릿 바디 -->        
 <div class="card card-primary" id="unmanagtErrorRegDiv">                   
    <div class="card-header" alt="과제 >과제아이디어등록">
        <h3 class="card-title">등록</h3>
    </div>
    <div class="card-body">
        <div class="row">
            <div class="col-md-12">
                <form class="form-inline" id="unmanagtErrorDetail">                    
                    <div class="form-group col-md-12 py-sm-2">
                        <label for="errorTyCd" class="col-sm-2 col-form-label">제목<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-10">
                            <input type="text" id="ideaSj" class="form-control"  style="width:92.5%;" maxlength="100"/>
                        </div>
                    </div>
                    <div class="form-group col-md-12 py-sm-2">
                        <label for="errorCn" class="col-sm-2 col-form-label">업무설명<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-10">
                            <textarea rows="2" id="jobDc" class="form-control" style="width:92.5%;" maxlength="2000"></textarea>
                        </div>
                    </div>                    
                    <div class="form-group col-md-6 py-sm-2">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">구분</label>
                        <div class="col-sm-8">
                            <select id="rpaClsCd" class="form-control" style="width:80%;margin-right: 3px;" type="text" ></select>
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-2">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">업무분류</label>
                        <div class="col-sm-8">
                            <select id="jobClsCd" class="form-control" style="width:80%;margin-right: 3px;" type="text" ></select>
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-2">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">회사</label>
                        <div class="col-sm-8">
                            <input type="hidden" id="regCmpnyCd" class="form-control"  style="width:80%;" value="${sessionUserInfo.txCmpnyCd}">
                            <input type="text" id="regCmpnyNm" class="form-control"  style="width:80%;" value="${sessionUserInfo.txCmpnyNm}" disabled>
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-2"></div>
                    <div class="form-group col-md-6 py-sm-2">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">부서</label>
                        <div class="col-sm-8">
                            <input type="hidden" id="deptCd" class="form-control"  style="width:80%;" value="${sessionUserInfo.txDeptCd}">
                            <input type="text" id="deptNm" class="form-control"  style="width:80%;" value="${sessionUserInfo.txDeptNm}" disabled>
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-2">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">담당자</label>
                        <div class="col-sm-8">
                            <input type="hidden" id="ideaUserId" class="form-control float-left"  style="width:70px;margin-right:5px;" value="${sessionUserInfo.txUserId}" disabled />
                            <input type="text" id="ideaUserNm" class="form-control"  style="width:80%;" value="${sessionUserInfo.txEmpNm}" disabled> 
                        </div>
                    </div>    
                     
                                           
                    <div class="form-group col-md-6 py-sm-2">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">업무시간(연간)</label>
                        <div class="col-sm-8">
                            <input type="text" id="jobTm" class="form-control float-left" style="width:120px;margin-right: 3px;" value="" maxlength="8" decimalNumberType1>H
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-2">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">빈도</label>
                        <div class="col-sm-8">
                            <select id="fqCd" class="form-control float-left" style="width:30%;margin-right: 10px;" type="text" ></select>
                            <input type="text" id="executCnt" class="form-control float-left" style="width:120px;margin-right: 3px;" value="" maxlength="6" numberOnly>회
                        </div>
                    </div>     
                    <div class="form-group col-md-12 py-sm-2">
                        <label for="errorTyCd" class="col-sm-2 col-form-label">개발사유<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-10">
                            <input type="text" id="devlopResn" class="form-control"  style="width:92.5%;" maxlength="2000">
                        </div>
                    </div>
                    <div class="form-group col-md-12 py-sm-2">
                        <label for="errorCn" class="col-sm-2 col-form-label">기대효과</label>
                        <div class="col-sm-10">
                            <textarea rows="2" id="expcEffect" class="form-control" style="width:92.5%;" maxlength="2000"></textarea>
                        </div>
                    </div>
                   <div class="form-group col-md-12">
                        <label for="managtChargerId" class="col-sm-2 col-form-label">첨부파일 </label>
                       <div class="col-sm-10"><div class="form-check2 row"  id="fileUpload" ></div></div>
                   </div>
<%--                    
                    <div class="form-group col-md-12 py-sm-3">
                        <label for="managtChargerId" class="col-sm-2 col-form-label">연관문서</label>
                        <div class="col-sm-10">
                            <input type="text" id="relateDoc" class="form-control"  style="width:80%;" value="" maxlength="2000">
                        </div>
                    </div>
--%>
                </form>
                <div class="float-right py-sm-2">
                    <button type="button" class="btn btn-primary" id="registerBtn">등록</button>
                    <button type="button" class="btn btn-primary" id="backListBtn">닫기</button>
                </div>
                <div id="divSearchUser" class="modal fade" tabindex="-1" role="dialog"></div>
            </div>
        </div>
    </div>
</div>
<script>

var fileGrpNo =0;
$(document).ready(function() {
    //이벤트 바인딩
    pageInit();
    bindEvent();
});

    /*
     * 이벤트 바인딩
     * @param
     * @return
     */
    function bindEvent() {
        var params = [];
        params.push({"id" : "fqCd", "clsCd" : "0017"});    //빈도
   	    params.push({"id" : "jobClsCd", "clsCd" : "0040"});    //업무분류
   	    params.push({"id" : "rpaClsCd", "clsCd" : "0042"});    //구분
   	    
   	    requestCmmnCd(params);
    	     
    	/* 저장 버튼 클릭 시 */
        $("#registerBtn").on("click",function(){
        	
        	var oIdeaSj = $("#ideaSj");
        	var oJobDc = $("#jobDc");
        	var oDevlopResn = $("#devlopResn");
        	var oJobTm = $("#jobTm");
        	var sJobTmVal = oJobTm.val();
        	if($.trim(oIdeaSj.val()) == ""){
                alert("제목을 입력하세요.");
                oIdeaSj.focus();
                return false;
            }
        	else if($.trim(oJobDc.val()) == ""){
                alert("업무설명을 입력하세요.");
                oJobDc.focus();
                return false;
            }
        	else if($.trim(sJobTmVal) != ""){
                sJobTmVal = sJobTmVal.replace(/,/gi, "");
                if(parseInt(sJobTmVal) >= 1000000){
                    alert("작업시간을 1,000,000미만으로 입력해 주십시오.");
                    oJobTm.focus();
                    return false;
                }
            }
        	
        	if($.trim(oDevlopResn.val()) == ""){
                alert("개발사유를 입력하세요.");
                oDevlopResn.focus();
                return false;
            }
        	
            
        	
        	/* 파일 유무 체크 없으면 0, 있으면 1 */
            if(bbsUpload.upload() == 0){
                fileGrpNo = 0;
            }else{
                fileGrpNo = bbsUpload.upload();
            }
        	
            var url = "/task/idea/insertTaskIdea";
            var param = {
            		ideaSj : oIdeaSj.val()
                  , jobDc : oJobDc.val().replace(/\n/g, "<br>")
                  , jobClsCd : $("#jobClsCd").val()
                  , rpaClsCd : $("#rpaClsCd").val()
                  , cmpnyCd : $("#regCmpnyCd").val()
                  , cmpnyNm : $("#regCmpnyNm").val()
                  , deptCd : $("#deptCd").val()
                  , deptNm : $("#deptNm").val()
                  , ideaUserId : $("#ideaUserId").val()
                  , jobTm : sJobTmVal
                  , fqCd : $("#fqCd").val()
                  , executCnt : $("#executCnt").val()
                  , devlopResn : $("#devlopResn").val().replace(/\n/g, "<br>")
                  , expcEffect : $("#expcEffect").val()
//                  , relateDoc : $("#relateDoc").val()
                  , fileGrpNo : fileGrpNo
                  
            };
            callAsyncAjax("/task/idea/insertTaskIdea", param, "mainPopCloseReload");
        });
    	
        /* 취소 버튼 누를 시 */
        $("#backListBtn").on("click", function() { 
            mainPopClose();
        });
    }
    
    function pageInit(){
        bbsUpload = new RpaUpload("fileUpload");
        bbsUpload.draw('',true);
    };
</script>
 </div>

<!--  템플릿 바디 끝 -->    