$(document).ready(function(){

//	$("input:text[numberOnly]").on("focus", function() {
//	    var x = $(this).val();
//	    x = removeCommas(x);
//	    $(this).val(x);
//	}).on("focusout", function() {
//	    var x = $(this).val();
//	    if(x && x.length > 0) {
//	        if(!$.isNumeric(x)) {
//	            x = x.replace(/[^0-9]/g,"");
//	        }
//	        x = addCommas(x);
//	        $(this).val(x);
//	    }
//	}).on("keyup", function() {
//	    $(this).val($(this).val().replace(/[^0-9]/g,""));
//	});
	
//숫자만 입력 가능
	$(document)
		.on("focus", "input:text[numberOnly]", function() {
		    var x = $(this).val();
		    x = removeCommas(x);
		    $(this).val(x);
		}).on("focusout", "input:text[numberOnly]", function() {
		    var x = $(this).val();
		    if(x && x.length > 0) {
		        if(!$.isNumeric(x)) {
		            x = x.replace(/[^0-9]/g,"");
		        }
		        x = addCommas(x);
		        $(this).val(x);
		    }
		}).on("keyup", "input:text[numberOnly]", function() {
		    $(this).val($(this).val().replace(/[^0-9]/g,""));
		});
	
	
	//콤마없이 숫자만 입력 가능 
	$(document)
		.on("focus", "input:text[numberOnlyNoComma]", function() {
		    var x = $(this).val();
		    x = removeCommas(x);
		    $(this).val(x);
		}).on("focusout", "input:text[numberOnlyNoComma]", function() {
		    var x = $(this).val();
		    if(x && x.length > 0) {
		        if(!$.isNumeric(x)) {
		            x = x.replace(/[^0-9]/g,"");
		        }
		        if (x.indexOf('.')){
	                var two = /^\d*[.]\d{2}$/;
	                if(!two.test(x)){
	                    x = x.slice(0,4);
	                }
	            }else{
	                x = addCommas(x);
	            }
		        $(this).val(x);
		    }
		}).on("keyup", "input:text[numberOnlyNoComma]", function() {
		    $(this).val($(this).val().replace(/[^0-9]/g,""));
		});
	

//숫자, 영문만 입력 가능
	$(document)
		.on("focusout", "input:text[numberEnglish]", function() {
			$(this).val(($(this).val().replace(/[^0-9A-Za-z]/g,"")).toUpperCase());
		})
		.on("keyup", "input:text[numberEnglish]", function() {
			$(this).val(($(this).val().replace(/[^0-9A-Za-z]/g,"")).toUpperCase());
		});
	});



// 소수점 첫번째 자리까지만 입력 가능
$(document)
	.on("focusin", "input:text[decimalNumberType1]", function() {
		$(this).val($(this).val().replace(/[^0-9\.]/g,""));
	})
	.on("focusout", "input:text[decimalNumberType1]", function() {
			var x = $(this).val();
		    if(x && x.length > 0) {
		        if(!$.isNumeric(x)) {
		            x = x.replace(/[^0-9\.]/g,"");
		        }
		        x = addCommas(x);
		        if(x.indexOf(".") == (x.length -1)){
		        	x = x.substring(0, x.length -1)
		        }
		        $(this).val(x);
		    }
		})
	.on("keydown", "input:text[decimalNumberType1]", function(evt) {
		var value = $(this).val();
		var iCode = evt.which ? evt.which :  event.keyCode;
			
		var pattern = /^\d*[.]\d{1}$/;
		if(pattern.test(value)){
			//console.log("iCode: " + iCode)
			if(iCode == 110 || iCode == 190){
				return false;
			}
			else if(iCode == 8 || iCode == 9 || iCode == 46 || (iCode > 47 && iCode < 59) || (iCode > 95 && iCode < 106) || (iCode > 36 && iCode < 41)){}
			else{
				return false;
			}
		}
	})
	.on("keyup", "input:text[decimalNumberType1]", function() {
			
			$(this).val($(this).val().replace(/[^0-9\.]/g,""));

			var pattern = /^\d{1,}(\.)?(\d{1})?/
			var matchArray = pattern.exec($(this).val());
			if(matchArray == null){
				$(this).val("");
			}
			else{
				$(this).val(matchArray[0]);
			}
		});
	



//3자리 단위마다 콤마 생성
function addCommas(x) { 
    return x != null ?  x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") : '';
}
//모든 콤마 제거
function removeCommas(x) {
    if(!x || x.length == 0) return "";
    else return x.split(",").join("");
}


/*
 * 공통코드 콤보 박스 데이터 요청
 * 사용예 :
 *   var params = [];
 *   var param = {"id" : "cbxPst", "clsCd" : "0001"};
 *   params.push(param);
 * @param : {id : 콤보박스의 selector id , clsCd : 분류코드} 배열
 * @return
 */
function requestCmmnCd(params) {
	$.each(params, function(index, item) {
		var param = {};
		param.clsCd = item.clsCd;
        $.ajax({
            type: "post",
	        url: "/stdrinfo/cmmncd/getCmmnCdListByClsCd",
	        async: false,
	        dataType: "json",
	        contentType : "application/json;charset=UTF-8",
	        data: JSON.stringify(param),
	        success : function(data){
	            if (data.responseCode != null && data.responseCode != undefined && data.responseCode.substr(0, 1) != "E") {
	            	var tmp = '';
	            	
	            	//<option value=''>선택</option> 노출 여부
	            	tmp = item.emptyOption == "Y" ? "" : "<option value=''>선택</option>"; 

	            	//제외할 value
        			if(item.exclusionList == undefined && item.includeList == undefined){
		            	$.each(data.result, function(idx, cd) {
		            			tmp += "<option value='" + cd.cd + "'>" + cd.cdNm + "</option>";
		            		});
	            	}
        			else if(item.includeList != undefined){
        				const aIncludeList = item.includeList;
        				$.each(data.result, function(idx, cd) {
	            			if(aIncludeList[cd.cd] != undefined){
	            				tmp += "<option value='" + cd.cd + "'>" + cd.cdNm + "</option>";
	            			}
	            		});
        			}
	            	else{
	            		var aExclusionList = item.exclusionList
	            		$.each(data.result, function(idx, cd) {
	            			if(aExclusionList[cd.cd] == undefined){
	            				tmp += "<option value='" + cd.cd + "'>" + cd.cdNm + "</option>";
	            			}
	            		});
	            	}
	            	
	            	var oObj = $("#"+item.id);
	            	oObj.html(tmp);
	            	
	            	//value 선택
	            	if(item.selectValue != undefined && item.selectValue != ""){
	            		oObj.find('option[value=' + item.selectValue +']').attr('selected','selected');
	            	}
	            	
	            	//disabled 처리 여부
	            	if(item.disable == "Y"){
	            		oObj.attr("disabled", true);
	            	}
	            }
            },
            error: function(request, status, err){
                alert(request.responseText);
            }
        });
	});
}

/*
 * jsGrid 페이징 초기화
 * @param pagerId : 그리드 페이저 jquery id      
 * @param callbackName : 그리드조회 함수명
 * @return
 */
function drawPager(pagerId, paginationInfo, callbackName) {

	var pagingHtml = "";
	
    if (paginationInfo.currentPageNo > paginationInfo.pageSize) {
    	pagingHtml += '<a id="firstPage" class="portal-pager-cell" title="처음" href="javascript:callPagingCallback(\''+callbackName+'\','+ 1 +');"><font style="font-weight: 300;"><<</font></a>';
    }

    if (paginationInfo.firstPageNoOnPageList > 1) {
    	pagingHtml += '<a id="prevPage" class="portal-pager-cell" title="이전" href="javascript:callPagingCallback(\''+callbackName+'\','+ Number(paginationInfo.firstPageNoOnPageList -1) +');"><font style="font-weight: 300;"><</font></a>';
    }
    
    for (var i = paginationInfo.firstPageNoOnPageList ; i <= paginationInfo.lastPageNoOnPageList ; i++) {
    	if (paginationInfo.currentPageNo == i) {
    		pagingHtml += '<a class="portal-pager-cell" href="javascript:callPagingCallback(\''+callbackName+'\','+ i +');"><strong  class="current_page">'+i+'</strong></a>';
    	} else {
    		pagingHtml += '<a class="portal-pager-cell" href="javascript:callPagingCallback(\''+callbackName+'\','+ i +');">'+i+'</a>';
    	}
    }
    
    if (paginationInfo.totalPageCount > paginationInfo.lastPageNoOnPageList) {
    	pagingHtml += '<a id="nextPage" class="portal-pager-cell" title="다음" href="javascript:callPagingCallback(\''+callbackName+'\','+ Number(paginationInfo.currentPageNo + 1) +');"><font style="font-weight: 200;">></font></a>';
    }
    
    if (paginationInfo.currentPageNo <= (paginationInfo.totalPageCount - (paginationInfo.totalPageCount % paginationInfo.pageSize))) {
    	pagingHtml += '<a id="lastPage" class="portal-pager-cell" title="마지막" href="javascript:callPagingCallback(\''+callbackName+'\','+ paginationInfo.totalPageCount + ');"><font style="font-weight: 200;">>></font></a>';
    }
    
    pagingHtml += '<div class="float-right" style="font-size:13px; color:#666666;"> <strong>';
    pagingHtml += paginationInfo.currentPageNo + ' </strong> of ' + paginationInfo.totalPageCount + ' </div><div class="float-left" style="font-size:13px; color:#4b5eb5;">총 건수 : ' + paginationInfo.totalRecordCount + '</div> ';
    	
    $("#"+pagerId).html(pagingHtml);
	
}

/*
 * 페이징 콜백함수 호출
 * @param
 * @return
 */
function callPagingCallback(callbackName, data) {
	if (callbackName != null && callbackName != undefined) {
	    var fn = window[callbackName];
	    if (typeof fn === "function") {
	    	fn(data);
	    }
	}
}

/*
 * 현재월을 기준으로 입력된 월만큼 차이의 년월을 리턴
 * @param 월차이(예시 : 한달전 -1, 두달후 2)
 * @return
 */
function getYearMonth(gapMonth) {
	
	var currentDate = new Date();
	
	var date = new Date(currentDate.getFullYear(), currentDate.getMonth(), 1);

	date.setMonth(date.getMonth() + gapMonth);

	var year = date.getFullYear();
	
	var month = date.getMonth() + 1;
	if (Number(month) < Number(10)) {
		month = "0" + month;
	}

	return ("" + year + month);
}

function getYearMonth2(gapMonth) {
	
	var currentDate = new Date();
	
	var date = new Date(currentDate.getFullYear(), currentDate.getMonth() + 24, currentDate.getDate() -1);

	var year = date.getFullYear();
	
	var month = date.getMonth() + 1;
	
	var day = date.getDate();
	
	if (Number(month) < Number(10)) {
		month = "0" + month;
	}
	
	if (Number(day) < Number(10)) {
		day = "0" + day;
	}

	return ("" + year + month + day);
}

/*
 * 현재일을 기준으로 입력된 월만큼 차이의 년월일을 리턴
 * @param 월차이(예시 : 한달전 -1, 두달후 2)
 * @return
 */
function getMonthGapDate(gapMonth) {
	
	var date = new Date();

	date.setMonth(date.getMonth() + gapMonth);
	
	var nextDate = new Date(date.getFullYear(), date.getMonth(), date.getDate());
	
	if (nextDate.getMonth() == date.getMonth()) {
		date.setDate(date.getDate() + 1);
	} else {
		nextDate = new Date(date.getFullYear(), date.getMonth() + 1, -1);
		date.setDate(nextDate.getDate());
	}

	var year = date.getFullYear();
	
	var month = date.getMonth() + 1;
	if (Number(month) < Number(10)) {
		month = "0" + month;
	}

	var day = date.getDate();
	if (Number(day) < Number(10)) {
		day = "0" + day;
	}

	return ("" + year + month + day);
	
}

/*
 * 상세페이지를 특정 DIV 에 추가
 * @param div아이디
 * @param 페이지 URL
 * @return
 */
function appendDetailPopup(divId, url, callbackFunc, params){
	var params = params;
    var html = "";
    html += '<div id="overPage2" class="over"></div>';
    $("#" + divId).append(html);
    $.ajax({
        url : url,
        dataType : "html",
        type : "GET",
        async : false,
        success : function(result){
            $("#overPage2").html(result);
            if (callbackFunc != null && callbackFunc != undefined) {
                var fn = window[callbackFunc];
                if (typeof fn === "function") {
       	            if (params != null && params != undefined) {
       	            	//setTimeout(() => fn(params), 500);
       	            	setTimeout(function(){fn(params)}, 500);
       	            }
       	            else{
       	            	//setTimeout(() => fn(), 500);
       	            	setTimeout(function(){fn(params)}, 500);
       	            }
                    
                }
            }
        }
    });
}

function appendDetailPopupType2(divId, url, callbackFunc, params){
	var params = params;
	$.ajax({
        url : url,
        dataType : "html",
        type : "GET",
        async : false,
        success : function(result){
            $("#" + divId).html(result);
            $("#" + divId).modal('show');
            
            var fn = window[callbackFunc];
            if (typeof fn === "function") {
   	            if (params != null && params != undefined) {
   	            	//setTimeout(() => fn(params), 500);
   	            	setTimeout(function(){fn(params)}, 200);
   	            }
   	            else{
   	            	//setTimeout(() => fn(), 500);
   	            	setTimeout(function(){fn(params)}, 200);
   	            }
            }
        }
    });
}

function appendCardDiv(divId, url, callbackFunc, params){
	var params = params;
    var html = "";
    $("#" + divId).append(html);
    $.ajax({
        url : url,
        dataType : "html",
        type : "GET",
        async : true,
        success : function(result){
        	$("#" + divId).html(result);
            if (callbackFunc != null && callbackFunc != undefined) {
                var fn = window[callbackFunc];
                if (typeof fn === "function") {
       	            if (params != null && params != undefined) {
       	            	//setTimeout(() => fn(params), 500);
       	            	setTimeout(function(){fn(params)}, 200);
       	            }
       	            else{
       	            	//setTimeout(() => fn(), 500);
       	            	setTimeout(function(){fn(params)}, 200);
       	            }
                    
                }
            }
        }
    });
}

/*
 * 세자리수 콤마 찍기
 * @param
 * @return
 */
function commify(n) {
	var reg = /(^[+-]?\d+)(\d{3})/;
	n = (new String(n)).replace(/,/g,"").replace(/[^0-9]/g,"");
	while (reg.test(n)) {
		n = n.replace(reg, '$1,$2');
	}
	return n;
}

/*
 * 콤마제거
 * @param
 * @return
 */
function uncommify(n) {
	return n.replace(/,/g,"");
}

/*
 * 전화번호 하이픈 자동추가
 * @param
 * @return
 */
function hyphenationPhoneNum(n) {
	var reg = /(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/;
	n = (new String(n)).replace(/-/g,"").replace(/[^0-9]/g,"");
	while (reg.test(n)) {
		n = n.replace(reg, "$1-$2-$3");
	}
	return n;
}

/*
 * 하이픈제거
 * @param
 * @return
 */
function unhyphenationPhoneNum(n) {
	return n.replace(/-/g,"");
}

/*
 * 일자 하이픈 추가
 * @param
 * @return
 */
function hyphenationDe(de) {
	var reg = /(^19\d{2}|^20\d{2})(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[0-1])/;
	de = de.replace(/[^0-9]/g,"");
	while (reg.test(de)) {
		de = de.replace(reg, "$1-$2-$3");
	}
	return de;
}

/*
 * 일자 하이픈 제거
 * @param
 * @return
 */
function unhyphenationDe(de) {
	return de.replace(/-/g, "");
}

/*
 * 그룹웨어 사용자 조회 팝업 열기
 * @param div 아이디
 * @param 콜백함수명
 * @return
 */
function openGwpwrUserPopup(divId, callbackName) {
    var url = "/gwpwr/user/gwpwrUserPop";
    $.ajax({
        url : url,
        dataType : "html",
        type : "GET",
        async : false,
        success : function(result){
            $("#" + divId).html(result);
            $("#" + divId).modal('show');
            $("#btnGwpwrSelect").on("click", function(){
            	if ($("#gwpwrGrid").jsGrid("option", "selectData") == null || $("#gwpwrGrid").jsGrid("option", "selectData") == "") {
            		alert("사원을 선택하셔야 합니다.");
            		return;
            	}
            	if (callbackName != null && callbackName != undefined) {
            	    var fn = window[callbackName];
            	    if (typeof fn === "function") {
            	    	fn($("#gwpwrGrid").jsGrid("option", "selectData"));
            	    }
            	}
            	$("#" + divId).modal('hide');
            });
        }
    });
}

/*
 * 그룹웨어 사용자 조회 팝업 열기V2
 * @param div 아이디
 * @param 콜백함수명
 * @return
 */
function openGwpwrUserPopupV2(divId, callbackName, cmpnyCd) {
    var url = "/gwpwr/user/gwpwrUserPopV2";
    $.ajax({
        url : url,
        dataType : "html",
        type : "GET",
        async : false,
        success : function(result){
            $("#" + divId).html(result);
            $("#" + divId).modal('show');
            
            if(cmpnyCd != null && cmpnyCd != undefined){
            	$("#gwpwrCmpnyCd").val(cmpnyCd);
            }
            
            $("#btnGwpwrSelect").on("click", function(){
            	if ($("#gwpwrGrid").jsGrid("option", "selectData") == null || $("#gwpwrGrid").jsGrid("option", "selectData") == "") {
            		alert("사원을 선택하셔야 합니다.");
            		return;
            	}
            	if (callbackName != null && callbackName != undefined) {
            	    var fn = window[callbackName];
            	    if (typeof fn === "function") {
            	    	fn($("#gwpwrGrid").jsGrid("option", "selectData"));
            	    }
            	}
            	$("#" + divId).modal('hide');
            });
        }
    });
}

/*
 * 그룹웨어 부서 조회 팝업 열기
 * @param div 아이디
 * @param 콜백함수명
 * @return
 */
function openGwpwrDeptPopup(divId, callbackName) {
    var url = "/gwpwr/dept/gwpwrDeptPop";
    $.ajax({
        url : url,
        dataType : "html",
        type : "GET",
        async : false,
        success : function(result){
            $("#" + divId).html(result);
            $("#" + divId).modal('show');
            $("#btnGwpwrSelect").on("click", function(){
            	var nodeId = $("#gwpwrDeptTree").jstree("get_selected");
            	if (nodeId == null || nodeId == "") {
            		alert("부서를 선택하셔야 합니다.");
            		return;
            	}
            	var nodeData = $("#gwpwrDeptTree").jstree("get_node", nodeId);
            	if (callbackName != null && callbackName != undefined) {
            	    var fn = window[callbackName];
            	    if (typeof fn === "function") {
            	    	fn(nodeData.original);
            	    }
            	}
            	$("#" + divId).modal('hide');
            });
        }
    });
}





/*
 * 프로세스 코드 콤보 박스 데이터 요청
 * 사용예 :
 * @param : id 
 * @return
 */
function getProcessCdListByClsCd(id, searchCmpnyCd) {
		var param = {};
		
		if(searchCmpnyCd != ""){
			param.searchCmpnyCd = searchCmpnyCd;
		}
	
		
        $.ajax({
            type: "post",
	        url: "/resrce/process/getProcessCdListByClsCd",
	        async: false,
	        dataType: "json",
	        contentType : "application/json;charset=UTF-8",
	        data: JSON.stringify(param),
	        success : function(data){ 
	            if (data.responseCode != null && data.responseCode != undefined && data.responseCode.substr(0, 1) != "E") {
	            	var tmp = '';
	            	tmp = "<option value=''>선택</option>";
	            	$.each(data.result, function(idx, cd) {
	            		tmp += "<option value='" + cd.processCd + "'>" + "(" + cd.processCd +")" + cd.processNm + "</option>";
	                });

	            	$("#"+id).html(tmp);
	            }
            },
            error: function(request, status, err){
                alert(request.responseText);
            }
	});
}


/*
 * 과제 코드 콤보 박스 데이터 요청
 * 사용예 :
 * @param : id 
 * @return
 */
function getTaskCdListByClsCd(id) {
		var param = {};
        $.ajax({
            type: "post",
	        url: "/task/develop/getTaskCdListByClsCd",
	        async: false,
	        dataType: "json",
	        contentType : "application/json;charset=UTF-8",
	        data: JSON.stringify(param),
	        success : function(data){ 
	            if (data.responseCode != null && data.responseCode != undefined && data.responseCode.substr(0, 1) != "E") {
	            	
	            	var tmp = '';
	            	tmp = "<option value=''>선택</option>";
	            	$.each(data.result, function(idx, cd) {
	            		tmp += "<option value='" + cd.devlopSn + "'>" + cd.taskCd + "</option>";
	                });

	            	$("#"+id).html(tmp);
	            }
            },
            error: function(request, status, err){
                alert(request.responseText);
            }
	});
}


function cmmn_makeYear(sJqueryId, iCreateYear){
	if(sJqueryId != undefined && sJqueryId != "" && iCreateYear != undefined && iCreateYear != ""){
		var sHtml = ""
		var oCurrentDate = new Date()
		var iStartYear = oCurrentDate.getFullYear();
		for(var i = 0; i < iCreateYear; i++){
			var iVewYear = iStartYear - i;
			sHtml += '<option value="'+ iVewYear +'">' + iVewYear + '</option>';
			if(iVewYear == 2019){
				break;
			}
		}
		
		$("#"+ sJqueryId).html(sHtml);
	}
}


function cmmn_makeMonth(sJqueryId){
    if(sJqueryId != undefined && sJqueryId != ""){
        var sHtml = ""
        for(var i = 0; i < 12; i++){
            var iMonth = i + 1;
            sHtml += '<option value="'+ iMonth +'">' + iMonth + '</option>';
        }
        
        $("#"+ sJqueryId).html(sHtml);
    }
}


function GBL_createSearchResultComboBox(params) {
	let tmp = '';
	            
	const aResultList = params.resultList;
	const iaResultList = aResultList.length;
	const sOptVal = params.optVal; 
	const sOptNm = params.optNm;
	const sAddNm = params.addNm;
	//<option value=''>선택</option> 노출 여부

	if(params.emptyOption != "Y"){
		tmp = "<option value=''>" + (params.emptyText == undefined ?  "총 " + iaResultList +"건이 검색되었습니다." : params.emptyText) + "</option>";
	}
	
	for(let i = 0; i < iaResultList; i++){
		let oTemp = aResultList[i];
		
		if(params.viewType == 2){
			tmp += "<option value='" + oTemp[sOptVal] + "'>(" + oTemp[sOptVal] + ")" + oTemp[sOptNm] + "</option>";
		}
		else{
			
			if(params.addNm == "state"){
				let sAddtext = "";
				if(oTemp[sAddNm] == 0){
					Addtext = "(사용 가능)";
				}
				else if(oTemp[sAddNm] == 1){
					Addtext = "(사용 중)";
				}
				else if(oTemp[sAddNm] == 2){
					Addtext = "(연결 끊김)";
				}
				else if(oTemp[sAddNm] == 3){
					Addtext = "(응답 없음)";
				}
				tmp += "<option value='" + oTemp[sOptVal] + "'>" + Addtext + oTemp[sOptNm] + "</option>";
			}
			else{
				tmp += "<option value='" + oTemp[sOptVal] + "'>" + oTemp[sOptNm] + "</option>";
			}	
			
			
		}
		
		
	}
	
	var oObj = $("#"+params.id);
	oObj.html(tmp);
	
	//value 선택
	if(params.selectValue != undefined && params.selectValue != ""){
		oObj.val(params.selectValue);
		//oObj.find('option[value=' + params.selectValue +']').attr('selected','selected');
	}

}

function GBL_makeLoading(sLoadingId){
//	console.log("function GBL_makeLoading: " + sLoadingId);
	let sHtml = '<div id="loading_div'+ sLoadingId +'" class="dimmed"></div>';
	sHtml += '<div id="loading_img'+ sLoadingId +'" class="loading show">';
	sHtml += '<div class="loading-bar"><div></div><div></div><div></div><div></div></div>';
	sHtml += '	<span class="loading-text">로딩 중...</span>';
	sHtml += '</div>';
	$(document.body).append(sHtml);
}

function GBL_removeLoading(sLoadingId){
//	console.log("function GBL_removeLoading: " + sLoadingId);
	$("#loading_div" + sLoadingId).remove();
	$("#loading_img" + sLoadingId).remove();
}


function GBL_formatDate(date){
	let d = date instanceof Date ? date :new Date(date);
	let month = '' + (d.getMonth() + 1)
	let day = '' + d.getDate()
	let year = d.getFullYear()

	if (month.length < 2) 
	    month = '0' + month;
	if (day.length < 2) 
	    day = '0' + day;
	
	return [year, month, day].join('-');
}


function GBL_dateDiff(_date1, _date2) {
    var diffDate_1 = _date1 instanceof Date ? _date1 :new Date(_date1);
    var diffDate_2 = _date2 instanceof Date ? _date2 :new Date(_date2);
 
    diffDate_1 =new Date(diffDate_1.getFullYear(), diffDate_1.getMonth()+1, diffDate_1.getDate());
    diffDate_2 =new Date(diffDate_2.getFullYear(), diffDate_2.getMonth()+1, diffDate_2.getDate());
 
    var diff = Math.abs(diffDate_2.getTime() - diffDate_1.getTime());
    diff = Math.ceil(diff / (1000 * 3600 * 24));
 
    return diff;
}




function GBL_lpad(str, padLen, padStr) {
    if (padStr.length > padLen) {
        console.log("오류 : 채우고자 하는 문자열이 요청 길이보다 큽니다");
        return str;
    }
    str += ""; // 문자로
    padStr += ""; // 문자로
    while (str.length < padLen)
        str = padStr + str;
    str = str.length >= padLen ? str.substring(0, padLen) : str;
    return str;
}


function GBL_array_find(aTempData, sKey, sSelectVal){
	if(aTempData == null || aTempData == undefined){
		return null;
	}
	
	const iaTempData = aTempData.length;
	for(let i = 0; i < iaTempData; i++){
		const oaTempData = aTempData[i]
		if(sSelectVal == oaTempData[sKey]){
			return oaTempData;
		}
	}
}