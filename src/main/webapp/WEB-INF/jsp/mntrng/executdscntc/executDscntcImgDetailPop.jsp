<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="card card-primary" id="cardDivDetl">
    <div class="card-header">
        <h3 class="card-title">실행중단 이미지 상세</h3>
    </div>
    <div class="card-body"style="height:704px; overflow:auto;">
            <div class="row">
                <div class="col-md-12">
                    <div class="form-inline">
                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                            <label class="col-sm-3 col-form-label">회사</label>
                            <div class="col-sm-9">
                                <input type="text" id="cmpnyCdDetl" class="form-control" style="width:80%;margin-right: 3px;" readOnly>
                            </div>
                        </div>
                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                            <label class="col-sm-3 col-form-label">실행중단일시</label>
                            <div class="col-sm-9">
                                <input type="text" id="executDscntcDtDetl" class="form-control" style="width:80%;margin-right: 3px;" readonly>
                            </div>
                        </div>   
                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                            <label class="col-sm-3 col-form-label">프로세스코드</label>
                          <div> 
                            <div class="col-sm-9">
                                <input type="text" id="processCdDetl" class="form-control" style="width:80%;margin-right: 3px;" readonly>
                            </div>
                          </div>                          
                        </div>
                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                            <label class="col-sm-3 col-form-label">프로세스명</label>
                            <div class="col-sm-9">
                                <input type="text" id="processNmDetl" class="form-control" style="width:80%;margin-right: 3px;" readonly>
                            </div>
                        </div>   
                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                            <label class="col-sm-3 col-form-label">로봇명</label>
                            <div class="col-sm-9">
                                <input type="text" id="robotNmDetl" class="form-control" style="width:80%;margin-right: 3px;" readonly>
                            </div>
                        </div>
                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                            <label class="col-sm-3 col-form-label">파일명</label>
                            <div class="col-sm-9">
                                <input type="text" id="fileNmDetl" class="form-control" style="width:80%;margin-right: 3px;" readonly>
                            </div>
                        </div>
                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                            <label class="col-sm-3 col-form-label">스크린샷</label>
                            <div class="col-sm-9" id="screenImg">
                                <image id="screenShotDetl" src="" style="width:400px;height:400px;"></image>
<!--                                 <input type="image" id="screenShotDetl" class="form-control" style="width:80%;margin-right: 3px;" readonly> -->
                            </div>
                        </div>
                    </div>
                </form>
                    <div class="float-right">
                        <button type="button" class="btn btn-primary" id="closeBtn">닫기</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
    
<script>

var executSn;

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
    	var params = [];
        params.push({"id" : "processCdDetl", "clsCd" : "0043"});
        requestCmmnCd(params);
        
        getExecutDscntcImgDetail(executSn);
    }
    
    /*
     * 이벤트 바인딩
     * @param
     * @return
     */
    function bindEvent() {
        $("#closeBtn").on("click", function() {
            closePop();
        });
    }
    
    /*
     * 과제템플릿 정보 상세 조회
     * @param
     * @return
     */
    function getExecutDscntcImgDetail(executDscntcImageSn) {
        var param = {"executDscntcImageSn" : executDscntcImageSn};
        callAsyncAjax("/mntrng/executdscntc/getExecutDscntcImgDetail", param, "executDscntcImgDetailPop");
    }
    
    /*
     * 상세 페이지 데이터 출력
     * @param
     * @return
     */
    function executDscntcImgDetailPop(data) {
        console.log(data);
        var executDetail    = data.result.executDscntcImg;
        
        var resultCmpnyCd            = executDetail.cmpnyCd;
        var resultExecutDscntcDt     = executDetail.executDscntcDt;
        var resultprocessCd          = executDetail.processCd;
        var resultProcessNm          = executDetail.processNm;
        var resultRobotId            = executDetail.robotId;
        var resultFileNm             = executDetail.fileNm;
        var resultFileCours          = executDetail.fileCours;
        
        //$("#cmpnyCdDetl").val(resultCmpnyCd);
        $("#cmpnyCdDetl").val(executDetail.cmpnyNm);
        $("#executDscntcDtDetl").val(resultExecutDscntcDt);
        $("#processNmDetl").val(resultProcessNm);
        $("#robotNmDetl").val(resultRobotId);
        $("#fileNmDetl").val(resultFileNm);
        $("#processCdDetl").val(resultprocessCd);
        //$("#screenShotDetl").attr("src", "http://localhost:8080/file/getRobotImage?filePath=" + resultFileCours + "&fileName=" + resultFileNm);
        $("#screenShotDetl").attr("src", "/mntrng/executdscntc/errorImg?filePath=" + encodeURI(resultFileCours) + "&fileName=" + resultFileNm);
        
        
    }
    
</script>