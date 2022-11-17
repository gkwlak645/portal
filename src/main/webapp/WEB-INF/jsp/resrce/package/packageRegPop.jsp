<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="modal-dialog modal-lg">
    <div class="modal-content">
        <div class="modal-header">
            <h4 class="modal-title" id="headerTxt">여러 프로세스 업그레이드</h4>
         <button type="button" class="close" data-dismiss="modal" aria-label="Close">
             <span aria-hidden="true">×</span>
         </button>
        </div>
        <div class="modal-body" >        
            <div class="form-group col-md-12 row" id="cmpnyForm">
                        <label class="col-sm-2 col-form-label" for="rgstCmpny">회사</label>
                        <div class="col-sm-3">
                            <select class="form-control" id="rgstCmpny">
                             </select>
                        </div>
                    </div>
            <div class="form-group col-md-12 row">
                 <label for="managtChargerId" class="col-sm-2 col-form-label">첨부파일 </label>
                 <div class="col-sm-10">
                     <form enctype="multipart/form-data" id="fileForm" onsubmit="return false">
                         <input id="file" type="file" accept=".nupkg" />
                     </form>
                 </div>
            </div>
            <p style="color: #4b5eb5; font-size: 12px; margin: 0 0 6px 14px;">※ 업로드가 전파되기 전에 몇 분 정도 걸릴 수 있습니다.</p>
            <div class="form-check" style="padding-left: 22px; margin-left: 12px;" id="updatePackage">
                <input class="form-check-input" type="checkbox" id="chkUpgrade" style="top: 6px; left: 0; width: 18px; height: 18px; margin: 0;">
                    <label class="form-check-label" for="checkbox_confirm">업그레이드 할 수 있는 프로세스를 확인하려고 합니다.</label>
               </div>
        </div>
        <div class="modal-footer">
            <input type="button" class="btn btn-default" data-dismiss="modal" id="cancel" value="취소">
            <button type="button" class="btn btn-primary" id="btnUpload">업로드</button>
        </div>
    </div>
</div>

<script>

    $(document).ready(function() {
        
        //페이지 초기화
        pageInit();
        
        bindEvent();
    });
    
    /*
     * 페이지 초기화
     * @param
     * @return
     */
    function pageInit() {
    	
    	var params = [];
    	
        if("${txScreenAuthor.untenantAuthor}" == 'Y'){
            params.push({"id" : "rgstCmpny", "clsCd" : "0024"});    //회사
        }else{
            params.push({"id" : "rgstCmpny", "clsCd" : "0024", "disable" : "Y", "selectValue": "${sessionUserInfo.txCmpnyCd}"});    //회사
        }
        
        requestCmmnCd(params);
         
    }
    
    function fileSizeCheck() {  	
    	var fileSize = document.getElementById("file").files[0].size;
        var maxSize = 30 * 1024 * 1024; //30MB 
        if(fileSize >= maxSize){
           alert("패키지 용량은 30MB 이내로 등록 가능합니다.\n용량을 줄여주세요.");
           return false;
        }
        return true;
    }
    
    function startLoading() {
        //로딩바 
        $('.dimmed').css({ display: 'block' });
        $('.loading').css({ display: 'block' });
        $('.loading').addClass('show');
    }
    
    function endLoading() {
    	setTimeout(function() {
            $('.dimmed').css({ display: 'none' });
            $('.loading').css({ display: 'none' });
            $('.loading').removeClass('show');                  
        }, 300);
    }
    
    /*
     * 이벤트 바인딩
     * @param
     * @return
     */
    function bindEvent(){
        
    	$(".close").on("click", function() {
            closePOP();
        });
    	
    	$("#cancel").on("click", function() {
            closePOP();
        });
    	
    	$("#btnUpload").on("click", function() {
    		if($('input:radio[name="checkRadio"]:checked').val() == "package"){
    			if($("#rgstCmpny").val() == null || $("#rgstCmpny").val() == '') {
                    alert("회사를 선택해주세요.");
                } else {
                	if(fileSizeCheck()) {
                		startLoading();
                		filesUpload();
                	}                   
                }
            } else {
            	startLoading();
            	filesUpload();
            }
    		
    	});
    }
    
    /*
     * 패키지, 라이브러리 화면 구분
     * @param 
     * @return
     */
    function packageLibraryView() {
        if($('input:radio[name="checkRadio"]:checked').val() == "package"){
        	$("#headerTxt").text("패키지 등록");
        	$("#updatePackage").show();
        	$('#cmpnyForm').show();
        } else {
        	$("#headerTxt").text("라이브러리 등록");
            $("#updatePackage").hide();
            $('#cmpnyForm').hide();
        }
    }
    
    function filesUpload() {
    	var form = $("#fileForm")[0];
    	var param = new FormData(form);
    	
    	if($("#file")[0].files[0] != null){
    		
    		param.append("file", $("#file")[0].files[0]);
    		param.append("cmpnyCd", $("#rgstCmpny").val());
// 	    	console.log("$(#file)[0].files[0]", $("#file")[0].files[0]);
// 	    	console.log("param", param);
	
	    	if($('input:radio[name="checkRadio"]:checked').val() == 'package'){
	    		var url = "/resrce/package/registerPackage";
	        } else {
	        	var url = "/resrce/package/registerLibrary";
	        }
	    	$.ajax({
	            type: "POST",
// 	            enctype: 'multipart/form-data',
	            enctype: '*/*',
	            url: url,
	            data: param,
	            async : false,
	            processData: false,
	            contentType: false,
	            cache: false,
	            success: function (data) {
	            	console.log(data);
	            	console.log(data.responseCode);
	            	if(data.responseCode == 'E00004'){
	            		alert("이미 등록된 패키지 입니다.");
	            	} else if(data.responseCode == 'E00005'){
	            	    alert("이미 등록된 라이브러리 입니다.");
	            	} else if(data.responseCode == 'E101'){
	            		alert("권한 토큰 에러입니다. 잠시 후 다시 시도해주세요.");
	            	} else {
	                    //업그레이드 확인 체크박스 체크된 경우
	                    if($('input:checkbox[id="chkUpgrade"]:checked').val() == 'on'){
	                    	var result = data.result[0].Body;
	                        var obj = JSON.parse(result);
	                        var rgstCmpnyCd = $("#rgstCmpny").val();
	                        //미리 팝업 닫으면 체크여부 구분 불가
	                        closePOP();
	                        searchPackageLibraryList();
	                        
	                        //체크시 팝업 출력
	                        appendDetailPopup("packageLibraryMainDiv", "/resrce/package/packageUpgradePop");
	                        processViewCheck(obj.Id, obj.Version, rgstCmpnyCd);
	                    } else {
	                        closePOP();
	                        searchPackageLibraryList();
	                    }
	            	}            	
	            	
	            	endLoading();
	            },
	            error: function (e) {
	            	endLoading();
	            }
	        });
    	} else {
    		alert("파일을 선택해주세요.");
    	}
    }

</script>
