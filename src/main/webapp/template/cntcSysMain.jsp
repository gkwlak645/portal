<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
                    <li class="nav-item">
                        <a class="nav-link" data-widget="pushmenu" href="#" role="button">
                            <i class="fas fa-bars"></i>
                        </a>
                    </li>
                </ul>
                <ul class="navbar-nav ml-auto">
                    <!-- Messages Dropdown Menu -->
                    <li class="nav-item">
                        <a></a>
                    </li>  
                </ul>
            </nav>
            <!-- / Navbar -->
        </div>

        <jsp:include page="/template/menu.jsp"></jsp:include>

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Content Header (Page header) -->
            <div class="content-header">
                <!-- .container-fluid -->
                <div class="container-fluid">
                    <div class="row mb-0">
                        <div class="col-sm-6">
                            <h1 class="m-0 text-dark">연계시스템관리</h1>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
                                <li class="breadcrumb-item">기준정보 / 연계시스템관리</li>
                            </ol>
                        </div>
                    </div>
                </div>
                <!-- /.container-fluid -->
            </div>
            <!-- /.content-header -->


            <!-- Main content -->
            <section class="content">
                <div id="content">                
                
                
                <!--  템플릿 바디 -->
				<div id="CntcSysMainDiv" class="container-fluid wrap">
				
				  <div class="row">
				        <div class="col-md-12">
				            <div class="card">
				                <div class="card-header">
				                     <form class="form-inline" onSubmit="return false;">
                                           <div class="form-group col-sm-6">
                                              <label for="schCmpny" class="col-sm-2 col-form-label">분류</label>
                                              <div class="col-sm-10">
                                                <select id="cntcType" class="form-control" style="width:50%">
                                                    <option value="">전체</option>
                                                    <option value="01">공통</option>
                                                    <option value="02">회사별</option>
                                                </select>
                                                </div>
                                            </div>
                                        
                                        
                                            <div class="form-group col-sm-6">
                                                <label for="schQueName" class="col-sm-2 col-form-label">회사</label>
                                                <div class="col-sm-10 float-left">
                                                    <select class="form-control float-left" id="tenant" style="margin-right:5px;width:50%" required >
	                                                    <option selected disabled>계열사선택</option>
	                                                    <option value="I">동원산업</option>
	                                                    <option value="X">동원로엑스</option>
	                                                    <option value="F">동원FnB</option>
	                                                    <option value="H">동원홈푸드</option>
	                                                    <option value="C">동원시스템즈</option>
	                                                    <option value="T">테크팩솔루션</option>
	                                                    <option value="A">동원건설산업</option>
	                                                </select>
                                                    <button type="button" id="btnSearch" class="btn btn-info float-left">조회</button>
                                                </div>
                                            </div>
                                        </form> 			                    
				                    
				                </div>
				            </div>
				        </div>
				    </div>
				
				
					<div class="row">
                            <div class="col-md-12">
                                <div class="card">
                                    <div class="card-body">                
                                        <button type="button" id="btnReg" class="btn btn-primary float-right" style="margin:5px 0 15px 2px;">등록</button>
										<div id="cntcGrid"></div>
										<div id="cntcGridPager" class="portal-pager"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>    
                        
				
				
				
					<script>
					function pageInit() {
					   
					    getCntcSysList();
					};
					
					
					function bindEvent(){
						  $("#btnReg").on("click",function(){
					          appendDetailPopup("CntcSysMainDiv", "/stdrinfo/cntcsys/cntcSysRegister");
					      });	
						  $("#btnSearch").on("click",function(){
							  getCntcSysList();
					      });	
						  
						   $("#cntcType").on("change", function(){
							  if($("#cntcType").val() == "01"){
							
								  $("#tenant").attr('disabled', true);
								 
							  }else if($("#cntcType").val() == "02"){
								  
								  $("#tenant").attr('disabled', false);
							  }  
						 
							  
							  
						  });
						  
						  
						  
						  
						  
						  
						  
					}
					
					
					
					//리스트 단순 조회
					function getCntcSysList(pageNo, typeCd){
						
						console.log(pageNo+"|||||||||||||||||"+typeCd);
						
						
						var url = '/stdrinfo/cntcsys/getCntcSysList';
						var currentPageNo = 1;
						if (pageNo != null && pageNo != undefined && pageNo != "") {
					        currentPageNo = pageNo;
					    }
						
						var param ={
								
								cntcType: $("#cntcType").val(),
							    tenant:$("#tenant").val(),
								currentPageNo:currentPageNo,
					            recordCountPerPage:10,
					            pageSize:10			
								
						};
						 console.log(param);
						callAsyncAjax(url,param,"drawGrid");				
						
					}
					
					
					
					function drawGrid(data){
						
						
						console.log("#####################data#############################" +JSON.stringify(data));
						
						var params = {}
						
						if (data != null && data != undefined) {
					        if(data.result.paginationInfo != null){
					        	params =  data.result.resultList;
					                  drawPager("cntcGridPager",data.result.paginationInfo,"getCntcSysList"); 
						             }
						     }
						   $("#cntcGrid").jsGrid({
					           height : "auto"
					           , width : "100%"
					           , autoload: true
					           , sorting : true
					           , align : "center"
					           , data : params
					           , rowClick:   function(arg){
					               popupCntcDetail(arg.item.cntcSysCd);
					
					               console.log("arg.item.cd" + arg.item.cntcSysCd);
					               console.log("arg" + JSON.stringify(arg.item)); 
					           } 
					           , fields : [
					                 {name: "cntcSysClsCd"       , title : "분류"           , type : "text"   , width : 40, align:"center"}
					               , {name: "cmpnyCd"             , title : "회사"           , type : "text"   , width : 50, align:"center"}
					               , {name: "cntcSysCd"           , title : "시스템코드"        , type : "text"   , width : 40, align:"center"}
					               , {name: "cntcSysNm"           , title : "시스템명"           , type : "text"   , width : 50, align:"center"}
					               , {name: "sysDc"               , title : "설명"         , type : "text"   }
					               , {name: "useAt"               , title : "사용여부"            , type : "text"   , width : 30, align:"center"}
					               
					           ]
					       });
						
						
					}
					
					function popupCntcDetail(cd){
						appendDetailPopup( "CntcSysMainDiv" , "/stdrinfo/cntcsys/cntcDetailPagePop");
						console.log("1111111111111111cd11111111111"+JSON.stringify(cd));
						getCntcDetail(cd);
					};
					
					
					
					function getCntcDetail(cd) {
						
						var url = '/stdrinfo/cntcsys/getCntcDetail'
						var param = {"sysCd" : cd} ;
						console.log("1111111111111111param11111111111"+JSON.stringify(param));
						callAsyncAjax(url, param, "printCntcDetail");
							
					}
					
					
					function printCntcDetail(data){
						
						console.log("11111111111111111data11111111111"+JSON.stringify(data));
						var cntcInfo = data.result;
						
						
						$("#cntcType").val(cntcInfo.cntcSysClsCd);
						$("#cmpny").val(cntcInfo.cmpnyCd);
						$("#sysCd").val(cntcInfo.cntcSysCd);
						$("#sysNm").val(cntcInfo.cntcSysNm);
						$("#sysDc").val(cntcInfo.sysDc);
						$("#use").val(cntcInfo.useAt);
						
							
					}				
													
					</script>
	
	
					<!--  템플릿 바디 끝 -->    

	                </div>
	         </section>
	         <!-- /.Main content -->
	        </div>
	        
	        <div id="footer">
	            <footer class="main-footer">Copyright &copy; 2020 <a href="http://www.echoit.co.kr">에코아이티</a>&nbsp;.&nbsp;All rights reserved.</footer>
	        </div>
	        
	    </div>
	</body>
</html>


