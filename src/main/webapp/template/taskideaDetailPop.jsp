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
                            <h1 class="m-0 text-dark">과제아이디어등록</h1>
                        </div>
                        <!-- /.col -->
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
                                <li class="breadcrumb-item">과제 / 과제아이디어등록</li>
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
    <div class="card-header" alt="과제 >과제아이디어상세">
        <h3 class="card-title">상세조회</h3>
    </div>
    <div class="card-body">
        <div class="row">
            <div class="col-md-12">
                <form class="form-inline" id="unmanagtErrorDetail">                    
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">등록번호</label>
                        <div class="col-sm-8">
                            <input type="text" id="" class="form-control"  style="width:80%;" value="20200818001" disabled>
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">상태</label>
                        <div class="col-sm-8">
                            <input type="text" id="" class="form-control"  style="width:80%;" value="등록" disabled>
                        </div>
                    </div>
                    <div class="form-group col-md-12">
                        <label for="errorTyCd" class="col-sm-2 col-form-label">제목<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-10">
                            <input type="text" id="" class="form-control"  style="width:92.5%;"/>
                        </div>
                    </div>
                    <div class="form-group col-md-12 py-sm-1">
                        <label for="errorCn" class="col-sm-2 col-form-label">업무설명<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-10">
                            <textarea rows="2" id="" class="form-control" style="width:92.5%;"></textarea>
                        </div>
                    </div>                    
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">업무분류</label>
                        <div class="col-sm-8">
                            <select id="" class="form-control" style="width:80%;margin-right: 3px;" type="text" >
                                <option value="">영업</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">구분</label>
                        <div class="col-sm-8">
                            <select id="" class="form-control" style="width:80%;margin-right: 3px;" type="text" >
                                <option value="">RPA</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">회사</label>
                        <div class="col-sm-8">
                            <input type="text" id="" class="form-control"  style="width:80%;" value="동원" disabled>
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">부서</label>
                        <div class="col-sm-8">
                            <input type="text" id="" class="form-control"  style="width:80%;" value="혁신팀" disabled>
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">담당자</label>
                        <div class="col-sm-8 float-left">
                            <input type="text" id="" class="form-control float-left"  style="width:70px;margin-right:5px;" value="홍길동" disabled /> 
                            <input type="text" id="" class="form-control float-left"  style="width:200px;" value="hgd@dongwon.com" disabled />
                        </div>
                    </div>    
                     
                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">연락처</label>
                        <div class="col-sm-8">
                            <input type="text" id="" class="form-control"  style="width:150px;" value="010-0000-0000" disabled />  
                        </div>
                    </div>                       
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">업무시간</label>
                        <div class="col-sm-8 float-left">
                            <input type="text" id="" class="form-control float-left" style="width:120px;margin-right: 3px;" value="264" type="text" >H
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">빈도</label>
                        <div class="col-sm-8 float-left">
                            <select id="" class="form-control float-left" style="width:30%;margin-right: 10px;" type="text" >
                                <option value="">월</option>
                            </select>
                            <input type="text" id="" class="form-control float-left" style="width:120px;margin-right: 3px;" type="text" value="22">회
                        </div>
                    </div>     
                    <div class="form-group col-md-12">
                        <label for="errorTyCd" class="col-sm-2 col-form-label">개발사유<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-10">
                            <input type="text" id="" class="form-control"  style="width:92.5%;"/>
                        </div>
                    </div>
                    <div class="form-group col-md-12  py-sm-2">
                        <label for="errorCn" class="col-sm-2 col-form-label">기대효과</label>
                        <div class="col-sm-10">
                            <textarea rows="2" id="" class="form-control" style="width:92.5%;"></textarea>
                        </div>
                    </div>
                    <div class="form-group col-md-12">
                        <label for="managtChargerId" class="col-sm-2 col-form-label">첨부파일 </label>
                       <div class="col-sm-10"><div class="form-check2 row"  id="fileUpload"></div></div>
                   </div>
                   
                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">연관문서 </label>
                        <div class="col-sm-8">
                            <input type="text" id="" class="form-control"  style="width:80%;">
                       </div>
                   </div>
                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">검토대상여부 </label>
                        <div class="col-sm-8">
                             <select id="" class="form-control float-left" style="width:30%;margin-right: 10px;" type="text" >
                                <option value="">대상</option>
                            </select>
                        </div>
                    </div>
                </form>
                <div class="float-right">
                    <button type="button" class="btn btn-primary" id="unmanagtErrorDetailUpdateBtn">확인</button>
                    <button type="button" class="btn btn-primary" id="unmanagtErrorDetailUpdateBtn">검토대상</button>
                    <button type="button" class="btn btn-primary" id="unmanagtErrorDetailUpdateBtn">등록</button>
                    <button type="button" class="btn btn-primary" id="unmanagtErrorDetailCancelBtn">닫기</button>
                </div>
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
    
    function pageInit(){
        bbsUpload = new RpaUpload("fileUpload");
        bbsUpload.draw('',true);
    };
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
</body>
</html>