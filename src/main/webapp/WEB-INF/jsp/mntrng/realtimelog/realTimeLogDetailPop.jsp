<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
                    
                    
<!--  템플릿 바디 -->        
 <div class="card card-primary" id="unmanagtErrorRegDiv">                   
    <div class="card-header">
        <h3 class="card-title">상세조회</h3>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-12">
                                    <form class="form-inline" id="trnscErrorDetail">
                                        <div class="form-group col-md-6 py-sm-2">
                                            <label for="cmpnyNm" class="col-sm-4 col-form-label">회사</label>
                                            <div class="col-sm-8">
                                                 <input type="text" id="cmpnyNm" class="form-control" disabled style="width:80%;" />
                                            </div>
                                        </div>
                                        <div class="form-group col-md-6 py-sm-2">
                                            <label for="occrrncDt" class="col-sm-4 col-form-label">발생일시</label>
                                            <div class="col-sm-8">
                                                 <input type="text" id="occrrncDt" class="form-control" disabled style="width:80%;" />
                                            </div>
                                        </div>
                                        
                                        <!-- <div class="form-group col-md-6 py-sm-1">
                                            <label for="reprsntAt" class="col-sm-4 col-form-label">프로세스코드</label>
                                            <div class="col-sm-8">
                                                 <input type="text" id="reprsntAt" class="form-control" disabled style="width:80%;" />
                                            </div>
                                        </div> -->
                                        
                                        <div class="form-group col-md-12 py-sm-1">
                                            <label for="processNm" class="col-sm-2 col-form-label">프로세스명</label>
                                            <div class="col-sm-10">
                                                <input type="text" id="processNm" class="form-control" disabled style="width:80%;"/>
                                            </div>
                                        </div>
                                        <div class="form-group col-md-12 py-sm-2">
                                            <label for="message" class="col-sm-2 col-form-label">Message</label>
                                            <div class="col-sm-10">
                                                <textarea rows="1" id="message" class="form-control" disabled style="width:92.5%;"></textarea>
                                            </div>
                                        </div>
                                        <div class="form-group col-md-12 py-sm-2">
                                            <label for="rawmessage" class="col-sm-2 col-form-label">내용</label>
                                            <div class="col-sm-10">
                                                <textarea rows="3" id="rawmessage" class="form-control" maxlength="1000" disabled style="width:92.5%;"></textarea>
                                            </div>
                                        </div>
                                        
                                        <!-- <div class="form-group col-md-12 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                                            <label class="col-sm-2 col-form-label">스크린샷</label>
                                            <div class="col-sm-10" id="screenImg">
                                                <image id="screenShotDetl" src="" style="width:450px;height:150px;"></image>
                                                <p class="text-success">이미지를 클릭하시면 원래 크기를 볼 수 있습니다.</p>
                                            </div>
                                        </div>  --> 
                                                                            
                                    </form>
                                    <div class="py-sm-2 float-right">
                                        <button type="button" class="btn btn-primary" id="closeBtn">닫기</button>
                                    </div>
                                    <!-- <div id="divSearchUser" class="modal fade" tabindex="-1" role="dialog"></div> -->
                                </div>
                            </div>
                        </div>
                    </div>
                                    
                    <!--  템플릿 바디 끝 -->
                    
<script>

var detailcmpny;
var detailprocessNm;
var detailoccrrncDt;
var detailmessage;
var detailrawmessage;

	$(document.body).ready(function () { 
	    setPopInfo();
	    bindEvent();	    
	});
	
	/*
	 * 페이지 초기화
	 * @param
	 * @return
	 */
	function setPopInfo() {	
		$("#cmpnyNm").val(detailcmpny);
	    $("#processNm").val(detailprocessNm);
	    $("#occrrncDt").val(detailoccrrncDt);
	    $("#message").text(detailmessage);
	    $("#rawmessage").text(detailrawmessage);
	    
	    adjustHeight(); // textarea 높이 자동 조절
	    
	    // 로딩 끝
        $('.dimmed').css({ display: 'none' });
        $('.loading').css({ display: 'none' });
        $('.loading').removeClass('show');
	}
	
	function adjustHeight() {
        var var_rawmessage = $("#rawmessage");        
        var_rawmessage[0].style.height = 'auto';       
        var Height = var_rawmessage.prop('scrollHeight');     
        var_rawmessage.css('height', Height);
        
        var var_message = $("#message");        
        var_message[0].style.height = 'auto';       
        var Height = var_message.prop('scrollHeight');     
        var_message.css('height', Height);
    };
	
	/*
     * 이벤트 바인딩
     * @param
     * @return
     */
    function bindEvent() {
    	// 닫기 버튼
        $("#closeBtn").off().on('click', function(){
        	closePop();
        	//searchRealTimeLogList();
        });
    	
        
    }     

</script>
           