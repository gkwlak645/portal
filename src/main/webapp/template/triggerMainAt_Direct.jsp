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
                            <h1 class="m-0 text-dark">트리거(AT)</h1>
                        </div>
                        <!-- /.col -->
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
                                <li class="breadcrumb-item">자원관리 / 트리거</li>
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
                        <div class="card-header">
                            <h3 class="card-title">즉시실행 등록</h3>
                        </div>
                        <div class="card-body" style="min-height:654px; overflow:auto;">
                                <div class="row">
                                    <div class="col-md-12">
                                    <form>
                                    
                                        <div class="form-inline">
                                            <div class="form-group col-md-12 py-sm-2">
                                                <label for="name" class="col-sm-2 col-form-label">이름</label>
                                                <div class="col-sm-10">
                                                    <input style="width:84.7%;" type="text" id="envrnName" class="form-control" required>
                                                </div>
                                             </div>
                                             <div class="form-group col-md-6 py-sm-2" >
                                                <label class="col-sm-4 col-form-label" for="inputName">프로세스</label>
                                                <div class="col-sm-8">
                                                    <select class="form-control" id="" style="width:60%;margin-right: 3px;">
                                                    </select>
                                                </div>
                                            </div>
                                             
                                            <div class="form-group col-md-6 py-sm-2" >
                                                <label class="col-sm-4 col-form-label" for="inputName">실행로봇</label>
                                                <div class="col-sm-8">
                                                    <select class="form-control" id="" style="width:60%;margin-right: 3px;">
                                                    </select>
                                                </div>
                                            </div>                    
                                        </div>
                                        <div class="float-right">
                                            <button type="button" class="btn btn-primary" id="envrnRegister">저장</button>
                                            <button type="button" class="btn btn-primary" id="cancel">취소</button>
                                        </div>                   
                                       
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    
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