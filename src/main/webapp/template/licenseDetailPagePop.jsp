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
            <nav
                class="main-header navbar navbar-expand border-bottom-0 navbar-dark navbar-primary text-sm">
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
                            <h1 class="m-0 text-dark">라이선스 상세</h1>
                        </div>
                        <!-- /.col -->
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
                                <li class="breadcrumb-item">자원관리 / 라이선스관리</li>
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
					    <div class="card-header">
					        <h3 class="card-title">상세</h3>
					    </div>
					    <div class="card-body">
					        <div class="col-md-12">
					            <form class="form-inline" id="">               
                                <div class="form-group col-md-6">
			                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">라이선스 키</label>
			                        <div class="col-sm-8">
			                            <input type="text" id="" class="form-control"  style="width:80%;" value="8874-9866-3637-6647" disabled>
			                        </div>
			                    </div>
			                    <div class="form-group col-md-6">
			                        <label for="managtChargerId" class="col-sm-4 col-form-label">활성화ID</label>
			                        <div class="col-sm-8">
			                            <input type="text" id="" class="form-control"  style="width:80%;" value="UIP-ae054092ca" disabled>
			                        </div>
			                    </div>
			                    </form>                  
	                         </div>
	                         
	                         <div class="col-md-12">
                                    <div id="licenseGrid"></div>
                             </div>  
						    
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
						    
						    
						    <div class="float-right" style="margin:15px 0 15px 2px;">
	                            <button type="button" class="btn btn-primary" id="runtimeRegister">저장</button>
	                            <button type="button" class="btn btn-primary" id="paramCancel">목록으로</button>
	                        </div>    				     
			           </div>
                   </div>



<script>

$(document.body).ready(function () { 
});

    /*
     * 페이지 초기화
     * @param
     * @return
     */
    function pageInit() {
        //그리드 초기화
        drawGrid();
        
        $("#btnSave").on('click', function(){
            unManagtErrorReg();
        });

    };
    
    /*
     * 그리드 초기화
     * @param
     * @return
     */
 
 function drawGrid(data){

     var params = new Array();

     for(var i = 0 ; i < 5 ; i++){
         params[i] = {
                 'MachineName' : 'LAPTOP-9FLV1FQJ',
                 'ServiceUserName' : '홍길동',
                 'template' : "템플릿이름",
                 'Runtimes' : 0,
                 'RobotsCount' : 4,
                 'ExecutingCount' : 2,
                 'IsOnline' : 0,
                 'Enabled' : "<button style='min-width:52px;' type='button' class='btn btn-outline-secondary'>활성</button>",
                 'edit' : "<button style='min-width:52px;' type='button' class='btn btn-outline-primary'>편집</button>",
                 'MachineId' : "12"
         };
     }
     
     
    
    $("#licenseGrid").jsGrid({
           height : "auto"
           , width : "100%"
           , autoload: true
           , sorting : true
           , align : "center"
           , data : params
           , rowClick: false
           , fields : [
               {name: "MachineName"                 , title : "머신"           , type : "text"   , align : "center"} 
               , {name: "ServiceUserName"             , title : "사용자이름"           , type : "text"   , width : 60, align : "center"} 
               , {name: "template"                    , title : "템플릿"        , type : "text"   , width : 80, align : "center"} 
               , {name: "Runtimes"                    , title : "런타임"           , type : "text"   , width : 40, align : "center"} 
               , {name: "RobotsCount"                 , title : "로봇"         , type : "text"   , width : 50, align : "center"} 
               , {name: "ExecutingCount"              , title : "사용됨"            , type : "text"   , width : 50, align : "center"} 
               , {name: "IsOnline"                    , title : "라이선스상태"            , type : "text"   , width : 60, align : "center"} 
               , {name: "Enabled"                     , title : "활성"           , type : "text"   , width : 60, align : "center"} 
               , {name: "edit"                        , title : "편집"           , type : "text"  , width : 60 , align : "center"}              
               , {name: "MachineId"                   , title : "머신아이디"           , type : "text"  , align : "center"}                        
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

<!--  템플릿 바디 끝 -->





</div>
</section>
<!-- /.Main content -->
</div>
<div id="footer">
<footer class="main-footer">
Copyright &copy; 2020 <a href="http://www.echoit.co.kr">에코아이티</a>&nbsp;.&nbsp;All
rights reserved. >
</footer>
</div>
</div>

