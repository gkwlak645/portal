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
                            <h1 class="m-0 text-dark">Dashboard</h1>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
                                <li class="breadcrumb-item">Dashboard</li>
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
                

<!-- 관리자 화면 -->
<div class="container-fluid">
    <div class="content row">
        <section class="col-lg-12">
            <div class="card">
                <div class="card-body">

                    <!-- 관리자 대시보드  -->
                    <div class="board-wrap">
                        <!-- 버튼 -->
                        <div class="board-btns-wrap">
                            <div class="board-btns">
                                <a id="btnWeek" class="board-btn" href="javascript:;">Week</a>
                                <a id="btnMonth" class="board-btn" href="javascript:;">Month</a>
                                <a id="btnYear" class="board-btn" href="javascript:;">Year</a>
                                <a id="btnTotal" class="board-btn active" href="javascript:;">Total</a>
                            </div>
                        </div>
                        <!-- 테이블 -->
                        <div class="board-container">
                            <table>
                                <caption></caption>
                                <colgroup>
                                    <col style="width: 100px;">
                                    <col style="width: 100px;">
                                    <col>
                                    <col>
                                    <col>
                                    <col>
                                    <col>
                                    <col>
                                    <col>
                                </colgroup>
                                <thead>
                                    <tr class="board-row">
                                        <th scope="col">구분</th>
                                        <th scope="col">그룹</th>
                                        <th scope="col">산업</th>
                                        <th scope="col">로엑스</th>
                                        <th scope="col">F&B</th>
                                        <th scope="col">홈푸드</th>
                                        <th scope="col">시스템즈</th>
                                        <th scope="col">시스템즈</th>
                                        <th scope="col">시스템즈</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr id="tableRowTotal" class="board-row active"><!-- 활성화 .active 추가 -->
                                        <th rowspan="4" scope="row">절감시간</th>
                                        <td class="board-row-name">누적</td>
                                        <td>000,000</td>
                                        <td>000,000</td>
                                        <td>000,000</td>
                                        <td>000,000</td>
                                        <td>000,000</td>
                                        <td>000,000</td>
                                        <td>000,000</td>
                                    </tr>
                                    <tr id="tableRowYear" class="board-row">
                                        <td class="board-row-name">누계</td>
                                        <td>누적</td>
                                        <td>누적</td>
                                        <td>누적</td>
                                        <td>누적</td>
                                        <td>누적</td>
                                        <td>누적</td>
                                        <td>누적</td>
                                    </tr>
                                    <tr id="tableRowMonth" class="board-row">
                                        <td class="board-row-name">당월</td>
                                        <td>누적</td>
                                        <td>누적</td>
                                        <td>누적</td>
                                        <td>누적</td>
                                        <td>누적</td>
                                        <td>누적</td>
                                        <td>누적</td>
                                    </tr>
                                    <tr id="tableRowWeek" class="board-row">
                                        <td class="board-row-name">주간</td>
                                        <td>누적</td>
                                        <td>누적</td>
                                        <td>누적</td>
                                        <td>누적</td>
                                        <td>누적</td>
                                        <td>누적</td>
                                        <td>누적</td>
                                    </tr>
                                    <tr>
                                        <th colspan="2" scope="row">개발과제 (건수)</th>
                                        <td>00</td>
                                        <td>00</td>
                                        <td>00</td>
                                        <td>00</td>
                                        <td>00</td>
                                        <td>00</td>
                                        <td>00</td>
                                    </tr>
                                    <tr>
                                        <th colspan="2" scope="row">환산인원 (명)</th>
                                        <td>00</td>
                                        <td>00</td>
                                        <td>00</td>
                                        <td>00</td>
                                        <td>00</td>
                                        <td>00</td>
                                        <td>00</td>
                                    </tr>
                                    <tr class="row-line">
                                        <th colspan="2" scope="row">개발자수 (명)</th>
                                        <td>00</td>
                                        <td>00</td>
                                        <td>00</td>
                                        <td>00</td>
                                        <td>00</td>
                                        <td>00</td>
                                        <td>00</td>
                                    </tr>
                                    <tr>
                                        <th colspan="2" scope="row">봇수 (대수)</th>
                                        <td>00</td>
                                        <td>00</td>
                                        <td>00</td>
                                        <td>00</td>
                                        <td>00</td>
                                        <td>00</td>
                                        <td>00</td>
                                    </tr>
                                    <tr>
                                        <th colspan="2" scope="row">가동룰 (%)</th>
                                        <td>00</td>
                                        <td>00</td>
                                        <td>00</td>
                                        <td>00</td>
                                        <td>00</td>
                                        <td>00</td>
                                        <td>00</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <script>
                        $(document).on('click','.board-btn',function(){
                            var btnName = $(this).attr('id');
                            var targetName = btnName.substring(3)
                            var targetRow = '#tableRow' + targetName
                            // console.log(targetRow)

                            //버튼 활성화 효과
                            $(this).addClass('active')
                            $(this).siblings().removeClass('active')
                            // 테이블 활성화 효과
                            $(targetRow).addClass('active')
                            $(targetRow).siblings('.board-row').removeClass('active')
                        })
                    </script>
                    <!-- // 관리자 대시보드  -->

                </div>
            </div>
        </section>
    </div>
</div>
<!-- // 관리자 화면 -->




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





