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
                            <h1 class="m-0 text-dark">과제운영 정기실행</h1>
                        </div>
                        <!-- /.col -->
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
                                <li class="breadcrumb-item">과제 / 과제운영</li>
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
 <div class="card card-primary" id="unmanagtErrorRegDiv">                   
    <div class="card-header" alt="과제 >과제운영">
        <h3 class="card-title">정기실행</h3>
    </div>
    <div class="card-body">
        <div class="row" >
            <div class="col-md-12">
                <form class="form-inline" id="unmanagtErrorDetail"> 
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">과제코드</label>
                        <div class="col-sm-8">
                            <input type="text" id="" class="form-control" style="width:70%;margin-right: 3px;" value="H001">
                         </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">과제명</label>
                        <div class="col-sm-8">
                            <input type="text" id="" class="form-control" style="width:70%;margin-right: 3px;">
                        </div>
                    </div>
                    
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">프로세스코드</label>
                        <div class="col-sm-8">
                            <input type="text" id="" class="form-control" style="width:70%;margin-right: 3px;" value="H00100">
                         </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">프로세스명</label>
                        <div class="col-sm-8">
                            <input type="text" id="" class="form-control" style="width:70%;margin-right: 3px;">
                        </div>
                    </div>                                      
                     
                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">프로세스아이디</label>
                        <div class="col-sm-8">
                            <input type="text" id="" class="form-control" style="width:70%;margin-right: 3px;" value="120006">
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">예상소요시간</label>
                        <div class="col-sm-8 float-left">
                            <input type="text" id="" class="form-control float-left" style="width:30%;margin-right: 3px;" value="50">분
                         </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">정기실행계획</label>
                        <div class="col-sm-8 float-left">
	                       <input type="text" id="" class="form-control float-left" style="width:70%;margin-right: 3px;" value="2020-08-01~2025-12-31 매주 월요일 21:00">
	                       <button type="button" id="btnSave"class="btn btn-outline-primary float-left" style="margin: 0;">정기실행등록</button>
	                    </div>
	                </div>
	                <div class="form-group col-md-6">  </div>
                    
                    <div class="col-md-12 m-3"></div>
	                <div class="form-group col-md-12">
		                <div class="col-sm-9"><h5 class="text-success float-left">⊙ 로봇예약정보</h5></div>
	                        <div class="col-sm-3 float-right"> 
	                              <div class="input-group date  float-right" id="startDeDiv" data-target-input="nearest"style="width:50%; min-width:130px;margin: 0 0 2px 0;">
	                                  <input type="text" id="startDe" name="startDe" class="form-control datetimepicker-input" data-target="#startDeDiv"value="2020-08-05"/>
	                                  <div class="input-group-append" data-target="#startDeDiv" data-toggle="datetimepicker">
	                                      <div class="input-group-text"><i class="fa fa-calendar"></i></div>
	                                  </div>
	                              </div>
	                          </div>
	                    </div>  	                
                    </div>                
	                
                    <div class="form-group col-md-12 table-wrap">
	                    <table class="table-borderless table-light" >
                            <colgroup>
                              <col width="*">
                              <col width="14%">
                              <col width="14%">
                              <col width="14%">
                              <col width="14%">
                              <col width="14%">
                              <col width="14%">
                            </colgroup>
                            <thead>                             
                                <tr>
                                    <th>time</th>
                                    <th>BOT1</th>
                                    <th>BOT2</th>
                                    <th>BOT3</th>
                                    <th>BOT4</th>
                                    <th>BOT5</th>
                                    <th>BOT6</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <th>00:00</th>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <th>00:10</th>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                  </tr>
                                   <tr>
                                    <th>00:20</th>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <th>00:30</th>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <th>00:40</th>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <th>00:50</th>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                  </tr>
                                   <tr>
                                    <th>01:00</th>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <th>01:10</th>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td class="color small">H01101</td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                  </tr>                                  
                                  <tr>
                                    <th>01:20</th>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <th>01:30</th>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                  </tr>
                                   <tr>
                                    <th>01:40</th>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <th>01:50</th>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>                                   
                                    <td></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <th>02:00</th>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <th>02:10</th>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                  </tr>
                                   <tr>
                                    <th>02:20</th>
                                    <td class="color small">H01101</td>
                                    <td class="color small">H01101</td>
                                    <td class="color small">H01101</td>
                                    <td></td>                                    
                                    <td></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <th>02:30</th>
                                    <td class="color small">H01101</td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                    <td></td>                                    
                                    <td></td>
                                    <td></td>
                                  </tr>
                                  
                                  <tr>
                                    <th>02:40</th>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <th>02:50</th>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                  </tr>
                                   <tr>
                                    <th>03:00</th>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <th>03:10</th>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <th>03:20</th>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <th>03:30</th>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                  </tr>
                                   <tr>
                                    <th>03:40</th>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <th>03:50</th>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td class="color small">H01101</td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                  </tr>                                  
                                  <tr>
                                    <th>04:00</th>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <th>04:10</th>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                  </tr>
                                   <tr>
                                    <th>04:20</th>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <th>04:30</th>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td class="color small">H01101</td>
                                  </tr>
                                  <tr>
                                    <th>04:40</th>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td class="color small">H01101</td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <th>04:50</th>
                                    <td class="color small">H01101</td>
                                    <td class="color small">H01101</td>
                                     <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <th>05:00</th>
                                    <td class="color small">H01101</td>
                                     <td></td>
                                    <td class="color small">H01101</td>
                                    <td></td>                                    
                                    <td></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <th>05:10</th>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td></td>                                    
                                    <td></td>
                                    <td></td>
                                  </tr>
                                  
                                  <tr>
                                    <th>05:20</th>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <th>05:30</th>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                  </tr>
                                   <tr>
                                    <th>05:40</th>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <th>05:50</th>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <th>06:00</th>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <th>06:10</th>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                  </tr>
                                   <tr>
                                    <th>06:20</th>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <th>06:30</th>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td class="color small">H01101</td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                  </tr>                                  
                                  <tr>
                                    <th>06:40</th>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <th>06:50</th>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                  </tr>
                                   <tr>
                                    <th>07:00</th>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <th>07:10</th>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>                                   
                                    <td></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <th>07:20</th>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <th>07:30</th>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                  </tr>
                                   <tr>
                                    <th>07:40</th>
                                    <td class="color small">H01101</td>
                                    <td class="color small">H01101</td>
                                    <td class="color small">H01101</td>
                                    <td></td>                                    
                                    <td></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <th>07:50</th>
                                    <td class="color small">H01101</td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                    <td></td>                                    
                                    <td></td>
                                    <td></td>
                                  </tr>                                  
                                  <tr>
                                    <th>08:00</th>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <th>08:10</th>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                  </tr>
                                   <tr>
                                    <th>08:20</th>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                  </tr>
                                  <tr>
                                    <th>08:30</th>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <th>08:40</th>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <th>08:50</th>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                  </tr>
                                   <tr>
                                    <th>09:00</th>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <th>09:10</th>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td class="color small">H01101</td>
                                    <td class="color small">H01101</td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                  </tr>                                  
                                  <tr>
                                    <th>09:20</th>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <th>09:30</th>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td class="color small">H01101</td>
                                  </tr>
                                   <tr>
                                    <th>09:40</th>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <th>09:50</th>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td class="color small">H01101</td>
                                  </tr>
                                  <tr>
                                    <th>10:00</th>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td class="color small">H01101</td>
                                    <td class="color small">H01101</td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <th>10:10</th>
                                    <td class="color small">H01101</td>
                                    <td class="color small">H01101</td>
                                     <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <th>10:20</th>
                                    <td class="color small">H01101</td>
                                     <td></td>
                                    <td class="color small">H01101</td>
                                    <td></td>                                    
                                    <td></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <th>10:30</th>
                                    <td></td>
                                    <td></td>
                                    <td class="color small">H01101</td>
                                    <td></td>                                    
                                    <td></td>
                                    <td></td>
                                  </tr>
                             </tbody>
                        </table>
                  </div>
               </form>
                <div id="divSearchUser" class="modal fade" tabindex="-1" role="dialog"></div>
            </div>
        </div>
    </div>
</div>
<script>

$(document).ready(function() {
    //이벤트 바인딩
    pageInit();
    bindEvent();
});
    /*
     * 이벤트 바인딩
     * @param
     * @return
     */
    function bindEvent() {
        
        $("#unmanagtErrorDetailCancelBtn").on("click", function() { 
            closePop();
        });
    }
</script>
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
</body>
</html>