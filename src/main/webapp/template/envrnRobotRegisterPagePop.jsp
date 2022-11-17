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
                            <h1 class="m-0 text-dark">환경관리 상세</h1>
                        </div>
                        <!-- /.col -->
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
                                <li class="breadcrumb-item">자원관리 / 환경관리</li>
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
                    <div class="card card-primary" id = "cardDiv">
                        <div class="card-header" alt="자원>환경관리 등록 ">
                            <h3 class="card-title">등록</h3>
                        </div>
                        <div class="card-body" style="min-height:654px; overflow:auto;">
							<div class="row">
						        <div class="col-md-12">
						            <div class="card">
						                <div class="form-group">
						                    <div id="envrnRobotGrid"></div>
						                    <div id="envrnRobotGridPager" style="text-align:center"></div>
				                         </div>
				                    </div>
				                    
					                <div class="float-right" style="margin:15px 0 15px 2px;">
				                        <button type="button" class="btn btn-primary"  id="addRobot">등록</button>
				                        <button type="button" class="btn btn-primary" id="cancel">취소</button>
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
				
					    /*
					     * 페이지 초기화
					     * @param
					     * @return
					     */
						function pageInit() {
						}
				
					    /*
					     * 이벤트 바인딩
					     * @param
					     * @return
					     */
						function bindEvent() {
							$("#addRobot").on("click", function() {
								addRobotToEnvrn();
							});
				
							$("#cancel").on("click", function() {
				// 				alert("취소");
								$(".over").remove();
				// 				detailPageMove(registerEnvrnId);
								popupEnvrnDetail(registerEnvrnId);
							});
						        
						}
						
				        /*
				         * 로봇 환경 추가
				         * @param
				         * @return
				         */
						function addRobotToEnvrn() {
							var selectedItems = [];
							var unselectedItems = [];
							
						    $('input[name=gridCheckbox]').each(function(){
						    	var robotId = parseInt($(this).val());
						    	if($(this).is(':checked')){
						    		selectedItems.push(robotId);
						    	}else {
						    		unselectedItems.push(robotId);
						    	}
						    })
						    
							url = '/resrce/envrn/addRobotToEnvrn'
						    var param = new Object();
						    param.addedRobotIds = selectedItems;
						    param.removedRobotIds = unselectedItems;
						    param.id = registerEnvrnId;
						    console.log(param);
							callSyncAjax(url, param, 'closePOP'); 
						};
					
						/*
					     * 상세페이지 pop
					     * @param
					     * @return
					     */
					    function popupEnvrnDetail(id) {
					        appendDetailPopup("envrnMainDiv", "/resrce/envrn/envrnDetailPop");
					        getEnvrnDetail("/resrce/envrn/getEnvrnDetail", id); 
					    };
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