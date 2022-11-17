<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>



   
   <div class="row">
         <div class="col-md-12">
            <div class="card">
                   <div class="card-body">
                    <div class="form-group">
                        <label for="Aruntime">사용가능한 런타임 <b style="color: red;">*</b></label>
                        <div class="col-4">
                            <input type="text" id="Aruntime" class="form-control" required>
                        </div>
                    </div> 
                    <div class="form-group">
                        <label for="runtime">런타임수 <b style="color: red;">*</b></label>
                        <div class="col-4">
                            <input type="text" id="runtime" class="form-control" required>
                            <input type="hidden" id="MachineId" >
                            <input type="hidden" id="MachineName">
                            <input type="hidden" id="slotType">
                            
                        </div>
                    </div> 
                    
                    <div class="float-right">
                        <button type="button" class="btn btn-primary" id="runtimeRegister">저장</button>
                        &nbsp;
                        <button type="button" class="btn btn-primary" id="cancel45">닫기</button>
                    </div>              
                   </div>
              </div>
          </div>
    </div>





<script>
$(document).ready(function() {
    
    //페이지 초기화
    pageInit();
    
    //이벤트 바인딩
    bindEvent();
});


      function bindEvent(){
    	  
    	//닫기 클릭
    	  $("#cancel45").on("click",function(){

    	  $(".over1").remove();           	         
    	     });
    	  
    	
        //저장 클릭
    	  $("#runtimeRegister").on("click",function(){
    		  alert("저장");
    		  runtimeModify();
    		  $(".over1").remove();    
    		  $(".over").remove();    
    	  });
    	  
      }

      function runtimeModify(){
    	  
          console.log("runtime 수정" );
          
          
          var url ="/resrce/license/updateRuntime"; 
        
          
           if( $("#slotType").val() == "Unattended"){
        	 
        	   var param = {
        		          
        	           "MachineId"   :  $("#MachineId").val()
        	          ,"Name" :  $("#MachineName").val()
        	          ,"UnattendedSlots"    : $("#runtime").val()
        	          
        	          };
        	 
          
          }else if( $("#slotType").val() == "NonProduction"){
        	  
        	  
        	  var param = {
                      
                      "MachineId"   :  $("#MachineId").val()
                     ,"Name" :  $("#MachineName").val()
                     ,"NonProductionSlots"    : $("#runtime").val()
                     
                     };
      
          
          }else{}
          
                   
          
          console.log("param 값 설정" +   param);

          callSyncAjax(url, param, null);
      }
          
              
      
      function printLicenseRuntimes(data){
    	     
    	     
    	  console.log("111111111sdfsf11111111data11111111111"+JSON.stringify(data));  
    	  console.log("111111111sdfsf11111111data.result11111111111"+JSON.stringify(data.result));  
    	  console.log("111111111sdfsf11111111data.result.findtype11111111111"+JSON.stringify(data.result.licenseType.findtype));  
    	  console.log("2222222222222222sdfsf1111122222221"+JSON.stringify(data.result.licenseType.findtype));  
    	  
    	  
    	  var type = data.result.licenseType.findtype;
    	  
    	  var allowValue =  data.result.resultList.Allowed;
          var useValue =  data.result.resultList.Used;
                  
          var allowedAttended    = allowValue.Attended;
          var allowedUnattended  = allowValue.Unattended;
          var allowedStudio      = allowValue.Development;
          var allowedStudioX      = allowValue.StudioX;
          var allowedStudioPro      = allowValue.StudioPro;
          var allowedTesting      = allowValue.TestAutomation;
          var allowedNonProduction      = allowValue.NonProduction;
                      
          var usedAttended    = useValue.Attended;
          var usedUnattended  = useValue.Unattended;
          var usedStudio      = useValue.Development;
          var usedStudioX      = useValue.StudioX;
          var usedStudioPro      = useValue.StudioPro;
          var usedTesting      = useValue.TestAutomation;
          var usedNonProduction      = useValue.NonProduction;
    	  
    	  
    	  
    	  if(type == "Unattended"  ){
    		  $("#Aruntime").val(usedUnattended + "/" + allowedUnattended);
    	  }
    	  else if (type == "NonProduction" ){
    		  $("#Aruntime").val(usedNonProduction + "/" + allowedNonProduction );
    	  }
    	  else{}
    	  
    	  
          
    	     
    	  
    	  
    	  
    	     
      }
     
      
      
      //runtime 넘기기
      function printRuntime(data , ST){
    	  
    	  
          console.log("lalalalal ST" +   ST);

    	  $("#MachineId").val(data.MachineId);
    	  $("#MachineName").val(data.MachineName);
    	  $("#runtime").val(data.Runtimes);
    	  $("#slotType").val(ST);
    	  
    	  
      }
      
     

</script>

