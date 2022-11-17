<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<div id="licenseMainDiv" class="container-fluid wrap">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <form id="searchForm" name="searchForm" class="form-inline row">
                        <div class="form-group col-md-6">                                      
                                          <label for="licenseKey" class="col-sm-4 col-form-label">라이선스 키</label>
                                          <div class="col-sm-8">
                                              <input type="text" class="form-control" id="licenseKey" disabled>
                                          </div>                         
                                        </div>                                       
                                        <div class="form-group col-md-6">
                                          <label for="activeId" class="col-sm-4 col-form-label">활성화ID</label>
                                          <div class="col-sm-8">
                                              <input type="text" class="form-control" id="activeId" disabled>
                                          </div>
                                        </div>
                                        <div class="form-group col-md-6">
                                          <label for="Expiration" class="col-sm-4 col-form-label">라이선스만료일</label>
                                          <div class="col-sm-8">
                                              <input type="text" class="form-control" id="Expiration" disabled>
                                          </div>
                                        </div>
                                        <div class="form-group col-md-6"></div>
                    </form> 
                </div>
            </div>
        </div>
    </div>
   
   <div class="row">
         <div class="col-md-12">
            <div class="card">
                   <div class="card-body">
                      <div class="cus_table-wrap">
                            <table class="cus_table" id="licenseTable">
                                 <colgroup>
                                     <col width="*">
                                     <col width="30%">
                                     <col width="30%">
                                 </colgroup>
                                 <thead>
                                     <tr>
                                         <th scope="col">유형</th>
                                         <th scope="col">수량</th>
                                         <th scope="col">사용수량</th>
                                    </tr>
                                 </thead>
                                 <tbody>
                                     <!-- 프로세스1 -->
                                     <tr id="tr1"> 
                                         <td id="td1"style="text-align: center;">attended</td>
                                         <td id="td2"></td>
                                         <td id="td3"></td>                                 
                                      </tr>
                                      <tr id="tr2"> 
                                         <td id="td4"style="text-align: center;">Unattended</td>
                                         <td id="td5"></td>
                                         <td id="td6"></td>                                 
                                      </tr>
                                      <tr id="tr3"> 
                                         <td id="td7"style="text-align: center;">Studio</td>
                                         <td id="td8"></td>
                                         <td id="td9"></td>                                 
                                      </tr>
                                      <tr id="tr4"> 
                                         <td id="td10"style="text-align: center;">StudioX</td>
                                         <td id="td11"></td>
                                         <td id="td12"></td>                                 
                                      </tr>
<!--                                       <tr id="tr5">  -->
<!--                                          <td id="td13"style="text-align: center;">StudioPro</td> -->
<!--                                          <td id="td14"></td> -->
<!--                                          <td id="td15"></td>                                  -->
<!--                                       </tr> -->
<!--                                       <tr id="tr6">  -->
<!--                                          <td id="td16"style="text-align: center;">Testing</td> -->
<!--                                          <td id="td17"></td> -->
<!--                                          <td id="td18"></td>                                  -->
<!--                                       </tr> -->
                                      <tr id="tr7"> 
                                         <td id="td19"style="text-align: center;">NonProduction</td>
                                         <td id="td20"></td>
                                         <td id="td21"></td>                                 
                                      </tr>    
                            </table>                     
                      </div>                  
                   </div>
              </div>
          </div>
     </div>
   </div> 
   
   
<style>

table{ 
   border-collapse: collapse;
    text-align: left;
    line-height: 1.5;
    width:100%;
    }


</style>





<script>




   /*
    * 페이지 초기화
    * @param
    * @return
    */
    function pageInit() {
       	     
    	     getLicenseList();
             getLicenseInfo();     
             
    };
                        
   /*
   * 이벤트 바인딩
   * @param
   * @return
   */
    function bindEvent(){
	   
	   
// 	   $("#tr1").click(function(){
// 		   appendDetailPopup("licenseMainDiv", "/resrce/license/licenseDetailPagePop");
// 		   findAPI("findFAttended");
// 	   });
	   
//        $("#tr2").click(function(){
//            appendDetailPopup("licenseMainDiv", "/resrce/license/licenseDetailPagePop");       
//            findAPI("findFUnattended");
//        });
       
//        $("#tr3").click(function(){
//            appendDetailPopup("licenseMainDiv", "/resrce/license/licenseDetailPagePop");       
//            findAPI("findFDevelopment");
//        });
       
//        $("#tr4").click(function(){
//            appendDetailPopup("licenseMainDiv", "/resrce/license/licenseDetailPagePop");       
//            findAPI("findFStudioX");
//        });
       
//        $("#tr5").click(function(){
//            appendDetailPopup("licenseMainDiv", "/resrce/license/licenseDetailPagePop");       
//            findAPI("findFStudioPro");
//        });
  
//        $("#tr6").click(function(){
//            appendDetailPopup("licenseMainDiv", "/resrce/license/licenseDetailPagePop");       
//            findAPI("findFTesting");
//        });
             
//        $("#tr7").click(function(){
//            appendDetailPopup("licenseMainDiv", "/resrce/license/licenseDetailPagePop");       
//            findAPI("findFNonProduction");
//        });
  	   
   }
   
   
    
   /* 
    * 라이선스 정보 상세 조회 API
    * @param
    * @return
    */
    function getLicenseDetail(){
    	var param = {};
    	console.log("1111111111111111param11111111111"+JSON.stringify(param));
    	
    	callAsyncAjax(url,param,"printLicenseDetail");
    }
   
   
    function getLicenseList(){
        var url = "/resrce/license/getLicenseList";
        var param = {
        		"cmpnyCd" : "${sessionUserInfo.txCmpnyCd}"
        }

        callAsyncAjax(url, param, "printLicenseDetail");
    }
   

    /*
     * 상세 데이터 출력 API
     * @param
     * @return
     */
     
     function printLicenseDetail(data){
    	
    	 console.log("11111111111111111data11111111111"+JSON.stringify(data));  	 
    	     	 
         console.log("data.result"+JSON.stringify(data.result));
         console.log("data.result.resultList.Allowed"+JSON.stringify(data.result.resultList[0].Allowed));
         console.log("data.result.resultList.Used"+JSON.stringify(data.result.resultList[0].Used));
    	
         
         var licenseValue = data.result.resultList[0];
         var allowValue =  data.result.resultList[0].Allowed;
         var useValue =  data.result.resultList[0].Used;
                 
         var resultLicenseKey   = licenseValue.Code;
         var resultExpiration   = licenseValue.ExpireDate;
         var allowedAttended    = allowValue.Attended;
         var allowedUnattended  = allowValue.Unattended;
         var allowedStudio      = allowValue.Development;
         var allowedStudioX      = allowValue.StudioX;
//          var allowedStudioPro      = allowValue.StudioPro;
//          var allowedTesting      = allowValue.TestAutomation;
         var allowedNonProduction      = allowValue.NonProduction;
                     
         var usedAttended    = useValue.Attended;
         var usedUnattended  = useValue.Unattended;
         var usedStudio      = useValue.Development;
         var usedStudioX      = useValue.StudioX;
//          var usedStudioPro      = useValue.StudioPro;
//          var usedTesting      = useValue.TestAutomation;
         var usedNonProduction      = useValue.NonProduction;
         
         var attendedexist     = licenseValue.AttendedConcurrent;
            
         $("#licenseKey").val(resultLicenseKey);
         $("#Expiration").val(resultExpiration);
               
         $("#td2").html(allowedAttended);
         $("#td5").html(allowedUnattended);
         $("#td8").html(allowedStudio);
         $("#td11").html(allowedStudioX);
//          $("#td14").html(allowedStudioPro);
//          $("#td17").html(allowedTesting);
         $("#td20").html(allowedNonProduction);
            
         $("#td3").html(usedAttended);
         $("#td6").html(usedUnattended);
         $("#td9").html(usedStudio);
         $("#td12").html(usedStudioX);       
//          $("#td15").html(usedStudioPro);
//          $("#td18").html(usedTesting);
         $("#td21").html(usedNonProduction);
                 	  	
    }
   
     /* 
      * 라이선스 정보 상세 조회 DB
      * @param  
      * @return
      */
    
     function getLicenseInfo(){
    	 var url = "/resrce/license/getLicenseInfo";
         var param = {}
         
         callAsyncAjax(url, param, "printLicenseInfoDetail");
     }
     
     /*
      * 상세 데이터 출력 DB
      * @param
      * @return
      */
      function printLicenseInfoDetail(data){
    	  
    	  console.log("11111111111111111data11111111111"+JSON.stringify(data));              
          console.log("data2.result"+JSON.stringify(data.result));
          
          var lcValue = data.result;
          var resultactiveId    = lcValue.value;
          
          $("#activeId").val(resultactiveId);
      }

</script>

