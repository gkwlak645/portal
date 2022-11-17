<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>템플릿화면</title>
<!-- Tell the browser to be responsive to screen width -->
<meta name="viewport" content="width=device-width, initial-scale=1">

<jsp:include page="/template/script.jsp"></jsp:include>
</head>
<body class="hold-transition sidebar-mini layout-fixed">
    <div class="wrapper">
       <div id="header">
            <!-- Navbar -->
            <nav class="main-header navbar navbar-expand border-bottom-0 navbar-dark navbar-primary text-sm">
                <ul class="navbar-nav">
                    <li class="nav-item"><a class="nav-link"
                        data-widget="pushmenu" href="#" role="button"><i
                            class="fas fa-bars"></i></a></li>
                </ul>                
                <ul class="navbar-nav ml-auto">
                    <!-- Messages Dropdown Menu -->
                    <li class="nav-item"></a></li>  
                </ul>
            </nav>
            <!-- /.navbar -->
        </div>
    
        <jsp:include page="/template/menu.jsp"></jsp:include>
        
        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Content Header (Page header) -->
            <div class="content-header">
                <div class="container-fluid">
                    <div class="row mb-0">
                        <div class="col-sm-6">
                            <h1 class="m-0 text-dark">과제아이디어등록</h1>
                        </div>
                        <!-- /.col -->
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
                                <li class="breadcrumb-item">과제 / 과제아이디어등록</li>
                            </ol>
                        </div>
                        <!-- /.col -->
                    </div>
                    <!-- /.row -->
                </div>
                <!-- /.container-fluid -->
            </div>
            <!-- /.content-header -->


            <!-- Main content -->
            <section class="content">
                <div id="content">
                    
                    
                    
                    
				<!--  템플릿 바디 -->        
				 <div class="card card-primary" id="unmanagtErrorDetailDiv">
				    <div class="card-header" alt="과제 >과제아이디어상세">
				        <h3 class="card-title">상세조회</h3>
				    </div>
				    <div class="card-body">
				        <div class="row">
		                    <div class="col-md-12">
		                       <form class="form-inline" id="">               
		                           <div class="form-group col-md-6">
		                               <label for="Aruntime" class="col-sm-4 col-form-label">사용가능한 런타임 <b style="color: red;">*</b></label>
		                               <div class="col-sm-8">
		                                   <input type="text" id="Aruntime" class="form-control" required>
		                               </div>
		                           </div>
		                           <div class="form-group col-md-6">
		                               <label for="runtime">런타임수 <b style="color: red;">*</b></label>
		                               <div class="col-sm-8">
		                                   <input type="text" id="runtime" class="form-control" required>
		                                   <input type="hidden" id="MachineId" >
		                                   <input type="hidden" id="MachineName">
		                                   <input type="hidden" id="slotType">
		                               </div>
		                           </div>
		                         </form>                  
		                     </div>
		                    
			                 
		              </div>
		              <div class="float-right">
                                <button type="button" class="btn btn-primary" id="runtimeRegister">저장</button>
                                &nbsp;
                                <button type="button" class="btn btn-primary" id="cancel45">닫기</button>
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

      <!--  템플릿 바디 끝 -->    





                         
                      </div>
                  </section>
                  <!-- /.Main content -->
              </div>
              <div id="footer">
                  <footer class="main-footer">
                      Copyright &copy; 2020 <a href="http://www.echoit.co.kr">에코아이티</a>&nbsp;.&nbsp;All
                      rights reserved.    >
                  </footer>
              </div>
          </div>
      </body>
      </html>

