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
	    
<!-- 	     프로세스가 존재하는 경우                -->

	    <div class="modal-body" id="processExist">
	        <div class="form-group col-md-12 row">
<!-- 	             <label class="form-check-label">업로드된 각 패키지의 경우 업그레이드할 프로세스를 선택합니다.</label> -->
	            <p translate="" class="ng-star-inserted" style="">업로드된 각 패키지의 경우 업그레이드할 프로세스를 선택합니다.</p>
	        </div>
	        <div class="form-group col-md-12 row">
	            <strong class="ng-star-inserted" id="packageNm"></strong>
            </div>
	        <div class="form-group col-md-12 row">
	            <p class="ng-star-inserted" style="">버전: <strong id="version"></strong></p>
            </div>
<!--             <div id="processListGrid"></div> -->
            <div class="check_wrap" id="processList">
	             <div class="form-check">
	                 <input class="form-check-input" type="checkbox" id="checkbox_confirm">
	                 <label class="form-check-label" for="checkbox_confirm" id="cntTxt"></label>
	             </div>
	        </div>
	    </div>
	    
<!--         //프로세스가 존재하는 경우                -->	    
	    
	    
<!--         프로세스가 존재하지 않는 경우                -->	    

	    <div class="modal-body" id="processNotExist">
	       <div class="form-group col-md-12 row">
	           <label class="form-check-label">업로드된 패키지로 업그레이드할 프로세스를 찾을 수 없습니다.</label>
	       </div>
	    </div>
	    
<!--         프로세스가 존재하지 않는 경우                -->        	    
	    
		<div class="modal-footer">
		    <input type="button" class="btn btn-default" data-dismiss="modal" id="cancel" value="닫기">
		    <button type="button" class="btn btn-primary" id="btnUpload">업그레이드</button>
		</div>
    </div>
</div>

<script>

var chkArr = [];
var chkArrTemp = [];
var updCmpnyCd = '';

    $(document).ready(function() {
        
        //페이지 초기화
        pageInit();
        
    });
    
    /*
     * 페이지 초기화
     * @param
     * @return
     */
    function pageInit() {
        
        bindEvent();
        
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
    		updatePackage();
        });
    	
    	$("input:checkbox[id='checkbox_confirm']").on('click', function(){
            var checked = $(this).is(":checked");
            // console.log('체크된 여부 : '+checked);
            if(checked == true) {
                $('.check_wrap').addClass('down');
                chkArr = chkArrTemp.slice();
                $("input:checkbox[name='checkbox']").prop("checked", true);
            }else {
                $('.check_wrap').removeClass('down');
                chkArr = [];
                $("input:checkbox[name='checkbox']").prop("checked", false);
            }
        });
    	
    }
    
    /*
     * 업로드 되어있는 프로세스 있는지 화면 구분
     * @param 
     * @return
     */
    function processViewCheck(id, version, cd) {
    	$("#packageNm").text(id);
        $("#version").text(version);
    	updCmpnyCd = cd;
        processUpdateList(id, updCmpnyCd);
    }
    
    function processUpdateList(id, updCmpnyCd){
       debugger;
        var url = "/resrce/package/processUpdateList?id=" + id + "&cmpnyCd=" + updCmpnyCd;
        $.ajax({
             type: "GET",
             url: url,
             processData: false,
             cache: false,
             dataType: "json",
             success: function (data) {
            	 console.log("data.result.resultList", data.result.resultList);
            	 console.log("data.result.resultList[0]", data.result.resultList[0]);
            	 if(data.result.resultList.length != 0 ){
            		 $("#processNotExist").hide();
                     $("#processExist").show();
                     $("#btnUpload").attr("disabled", false);
                     
            		 drawProcessList(data.result.resultList);
            	 } else {
            		 $("#processNotExist").show();
            		 $("#processExist").hide();
            		 $("#btnUpload").attr("disabled", true);
            	 }
             },
             error: function (e) {
             }
        });
    }
    
    //퍼블 사용
    function drawProcessList(data){
    	console.log("data", data);
    	console.log("data.length", data.length);
    	
    	$("#cntTxt").text(data.length + "개 프로세스를 업그레이드할 수 있습니다.");
    	
    	$.each(data, function(key, value){
    		var str = '';
    		
    		str += '<ul class="check_wrap-drop">';
	        str += '    <li>';
	        str += '        <div class="form-check">';
	        str += '            <input class="form-check-input" type="checkbox" name="checkbox" id="checkbox' + value.Id + '" value="' + value.Id + '"onchange="makeFilter(this);">';
	        str += '            <label class="form-check-label" for="checkbox' + value.Id + '">v' + value.ProcessVersion + ' - ' + value.EnvironmentName + '</label>';
	        str += '        </div>';
	        str += '    </li>';
            str += '</ul>';
            
            $("#processList").append(str);
            chkArrTemp.push(Number(value.Id));
            chkArr.push(Number(value.Id));
    	});
    }
    
    function makeFilter(target){
    	
        var chkVal = Number(target.value);
        var confirmCheck = target.checked;
        
        if(confirmCheck == true){
        	$(this).prop("checked", true);
            chkArr.push(chkVal);
		}else{
			$(this).prop("checked", false);
			chkArr.splice(chkArr.indexOf(chkVal), 1); 
			$("#checkbox_confirm").prop("checked", false);
		}
	}
    
    function updatePackage() {
    	if(chkArr != null){
    	    var confirm_test = confirm("선택된 프로세스를 업그레이드하시겠습니까?");
    		if ( confirm_test == true ) {
    			var url = "/resrce/package/updatePackageLatest"
    	        var param = {
    				"releaseIds" : chkArr,
    				"cmpnyCd"    : updCmpnyCd
    	        };
    	        callAsyncAjax(url, param, 'closePOP');
                searchPackageLibraryList();
    		} else if ( confirm_test == false ) {
    			return;
    		}
    	} else {
    		alert("체크박스를 선택해주세요.");
    	}
    }

</script>
