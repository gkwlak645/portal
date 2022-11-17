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
                            <h1 class="m-0 text-dark">JOB오류관리 상세</h1>
                        </div>
                        <!-- /.col -->
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
                                <li class="breadcrumb-item">모니터링/ JOB오류관리</li>
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
								<div class="card card-primary" id="cardDiv">
								    <div class="card-header">
								        <h3 class="card-title">상세조회</h3>
								    </div>
								    <div class="card-body">
								        <div class="row">
								            <div class="col-md-12">
								                <form class="form-inline" id="jobErrorDetail">
									                <div class="form-group col-md-12 py-sm-1">
									                    <label for="cmpnyNm" class="col-sm-2 col-form-label">회사</label>
									                    <div class="col-sm-10">
										                    <input type="text" id="cmpnyNm" class="form-control" disabled />
									                    </div>
									                </div>
									                <div class="form-group col-md-6 py-sm-1">
									                    <label for="occrrncSeCd" class="col-sm-4 col-form-label">오류발생구분<b style="color: red;"> *</b></label>
								                        <div class="col-sm-8">
								                            <select id="occrrncSeCd" name="occrrncSeCd" class="form-control" style="width:80%;"></select>
								                        </div>
									                </div>
									                <div class="form-group col-md-6 py-sm-1">
								                        <label for="tyCd" class="col-sm-4 col-form-label">오류유형<b style="color: red;"> *</b></label>
								                        <div class="col-sm-8">
								                            <select id="tyCd" name="tyCd" class="form-control" style="width:80%;"></select>
								                        </div>
								                    </div>
									                <div class="form-group col-md-6 py-sm-1">
									                    <label for="occrrncDe" class="col-sm-4 col-form-label">발생일</label>
									                    <div class="col-sm-8">
									                        <input type="text" id="occrrncDe" class="form-control" disabled style="width:80%;" />
									                    </div>
									                </div>
									                <div class="form-group col-md-6 py-sm-1">
									                    <label for="occrrncHm" class="col-sm-4 col-form-label">발생시간</label>
									                    <div class="col-sm-8">
									                        <input type="text" id="occrrncHm" class="form-control" disabled style="width:80%;"/>
									                    </div>
									                </div>
									                <div class="form-group col-md-6 py-sm-2">
									                    <label for="processCd" class="col-sm-4 col-form-label">프로세스코드</label>
									                    <div class="col-sm-8">
									                        <input type="text" id="processCd" class="form-control" disabled style="width:80%;"/>
									                    </div>
									                </div>
									                <div class="form-group col-md-6">
								                        <label for="processNm" class="col-sm-4 col-form-label">프로세스명</label>
								                        <div class="col-sm-8">
								                            <input type="text" id="processNm" class="form-control" disabled style="width:80%;"/>
								                        </div>
								                    </div>
								                    <div class="form-group col-md-12 py-sm-2">
								                        <label for="errorCn" class="col-sm-2 col-form-label">오류내용</label>
								                        <div class="col-sm-10">
								                            <textarea rows="3" id="errorCn" class="form-control" maxlength="1000" disabled style="width:92.5%;"></textarea>
								                        </div>
								                    </div>
								                    <div class="form-group col-md-6 py-sm-2">
								                        <label for="managtDe" class="col-sm-4 col-form-label">조치일<b style="color: red;"> *</b></label>
								                        <div class="col-sm-8">
								                            <div class="input-group date" id="managtDiv" data-target-input="nearest" style="width:80%;min-width:140px;">
								                                 <input type="text" id="managtDe" name="managtDe" class="form-control datetimepicker-input"  data-target="#jobErrorDetail #managtDiv" />
								                                 <div class="input-group-append" data-target="#jobErrorDetail #managtDiv" data-toggle="datetimepicker" >
								                                     <div class="input-group-text"><i class="fa fa-calendar"></i></div>
								                                 </div>
								                             </div>
								                        </div>
								                    </div>
								                    <div class="form-group col-md-6 py-sm-2">
								                        <label for="managtHm" class="col-sm-4 col-form-label">조치시간</label>
								                        <div class="col-sm-8 float-left">
								                             <select id="managtHm" name="managtHm" class="form-control float-left" style="width:25%;">
								                                <option value="0000">00</option>
								                                <option value="0100">01</option>
								                                <option value="0200">02</option>
								                                <option value="0300">03</option>
								                                <option value="0400">04</option>
								                                <option value="0500">05</option>
								                                <option value="0600">06</option>
								                                <option value="0700">07</option>
								                                <option value="0800">08</option>
								                                <option value="0900">09</option>
								                                <option value="1000">10</option>
								                                <option value="1100">11</option>
								                                <option value="1200">12</option>
								                                <option value="1300">13</option>
								                                <option value="1400">14</option>
								                                <option value="1500">15</option>
								                                <option value="1600">16</option>
								                                <option value="1700">17</option>
								                                <option value="1800">18</option>
								                                <option value="1900">19</option>
								                                <option value="2000">20</option>
								                                <option value="2100">21</option>
								                                <option value="2200">22</option>
								                                <option value="2300">23</option>
								                                <option value="2400">24</option>
								                             </select>&nbsp;시간
								                             <!-- <select id="managtHm" name="managtHm" class="form-control" style="width:40%;"></select> -->
								                        </div>
								                    </div>
								                    <div class="form-group col-md-6 py-sm-1">
								                        <label for="processTm" class="col-sm-4 col-form-label">처리시간</label>
								                        <div class="col-sm-8">
								                            <input type="text" id="processTm" name="processTm" class="form-control" maxlength="4" style="width:80%;" numberOnly2/>
								                        </div>
								                    </div>
								                    <div class="form-group col-md-6 py-sm-1">
								                        <label for="seDe" class="col-sm-4 col-form-label">구분날짜</label>
								                        <div class="col-sm-8">
								                            <div class="input-group date" id="seDeDiv" style="width:80%;min-width:140px;"data-target-input="nearest">
								                                 <input type="text" id="seDe" name="seDe" class="form-control datetimepicker-input" data-target="#jobErrorDetail #seDeDiv"/>
								                                 <div class="input-group-append" data-target="#jobErrorDetail #seDeDiv" data-toggle="datetimepicker" >
								                                     <div class="input-group-text"><i class="fa fa-calendar"></i></div>
								                                 </div>
								                             </div>
								                        </div>
								                    </div>
								                    <div class="form-group col-md-12 py-sm-2">
								                        <label for="managtCn" class="col-sm-2 col-form-label">조치내용<b style="color: red;"> *</b></label>
								                        <div class="col-sm-10">
								                            <textarea rows="3" id="managtCn" class="form-control" maxlength="1000" style="width:92.5%;"></textarea>
								                        </div>
								                    </div>
								                    <div class="form-group col-md-6 py-sm-2">
								                        <label for="managtTyCd" class="col-sm-4 col-form-label">조치유형</label>
								                        <div class="col-sm-8">
								                            <select id="managtTyCd" name="managtTyCd" class="form-control" style="width:80%;"></select>
								                        </div>
								                    </div>
								                    <div class="form-group col-md-6 py-sm-2">
								                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">소스수정내역ID<b style="color: red;"> *</b></label>
								                        <div class="col-sm-8 float-left">
								                            <input type="hidden" id="sourcUpdtId" name="sourcUpdtId">
								                            <input type="text" id="sourcUpdtNm" class="form-control float-left" style="width:65%;margin-right:5px" disabled/>
								                            <button type="button" class="btn btn-outline-primary float-left" id="btnSchSourcUpdtId">찾기</button>
								                        </div>
								                    </div>
								                    <div class="form-group col-md-6">
								                        <label for="devlopChargerId" class="col-sm-4 col-form-label">개발담당자<b style="color: red;"> *</b></label>
								                        <div class="col-sm-8 float-left">
								                            <input type="hidden" id="devlopChargerId" name="devlopChargerId">
								                            <input type="text" id="devlopChargerNm" class="form-control float-left"  style="width:65%;margin-right:5px" disabled/>
								                            <button type="button" class="btn btn-outline-primary float-left" id="btnSchDevlopChargerId">찾기</button>
								                        </div>
								                    </div>
								                    <div class="form-group col-md-6 py-sm-2">
								                        <label for="managtChargerId" class="col-sm-4 col-form-label">조치담당자<b style="color: red;"> *</b></label>
								                        <div class="col-sm-8 float-left">
								                            <input type="hidden" id="managtChargerId" name="managtChargerId">
								                            <input type="text" id="managtChargerNm" class="form-control float-left"  style="width:65%;margin-right:5px" disabled/>
								                            <button type="button" class="btn btn-outline-primary float-left" id="btnSchManagtChargerId">찾기</button>
								                        </div>
								                    </div>
								                    <div class="form-group col-md-6 py-sm-1">
								                        <label for="occrrncRobotId" class="col-sm-4 col-form-label">발생로봇<b style="color: red;"> *</b></label>
								                        <div class="col-sm-8">
								                            <input type="text" id="occrrncRobotId" class="form-control"  style="width:80%;"/>
								                        </div>
								                    </div>
								                    <div class="form-group col-md-6 py-sm-1">
								                        <label for="managtSttusCd" class="col-sm-4 col-form-label">현상태<b style="color: red;"> *</b></label>
								                        <div class="col-sm-8">
								                            <select id="managtSttusCd" name="managtSttusCd" class="form-control" style="width:80%;"></select>
								                        </div>
								                    </div>
								                </form>
								                <div class="py-sm-2 float-right" >
								                    <button type="button" class="btn btn-primary" id="jobErrorSave">저장</button>
								                    <button type="button" class="btn btn-primary" id="jobErrorCancel">닫기</button>
								                </div>
								                <div id="divSearchUser" class="modal fade" tabindex="-1" role="dialog"></div>
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








