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
                    <li class="nav-item"></li>
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
                            <h1 class="m-0 text-dark">연계시스템 선택</h1>
                        </div>
                        <!-- /.col -->
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
                                <li class="breadcrumb-item">시스템관리 / 접속가능명단</li>
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

                    <div id="unmanagtErrorMainDiv" class="container-fluid wrap">                        
                        <div class="row">
                            <div class="col-md-12">
                                <div class="card">
                                    <div class="card-header">
                                        <form id="searchForm" name="searchForm" class="form-inline">                                            
                                            <div class="form-group row col-sm-6">
                                                <label for="usr" class="col-sm-4 col-form-label">회사</label>
                                                <div class="col-sm-8">
                                                    <select class="form-control" id="searchCmpny"
                                                        style="width: 60%; max-width: 196px;">
                                                        <option value="">동원</option>
                                                    </select>
                                                </div>                                                
                                            </div>
                                            <div class="form-group row  col-sm-6">
                                                <label for="usr" class="col-sm-4 col-form-label">권한</label>
                                                <div class="col-sm-8">
                                                    <select class="form-control" id="searchCmpny"
                                                        style="width: 60%; max-width: 196px;">
                                                        <option value="">권한옵션</option>
                                                    </select>
                                                </div>
                                            </div>
                                            

                                            <div class="form-group row  col-sm-6">
                                                <label for="usr" class="col-sm-4 col-form-label">ID</label>
                                                <div class="col-sm-8">
                                                    <input type="text" name="" class="form-control" id="" style="width: 60%; max-width: 196px;">
                                                </div>
                                            </div>
                                            <div class="form-group row  col-sm-6">
                                                <label for="usr" class="col-sm-4 col-form-label">이름</label>
                                                <div class="col-sm-8">
                                                    <input type="text" name=""class="form-control float-left" id=""style="width: 60%; max-width: 196px;">
                                                    <button type="button" id="btnSearch" class="btn btn-info">조회</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            
						    <div class="col-md-7">
						        <div class="card card-default">
						            <div class="card-body" style="height:600px; overflow:auto;">
						                <div id="userSearchGrid" class="jsgrid" style="position: relative; width: 100%;">
						                   <div class="jsgrid-grid-header jsgrid-header-scrollbar">
						                       <table class="jsgrid-table">
						                           <tr class="jsgrid-header-row">
							                           <th class="jsgrid-header-cell jsgrid-align-center jsgrid-header-sortable" style="width: 25%;">회사</th>						                           
	                                                   <th class="jsgrid-header-cell jsgrid-align-center jsgrid-header-sortable" style="width: 25%;">이름</th>
							                           <th class="jsgrid-header-cell jsgrid-align-center jsgrid-header-sortable" style="width: 25%;">아이디</th>
							                           <th class="jsgrid-header-cell jsgrid-align-center jsgrid-header-sortable" style="width: 25%;">권한</th>
						                           </tr>
						                           <tr class="jsgrid-filter-row">
						                               <td class="jsgrid-cell jsgrid-align-center">동원팜스</td>					                               
						                               <td class="jsgrid-cell jsgrid-align-center">로엑스02</td>
						                               <td class="jsgrid-cell jsgrid-align-center">ROEX02</td>
						                               <td class="jsgrid-cell jsgrid-align-center">IT관리자</td>
						                           </tr>						                          		                          
						                       </table>
						                   </div>
						               </div>   
						           </div>
						       </div>
						    </div>
						    <div class="col-md-5">
						        <div class="card card-default">
						            <div class="card-body" style="height:292px;">
						               <div class="cus_table-wrap2" style="height:100%">
                                        <table class="cus_table2">
                                            <colgroup>
                                              <col width="*">
                                              <col width="35%">
                                            </colgroup>
                                            <thead>                             
                                                <tr>
                                                    <th scope="col">회사</th>
                                                    <th scope="col">인원수</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>동원팜스</td>
                                                    <td>156</td>
                                                  </tr>   
                                            <tbody>                                                                       
                                         </table>
						               </div>
						            </div>
						        </div>
						        <div class="card card-default">
                                    <div class="card-body" style="height:292px;">
                                       <div class="cus_table-wrap2" style="height:100%">
                                        <table class="cus_table2">
				                            <colgroup>
				                              <col width="*">
				                              <col width="35%">
				                            </colgroup>
				                            <thead>                             
				                                <tr>
				                                    <th scope="col">권한</th>
				                                    <th scope="col">인원수</th>
				                                </tr>
				                            </thead>
				                            <tbody>
				                                <tr>
                                                    <td>IT관리자</td>
				                                    <td>156</td>
				                                  </tr>
				                                  <tr>
                                                    <td>IT관리자</td>
                                                    <td>156</td>
                                                  </tr> 
                                                  <tr>
                                                    <td>IT관리자</td>
                                                    <td>156</td>
                                                  </tr> 
                                                  <tr>
                                                    <td>IT관리자</td>
                                                    <td>156</td>
                                                  </tr> 
                                                  <tr>
                                                    <td>IT관리자</td>
                                                    <td>156</td>
                                                  </tr> 
                                                  <tr>
                                                    <td>IT관리자</td>
                                                    <td>156</td>
                                                  </tr> 
                                                  <tr>
                                                    <td>IT관리자</td>
                                                    <td>156</td>
                                                  </tr> 
                                                  <tr>
                                                    <td>IT관리자</td>
                                                    <td>156</td>
                                                  </tr> 
                                                  <tr>
                                                    <td>IT관리자</td>
                                                    <td>156</td>
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
            <footer class="main-footer">
                Copyright &copy; 2020 <a href="http://www.echoit.co.kr">에코아이티</a>&nbsp;.&nbsp;All
                rights reserved.    >
            </footer>
        </div>
    </div>