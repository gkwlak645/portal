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
                            <h1 class="m-0 text-dark">공통코드관리</h1>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
                                <li class="breadcrumb-item">기준정보 / 공통코드관리</li>
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
				<div class="row">
				  <div class="col-md-6">
				    <div class="card">
				      <div class="card-header">
				        <h3 class="card-title">분류코드</h3>
				      </div>
				      <!-- /.card-header -->
				     <div class="card-body">
				       <table class="table table-bordered">
				         <thead>                  
				           <tr>
				             <th>번호</th>
				             <th>분류코드</th>
				             <th>분류코드명</th>
				             <th>분류코드설명</th>
				           </tr>
				         </thead>
				         <tbody>
				           <tr>
				             <td>1.</td>
				             <td>Update software</td>
				             <td>
				               <div class="progress progress-xs">
				                 <div class="progress-bar progress-bar-danger" style="width: 55%"></div>
				               </div>
				             </td>
				             <td><span class="badge bg-danger">55%</span></td>
				           </tr>
				           <tr>
				             <td>2.</td>
				             <td>Clean database</td>
				             <td>
				               <div class="progress progress-xs">
				                 <div class="progress-bar bg-warning" style="width: 70%"></div>
				               </div>
				             </td>
				             <td><span class="badge bg-warning">70%</span></td>
				           </tr>
				           <tr>
				             <td>3.</td>
				             <td>Cron job running</td>
				             <td>
				               <div class="progress progress-xs progress-striped active">
				                 <div class="progress-bar bg-primary" style="width: 30%"></div>
				               </div>
				             </td>
				             <td><span class="badge bg-primary">30%</span></td>
				           </tr>
				           <tr>
				             <td>4.</td>
				             <td>Fix and squish bugs</td>
				             <td>
				               <div class="progress progress-xs progress-striped active">
				                 <div class="progress-bar bg-success" style="width: 90%"></div>
				               </div>
				             </td>
				             <td><span class="badge bg-success">90%</span></td>
				           </tr>
				         </tbody>
				       </table>
				     </div>
				     <!-- /.card-body -->
				     <div class="card-footer clearfix">
				       <ul class="pagination pagination-sm m-0 float-right">
				         <li class="page-item"><a class="page-link" href="#">&laquo;</a></li>
				         <li class="page-item"><a class="page-link" href="#">1</a></li>
				         <li class="page-item"><a class="page-link" href="#">2</a></li>
				         <li class="page-item"><a class="page-link" href="#">3</a></li>
				         <li class="page-item"><a class="page-link" href="#">&raquo;</a></li>
				       </ul>
				     </div>
				   </div>
				   <!-- /.card -->
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