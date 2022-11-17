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
                            <h1 class="m-0 text-dark">일일미조치현황 상세</h1>
                        </div>
                        <!-- /.col -->
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
                                <li class="breadcrumb-item">모니터링/ 일일미조치현황</li>
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
                    <div class="card card-primary" id="unmanagtErrorDetailDiv">
					    <div class="card-header">
					        <h3 class="card-title">상세조회</h3>
					    </div>
					    <div class="card-body">
					        <div class="row">
					            <div class="col-md-12">
					                <form class="form-inline" id="unmanagtErrorDetail">
					                    <div class="form-group col-md-6 py-sm-2">
					                        <label for="cmpnyCd" class="col-sm-4 col-form-label">회사</label>
					                        <div class="col-sm-8">
					                            <select id="cmpnyCd" class="form-control" style="width:80%;">
					                                  <option value=""></option>
					                            </select>
					                        </div>
					                    </div>
					                    <div class="form-group col-md-6 py-sm-2">
					                        <label for="unmanagtDe" class="col-sm-4 col-form-label">미조치일</label>
					                        <div class="col-sm-6">
					                            <div class="input-group date" id="unmanagtDeDiv" data-target-input="nearest"style="width:80%;min-width:200px;">
					                                <input type="text" id="unmanagtDe" name="unmanagtDe" class="form-control datetimepicker-input" data-target="#unmanagtErrorDetail #unmanagtDeDiv"/>
					                                <div class="input-group-append" data-target="#unmanagtDeDiv" data-toggle="datetimepicker">
					                                    <div class="input-group-text"><i class="fa fa-calendar"></i></div>
					                                </div>
					                            </div>
					                        </div>
					                    </div>
					                    <div class="form-group col-md-6 py-sm-2">
					                        <label for="processCdDetailPop" class="col-sm-4 col-form-label">프로세스코드</label>
					                        <div class="col-sm-8">
					                            <select id="processCdDetailPop" class="form-control" style="width:80%;">
					                                  <option value=""></option>
					                            </select>
					                            <select id="processCdDetailHidden" style="display:none" class="form-control" >
					                                  <option value=""></option>
					                            </select>
					                        </div>
					                    </div>
					                    <div class="form-group col-md-6 py-sm-2">
					                        <label for="processNm" class="col-sm-4 col-form-label">프로세스명</label>
					                        <div class="col-sm-8">
					                            <input type="text" id="processNm" class="form-control" disabled style="width:80%;"/>
					                        </div>
					                    </div>
					                    <div class="form-group col-md-6 py-sm-2">
					                        <label for="errorOccrrncSeCd" class="col-sm-4 col-form-label">오류발생구분</label>
					                        <div class="col-sm-8">
					                            <select id="errorOccrrncSeCd" name="errorOccrrncSeCd" class="form-control" style="width:80%;"></select>
					                        </div>
					                    </div>
					                    <div class="form-group col-md-6 py-sm-2">
					                        <label for="errorTyCd" class="col-sm-4 col-form-label">오류유형</label>
					                        <div class="col-sm-8">
					                            <select id="errorTyCd" name="errorTyCd" class="form-control" style="width:80%;"></select>
					                        </div>
					                    </div>
					                    <div class="form-group col-md-12 py-sm-2">
					                        <label for="errorCn" class="col-sm-2 col-form-label">오류상세내용</label>
					                        <div class="col-sm-10">
					                            <textarea rows="3" id="errorCn" class="form-control" style="width:92.5%;"></textarea>
					                        </div>
					                    </div>
					                    <div class="form-group col-md-12 py-sm-2">
					                        <label for="managtCn" class="col-sm-2 col-form-label">조치상세내용</label>
					                        <div class="col-sm-10">
					                            <textarea rows="3" id="managtCn" class="form-control" style="width:92.5%;"></textarea>
					                        </div>
					                    </div>
					                    <div class="form-group col-md-6 py-sm-2">
					                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">소스수정내역ID</label>
					                        <div class="col-sm-8">
					                            <input type="hidden" id="sourcUpdtId" name="sourcUpdtId">
					                            <input type="text" id="sourcUpdtNm" class="form-control" style="width:80%;" />
					                        </div>
					                    </div>
					                    <div class="form-group col-md-6 py-sm-2">
					                        <label for="managtChargerId" class="col-sm-4 col-form-label">조치담당자</label>
					                        <div class="col-sm-8">
					                            <input type="hidden" id="managtChargerId" name="managtChargerId">
					                            <input type="text" id="managtChargerNm" class="form-control"  style="width:80%;"/>
					                        </div>
					                    </div>
					                    <div class="form-group col-md-6 py-sm-2">
					                        <label for="occrrncDe" class="col-sm-4 col-form-label">발생일</label>
					                        <div class="col-sm-6">
					                            <div class="input-group date" id="occrrncDeDiv" data-target-input="nearest"style="width:80%;min-width:200px;">
					                                <input type="text" id="occrrncDe" name="occrrncDe" class="form-control datetimepicker-input" data-target="#unmanagtErrorDetail #occrrncDeDiv"/>
					                                <div class="input-group-append" data-target="#occrrncDeDiv" data-toggle="datetimepicker">
					                                    <div class="input-group-text"><i class="fa fa-calendar"></i></div>
					                                </div>
					                            </div>
					                        </div>                        
					                    </div>
					                    <div class="form-group col-md-6 py-sm-2">
					                        <label for="managtPrearngeDe" class="col-sm-4 col-form-label">조치예정일</label>
					                        <div class="col-sm-6">
					                            <div class="input-group date" id="managtPrearngeDeDiv" data-target-input="nearest"style="width:80%;min-width:200px;">
					                                <input type="text" id="managtPrearngeDe" name="managtPrearngeDe" class="form-control datetimepicker-input" data-target="#unmanagtErrorDetail #managtPrearngeDeDiv"/>
					                                <div class="input-group-append" data-target="#managtPrearngeDeDiv" data-toggle="datetimepicker">
					                                    <div class="input-group-text"><i class="fa fa-calendar"></i></div>
					                                </div>
					                            </div>
					                        </div>                        
					                    </div>
					                    <div class="form-group col-md-6 py-sm-2">
					                        <label for="managtComptDe" class="col-sm-4 col-form-label">조치완료일</label>
					                        <div class="col-sm-6">
					                            <div class="input-group date" id="managtComptDeDiv" data-target-input="nearest"style="width:80%;min-width:200px;">
					                                <input type="text" id="managtComptDe" name="managtComptDe" class="form-control datetimepicker-input" data-target="#unmanagtErrorDetail #managtComptDeDiv"/>
					                                <div class="input-group-append" data-target="#managtComptDeDiv" data-toggle="datetimepicker">
					                                    <div class="input-group-text"><i class="fa fa-calendar"></i></div>
					                                </div>
					                            </div>
					                        </div>
					                    </div>
					                    <div class="form-group col-md-6 py-sm-2">
					                        <label for="tyCd" class="col-sm-4 col-form-label">현상태</label>
					                        <div class="col-sm-8">
					                            <select id="managtSttusCd" name="managtSttusCd" class="form-control" style="width:80%;"></select>
					                        </div>
					                    </div>
					                    <div class="form-group col-md-6 py-sm-2">
					                        <label for="opertTm" class="col-sm-4 col-form-label">작업시간</label>
					                        <div class="col-sm-8 float-left">
					                             <input type="text" id="opertTm" class="form-control float-left" style="width:25%;margin-right:5px;" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength=4/> 시간
					                        </div>
					                    </div>
					                    <div class="form-group col-md-6 py-sm-2">
					                        <label for="jobChargerGrpwrId" class="col-sm-4 col-form-label">업무담당자</label>
					                        <div class="col-sm-8">
					                            <input type="hidden" id="jobChargerGrpwrId" name="jobChargerGrpwrId">
					                            <input type="text" id="jobChargerGrpwrNm" class="form-control"  style="width:80%;"/>
					                        </div>
					                    </div>                  
					                </form>
					                <div class="float-right">
					                    <button type="button" class="btn btn-primary" id="unmanagtErrorDetailUpdateBtn">저장</button>
					                    <button type="button" class="btn btn-primary" id="unmanagtErrorDetailCancelBtn">닫기</button>
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
    










