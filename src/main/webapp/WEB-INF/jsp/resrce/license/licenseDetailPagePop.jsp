<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="card card-primary">
    <div class="card-header">
        <h3 class="card-title">상세</h3>
    </div>
    <div class="card-body">
	    <div class="col-md-12">
            <div>
                <div id="licenseGrid"></div>
                <div id="licenseGrid2"></div>               
            </div>  
	        
	        <div class="col-md-12">
            </div>

	        <div class="float-right">
	            <button type="button" class="btn btn-primary" id="cancel42">닫기</button>
	        </div> 
	    </div>
	</div>
</div>

<script>


	/*
	 * 페이지 초기화
	 * @param
	 * @return
	 */
	$(document).ready(function() {
	    
	    //페이지 초기화
	    pageInit();
	    
	    //이벤트 바인딩
	    bindEvent();
	});

	function bindEvent(){
	          
        $("#cancel42").on("click",function(){
            $(".over").remove();
        });
        
    }

	/*
	 * 상세 데이터 출력 API LicensesNamedUser GET 
	 * @param
	 * @return
	 */ 
	function getLicenseDetailList(data , data2){
		
		console.log("getLicenseDetailList 넘어온값888888888888888" + data + "urltype"  +data2);
		
		if(data == "NamedUser"){
			var url = "/resrce/license/getLicenseDetailList";
			var param = {"urltype" : data2}
			
			callAsyncAjax(url, param, "drawGrid");
		}else if(data == "Runtime"){
			var url = "/resrce/license/getLicenseDetailList2";
			var param = {"urltype" : data2}
			
			callAsyncAjax(url, param, "drawGrid2");
		}else{
			alert("예외발생");
		}
	}
	
	/*
	* false 찾기 license 조회 분기처리
	* @param
	* @return
	*/ 
	function findFalse(data){
	   
	   console.log("findFalse 넘어온값777777777777777777" + JSON.stringify(data));
	   console.log("findFalse 넘어온값777777777777777777" + JSON.stringify(data.result.resultList.AttendedConcurrent));
	   console.log("findFalse 넘어온값777777777777777777" + JSON.stringify(data.result.licenseType.licenseType));
	  
	    var findF = data.result.resultList;
	    var findType= data.result.licenseType.licenseType
	    
	    var findFAttended = findF.AttendedConcurrent;   
	    var findFUnattended = findF.UnattendedConcurrent;   
	    var findFStudioX = findF.StudioXConcurrent;   
	    var findFStudioPro = findF.StudioProConcurrent;   
	    var findFDevelopment = findF.DevelopmentConcurrent;   
	    var findFTesting = findF.TestAutomationConcurrent;   
	    var findFNonProduction = findF.NonProductionConcurrent;   
	      
	    console.log("findType 넘어온값777777777777777777" + JSON.stringify(findType));
	    console.log("findFAttended 넘어온값777777777777777777" + JSON.stringify(findFAttended));
	    
	    if (findType == "findFAttended" ){   
            if(findFAttended == false ){
         	   getLicenseDetailList("NamedUser" , "Attended");
            }   else{
         	   getLicenseDetailList("Runtime" , "Attended");
            }   
	    }else if(findType == "findFUnattended"){
	      	if(findFUnattended == false ){
	      		getLicenseDetailList("NamedUser" ,  "Unattended" );
	      	}   else{
	      		getLicenseDetailList("Runtime" , "Unattended");
	        }  
	    }else if(findType == "findFStudioX"){
	        if(findFStudioX == false ){
	            getLicenseDetailList("NamedUser" ,"StudioX" );
	        }   else{
	        	getLicenseDetailList("Runtime" ,"StudioX" );
	        }  
	    }else if(findType == "findFStudioPro"){
	        if(findFStudioPro == false ){
	            getLicenseDetailList("NamedUser" , "StudioPro");
	        }   else{
	        	getLicenseDetailList("Runtime" , "StudioPro");
	        }  
	    }else if(findType == "findFDevelopment"){
	        if(findFDevelopment == false ){
	            getLicenseDetailList("NamedUser" , "Development");
	        }   else{
	        	getLicenseDetailList("Runtime" , "Development");
	        }  
	    }else if(findType == "findFTesting"){
	        if(findFTesting == false ){
	            getLicenseDetailList("NamedUser" , "TestAutomation");
	        }   else{
	        	getLicenseDetailList("Runtime" , "TestAutomation");
	        }  
	    }else if(findType == "findFNonProduction"){
	        if(findFNonProduction == false ){
	            getLicenseDetailList("NamedUser" , "NonProduction");
	        }   else{
	        	getLicenseDetailList("Runtime" , "NonProduction");
	        }  
	    }else{
	    	alert("해당사항없음");
	    }
	       //getLicenseDetailList();
	}
	
	/*
	 * API 선택값 넘김
	 * @param
	 * @return
	 */
	function findAPI(data){
		   console.log("findAPI 넘어온값777777777777777777" + data);

		   var url = "/resrce/license/getLicenseList";
		   var param = {
				   "licenseType" : data
		   }
		   callAsyncAjax(url, param, "findFalse");
		}
	
	/*
	 * 라이선스 상세 그리드
	 * @param
	 * @return
	 */
	function drawGrid(data){
		   
		var TT = data.result;
		
		   console.log("jsGrid!!!!!!!!!!!!!!!!!!" + JSON.stringify(data));
		   console.log("jsGrid2222!!!!!!!!!!!!!!!!!!" + JSON.stringify(data.result.resultList));
		
		var params = data.result.resultList;
	    console.log("params", params);
	    $("#licenseGrid").jsGrid({
	           height : "auto"
	           , width : "100%"
	           , autoload: true
	           , sorting : true
	           , align : "center"
	           , data : params
	           , rowClick: false
	           , fields : [
	                 {name: "UserName"             , title : "사용자이름"       , type : "text"  , width : 80, align : "center"}
	               , {name: "LastLoginDate"        , title : "마지막로그인"      , type : "text"  , width : 80, align : "center",
	                   itemTemplate:function(value){
	                	   if(value != null){
	                		   return moment(value).format('YYYY-MM-DD');
	                	   } else {
	                		   return;
	                	   }
	                 }}
	               , {name: "MachineNames"         , title : "머신"           , type : "text"  , width : 100, align : "center"}
	               , {name: "IsLicensed"             , title : "라이선스상태"    , type : "text"  , width : 80, align : "center"
                       , itemTemplate: function(_, item) {
                           if(item.IsLicensed.toString() == "true"){
                               return "활성";
                           } else {
                               return "없음";
                           }
                       }
                    } 
	                      
	           ]
	       });
	}
	/*
	 * 라이선스 상세 그리드2 
	 * @param
	 * @return
	 */
	function drawGrid2(data){
		var ST = data.result.resultSlot;
		
// 		   console.log("jsGrid!!!!!!!!!!!!!!!!!!" + JSON.stringify(data));
// 		   console.log("jsGrid2222!!!!!!!!!!!!!!!!!!" + JSON.stringify(data.result.resultList));
// 		   console.log("jsGrid33333!!!!!!!!!!!!!!!!!!" + JSON.stringify(data.result.resultSlot));
		
		var params = data.result.resultList;
	    console.log("param", params);
	    $("#licenseGrid2").jsGrid({
	        height : "auto"
	        , width : "100%"
	        , autoload: true
	        , sorting : true
	        , align : "center"
	        , data : params
	        , rowClick: false
	        , fields : [
	        	{name: "MachineName"                 , title : "머신"         , type : "text"   , align : "center"} 
	               , {name: "ServiceUserName"        , title : "사용자이름"     , type : "text"   , width : 60, align : "center"} 
	               , {name: "template"               , title : "템플릿"        , type : "text"   , width : 80, align : "center"} 
	               , {name: "Runtimes"               , title : "런타임"        , type : "text"   , width : 40, align : "center"} 
	               , {name: "RobotsCount"            , title : "로봇"         , type : "text"   , width : 50, align : "center"} 
	               , {name: "ExecutingCount"         , title : "사용됨"        , type : "text"   , width : 50, align : "center"} 
	               , {name: "IsLicensed"             , title : "라이선스상태"    , type : "text"   , width : 60, align : "center"
	            	   , itemTemplate: function(_, item) {
	                        if(item.IsLicensed.toString() == "true"){
	                            return "활성";
	                        } else {
	                        	return "없음";
	                        }
	                    }
	                 } 
	               , {name: "Enabled"                , title : "활성"         , type : "text"   , width : 60, align : "center"
	            	   , itemTemplate: function(_, item) {
                        if(item.Enabled.toString() == "true"){
                        	return $("<button style='min-width:52px;' type='button' class='btn btn-outline-primary'>").text("활성").on("click", function() {
                                //license안에 toggle api 사용 함수 추가
                            });
                        } else {
                        	return $("<button style='min-width:52px;' type='button' class='btn btn-outline-secondary'>").text("활성").on("click", function() {
                                //license안에 toggle api 사용 함수 추가
                            });
                        }
	            	 }} 
	               , {name: ""                   , title : "편집"         , type : "text"  , width : 60 , align : "center"
	            	   , itemTemplate: function(_, item) {
	            		   return $("<button style='min-width:52px;' type='button' class='btn btn-outline-primary' id='" + item.MachineId + "'>").text("편집").on("click", function() {
                               //편집 함수 추가
                           });
	            	   }
	            	 }             
	               , {name: "MachineId"              , title : "머신아이디"     , type : "text"  , align : "center"}                              
	        ]
	    });
	    
	}
	  
	/*
	 * Edit 상세 페이지
	 * @param
	 * @return
	 */ 
	function popupEditDetail(data , ST){
	    var param = {};
	    console.log("1111111111111111param11111111111"+JSON.stringify(ST));
	    console.log("2222222222222222param11111111111"+JSON.stringify(data));
	    
	    appendDetailPopup2("licenseMainDiv", "/resrce/license/licenseEditPagePop");
	    
	    getLicenseListR(ST);
	    printRuntime(data , ST); 
	}
	
	function appendDetailPopup2(divid, url){
	    var html = "";
	    html += '<div id="overPage3" class="over1"></div>';
	    $("#"+divid).append(html);
	    $.ajax({
	        url : url,
	        dataType : "html",
	        type : "GET",
	        async : false,
	        success : function(result){
	            $("#overPage3").html(result);
	        }
	    });
	}
	
	function getLicenseListR(ST){
	   
		var url = "/resrce/license/getLicenseList";
	    var param = { "findtype" :ST}
	    
	    callAsyncAjax(url, param, "printLicenseRuntimes");
	}

</script>

