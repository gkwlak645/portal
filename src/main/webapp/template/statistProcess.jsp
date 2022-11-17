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
                            <h1 class="m-0 text-dark">프로세스별 실행 현황</h1>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
                                <li class="breadcrumb-item">통계 > 프로세스별  실행현황</li>
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
                <div class="card-header">
                    <form class="form-inline">  
                        <div class="form-group col-md-12">
                            <input type="radio" name="chkPer" id="periYear" checked>
                             <span for="periYear">년도별</span> &nbsp; &nbsp; &nbsp;
                             <input type="radio" name="chkPer" id="periMoth">
                             <span for="periMoth">월별</span>
                         </div>
                         <div class="form-group col-md-6">
                             <label class="col-form-label col-sm-2" >기간</label>
                             <div class="col-sm-10 cus_dataing">
                                 <select class="form-control cus_dataing-year" style="margin-right:5px;width:30%">
                                     <option value="">2020</option>
                                 </select>년 &nbsp; 
                                 <select class="form-control cus_dataing-month" readonly="readonly"style="margin-right:5px;width:30%">
                                     <option value="">00</option>
                                 </select>월
                              </div>
                         </div>
                         <div class="form-group col-md-6">
                             <label class="col-form-label col-sm-2">회사</label>
                             <div class="col-sm-10 selectbox">
                                  <select class="form-control select" style="width: 60%">
                                      <option value=""></option>
                                  </select>
                                 <button type="button" id="btnSearch" class="btn btn-info">검색</button>
                             </div>
                         </div>
                    </form>  
                </div>
            </div>
        </div>
    </div>
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
                                <col style="width: 10%">
                                <col>
                                <col>
                                <col>
                                <col>
                                <col>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th scope="col">프로세스코드</th>
                                    <th scope="col">프로세스명</th>
                                    <th scope="col">프로세스별 합계/평균</th>
                                    <th scope="col">구분</th>
                                    <th scope="col">01</th>
                                    <th scope="col">02</th>
                                    <th scope="col">03</th>
                                    <th scope="col">04</th>
                                    <th scope="col">05</th>
                                    <th scope="col">06</th>
                                    <th scope="col">07</th>
                                    <th scope="col">08</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- 프로세스1 -->
                                <tr>
                                    <th rowspan="3">A00100</th>
                                    <th rowspan="3">프로세스1</th>
                                    <td>595</td>
                                    <td style="text-align: center;">성공</td>
                                    <td>70</td>
                                    <td>78</td>
                                    <td>72</td>
                                    <td>60</td>
                                    <td>90</td>
                                    <td>80</td>
                                    <td>70</td>
                                    <td>75</td>
                                </tr>
                                <tr>
                                    <td>20</td>
                                    <td style="text-align: center;">실패</td>
                                    <td>2</td>
                                    <td>2</td>
                                    <td>2</td>
                                    <td>2</td>
                                    <td>2</td>
                                    <td>2</td>
                                    <td>2</td>
                                    <td>2</td>
                                </tr>
                                <tr class="lastline"> <!-- 마지막 라인에 추가 -->
                                    <td>97</td>
                                    <td style="text-align: center;">성공률</td>
                                    <td>70</td>
                                    <td>78</td>
                                    <td>72</td>
                                    <td>60</td>
                                    <td>90</td>
                                    <td>80</td>
                                    <td>70</td>
                                    <td>75</td>
                                </tr>
                                <!-- // 프로세스1 -->
                                
                                <!-- 프로세스2 -->
                                <tr>
                                    <th rowspan="3">A00200</th>
                                    <th rowspan="3">프로세스2</th>
                                    <td>595</td>
                                    <td style="text-align: center;">성공</td>
                                    <td>70</td>
                                    <td>78</td>
                                    <td>72</td>
                                    <td>60</td>
                                    <td>90</td>
                                    <td>80</td>
                                    <td>70</td>
                                    <td>75</td>
                                </tr>
                                <tr>
                                    <td>20</td>
                                    <td style="text-align: center;">실패</td>
                                    <td>2</td>
                                    <td>2</td>
                                    <td>2</td>
                                    <td>2</td>
                                    <td>2</td>
                                    <td>2</td>
                                    <td>2</td>
                                    <td>2</td>
                                </tr>
                                <tr class="lastline"> <!-- 마지막 라인에 추가 -->
                                    <td>97</td>
                                    <td style="text-align: center;">성공률</td>
                                    <td>70</td>
                                    <td>78</td>
                                    <td>72</td>
                                    <td>60</td>
                                    <td>90</td>
                                    <td>80</td>
                                    <td>70</td>
                                    <td>75</td>
                                </tr>
                                <!-- // 프로세스2 -->
                            </tbody>
                         </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<script>


</script>


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



