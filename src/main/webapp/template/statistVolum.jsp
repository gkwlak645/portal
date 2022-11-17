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
                            <h1 class="m-0 text-dark">인원 및 봇 수 현황</h1>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
                                <li class="breadcrumb-item">통계 > 인원 및 봇 수 현황</li>
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
                
<div id="unmanagtErrorMainDiv" class="container-fluid wrap">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-body">
                    <div class="cus_table-wrap">
	                    <table class="cus_table">
	                        <colgroup>
	                            <col style="width: 10%">
                                <col style="width: 10%">
                                <col style="width: 10%">
	                            <col>
	                            <col>
	                        </colgroup>
	                        <thead>
	                            <tr>
	                                <th scope="col" colspan="3">구분</th>
                                    <th scope="col">현재(08/09)</th>
                                    <th scope="col">전회의(08/08)</th>
                                    <th scope="col">차이</th>
                                    <th scope="col">차이내용</th>
	                            </tr>
	                        </thead>
	                        <tbody>
                                <tr>
                                    <th rowspan="5">그룹계</th>
                                    <th rowspan="4">인원수</th>
                                    <th>인원합계</th>
                                    <td>56</td>
                                    <td>56</td>
                                    <td>0</td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <th>상근</th>
                                    <td>22</td>
                                    <td>22</td>
                                    <td>0</td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <th>파워유저</th>
                                    <td>22</td>
                                    <td>22</td>
                                    <td>0</td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <th>비상근</th>
                                    <td>3</td>
                                    <td>3</td>
                                    <td>0</td>
                                    <td></td>
                                </tr>
                                <tr class="lastline">
                                    <th colspan="2">봇수</th>
                                    <td>19</td>
                                    <td>19</td>
                                    <td>0</td>
                                    <td></td>
                                </tr>
	                        </tbody>
	                     </table>
                    </div>
                </div>
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



