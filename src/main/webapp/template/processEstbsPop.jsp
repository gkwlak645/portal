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
                            <h1 class="m-0 text-dark">프로세스 설정</h1>
                        </div>
                        <!-- /.col -->
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
                                <li class="breadcrumb-item">자원관리 / 프로세스관리</li>
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
					<div class="card card-primary">
					    <div class="card-header">
					        <h3 class="card-title">프로세스 설정</h3>
					    </div>
					     <div class="card-body">
                           <form id="version" class="form-inline">
                                <div class="col-md-12 row">
                                    <div class="form-group col-md-6 py-sm-2">
                                        <label for="" class="col-sm-4 col-form-label">표시이름</label>
                                        <div class="col-sm-8">
                                            <input type="hidden" id="id" name="id" value="" />
                                            <input type="text" id="name" class="form-control" name="id" value="" />
                                        </div>
                                    </div>
                                    <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                                        <label for="" class="col-sm-4 col-form-label">우선순위</label>
                                        <div class="col-sm-8">
                                             <input type="hidden" id="jobPriority">
                                            <select id="cmbJobPriority" class="form-control" style="width:60%;margin-right: 3px;">
                                            </select>
                                        </div>
                                    </div>                                    
					            </div>
					            
					            <div class="col-sm-12 custom-control custom-switch">     
                                        <input type="checkbox" id="customSwitch2" class="custom-control-input" >                       
                                        <label class="custom-control-label float-right" for="customSwitch2">프로세스를 자동으로 시작</label>                         
                                 </div>   
                                
                            </form>                     
                           
                            <div class="float-right" style="margin:15px 0 15px 2px;">
                                <button type="button" class="btn btn-primary">저장</button>
                                <button type="button" class="btn btn-primary">취소</button>
                            </div>
                            </div>
                    </div>
					
					<script>
					
					    
					
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