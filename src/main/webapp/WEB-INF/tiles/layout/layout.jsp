<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="c"       uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn"      uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt"     uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>메인화면</title>
        <!-- Tell the browser to be responsive to screen width -->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="/resources/plugins/fontawesome-free/css/all.min.css">
        <!-- Ionicons -->
        <!-- <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css"> -->
        <link rel="stylesheet" href="/resources/css/ionicons/css/ionicons.min.css">
        <!-- Tempusdominus Bbootstrap 4 -->
        <link rel="stylesheet" href="/resources/plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
        <!-- iCheck -->
        <link rel="stylesheet" href="/resources/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
        <!-- JQVMap -->
        <link rel="stylesheet" href="/resources/plugins/jqvmap/jqvmap.min.css">
        <!-- Theme style -->
        <link rel="stylesheet" href="/resources/css/dist/adminlte.css">
        <!-- overlayScrollbars -->
        <link rel="stylesheet" href="/resources/plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
        <!-- Daterange picker -->
        <link rel="stylesheet" href="/resources/plugins/daterangepicker/daterangepicker.css">
        <!-- summernote -->
        <link rel="stylesheet" href="/resources/plugins/summernote/summernote-bs4.css">
        <!-- Google Font: Source Sans Pro -->
        <!-- <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet"> -->
        <link rel="stylesheet" href="/resources/css/opensans/opensans.css">
        <!-- jsGrid -->
        
        <link rel="stylesheet" href="/resources/plugins/jsgrid/jsgrid.css">
        
        <link rel="stylesheet" href="/resources/plugins/jsgrid/jsgrid.min.css">
        <link rel="stylesheet" href="/resources/plugins/jsgrid/jsgrid-theme.min.css">
        <link rel="stylesheet" href="/resources/css/custom.css">
        <!-- jstree -->
        <link rel="stylesheet" href="/resources/js/jstree/themes/default/style.min.css" />
        <link rel="stylesheet" href="/resources/js/jstree/themes/proton/style.min.css" />
        
        <!-- calendar -->
        <link rel="stylesheet"
        	href="/resources/plugins/fullcalendar/main.min.css">
        <link rel="stylesheet"
        	href="/resources/plugins/fullcalendar-daygrid/main.min.css">
        <link rel="stylesheet"
        	href="/resources/plugins/fullcalendar-timegrid/main.min.css">
        <link rel="stylesheet"
        	href="/resources/plugins/fullcalendar-bootstrap/main.min.css">
        
        <script src="/resources/plugins/moment/moment.min.js"></script>
        <script src="/resources/plugins/fullcalendar/main.min.js"></script>
        <script src="/resources/plugins/fullcalendar-daygrid/main.min.js"></script>
        <script src="/resources/plugins/fullcalendar-timegrid/main.min.js"></script>
        <script src="/resources/plugins/fullcalendar-interaction/main.min.js"></script>
        <script src="/resources/plugins/fullcalendar-bootstrap/main.min.js"></script>
        
        
        
        
        <!-- jQuery -->
        <script src="/resources/plugins/jquery/jquery.min.js"></script>
        <script src="/resources/js/jquery/jquery.form.min.js"></script>
        <!-- jQuery UI 1.11.4 -->
        <script src="/resources/plugins/jquery-ui/jquery-ui.min.js"></script>
        <!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
        <script>
        $.widget.bridge('uibutton', $.ui.button)
        </script>
        <!-- Bootstrap 4 -->
        <script src="/resources/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
        <!-- ChartJS -->
        <script src="/resources/plugins/chart.js/Chart.min.js"></script>
        <!-- Sparkline -->
        <script src="/resources/plugins/sparklines/sparkline.js"></script>
        <!-- JQVMap -->
        <script src="/resources/plugins/jqvmap/jquery.vmap.min.js"></script>
        <script src="/resources/plugins/jqvmap/maps/jquery.vmap.usa.js"></script>
        <!-- jQuery Knob Chart -->
        <script src="/resources/plugins/jquery-knob/jquery.knob.min.js"></script>
        <!-- daterangepicker -->
        <script src="/resources/plugins/moment/moment.min.js"></script>
        <!-- daterangepicker 한글 적용 -->
        <script src="/resources/plugins/moment/locale/ko.js"></script>
        <script src="/resources/plugins/daterangepicker/daterangepicker.js"></script>
        <!-- Tempusdominus Bootstrap 4 -->
        <script src="/resources/plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
        <!-- Summernote -->
        <script src="/resources/plugins/summernote/summernote-bs4.min.js"></script>
        <!-- overlayScrollbars -->
        <script src="/resources/plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
        <!-- AdminLTE App -->
        <script src="/resources/js/dist/adminlte.js"></script>
        <!-- AdminLTE dashboard demo (This is only for demo purposes) -->
        <script src="/resources/js/dist/pages/dashboard.js"></script>
        <!-- AdminLTE for demo purposes -->
        <script src="/resources/plugins/jsgrid/jsgrid.min.js"></script>
        
        <script src="/resources/js/common.js"></script>
        <script src="/resources/js/common-ajax.js"></script>
        <script src="/resources/js/file-upload.js"></script>
        <!-- jstree -->
        <script src="/resources/js/jstree/jstree.min.js"></script>
        
        <!-- Summernote -->
        <script src="/resources/plugins/summernote/summernote-bs4.min.js"></script>
        <script>
        
        $(document).ready(function(){
        	
        	if (typeof pageInit === 'function') {
        		pageInit();
        	}
        	
            if (typeof bindEvent === 'function') {

            	bindEvent();
            }
            
        });
        
        </script>
        
    </head>
    <body class="hold-transition sidebar-mini layout-fixed">
        <div class="wrapper">
            <div id="header"><tiles:insertAttribute name="header" /></div>
            <div id="menu"><tiles:insertAttribute name="left" /></div>
    
			<!-- Content Wrapper. Contains page content -->
			<div class="content-wrapper">
			    <!-- Content Header (Page header) -->
			    <div class="content-header">
			        <div class="container-fluid">
			            <div class="row mb-0">
			                <div class="col-sm-6">
			                    <h1 class="m-0 text-dark">
                                <c:if test="${menuNm != null and menuNm != ''}">
                                    <c:out value="${menuNm}" />
                                </c:if>
			                    </h1>
			                </div><!-- /.col -->
			                <div class="col-sm-6">
			                    <ol class="breadcrumb float-sm-right">
			                        <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
			                        <li class="breadcrumb-item">
			                        <c:if test="${menuPath != null and menuPath != ''}">
			                            <c:out value="${menuPath}" />
			                        </c:if>
			                        </li>
			                    </ol>
			                </div><!-- /.col -->
			            </div><!-- /.row -->
			        </div><!-- /.container-fluid -->
			    </div>
			    <!-- /.content-header -->
			
			
			    <!-- Main content -->
			    <section class="content">
			        <div id="content"><tiles:insertAttribute name="content" /></div>
			    </section>
			    <!-- /.Main content -->
			</div>
			
			<div id="footer"><tiles:insertAttribute name="footer" /></div>
			
            <!-- Control Sidebar -->
            <aside class="control-sidebar control-sidebar-dark">
            <!-- Control sidebar content goes here -->
            </aside>
            <!-- /.control-sidebar -->
			
        </div>
        <!-- ./wrapper -->
    </body>
</html>