<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="card card-primary" id="cardDivDetl">
    <div class="card-header">
        <h3 class="card-title">과제템플릿 상세</h3>
    </div>
    <div class="card-body"style="height:704px; overflow:auto;">
            <div class="row">
                <div class="col-md-12">
                    <div class="form-inline">
                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                            <label class="col-sm-3 col-form-label">프로세스코드</label>
                            <div class="col-sm-9">
                                <input type="text" id="processCdDetl" class="form-control" style="width:80%;margin-right: 3px;" readonly="readonly">
                                <input type="hidden" id="snDetl">
                            </div>
                        </div>   
                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                            <label class="col-sm-3 col-form-label">프로세스명</label>
                            <div class="col-sm-9">
                                <input type="text" id="processNmDetl" class="form-control" style="width:80%;margin-right: 3px;" readonly="readonly">
                            </div>
                        </div>   
                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                            <label class="col-sm-3 col-form-label">템플릿코드</label>
                            <div class="col-sm-9">
                                <input type="text" id="tmplatCdDetl" class="form-control" style="width:80%;margin-right: 3px;" readOnly>
                            </div>
                        </div>
                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                            <label class="col-sm-3 col-form-label">템플릿명<b style="color:red;padding-left:10px;">*</b></label>
                            <div class="col-sm-9">
                                <input type="text" id="tmplatNmDetl" class="form-control" style="width:80%;margin-right: 3px;" required>
                            </div>
                        </div>   
                        <div class="form-group col-md-9 py-sm-2" style="margin: 0.25rem 0 0.1rem 0;">
                             <label  class="col-sm-2 col-form-label">첨부파일<b style="color:red;padding-left:10px;">*</b></label>
                             <div class="col-sm-10"style="padding-left: 4px;" id="fileUploadDetl"></div>
                        </div>
                        <div class="form-group col-md-9 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                            <label class="col-sm-2 col-form-label">다운로드 URL</label>
                            <div class="col-sm-10">
                                <input type="text" id="downloadURLDetl" class="form-control" style="width:100%;margin-right: 3px;" readonly>
                                <input type="hidden" id="fileGrpNoDetl">
                            </div>
                        </div>
                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                            <label class="col-sm-3 col-form-label">최초등록일</label>
                            <div class="col-sm-9">
                                <input type="text" id="regDtDetl" class="form-control" style="width:80%;margin-right: 3px;" readonly>
                            </div>
                        </div>  
                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                            <label class="col-sm-3 col-form-label">최종수정일</label>
                            <div class="col-sm-9">
                                <input type="text" id="updtDtDetl" class="form-control" style="width:80%;margin-right: 3px;" readonly>
                            </div>
                        </div>  
                    </div>
                </form>
                    <div class="float-right">
                        <button type="button" class="btn btn-primary" id="saveBtn" style="display:none">저장</button>
                        <button type="button" class="btn btn-primary" id="deleteBtn" style="display:none">삭제</button>
                        <button type="button" class="btn btn-primary" id="closeBtn">닫기</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
    
<script>

    var fileGrpNo =0;
    var detlTmplatSn;
    var tmplatUpload = new RpaUploadType2("fileUploadDetl")
    
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
    	getTaskTmplatDetail(detlTmplatSn);
    }
    
    /*
     * 이벤트 바인딩
     * @param
     * @return
     */
    function bindEvent() {

        $("#saveBtn").on("click", function() {
        	if($("#tblUpload tbody tr").length != 1) {
                alert("첨부파일을 1개만 선택하세요.");
                return false;
            }
        	updateTmplat();
        });
        
        $("#deleteBtn").on("click", function() {
            deleteTmplat();
        });
        
        $("#closeBtn").on("click", function() {
            closePop();
        });

    }
    
    function changeNo() {
    	var fileNo = $("#fileGrpNoDetl").val();
    	tmplatUpload.draw(Number(fileNo), true);
//         $("#btnAdd").hide();        
//         $("input[name=delFile]").off();
    }
    
    /*
     * 과제템플릿 정보 상세 조회
     * @param
     * @return
     */
    function getTaskTmplatDetail(tmplatSn) {
        var param = {"sn" : tmplatSn};
        callAsyncAjax("/stdrinfo/tmplat/getTaskTmplatDetail", param, "taskTmplatDetailPop");
        
     // 로딩 끝
        $('.dimmed').css({ display: 'none' });
        $('.loading').css({ display: 'none' });
        $('.loading').removeClass('show');
    }
    
    /*
     * 상세 페이지 데이터 출력
     * @param
     * @return
     */
    function taskTmplatDetailPop(data) {
        console.log(data);
        var taskTmplatDetail    = data.result.taskTmplatMng;
        
        var resultProcessCd     = taskTmplatDetail.processCd;
        var resultProcessNm     = taskTmplatDetail.processNm;
        var resultTmplatCd      = taskTmplatDetail.tmplatCd;
        var resultTmplatNm      = taskTmplatDetail.tmplatNm;
        var resultDwldUrl       = taskTmplatDetail.dwldUrl;
        var resultRegDt         = taskTmplatDetail.regDt;
        var resultUpdtDt        = taskTmplatDetail.updtDt;
        var resultFileGrpNo     = taskTmplatDetail.fileGrpNo;
        var resultOriFileNm     = taskTmplatDetail.oriFileNm;
        
        $("#processCdDetl").val(resultProcessCd);
        $("#processNmDetl").val(resultProcessNm);
        $("#tmplatCdDetl").val(resultTmplatCd);
        $("#tmplatNmDetl").val (resultTmplatNm);
        $("#downloadURLDetl").val(PRI_URL + '/file/templateDownloadAtchmnfl?fileGrpNo=' + resultFileGrpNo + '&fileNo=1');
        $("#regDtDetl").val(resultRegDt);
        $("#updtDtDetl").val(resultUpdtDt);
        $("#fileGrpNoDetl").val(resultFileGrpNo);
        $("#snDetl").val(taskTmplatDetail.sn)
        
        $("#saveBtn").show();
        $("#deleteBtn").show();
        
        // 해당 템플릿을 업로드한 사람만이 저장과 삭제를 하고 싶자면, 아래 주석 해제하고, 위 2개(show()) 주석할 것.
        /* if(taskTmplatDetail.identityFlag == "Y"){
        	$("#saveBtn").show();
            $("#deleteBtn").show();
        }
        else{
        	$("#saveBtn").remove();
            $("#deleteBtn").remove();
        } */
        
        changeNo();
    }
    
    /*
     * 과제템플릿 수정
     * @param
     * @return
     */
    function updateTmplat() {
        var processCd = $('#processCdDetl').val();
        var processNm = $('#processNmDetl').val();
        var tmplatCd = $('#tmplatCdDetl').val();
        var tmplatNm = $('#tmplatNmDetl').val();
        var downloadURL = $('#downloadURLDetl').val();
        
        if(tmplatNm == "") {
            alert("템플릿명을 입력하세요.");
            $("#tmplatNm").focus();
            return false;
        } 
        
        if($("input[name=changeFile]").length < 1){
        	tmplatUpload.setFileGrpNo(0); 
        }
        
        fileGrpNo = tmplatUpload.upload();
        
        if(fileGrpNo == -1 || fileGrpNo == 0) {
            /* 파일 유무 체크 없으면 0, 있으면 1 */
            alert("첨부파일을 선택하세요.");
            return false;
        }
        
        var url = "/stdrinfo/tmplat/updateTaskTmplat";
        var param = {
                sn   : $('#snDetl').val()
              , tmplatNm   : tmplatNm
              , fileGrpNo  : fileGrpNo
        };
        callAsyncAjax(url, param, backPage());
    }
    
    function deleteTmplat() {
    	if ( window.confirm('정말로 삭제하시겠습니까?') ) {
    		var url = "/stdrinfo/tmplat/deleteTaskTmplat";
            var param = {
            		sn   : $('#snDetl').val()
            };
            callAsyncAjax(url, param, "backPage");
        }
        else {
            return false
        }
    }
    
    /* 되돌아 가기 */ 
    function backPage(){
        closePop();
    }

</script>