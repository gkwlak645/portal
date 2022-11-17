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
                            <h1 class="m-0 text-dark">명예의전당</h1>
                        </div>
                        <!-- /.col -->
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
                                <li class="breadcrumb-item">커뮤니티 / 명예의전당</li>
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
				    <div class="card-header" alt="커뮤니티 >시스템작업공지상세">
				        <h3 class="card-title">상세조회</h3>
				    </div>
				    <div class="card-body">
				        <div class="row" style="min-height:674px;">
				            <div class="col-md-12">
				                 <form class="form-inline" id="unmanagtErrorDetail">    
				                    <div class="form-group col-md-6 py-sm-2">
				                        <label for="errorCn" class="col-sm-2 col-form-label">연도</label>
				                        <div class="col-sm-10">
				                            <input type="text" id="" class="form-control" style="width:30%;" value="2020" readonly>
				                        </div>
				                    </div>  
				                    <div class="form-group col-md-6 py-sm-2"">
				                        <label for="errorCn" class="col-sm-2 col-form-label">회사</label>
				                        <div class="col-sm-10">
				                            <input type="text" id="" class="form-control" style="width:30%;" value="동원산업" readonly>
				                        </div>
				                    </div>
				                    
				                    <div class="form-group col-md-6 py-sm-2">
                                        <label for="errorCn" class="col-sm-2 col-form-label">부서</label>
                                        <div class="col-sm-10">
                                            <input type="text" id="" class="form-control" style="width:30%;" value="IT실" readonly>
                                        </div>
                                    </div>  
                                    <div class="form-group col-md-6 py-sm-2"">
                                        <label for="errorCn" class="col-sm-2 col-form-label">성명</label>
                                        <div class="col-sm-10">
                                            <input type="text" id="" class="form-control" style="width:30%;" value="홍길동" readonly>
                                        </div>
                                    </div> 
                                    
                                    <div class="form-group col-md-6 py-sm-2">
                                        <label for="errorCn" class="col-sm-2 col-form-label">랭킹</label>
                                        <div class="col-sm-10">
                                            <input type="text" id="" class="form-control" style="width:30%;" value="1" readonly>
                                        </div>
                                    </div>  
                                    <div class="form-group col-md-6 py-sm-2">
                                        <label for="errorCn" class="col-sm-2 col-form-label">기여점수</label>
                                        <div class="col-sm-10">
                                            <input type="text" id="" class="form-control" style="width:30%;" value="1000" readonly>
                                        </div>
                                    </div>
				                                      
				                    <div class="form-group col-md-12 py-sm-2">
				                        <table class="table" style="margin-top:20px;">
				                            <colgroup>
				                              <col width="20%">				                              
				                              <col width="20%">
				                              <col width="*">
				                              <col width="15%">
				                              <col width="15%">
				                            </colgroup>
				                            <thead>                             
				                                <tr>
				                                    <th>과제코드</th>
				                                    <th>프로세스코드</th>
				                                    <th>프로세스명</th>
				                                    <th>절감시간</th>
                                                    <th>기여점수</th>
				                                </tr>
				                            </thead>
				                            <tbody>
				                                <tr>
				                                    <td>A001</td>
				                                    <td>A00101</td>
				                                    <td>프로세스명이 들어옵니다</td>
				                                    <td>100000</td>
				                                    <td>100</td>
				                                </tr>
				                                <tr>
                                                    <td>A001</td>
                                                    <td>A00101</td>
                                                    <td>프로세스명이 들어옵니다</td>
                                                    <td>100000</td>
                                                    <td>100</td>
                                                </tr>
                                                <tr>
                                                    <td>A001</td>
                                                    <td>A00101</td>
                                                    <td>프로세스명이 들어옵니다</td>
                                                    <td>100000</td>
                                                    <td>100</td>
                                                </tr>
				                              </tbody>
				                         </table>
				                     </div>  
				                </form>
				                <div class="float-right py-sm-3">
				                    <button type="button" class="btn btn-primary" id="closeBtn">닫기</button>
				                </div>
				                <div id="divSearchUser" class="modal fade" tabindex="-1" role="dialog"></div>
				            </div>
				        </div>
				    </div>
				</div>
<script>
$(document).ready(function() {
});
    /*
     * 이벤트 바인딩
     * @param
     * @return
     */
    function bindEvent() {
        
        $("#closeBtn").on("click", function() { 
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