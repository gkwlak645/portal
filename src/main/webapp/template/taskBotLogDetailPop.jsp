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
                            <h1 class="m-0 text-dark">프로세스 상태 정보</h1>
                        </div>
                        <!-- /.col -->
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
                                <li class="breadcrumb-item">모니터링 / BOT별 동작현황</li>
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
    <div class="card-header">
        <h3 class="card-title">상세조회</h3>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-12">
                                    <form class="form-inline" id="trnscErrorDetail">
                                        <div class="form-group col-md-6 py-sm-2">
                                            <label for="trnscErrorSn" class="col-sm-4 col-form-label">회사</label>
                                            <div class="col-sm-8">
                                                 <input type="text" id="trnscErrorSn" class="form-control" disabled style="width:80%;" />
                                            </div>
                                        </div>
                                        <div class="form-group col-md-6 py-sm-2">
                                            <label for="errorUnitySn" class="col-sm-4 col-form-label">발생일시</label>
                                            <div class="col-sm-8">
                                                 <input type="text" id="errorUnitySn" class="form-control" disabled style="width:80%;" />
                                            </div>
                                        </div>
                                        <div class="form-group col-md-6 py-sm-1">
                                            <label for="reprsntAt" class="col-sm-4 col-form-label">프로세스코드</label>
                                            <div class="col-sm-8">
                                                 <input type="text" id="reprsntAt" class="form-control" disabled style="width:80%;" />
                                            </div>
                                        </div>
                                        <div class="form-group col-md-6 py-sm-1">
                                            <label for="cmpnyNm" class="col-sm-4 col-form-label">프로세스명</label>
                                            <div class="col-sm-8">
                                                <input type="text" id="cmpnyNm" class="form-control" disabled style="width:80%;"/>
                                            </div>
                                        </div>
                                        <div class="form-group col-md-12 py-sm-2">
                                            <label for="errorCn" class="col-sm-2 col-form-label">오류메세지</label>
                                            <div class="col-sm-10">
                                                <textarea rows="1" id="errorCn" class="form-control" disabled style="width:92.5%;"></textarea>
                                            </div>
                                        </div>
                                        <div class="form-group col-md-12 py-sm-2">
                                            <label for="errorCn" class="col-sm-2 col-form-label">오류내용</label>
                                            <div class="col-sm-10">
                                                <textarea rows="3" id="errorCn" class="form-control" maxlength="1000" disabled style="width:92.5%;"></textarea>
                                            </div>
                                        </div>
                                        <div class="form-group col-md-12 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                                            <label class="col-sm-2 col-form-label">스크린샷</label>
                                            <div class="col-sm-10" id="screenImg">
                                                <image id="screenShotDetl" src="" style="width:450px;height:150px;"></image>
                                                <p class="text-success">이미지를 클릭하시면 원래 크기를 볼 수 있습니다.</p>
                                            </div>
                                        </div>                                      
                                    </form>
                                    <div class="py-sm-2 float-right">
                                        <button type="button" class="btn btn-primary" id="trnscErrorCancel">닫기</button>
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
</body>
</html>