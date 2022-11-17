
//권한에 따른 다운로드 버튼 제외 페이지 여부
var isDownloadBtnRolePageAt = false;
//다운로드 버튼 권한 여부
var isDownloadBtnRoleAt = false;

function RpaUpload(paramDivId) {

	var divId = paramDivId;	//파일첨부화면을 보여줄 DIV 아이디
	
	var activity = true;	//활성화여부(true:활성화, false:비활성화)
	
	var fileGrpNo = 0;		//파일그룹번호

	if ($("#"+divId).length == 0) {
		alert("파일업로드 화면을 출력할 DIV가 유효하지 않습니다.");
		return;
	}
	
	//업로드/다운로드용 form 추가
	appendForm();

	/*
	 * 업로드영역을 그림
	 * @param paramFileGrpNo 파일그룹번호
	 * @param paramActivity 영역 활성화 여부
     * @return
	 */
	this.draw = function(paramFileGrpNo, paramActivity) {
		
		fileGrpNo = paramFileGrpNo;

		activity = paramActivity;

		if (fileGrpNo != null && fileGrpNo != undefined && fileGrpNo != "") {
			getFileInfo(fileGrpNo);
		} else {
			printFileArea();
		}
	}

    /*
     * 파일 업로드
     * @param
     * @return
     */
	this.upload = function() {
		
		if (fileGrpNo == 0 && $("#"+divId+" input[type='file']").length <= 1) {
			if ($("#"+divId+" input[type='file']")[0].files.length === 0) {
				//파일없음 리턴
				return 0;
			}
		}
		
		if (!checkTotalFileSize()) {
			//오류리턴
			return -1;
		}
		
		//업로드 form 에 데이터 추가
		$("#uploadForm").find("input").remove();
		$("#"+divId+" :input").each(function(e){
			$("#uploadForm").append(this);
		});
		
		
		//호출한 클라이언트에게 돌려줄 리턴값
		var returnFileGrpNo = 0;

    	$("#uploadForm").ajaxForm({
    		url: "/file/uploadAtchmnfl",
    		enctype: "multipart/form-data",
    		dataType: "json",
    		async:false,
    		success: function(data){
            	if (data.responseCode != null && data.responseCode != undefined && data.responseCode.substr(0, 1) == "E") {
            		alert(data.responseMessage);
            		returnFileGrpNo = -1;
            	} else {
            		/*data.length RespnseVO 로 받기때문에 result 추가  나타남*/
	    			if (data != null && data != undefined && data.result.length >= 1) {
	    				fileGrpNo = data.result[0].fileGrpNo;
	    			}
	    			printFileArea(data);
	    			//호출한 클라이언트에게 돌려줄 리턴값 설정
	    			returnFileGrpNo = fileGrpNo;
            	}
    		},
    		error: function(request, status, err){
    			alert(request.responseText);
    			
    			//호출한 클라이언트에게 돌려줄 리턴값 설정
    			returnFileGrpNo = -1;
    		}
    	});
    	
    	$("#uploadForm").submit();
    	
    	return returnFileGrpNo;
    }
	
	/*
     * 파일 사이즈 체크
     * @param
     * @return
	 */
	function checkFileSize(obj) {
		if (obj.files[0] != undefined && obj.files[0].size >= Number(52428800)) {
			alert("파일 하나의 크기는 50MB를 넘을 수 없습니다.");
			$(obj).val("");
		}
	}
	
	/*
     * 전체 파일정보 사이즈 체크
     * @param
     * @return
	 */
	function checkTotalFileSize() {
		
		var totalSize = Number(0);
		$("#"+divId+" input[type='file']").each(function(){
			var fileSize = 0;
			if ($(this)[0].files[0] != undefined) {
				fileSize = $(this)[0].files[0].size;
			}
			totalSize += Number(fileSize);
		});
		
		$("#"+divId+" input[name='fileSz']").each(function(){
			var fileSize = $(this).val();
			totalSize += Number(fileSize);
		});

		if (totalSize >= Number(524288000)) {
			alert("전체 파일 크기는 500MB를 넘을 수 없습니다.");
			return false;
		}
		
		return true;
	}
	
	/*
     * 파일정보 조회
     * @param
     * @return
	 */
	function getFileInfo(fileGrpNo) {
		var param = {fileGrpNo:fileGrpNo};
	    $.ajax({
	        type: 'post',
	        url: "/file/getAtchmnflList",
	        data : JSON.stringify(param),
	        dataType: "json",
	        contentType : "application/json;charset=UTF-8",
	        success: function(data) {
	        	printFileArea(data);
	        },
    		error: function(request, status, err){
    			alert(request.responseText);
    		}
	    });
		
	}
	
	/*
     * 파일 업로드/다운로드용 form 생성
     * @param
     * @return
	 */
	function appendForm() {

		$("body").append("<div id='divHidden' style='display:none;'></div>")
		
		var text = "";
		text += '<form id="uploadForm" name="uploadForm" method="post" enctype="multipart/form-data"></form>';
		text += '<form id="downloadForm" name="downloadForm" action="/file/downloadAtchmnfl" method="post">';
		text += '<input type="hidden" id="downloadFileGrpNo" name="fileGrpNo" value="" />';
		text += '<input type="hidden" id="downloadFileNo" name="fileNo" value="" />';
		text += '</form>';

		$("#divHidden").html(text);

	}
	
	/*
     * 파일영역 출력
     * @param
     * @return
	 */
	function printFileArea(fileInfoList) {
    /*result 추가..selectAtchmnfl,uploadAtchmnfl 모두 ResponseVO로 리턴되기 때문에, 밑에 if문 || fileInfoList == "" || fileInfoList.result == ""추가.. 파일 없이 등록 한 후 수정을 누를시 fileGrpNo가 없어 에러가 나타남*/
		$("#"+divId).html("");

		var text = "";

		if (fileInfoList == null || fileInfoList == undefined || fileInfoList.length < 1 || fileInfoList.result == "") {
			
			text += '<input type="hidden" id="fileGrpNo" name="fileGrpNo" value="" />';
			text += '<table id="tblUpload">';
			text += '<tbody>';
			text += '<tr id="trUpload0">';
			text += '<td>';
			text += '<input type="hidden" id="fileNo0" name="fileNo" value="0" />';
			text += '<input type="hidden" id="fileSz0" name="fileSz" value="0" />';
			text += '<input type="file" id="file0" name="file" style="width:100%;min-width:260px;line-height:130%"/>';
			text += '</td>';
			text += '<td>';
			text += '<input type="button" class="btn btn-outline-secondary float-left" style="margin:0 15px 0 5px;" id="btnDelFile0" name="delFile" value="삭제" />';
			text += '</td>';
			text += '</tr>';
			text += '</tbody>';
			text += '</table>';
			
		} else {
			
			text += '<input type="hidden" id="fileGrpNo" name="fileGrpNo" value="'+fileInfoList.result[0].fileGrpNo+'" />';
			text += '<table id="tblUpload">';
			text += '<tbody>';
			
			$.each(fileInfoList.result, function(idx, item){
				text += '<tr id="trUpload'+idx+'">';
				text += '<td>';
				text += '<input type="hidden" id="fileNo'+idx+'" name="fileNo" value="'+item.fileNo+'" />';
				text += '<input type="hidden" id="fileSz'+idx+'" name="fileSz" value="'+item.fileSz+'" />';
				text += '<input type="text" id="file'+idx+'" name="file" value="'+item.oriFileNm+'" disabled/>';
				text += '</td>';
				text += '<td>';
				text += '<input type="button" class="btn btn-outline-secondary float-left" style="margin:0 15px 0 5px;"id="btnDownFile'+idx+'" name="downFile" value="다운로드" />';
				text += '<input type="button" class="btn btn-outline-secondary float-left" style="margin:0 15px 0 5px;" id="btnDelFile'+idx+'" name="delFile" value="삭제" />';
				text += '</td>';
				text += '</tr>';
		    });
	    }

		text += '<table>';
		text += '<tbody>';
		text += '<tr>';
		text += '<td colspan="2">';
		text += '<input type="button" class="btn btn-secondary float-left" id="btnAdd" style="padding:3px 15px;" name="add" value="추가" />';
		text += '</td>';
		text += '</tr>';
		text += '</tbody>';
		text += '</table>';

		$("#"+divId).html(text);

		//활성화 여부에 따른 처리
		if (!activity) {	//비할성화인 경우 파일객체와 버튼들을 비활성화 한다.

			$("#"+divId+" input[type='file']").prop("disabled", true);
			$("#"+divId+" input[id^='btnDelFile']").prop("disabled", true);
			$("#"+divId+" btnAdd").prop("disabled", true);
			
		} else {	//활성화인 경우 객체와 버튼 이벤트 등록

	    	$("#"+divId+" input[id='btnAdd']").on("click", function(){
	    		addFile();
	    	});
	    	
	    	$("#"+divId+" input[id^='btnDelFile']").on("click", function(){
	    		deleteFile($(this).closest("tr").attr("id"));
	    	});
	    	
	    	$("#"+divId+" input[type='file']").on("change", function(){
	    		checkFileSize(this);
	    	});

		}

    	$("#"+divId+" input[id^='btnDownFile']").on("click", function(){
    		downloadFile($(this).closest("tr").attr("id"));
    	});

	}

    /*
     * 파일 추가
     * @param
     * @return
     */
    function addFile() {
    	
    	if ($("#tblUpload tbody tr").length >= 10) {
    		alert("첨부파일은 10개까지 추가 가능합니다.");
    		return;
    	}
    	
    	var lastTrId = $("#tblUpload tr").last().attr("id");
    	
    	if(lastTrId == null){
    		lastTrId = "trUpload0";
    	}
    	
    	var lastNum = lastTrId.replace("trUpload", "");
    	var newNum = Number(lastNum) + 1;
    	var newTrId = "trUpload" + newNum;
    	$("#tblUpload tbody").last().append($("<tr>").attr("id", newTrId));
    	$("#"+newTrId).last().append($("<td>"));
    	$("#"+newTrId + " td").last().append('<input type="hidden" id="fileNo'+newNum+'" name=fileNo value="0">');
    	$("#"+newTrId + " td").last().append('<input type="hidden" id="fileSz'+newNum+'" name=fileSz value="0">');
    	$("#"+newTrId + " td").last().append('<input type="file" style="width:100%;min-width:260px;line-height:130%" id="file' +newNum+'" name=file>');
    	$("#"+newTrId).last().append($("<td>"));
    	$("#"+newTrId + " td").last().append('<input type="button" class="btn btn-outline-secondary float-left" style="margin:0 15px 0 5px;" id="btnDelFile'+newNum+'" name=delFile value="삭제" />');
    	
    	$("#"+divId+" input[type='file']").on("change", function(){
    		checkFileSize(this);
    	});
    	
    	$("#"+divId+" input[id='btnDelFile"+newNum+"']").on("click", function(){
    		deleteFile(newTrId);
    	});
    }
    
    /*
     * 파일 삭제
     * @param
     * @return
     */
    function deleteFile(trId) {
    	$("#"+trId).remove();
    }
    
    /*
     * 파일 다운로드
     * @param
     * @return
     */
    function downloadFile(trId) {
    	var fileNo = $("#"+trId+" input[id^='fileNo']").val();
    	$("#downloadFileGrpNo").val(fileGrpNo);
    	$("#downloadFileNo").val(fileNo);
	    $("#downloadForm")[0].submit();
    }
	
}



function RpaUploadV2(paramDivId) {

	var divId = paramDivId;	//파일첨부화면을 보여줄 DIV 아이디
	
	var activity = true;	//활성화여부(true:활성화, false:비활성화)
	
	var fileGrpNo = 0;		//파일그룹번호

	if ($("#"+divId).length == 0) {
		alert("파일업로드 화면을 출력할 DIV가 유효하지 않습니다.");
		return;
	}
	
	//업로드/다운로드용 form 추가
	appendForm();

	/*
	 * 업로드영역을 그림
	 * @param paramFileGrpNo 파일그룹번호
	 * @param paramActivity 영역 활성화 여부
     * @return
	 */
	this.draw = function(paramFileGrpNo, paramActivity) {
		
		fileGrpNo = paramFileGrpNo;

		activity = paramActivity;

		if (fileGrpNo != null && fileGrpNo != undefined && fileGrpNo != "") {
			getFileInfo(fileGrpNo);
		} else {
			printFileArea();
		}
	}

    /*
     * 파일 업로드
     * @param
     * @return
     */
	this.upload = function() {
		
		if ((fileGrpNo == "" || fileGrpNo == 0) && $("#"+divId+" input[type='file']").length < 1) {
				//파일없음 리턴
				return 0;
		}
		
		if (!checkTotalFileSize()) {
			//오류리턴
			return -1;
		}
		
		//업로드 form 에 데이터 추가
		$("#"+divId+"_uploadForm").find("input").remove();
		$("#"+divId+" :input").each(function(e){
			$("#"+divId+"_uploadForm").append(this);
		});
		
		
		//호출한 클라이언트에게 돌려줄 리턴값
		var returnFileGrpNo = 0;

    	$("#"+divId+"_uploadForm").ajaxForm({
    		url: "/file/uploadAtchmnfl",
    		enctype: "multipart/form-data",
    		dataType: "json",
    		async:false,
    		success: function(data){
            	if (data.responseCode != null && data.responseCode != undefined && data.responseCode.substr(0, 1) == "E") {
            		alert(data.responseMessage);
            		returnFileGrpNo = -1;
            	} else {
            		/*data.length RespnseVO 로 받기때문에 result 추가  나타남*/
	    			if (data != null && data != undefined && data.result.length >= 1) {
	    				fileGrpNo = data.result[0].fileGrpNo;
	    			}
	    			printFileArea(data);
	    			//호출한 클라이언트에게 돌려줄 리턴값 설정
	    			returnFileGrpNo = fileGrpNo;
            	}
    		},
    		error: function(request, status, err){
    			alert(request.responseText);
    			
    			//호출한 클라이언트에게 돌려줄 리턴값 설정
    			returnFileGrpNo = -1;
    		}
    	});
    	
    	$("#"+divId+"_uploadForm").submit();
    	
    	return returnFileGrpNo;
    }
	
	/*
     * 파일 사이즈 체크
     * @param
     * @return
	 */
	function checkFileSize(obj) {
		if (obj.files[0] != undefined && obj.files[0].size >= Number(52428800)) {
			alert("파일 하나의 크기는 50MB를 넘을 수 없습니다.");
			$(obj).val("");
		}
	}
	
	/*
     * 전체 파일정보 사이즈 체크
     * @param
     * @return
	 */
	function checkTotalFileSize() {
		
		var totalSize = Number(0);
		$("#"+divId+" input[type='file']").each(function(){
			var fileSize = 0;
			if ($(this)[0].files[0] != undefined) {
				fileSize = $(this)[0].files[0].size;
			}
			totalSize += Number(fileSize);
		});
		
		$("#"+divId+" input[name='fileSz']").each(function(){
			var fileSize = $(this).val();
			totalSize += Number(fileSize);
		});

		if (totalSize >= Number(524288000)) {
			alert("전체 파일 크기는 500MB를 넘을 수 없습니다.");
			return false;
		}
		
		return true;
	}
	
	/*
     * 파일정보 조회
     * @param
     * @return
	 */
	function getFileInfo(fileGrpNo) {
		var param = {fileGrpNo:fileGrpNo};
	    $.ajax({
	        type: 'post',
	        url: "/file/getAtchmnflList",
	        data : JSON.stringify(param),
	        dataType: "json",
	        contentType : "application/json;charset=UTF-8",
	        success: function(data) {
	        	printFileArea(data);
	        },
    		error: function(request, status, err){
    			alert(request.responseText);
    		}
	    });
		
	}
	
	/*
     * 파일 업로드/다운로드용 form 생성
     * @param
     * @return
	 */
	function appendForm() {
		$("#"+divId+"divHidden").remove();
		$("body").append("<div id='"+divId+"divHidden' style='display:none;'></div>")
		
		var text = "";
		text += '<form id="'+divId+'_uploadForm" name="uploadForm" method="post" enctype="multipart/form-data"></form>';
		text += '<form id="'+divId+'_downloadForm" name="downloadForm" action="/file/downloadAtchmnfl" method="post">';
		text += '<input type="hidden" id="'+divId+'_downloadFileGrpNo" name="fileGrpNo" value="" />';
		text += '<input type="hidden" id="'+divId+'_downloadFileNo" name="fileNo" value="" />';
		text += '</form>';

		$("#"+divId+"divHidden").html(text);

	}
	
	/*
     * 파일영역 출력
     * @param
     * @return
	 */
	function printFileArea(fileInfoList) {
    /*result 추가..selectAtchmnfl,uploadAtchmnfl 모두 ResponseVO로 리턴되기 때문에, 밑에 if문 || fileInfoList == "" || fileInfoList.result == ""추가.. 파일 없이 등록 한 후 수정을 누를시 fileGrpNo가 없어 에러가 나타남*/
		$("#"+divId).html("");

		var text = "";

		if (fileInfoList == null || fileInfoList == undefined || fileInfoList.length < 1 || fileInfoList.result == "") {
			
			text += '<input type="hidden" id="fileGrpNo" name="fileGrpNo" value="" />';
			text += '<table id="tblUpload">';
			text += '<tbody>';
			text += '<tr id="trUpload0">';
			text += '<td>';
			text += '<input type="hidden" id="fileNo0" name="fileNo" value="0" />';
			text += '<input type="hidden" id="fileSz0" name="fileSz" value="0" />';
			text += '<input type="file" id="file0" name="file" style="width:100%;min-width:260px;line-height:120%"/>';
			text += '</td>';
			text += '<td>';
			text += '<input type="button" class="btn btn-outline-secondary float-left" style="margin:0 15px 0 5px;" id="btnDelFile0" name="delFile" value="삭제" />';
			text += '</td>';
			text += '</tr>';
			text += '</tbody>';
			text += '</table>';
			
		} else {
			
			text += '<input type="hidden" id="fileGrpNo" name="fileGrpNo" value="'+fileInfoList.result[0].fileGrpNo+'" />';
			text += '<table id="tblUpload">';
			text += '<tbody>';
			
			$.each(fileInfoList.result, function(idx, item){
				text += '<tr id="trUpload'+idx+'">';
				text += '<td>';
				text += '<input type="hidden" id="fileNo'+idx+'" name="fileNo" value="'+item.fileNo+'" />';
				text += '<input type="hidden" id="fileSz'+idx+'" name="fileSz" value="'+item.fileSz+'" />';
				text += '<input type="text" id="file'+idx+'" name="file" value="'+item.oriFileNm+'" disabled/>';
				text += '</td>';
				text += '<td>';
				
				if(isDownloadBtnRolePageAt){
					if(isDownloadBtnRoleAt){
						text += '<input type="button" class="btn btn-outline-secondary float-left" id="btnDownFile'+idx+'" name="downFile" value="다운로드" />';
					}
				}else{
					text += '<input type="button" class="btn btn-outline-secondary float-left" id="btnDownFile'+idx+'" name="downFile" value="다운로드" />';
				}
				
				text += '<input type="button" class="btn btn-outline-secondary float-left" style="margin:0 15px;" id="btnDelFile'+idx+'" name="delFile" value="삭제" />';
				text += '</td>';
				text += '</tr>';
		    });
	    }

		text += '<table>';
		text += '<tbody>';
		text += '<tr>';
		text += '<td colspan="2">';
		text += '<input type="button" class="btn btn-secondary float-left" id="btnAdd" style="padding:3px 15px;" name="add" value="추가" />';
		text += '</td>';
		text += '</tr>';
		text += '</tbody>';
		text += '</table>';

		$("#"+divId).html(text);

		//활성화 여부에 따른 처리
		if (!activity) {	//비할성화인 경우 파일객체와 버튼들을 비활성화 한다.

			$("#"+divId+" input[type='file']").prop("disabled", true);
			$("#"+divId+" input[id^='btnDelFile']").prop("disabled", true);
			$("#"+divId+" btnAdd").prop("disabled", true);
			
		} else {	//활성화인 경우 객체와 버튼 이벤트 등록

	    	$("#"+divId+" input[id='btnAdd']").on("click", function(){
	    		addFile();
	    	});
	    	
	    	$("#"+divId+" input[id^='btnDelFile']").on("click", function(){
	    		deleteFile($(this).closest("tr").attr("id"));
	    	});
	    	
	    	$("#"+divId+" input[type='file']").on("change", function(){
	    		checkFileSize(this);
	    	});

		}

    	$("#"+divId+" input[id^='btnDownFile']").on("click", function(){
    		downloadFile($(this).closest("tr").attr("id"));
    	});

	}

    /*
     * 파일 추가
     * @param
     * @return
     */
    function addFile() {
    	
    	if ($("#"+divId+ " #tblUpload tbody tr").length >= 10) {
    		alert("첨부파일은 10개까지 추가 가능합니다.");
    		return;
    	}
    	
    	var lastTrId = $("#"+divId+ " #tblUpload tr").last().attr("id");
    	
    	if(lastTrId == null){
    		lastTrId = "trUpload0";
    	}
    	
    	var lastNum = lastTrId.replace("trUpload", "");
    	var newNum = Number(lastNum) + 1;
    	var newTrId = "trUpload" + newNum;
    	$("#"+divId+ " #tblUpload tbody").last().append($("<tr>").attr("id", newTrId));
    	$("#"+divId+ " #"+newTrId).last().append($("<td>"));
    	$("#"+divId+ " #"+newTrId + " td").last().append('<input type="hidden" id="fileNo'+newNum+'" name=fileNo value="0">');
    	$("#"+divId+ " #"+newTrId + " td").last().append('<input type="hidden" id="fileSz'+newNum+'" name=fileSz value="0">');
    	$("#"+divId+ " #"+newTrId + " td").last().append('<input type="file" id="file'+newNum+'" name=file style="width:100%;min-width:260px;line-height:120%">');
    	$("#"+divId+ " #"+newTrId).last().append($("<td>"));
    	$("#"+divId+ " #"+newTrId + " td").last().append('<input type="button" class="btn btn-outline-secondary float-left" style="margin:0 15px 0 5px;" id="btnDelFile'+newNum+'" name="delFile" value="삭제">');
    	
    	$("#"+divId+" input[type='file']").on("change", function(){
    		checkFileSize(this);
    	});
    	
    	$("#"+divId+" input[id='btnDelFile"+newNum+"']").on("click", function(){
    		deleteFile(newTrId);
    	});
    }
    
    /*
     * 파일 삭제
     * @param
     * @return
     */
    function deleteFile(trId) {
    	$("#"+divId+ " #"+trId).remove();
    }
    
    /*
     * 파일 다운로드
     * @param
     * @return
     */
    function downloadFile(trId) {
    	var fileNo = $("#"+divId+ " #"+trId+" input[id^='fileNo']").val();
    	$("#"+divId+ "_downloadFileGrpNo").val(fileGrpNo);
    	$("#"+divId+ "_downloadFileNo").val(fileNo);
	    $("#"+divId+ "_downloadForm")[0].submit();
    }
}

//------------------------------------------------------------------------------------------
//RpaUploadType2 START
//------------------------------------------------------------------------------------------
function RpaUploadType2(paramDivId) {

	var divId = paramDivId;	//파일첨부화면을 보여줄 DIV 아이디
	
	var activity = true;	//활성화여부(true:활성화, false:비활성화)
	
	var fileGrpNo = 0;		//파일그룹번호

	if ($("#"+divId).length == 0) {
		alert("파일업로드 화면을 출력할 DIV가 유효하지 않습니다.");
		return;
	}
	
	//업로드/다운로드용 form 추가
	appendForm();
	
	this.setFileGrpNo = function(paramFileGrpNo){
		fileGrpNo = paramFileGrpNo;
	};

	/*
	 * 업로드영역을 그림
	 * @param paramFileGrpNo 파일그룹번호
	 * @param paramActivity 영역 활성화 여부
     * @return
	 */
	this.draw = function(paramFileGrpNo, paramActivity) {
		
		fileGrpNo = paramFileGrpNo;

		activity = paramActivity;

		if (fileGrpNo != null && fileGrpNo != undefined && fileGrpNo != "") {
			getFileInfo(fileGrpNo);
		} else {
			printFileArea();
		}
	}

    /*
     * 파일 업로드
     * @param
     * @return
     */
	this.upload = function() {
		
		if (fileGrpNo == 0 && $("#"+divId+" input[type='file']").length <= 1) {
			if ($("#"+divId+" input[type='file']")[0].files.length === 0) {
				//파일없음 리턴
				return 0;
			}
		}
		
		if (!checkTotalFileSize()) {
			//오류리턴
			return -1;
		}
		
		//업로드 form 에 데이터 추가
		$("#"+divId+"_uploadForm").find("input").remove();
		$("#"+divId+" :input").each(function(e){
			$("#"+divId+"_uploadForm").append(this);
		});
		
		
		//호출한 클라이언트에게 돌려줄 리턴값
		var returnFileGrpNo = 0;

    	$("#"+divId+"_uploadForm").ajaxForm({
    		url: "/file/uploadAtchmnfl",
    		enctype: "multipart/form-data",
    		dataType: "json",
    		async:false,
    		success: function(data){
            	if (data.responseCode != null && data.responseCode != undefined && data.responseCode.substr(0, 1) == "E") {
            		alert(data.responseMessage);
            		returnFileGrpNo = -1;
            	} else {
            		/*data.length RespnseVO 로 받기때문에 result 추가  나타남*/
	    			if (data != null && data != undefined && data.result.length >= 1) {
	    				fileGrpNo = data.result[0].fileGrpNo;
	    			}
	    			printFileArea(data);
	    			//호출한 클라이언트에게 돌려줄 리턴값 설정
	    			returnFileGrpNo = fileGrpNo;
            	}
    		},
    		error: function(request, status, err){
    			alert(request.responseText);
    			
    			//호출한 클라이언트에게 돌려줄 리턴값 설정
    			returnFileGrpNo = -1;
    		}
    	});
    	
    	$("#"+divId+"_uploadForm").submit();
    	
    	return returnFileGrpNo;
    }
	
	/*
     * 파일 사이즈 체크
     * @param
     * @return
	 */
	function checkFileSize(obj) {
		if (obj.files[0] != undefined && obj.files[0].size >= Number(52428800)) {
			alert("파일 하나의 크기는 50MB를 넘을 수 없습니다.");
			$(obj).val("");
		}
	}
	
	/*
     * 전체 파일정보 사이즈 체크
     * @param
     * @return
	 */
	function checkTotalFileSize() {
		
		var totalSize = Number(0);
		$("#"+divId+" input[type='file']").each(function(){
			var fileSize = 0;
			if ($(this)[0].files[0] != undefined) {
				fileSize = $(this)[0].files[0].size;
			}
			totalSize += Number(fileSize);
		});
		
		$("#"+divId+" input[name='fileSz']").each(function(){
			var fileSize = $(this).val();
			totalSize += Number(fileSize);
		});

		if (totalSize >= Number(524288000)) {
			alert("전체 파일 크기는 500MB를 넘을 수 없습니다.");
			return false;
		}
		
		return true;
	}
	
	/*
     * 파일정보 조회
     * @param
     * @return
	 */
	function getFileInfo(fileGrpNo) {
		var param = {fileGrpNo:fileGrpNo};
	    $.ajax({
	        type: 'post',
	        url: "/file/getAtchmnflList",
	        data : JSON.stringify(param),
	        dataType: "json",
	        contentType : "application/json;charset=UTF-8",
	        success: function(data) {
	        	printFileArea(data);
	        },
    		error: function(request, status, err){
    			alert(request.responseText);
    		}
	    });
	}
	
	/*
     * 파일 업로드/다운로드용 form 생성
     * @param
     * @return
	 */
	function appendForm() {
		$("#"+divId+"divHidden").remove();
		$("body").append("<div id='"+divId+"divHidden' style='display:none;'></div>")
		
		var text = "";
		text += '<form id="'+divId+'_uploadForm" name="uploadForm" method="post" enctype="multipart/form-data"></form>';
		text += '<form id="'+divId+'_downloadForm" name="downloadForm" action="/file/downloadAtchmnfl" method="post">';
		text += '<input type="hidden" id="'+divId+'_downloadFileGrpNo" name="fileGrpNo" value="" />';
		text += '<input type="hidden" id="'+divId+'_downloadFileNo" name="fileNo" value="" />';
		text += '</form>';

		$("#"+divId+"divHidden").html(text);

	}
	
	/*
     * 파일영역 출력
     * @param
     * @return
	 */
	function printFileArea(fileInfoList) {
    /*result 추가..selectAtchmnfl,uploadAtchmnfl 모두 ResponseVO로 리턴되기 때문에, 밑에 if문 || fileInfoList == "" || fileInfoList.result == ""추가.. 파일 없이 등록 한 후 수정을 누를시 fileGrpNo가 없어 에러가 나타남*/
		$("#"+divId).html("");

		var text = "";

		if (fileInfoList == null || fileInfoList == undefined || fileInfoList.length < 1 || fileInfoList.result == "") {
			
			text += '<input type="hidden" id="fileGrpNo" name="fileGrpNo" value="" />';
			text += '<table id="tblUpload">';
			text += '<tbody>';
			text += '<tr id="trUpload0">';
			text += '<td>';
			text += '<input type="hidden" id="fileNo0" name="fileNo" value="0" />';
			text += '<input type="hidden" id="fileSz0" name="fileSz" value="0" />';
			text += '<input type="file" id="file0" name="file" style="width:100%;min-width:260px;line-height:120%"/>';
			text += '</td>';
			text += '</tr>';
			text += '</tbody>';
			text += '</table>';
			
		} else {
			
			text += '<input type="hidden" id="fileGrpNo" name="fileGrpNo" value="'+fileInfoList.result[0].fileGrpNo+'" />';
			text += '<table id="tblUpload">';
			text += '<tbody>';
			
			$.each(fileInfoList.result, function(idx, item){
				text += '<tr id="trUpload'+idx+'">';
				text += '<td>';
				text += '<input type="hidden" id="fileNo'+idx+'" name="fileNo" value="'+item.fileNo+'" />';
				text += '<input type="hidden" id="fileSz'+idx+'" name="fileSz" value="'+item.fileSz+'" />';
				text += '<input type="text" id="file'+idx+'" name="file" value="'+item.oriFileNm+'" disabled/>';
				text += '</td>';
				text += '<td>';
				
				
				if(isDownloadBtnRolePageAt){
					if(isDownloadBtnRoleAt){
						text += '<input type="button" class="btn btn-outline-secondary float-left" id="btnDownFile'+idx+'" name="downFile" value="다운로드" />';
					}
				}else{
					text += '<input type="button" class="btn btn-outline-secondary float-left" id="btnDownFile'+idx+'" name="downFile" value="다운로드" />';
				}
				
				
				text += '<input type="button" class="btn btn-outline-secondary float-left" style="margin:0 15px;" id="btnChangeFile'+idx+'" name="changeFile" value="식제" />';
				text += '</td>';
				text += '</tr>';
		    });
	    }

		$("#"+divId).html(text);

		//활성화 여부에 따른 처리
		if (!activity) {	//비할성화인 경우 파일객체와 버튼들을 비활성화 한다.

			$("#"+divId+" input[type='file']").prop("disabled", true);
			$("#"+divId+" input[id^='btnDelFile']").prop("disabled", true);
			$("#"+divId+" btnAdd").prop("disabled", true);
			
		} else {	//활성화인 경우 객체와 버튼 이벤트 등록

	    	$("#"+divId+" input[id='btnAdd']").on("click", function(){
	    		addFile();
	    	});
	    	
	    	$("#"+divId+" input[id^='btnDelFile']").on("click", function(){
	    		deleteFile($(this).closest("tr").attr("id"));
	    	});
	    	
	    	$("#"+divId+" input[type='file']").on("change", function(){
	    		checkFileSize(this);
	    	});
	    	
	    	$("#"+divId+" input[id^='btnDelFile']").on("click", function(){
	    		deleteFile($(this).closest("tr").attr("id"));
	    	});
	    	
	    	$("#"+divId+" input[id^='btnChangeFile']").on("click", function(){
	    		deleteFile($(this).closest("tr").attr("id"));
	    		addFile();
	    	});
		}

    	$("#"+divId+" input[id^='btnDownFile']").on("click", function(){
    		downloadFile($(this).closest("tr").attr("id"));
    	});

	}

    /*
     * 파일 추가
     * @param
     * @return
     */
    function addFile() {
    	
    	if ($("#"+divId+ " #tblUpload tbody tr").length >= 10) {
    		alert("첨부파일은 10개까지 추가 가능합니다.");
    		return;
    	}
    	
    	var lastTrId = $("#"+divId+ " #tblUpload tr").last().attr("id");
    	
    	if(lastTrId == null){
    		lastTrId = "trUpload0";
    	}
    	
    	var lastNum = lastTrId.replace("trUpload", "");
    	var newNum = Number(lastNum) + 1;
    	var newTrId = "trUpload" + newNum;
    	$("#"+divId+ " #tblUpload tbody").last().append($("<tr>").attr("id", newTrId));
    	$("#"+divId+ " #"+newTrId).last().append($("<td>"));
    	$("#"+divId+ " #"+newTrId + " td").last().append('<input type="hidden" id="fileNo'+newNum+'" name=fileNo value="0">');
    	$("#"+divId+ " #"+newTrId + " td").last().append('<input type="hidden" id="fileSz'+newNum+'" name=fileSz value="0">');
    	$("#"+divId+ " #"+newTrId + " td").last().append('<input type="file" id="file'+newNum+'" name=file style="width:100%;min-width:260px;line-height:120%">');
    	
    	$("#"+divId+ " #"+newTrId).last().append($("<td>"));
//	    	$("#"+divId+ " #"+newTrId + " td").last().append('<input type="button" class="btn btn-outline-secondary float-left" style="margin:0 15px;" id="btnDelFile'+newNum+'" name=delFile value="삭제" />');
    	
    	$("#"+divId+" input[type='file']").on("change", function(){
    		checkFileSize(this);
    	});
    	
    	$("#"+divId+" input[id='btnDelFile"+newNum+"']").on("click", function(){
    		deleteFile(newTrId);
    	});
    }
    
    /*
     * 파일 삭제
     * @param
     * @return
     */
    function deleteFile(trId) {
    	$("#"+divId+ " #"+trId).remove();
    }
    
    /*
     * 파일 다운로드
     * @param
     * @return
     */
    function downloadFile(trId) {
    	var fileNo = $("#"+divId+ " #"+trId+" input[id^='fileNo']").val();
    	$("#"+divId+ "_downloadFileGrpNo").val(fileGrpNo);
    	$("#"+divId+ "_downloadFileNo").val(fileNo);
	    $("#"+divId+ "_downloadForm")[0].submit();
    }
}

//------------------------------------------------------------------------------------------
//RpaUploadType2 END
//------------------------------------------------------------------------------------------