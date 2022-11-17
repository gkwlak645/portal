<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--  템플릿 바디 -->
<div class="card card-primary" id="unmanagtErrorDetailDiv">
	<div class="card-header" alt="과제 >과제아이디어상세">
		<h3 class="card-title">상세조회</h3>
	</div>
	<div class="card-body">
		<div class="row">
			<div class="col-md-12">
				<form class="form-inline" id="unmanagtErrorDetail">
					<div class="form-group col-md-6 py-sm-2">
						<label for="sourcUpdtNm" class="col-sm-4 col-form-label">등록번호</label>
						<div class="col-sm-8">
							<input type="text" id="view_ideaSn" class="form-control"
								style="width: 80%;" value="20200818001" disabled>
						</div>
					</div>
					<div class="form-group col-md-6 py-sm-2">
						<label for="managtChargerId" class="col-sm-4 col-form-label">상태</label>
						<div class="col-sm-8">
							<input type="text" id="view_prgrSttusNm" class="form-control"
								style="width: 80%;" value="등록" disabled>
						</div>
					</div>
					<div class="form-group col-md-12 py-sm-2">
						<label for="errorTyCd" class="col-sm-2 col-form-label">제목<b
							style="color: red; padding-left: 10px;">*</b></label>
						<div class="col-sm-10">
							<input type="text" id="view_ideaSj" class="form-control"
								style="width: 92.5%;" maxlength="100" />
						</div>
					</div>
					<div class="form-group col-md-12 py-sm-2">
						<label for="errorCn" class="col-sm-2 col-form-label">업무설명<b
							style="color: red; padding-left: 10px;">*</b></label>
						<div class="col-sm-10">
							<textarea rows="2" id="view_jobDc" class="form-control"
								style="width: 92.5%;" maxlength="2000"></textarea>
						</div>
					</div>
					<div class="form-group col-md-6 py-sm-2">
						<label for="managtChargerId" class="col-sm-4 col-form-label">구분</label>
						<div class="col-sm-8">
							<select id="view_rpaClsCd" class="form-control" style="width: 80%; margin-right: 3px;" type="text"></select>
						</div>
					</div>
					<div class="form-group col-md-6 py-sm-2">
						<label for="sourcUpdtNm" class="col-sm-4 col-form-label">업무분류</label>
						<div class="col-sm-8">
							<select id="view_jobClsCd" class="form-control"
								style="width: 80%; margin-right: 3px;" type="text"></select>
						</div>
					</div>
					<div class="form-group col-md-6 py-sm-2">
						<label for="sourcUpdtNm" class="col-sm-4 col-form-label">회사</label>
						<div class="col-sm-8">
							<input type="text" id="view_cmpnyNm" class="form-control"
								style="width: 80%;" value="동원" disabled>
						</div>
					</div>
					<div class="form-group col-md-6 py-sm-2">
						<label for="managtChargerId" class="col-sm-4 col-form-label">부서</label>
						<div class="col-sm-8">
							<input type="text" id="view_deptNm" class="form-control"
								style="width: 80%;" value="혁신팀" disabled>
						</div>
					</div>
					<div class="form-group col-md-6 py-sm-2">
						<label for="sourcUpdtNm" class="col-sm-4 col-form-label">담당자</label>
						<div class="col-sm-8">
							<input type="text" id="view_ideaUserNm"
								class="form-control float-left"
								style="width: 70px; margin-right: 5px;" value="홍길동" disabled />
							<input type="text" id="view_emailAdr"
								class="form-control float-left" style="width: 200px;"
								value="hgd@dongwon.com" disabled />
						</div>
					</div>

					<div class="form-group col-md-6 py-sm-2">
						<label for="managtChargerId" class="col-sm-4 col-form-label">연락처</label>
						<div class="col-sm-8">
							<input type="text" id="view_mbtlnum"
								class="form-control float-left" style="width: 150px;"
								value="010-0000-0000" disabled />
						</div>
					</div>
					<div class="form-group col-md-6 py-sm-2">
						<label for="sourcUpdtNm" class="col-sm-4 col-form-label">업무시간(연간)</label>
						<div class="col-sm-8">
							<input type="text" id="view_jobTm"
								class="form-control float-left"
								style="width: 120px; margin-right: 3px;" value="" type="text"
								maxlength="8" decimalNumberType1>H
						</div>
					</div>
					<div class="form-group col-md-6 py-sm-2">
						<label for="managtChargerId" class="col-sm-4 col-form-label">빈도</label>
						<div class="col-sm-8">
							<select id="view_fqCd" class="form-control float-left"
								style="width: 30%; margin-right: 10px;" type="text">
								<option value="">월</option>
							</select> <input type="text" id="view_executCnt"
								class="form-control float-left"
								style="width: 120px; margin-right: 3px;" type="text" value=""
								maxlength="6">회
						</div>
					</div>
					<div class="form-group col-md-12 py-sm-2">
						<label for="errorTyCd" class="col-sm-2 col-form-label">개발사유<b
							style="color: red; padding-left: 10px;">*</b></label>
						<div class="col-sm-10">
							<input type="text" id="view_devlopResn" class="form-control"
								style="width: 92.5%;" maxlength="2000" />
						</div>
					</div>
					<div class="form-group col-md-12 py-sm-2">
						<label for="errorCn" class="col-sm-2 col-form-label">기대효과</label>
						<div class="col-sm-10">
							<textarea rows="2" id="view_expcEffect" class="form-control"
								style="width: 92.5%;" maxlength="2000"></textarea>
						</div>
					</div>

					<div class="form-group col-md-12 py-sm-2">
						<label for="managtChargerId" class="col-sm-2 col-form-label">첨부파일
						</label>
						<div class="col-sm-10">
							<c:choose>
								<c:when test="${identityFlag}">
									<div class="form-check2 row" id="fileUpload"></div>
								</c:when>
								<c:otherwise>
									<div class="form-check2 row" id="atchFile">
										<ul
											class="mailbox-attachments d-flex align-items-stretch clearfix"></ul>
									</div>
								</c:otherwise>
							</c:choose>

						</div>
					</div>

					<div id="reviewOpinDiv" class="form-group col-md-12 py-sm-2" style="display: none">
						<label for="errorCn" class="col-sm-2 col-form-label">검토의견</label>
						<div class="col-sm-10">
							<textarea rows="2" id="view_reviewOpin" class="form-control"
								style="width: 92.5%;" maxlength="2000"
								placeholder="'검토대상여부'를 '비대상'으로 [검토완료]할 경우 필수 입력"></textarea>
						</div>
					</div>

					<%--                   
                    <div class="form-group col-md-6 py-sm-2">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">연관문서 </label>
                        <div class="col-sm-8">
                            <input type="text" id="view_relateDoc" class="form-control"  style="width:80%;" maxlength="2000">
                       </div>
                   </div>
--%>
					<c:if test="${txScreenAuthor.resveAuthor2 eq 'Y'}">
						<div class="form-group col-md-6 py-sm-2">
							<label for="managtChargerId" class="col-sm-4 col-form-label">검토대상여부
							</label>
							<div class="col-sm-8">
								<select id="view_reviewTrgetAt" class="form-control float-left"
									style="width: 30%; margin-right: 10px;" type="text">
								</select>
							</div>
						</div>
					</c:if>
				</form>

				<div class="float-right py-sm-2">
					<c:if test="${txScreenAuthor.resveAuthor2 eq 'Y'}">
						<button type="button" class="btn btn-primary"
							id="setReviewCompleteBtn" style="display: none">검토완료</button>
					</c:if>
					<c:if test="${identityFlag}">
						<button type="button" class="btn btn-primary" id="regCancelBtn"
							style="display: none">등록취소</button>
						<button type="button" class="btn btn-primary" id="saveBtn"
							style="display: none">저장</button>
					</c:if>
					<button type="button" class="btn btn-primary" id="backListBtn">닫기</button>
				</div>
				<div id="divSearchUser" class="modal fade" tabindex="-1"
					role="dialog"></div>
			</div>
		</div>
	</div>
</div>

<script>
var fileGrpNo = 0
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
    	/* 취소 버튼 누를 시 */
        $("#backListBtn").on("click", function() { 
            mainPopClose();
        });
    	
        $("#setReviewCompleteBtn").on("click", function() { 
            if(confirm("검토완료 하시겠습니까?")){
            	var oReviewOpin = $("#view_reviewOpin");
            	if($("#view_reviewTrgetAt").val() == "N"){
            		if($.trim(oReviewOpin.val()) == ""){
                        alert("검토의견을 입력하세요.");
                        oReviewOpin.focus();
                        return false;
                    }
            	}
            	//업무정의서.
                var param = {
                		ideaSn : $("#view_ideaSn").val()
                		, reviewTrgetAt: $("#view_reviewTrgetAt").val()
                		, reviewOpin: oReviewOpin.val()
                };
                callAsyncAjax("/task/idea/setTaskIdeaReviewComplete", param, "mainPopCloseReloadType2");
            }
        });
        
        $("#saveBtn").on("click", function() { 
            if(confirm("변경된 내용을 하시겠습니까?")){
            	//setTaskIdeaDetail
            	var oIdeaSj = $("#view_ideaSj");
                var oJobDc = $("#view_jobDc");
                var oDevlopResn = $("#view_devlopResn");
                var oJobTm = $("#view_jobTm");
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
               
<c:if test="${identityFlag}">                
                /* 파일 유무 체크 없으면 0, 있으면 1 */
                if(bbsUpload.upload() == 0){
                    fileGrpNo = 0;
                }else{
                    fileGrpNo = bbsUpload.upload();
                }
</c:if>
                var param = {
                		ideaSn : $("#view_ideaSn").val()
                      , ideaSj : oIdeaSj.val()
                      , jobDc : oJobDc.val().replace(/\n/g, "<br>")
                      , jobClsCd : $("#view_jobClsCd").val()
                      , rpaClsCd : $("#view_rpaClsCd").val()
                      , jobTm : sJobTmVal
                      , fqCd : $("#view_fqCd").val()
                      , executCnt : $("#view_executCnt").val()
                      , devlopResn : $("#view_devlopResn").val().replace(/\n/g, "<br>")
                      , expcEffect : $("#view_expcEffect").val()
                      , relateDoc : $("#view_relateDoc").val()
<c:if test="${identityFlag}">                      
                      , fileGrpNo : fileGrpNo
</c:if>                      
                };
                callAsyncAjax("/task/idea/setTaskIdeaDetail", param, "mainPopCloseReload");
            }
        });
        
        $("#regCancelBtn").on("click", function() { 
            if(confirm("등록취소 하시겠습니까?")){
                var param = {
                        ideaSn : $("#view_ideaSn").val()
                };
                callAsyncAjax("/task/idea/setTaskIdeaCancel", param, "mainPopCloseReloadType2");
            	//setTaskIdeaCancel
            }
        });
    }
    
    function pageInit(){
    	
    };
    
    function bbsUploadDraw(view_fileGrpNo){
    	fileGrpNo = view_fileGrpNo;
<c:choose>
    <c:when test="${identityFlag}">
        bbsUpload = new RpaUpload("fileUpload");
        if(fileGrpNo != "" && fileGrpNo != "0" && fileGrpNo != null){
            bbsUpload.draw(fileGrpNo,true);
        }
        else{
            bbsUpload.draw('',true);
        }
</c:when>
    <c:otherwise>
	    if(fileGrpNo != "" && fileGrpNo != "0" && fileGrpNo != null){
	        var url = "/file/getAtchmnflList";
	        var param = {
	                fileGrpNo : fileGrpNo
	        };
	        callAsyncAjax(url, param, "getAtchFile");
	    }
    </c:otherwise>
</c:choose>
    }
    
    /*resonseVO 리턴형이라 result 추가*/
    function getAtchFile(fileInfoList){
        var html = "";
        var fileGrpNo = fileInfoList.result[0].fileGrpNo;
        var szUnit = "byte";
        var convertSz = 0;
        
        html += '<input type="hidden" id="fileGrpNo" name="fileGrpNo" value="'+fileGrpNo+'" />';
        $.each(fileInfoList.result, function(index,item){
            html += '<li id="upload'+index+'">';
            html +=     '<span class="mailbox-attachment-icon"><i class="far fa-file-pdf"></i></span>';
            html +=     '<div class="mailbox-attachment-info">';
            html +=         '<a href="#" class="mailbox-attachment-name"><i class="fas fa-paperclip"></i>'+item.oriFileNm+'</a>';
            html +=         '<span class="mailbox-attachment-size clearfix mt-1">';
            if(item.fileSz < 1024){
                convertSz = item.fileSz;
            }else if(item.fileSz/1024 < 1024){
                var tmp = item.fileSz/1024;
                szUnit = "KB";
                convertSz = tmp.toString().substring(0,tmp.toString().indexOf(".")+2);
            }else{
                var tmp = (item.fileSz/1024)/1024;
                szUnit = "MB";
                convertSz = tmp.toString().substring(0,tmp.toString().indexOf(".")+2);
            }
            html +=             '<span>'+ convertSz+szUnit +'</span>';
            html +=             '<input type="hidden" id="fileNo'+index+'" name="fileNo" value="'+item.fileNo+'" />';
            html +=             '<a href="#" class="btn btn-default btn-sm float-right" id="btnDownFile'+index+'">';
            html +=                 '<i class="fas fa-cloud-download-alt"></i>';
            html +=             '</a>';
            html +=         '</span>';
            html +=     '</div>';
            html += '</li>';
        });
        
        $("#atchFile ul").html(html);
        
        $("#atchFile ul [id^='btnDownFile']").on("click", function(){
            downloadFile(fileGrpNo, $(this).closest("li").attr("id"));
        });
        
    }
    
    function downloadFile(fileGrpNo, liId) {
        var fileNo = $("#"+liId+" input[id^='fileNo']").val();
        $("#downloadFileGrpNo").val(fileGrpNo);
        $("#downloadFileNo").val(fileNo);
        $("#downloadForm").submit();
    }
</script>

<!--  템플릿 바디 끝 -->