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
                            <h1 class="m-0 text-dark">BOT별 동작현황</h1>
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
                    
<div id="unmanagtErrorMainDiv" class="container-fluid wrap">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <form class="form-inline">
                        <div class="form-group col-md-6">
                            <label for="usr" class="col-sm-3 col-form-label">ROBOT명</label>
                             <div class="col-sm-9 float-left">
                              <input type="text" class="form-control float-left" id="windowsIdentity" name="windowsIdentity"   style="width:70%;min-width: 134px;"><button type="button" id="btnSearch" class="btn btn-info  float-left">조회</button>
                        
                            </div>
                        </div>
                    </form> 
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="form-group col-md-12">
            <div class="card">
                <div class="card-body2">
                <form class="form-inline">                     
                    <div class="form-group col-md-12">
                        <div class="col-sm-5 float-left" style="min-width:415px">
                            <img src="/resources/images/dist/color_green.gif" alt="color_green" style="margin-right:5px;">성공 &nbsp;
                            <img src="/resources/images/dist/twinkle.gif" alt="twinkle"  style="margin-right:5px;">실행중 &nbsp;
                            <img src="/resources/images/dist/color_red.gif" alt="color_red" style="margin-right:5px;">실패 &nbsp;
                            <img src="/resources/images/dist/color_gray.gif" alt="color_gray"  style="margin-right:5px;">비정상 &nbsp;
                            <img src="/resources/images/dist/bg_gray.gif" alt="bg_gray" style="margin-right:5px;">오프라인  &nbsp;
                            <img src="/resources/images/dist/bg_white.gif" alt="bg_white" style="margin-right:5px;">온라인
                         </div>
                        <div class="col-sm-4"><h2>2020-08-11</h2></div>
                        <div class="col-sm-3" style="min-width:310px">
                              <button type="button" id="btnSearch" class="btn btn-primary float-right">재갱신</button>
                              <font class="float-right text-warning"  style="margin-right:15px;">※ N분 단위로 정보가 갱신됩니다.</font> 
                         </div>
                        </div>
                        <div class="col-md-12 table-borderless2-wrap2"> 
	                        <div class="p-0" style="width:140px;">
                                <table class="table-borderless2 table-light2">                            
                                    <colgroup>
                                      <col width="100%">
                                    </colgroup>
                                    <thead>                             
                                        <tr>
                                            <th></th>
                                        </tr>
                                    </thead>                                   
                                    <tbody>
                                        <tr>
                                            <th>(AA01)H00101</th>
                                          </tr>
                                          <tr>
                                            <th>(AA01)H00102</th>
                                          </tr>
                                           <tr>
                                            <th>(AA01)H00103</th>
                                          </tr>
                                          <tr>
                                            <th>(AA01)H00104</th>
                                          </tr>
                                          <tr>
                                            <th>(AA01)H00105</th>
                                          </tr>
                                          <tr>
                                            <th>(AA01)H00106</th>
                                          </tr>
                                           <tr>
                                            <th>(AA01)H00107</th>
                                          </tr>
                                          <tr>
                                            <th>(AA01)H00108</th>
                                          </tr>                                  
                                          <tr>
                                            <th>(AA01)H00109</th>
                                          </tr>
                                          <tr>
                                            <th>(AA01)H00110</th>
                                          </tr>
                                           <tr>
                                            <th>(AA01)H00111</th>
                                          </tr>
                                          <tr>
                                            <th>(AA01)H00112</th>
                                          </tr>
                                          <tr>
                                            <th>(AA01)H00113</th>
                                          </tr>
                                          <tr>
                                            <th>(AA01)H00114</th>
                                          </tr>
                                           <tr>
                                            <th>(AA01)H00115</th>
                                          </tr>
                                          <tr>
                                            <th>(AA01)H00116</th>
                                          </tr>                                  
                                          <tr>
                                            <th>(AA01)H00117</th>
                                          </tr>
                                          <tr>
                                            <th>(AA01)H00118</th>
                                          </tr>
                                           <tr>
                                            <th>(AA01)H00119</th>
                                          </tr>
                                          <tr>
                                            <th>(AA01)H00120</th>
                                          </tr>
                                          <!-- 20개 이상 TEST -->
                                          <tr>
                                            <th>(AA01)H00121</th>
                                          </tr>
                                          <tr>
                                            <th>(AA01)H00122</th>
                                          </tr>
                                           <tr>
                                            <th>(AA01)H00123</th>
                                          </tr>
                                          <tr>
                                            <th>(AA01)H00124</th>
                                          </tr> 
                                                                         
                                     </tbody>
                                </table>
                            </div>
                            
                            <!-- 현재시간 표시부분 left값을 계산식으로 넣어주세요 -->
                            <div class="hline" style="position:absolute;top: 30px;left: calc(1.925% + 146px);height: calc(100% - 30px);"><img><!-- <img src="/resources/images/dist/hline.png"> --></div>  
                            
                            
			                <div class="table-borderless2-wrap" style="position:absolute;height:auto;top: 0px;left: 147.5px;width: calc(100% - 148.5px);">			                     
		                         <table class="table-borderless2  table-light2" style="width:100%;height:100%;min-width: 1200px;" >
		                              <colgroup>
		                                <col width="2%">
		                                <col width="2%">
		                                <col width="2%">
		                                <col width="2%">
		                                <col width="2%">
		                                <col width="2%">
		                                <col width="2%">
		                                <col width="2%">
		                                <col width="2%">
		                                <col width="2%">
		                                <col width="2%">
		                                <col width="2%">
		                                <col width="2%">
		                                <col width="2%">
		                                <col width="2%">
		                                <col width="2%">
		                                <col width="2%">
		                                <col width="2%">
		                                <col width="2%">
		                                <col width="2%">
		                                <col width="2%">
		                                <col width="2%">
		                                <col width="2%">
		                                <col width="2%">
		                                <col width="2%">
		                                <col width="2%">
		                                <col width="2%">
		                                <col width="2%">
		                                <col width="2%">
		                                <col width="2%">
		                                <col width="2%">
		                                <col width="2%">
		                                <col width="2%">
		                                <col width="2%">
		                                <col width="2%">
		                                <col width="2%">
		                                <col width="2%">
		                                <col width="2%">
		                                <col width="2%">
		                                <col width="2%">
		                                <col width="2%">
		                                <col width="2%">
		                                <col width="2%">
		                                <col width="2%">
		                                <col width="2%">
		                                <col width="2%">
		                                <col width="2%">
		                                <col width="2%">
		                                <col width="2%">
		                              </colgroup>
		                              <thead>                             
                                          <tr>
                                              <th colspan="2">01</th>
                                              <th colspan="2">02</th>
                                              <th colspan="2">03</th>
                                              <th colspan="2">04</th>
                                              <th colspan="2">05</th>
                                              <th colspan="2">06</th>
                                              <th colspan="2">07</th>
                                              <th colspan="2">08</th>
                                              <th colspan="2">09</th>
                                              <th colspan="2">10</th>
                                              <th colspan="2">11</th>
                                              <th colspan="2">12</th>
                                              <th colspan="2">13</th>
                                              <th colspan="2">14</th>
                                              <th colspan="2">15</th>
                                              <th colspan="2">16</th>
                                              <th colspan="2">17</th>
                                              <th colspan="2">18</th>
                                              <th colspan="2">19</th>
                                              <th colspan="2">20</th>
                                              <th colspan="2">21</th>
                                              <th colspan="2">22</th>
                                              <th colspan="2">23</th>
                                              <th class="tar">24</th>
                                          </tr>
                                      </thead>	                              
		                              <tbody>
		                                  <tr class="overcell">
		                                      <td class="color-green fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="color-green fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="color-green fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td class="color-red fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="color-red fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td class="color-red fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="color-red fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td class="color-green fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="color-green fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="color-green fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="color-green fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="color-green fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="color-green fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td></td>
		                                      <td class="color-red fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="color-red fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="color-red fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="color-red fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td></td>
		                                      <td></td>
		                                    </tr>   
		                                    <tr class="overcell">
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td class="twinkle fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="twinkle fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="twinkle fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="twinkle fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td class="color-gray fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="color-gray fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="color-gray fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td class="twinkle fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="twinkle fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td class="color-gray fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                    </tr>
		                                    <tr class="overcell">
		                                      <td class="color-red fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="color-red fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td class="color-red fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="color-gray fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td></td>
		                                      <td></td>
		                                      <td class="color-gray fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="color-gray fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td class="color-gray fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="color-gray fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td class="twinkle fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="twinkle fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="twinkle fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="twinkle fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="twinkle fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="color-gray fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                    </tr>
		                                    <tr>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td class="color-green fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="color-green fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="color-green fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td class="color-gray fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td class="color-green fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="color-green fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="color-green fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td class="twinkle fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="twinkle fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="twinkle fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="twinkle fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                    </tr>
		                                    <tr>
		                                      <td class="color-gray fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td class="color-green fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="color-green fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="color-green fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="color-green fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="color-green fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="color-green fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="color-green fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="color-green fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="color-green fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="color-green fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="color-green fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="color-green fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td class="color-gray fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="color-gray fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                    </tr>
		                                    <tr>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td class="color-red fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="color-red fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="color-red fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="color-red fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="color-red fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="color-red fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="color-red fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="color-red fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td class="twinkle fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="twinkle fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="twinkle fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="twinkle fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="twinkle fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="twinkle fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                    </tr>
		                                    <tr>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td class="color-red fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-red fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-red fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-red fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-red fill">
                                                <a href="#"><div class="color-top"></div></a>
                                                  
                                              </td>
                                              <td class="color-red fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-red fill">
                                                <a href="#"><div class="color-top"></div></a>
                                                  
                                              </td>
                                              <td class="color-red fill">
                                                <a href="#"><div class="color-top"></div></a>
                                                  
                                              </td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td class="twinkle fill">
                                                <a href="#"><div class="color-top"></div></a>
                                                  
                                              </td>
                                              <td class="twinkle fill">
                                                <a href="#"><div class="color-top"></div></a>
                                                  
                                              </td>
                                              <td class="twinkle fill">
                                                <a href="#"><div class="color-top"></div></a>
                                               
                                              </td>
                                              <td class="twinkle fill">
                                                <a href="#"><div class="color-top"></div></a>
                                                  
                                              </td>
                                              <td class="twinkle fill">
                                                <a href="#"><div class="color-top"></div></a>
                                                  
                                              </td>
                                              <td class="twinkle fill">
                                                <a href="#"><div class="color-top"></div></a>
                                                  
                                              </td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>                                              
                                            </tr>
		                                    <tr>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td class="twinkle fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td class="twinkle fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td class="twinkle fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td class="twinkle fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                    </tr>
		                                    <tr>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td class="twinkle fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td class="twinkle fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                    </tr>
		                                    <tr>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td class="twinkle fill">
		                                        <a href="#"><div class="color-top"></div></a>
		                                      </td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                      <td></td>
		                                    </tr>
		                                    <tr> 
		                                      <td class="off"></td>
		                                      <td class="off"></td>
		                                      <td class="off"></td>
		                                      <td class="off"></td>
		                                      <td class="off"></td>
		                                      <td class="off"></td>
		                                      <td class="off"></td>
		                                      <td class="off"></td>
		                                      <td class="off"></td>
		                                      <td class="off"></td>
		                                      <td class="off"></td>
		                                      <td class="off"></td>
		                                      <td class="off"></td>
		                                      <td class="off"></td>
		                                      <td class="off"></td>
		                                      <td class="off"></td>
		                                      <td class="off"></td>
		                                      <td class="off"></td>
		                                      <td class="off"></td>
		                                      <td class="off"></td>
		                                      <td class="off"></td>
		                                      <td class="off"></td>
		                                      <td class="off"></td>
		                                      <td class="off"></td>
		                                      <td class="off"></td>
		                                      <td class="off"></td>
		                                      <td class="off"></td>
		                                      <td class="off"></td>
		                                      <td class="off"></td>
		                                      <td class="off"></td>
		                                      <td class="off"></td>
		                                      <td class="off"></td>
		                                      <td class="off"></td>
		                                      <td class="off"></td>
		                                      <td class="off"></td>
		                                      <td class="off"></td>
		                                      <td class="off"></td>
		                                      <td class="off"></td>
		                                      <td class="off"></td>
		                                      <td class="off"></td>
		                                      <td class="off"></td>
		                                      <td class="off"></td>
		                                      <td class="off"></td>
		                                      <td class="off"></td>
		                                      <td class="off"></td>
		                                      <td class="off"></td>
		                                      <td class="off"></td>
		                                    </tr>
		                                    <tr> 
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                        </tr>
	                                        <tr> 
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                          <td class="off"></td>
	                                        </tr>
		                                    
		                                    <tr>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td class="twinkle fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="twinkle fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="twinkle fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="twinkle fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td class="color-gray fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-gray fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-gray fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td class="twinkle fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="twinkle fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td class="color-gray fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                            </tr>
                                            <tr>
                                              <td class="color-red fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-red fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td class="color-red fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-gray fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td></td>
                                              <td></td>
                                              <td class="color-gray fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-gray fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td class="color-gray fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-gray fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td class="twinkle fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="twinkle fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="twinkle fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="twinkle fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="twinkle fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-gray fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                            </tr>
                                            <tr>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td class="color-green fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-green fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-green fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td class="color-gray fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td class="color-green fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-green fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-green fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td class="twinkle fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="twinkle fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="twinkle fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="twinkle fill">
                                                <a href="#"><div class="color-top"></div></a>
                                                <!-- 여백클릭시 나오는부분 <div class="space_click" style="display: block;">21.01.16 am 15:40</div>-->
                                              </td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                            </tr>
                                            <tr>
                                              <td class="color-gray fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td class="color-green fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-green fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-green fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-green fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-green fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-green fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-green fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-green fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-green fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-green fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-green fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-green fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td class="color-gray fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-gray fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                            </tr>
                                            <tr>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td class="color-red fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-red fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-red fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-red fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-red fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-red fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-red fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-red fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td class="twinkle fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="twinkle fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="twinkle fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="twinkle fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="twinkle fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="twinkle fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                            </tr>
                                            <tr>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td class="twinkle fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td class="twinkle fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td class="twinkle fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="twinkle fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                            </tr>
                                            <tr>
                                              <td class="color-gray fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td class="color-green fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-green fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-green fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-green fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-green fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-green fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-green fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-green fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-green fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-green fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-green fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-green fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td class="color-gray fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-gray fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                            </tr>
                                            
                                            <!-- 20개 이상TEST --> 
		                                    <tr>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td class="color-red fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-red fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-red fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-red fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-red fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-red fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-red fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="color-red fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td class="twinkle fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="twinkle fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="twinkle fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="twinkle fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="twinkle fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td class="twinkle fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                            </tr>
                              
                                            <tr>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td class="twinkle fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td class="twinkle fill">
                                                <a href="#"><div class="color-top"></div></a>
                                              </td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                            </tr>
                                            <tr>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                            </tr>                                           
                                            <tr>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                            </tr>                                                           
		                               </tbody>
		                          </table> 
	                        
		                        <!-- TR오버시 레이어로 나올부분 -->
	                            <div class="timeline24" style="display:none;position:relative;height:30px;width:100%;margin-top:-160px;left: 0;z-index:2">                               
	                                 <table class="table-light3" style="width:100%;height:30px;min-width: 1200px;" >
	                                      <colgroup>
	                                        <col width="2%">
	                                        <col width="2%">
	                                        <col width="2%">
	                                        <col width="2%">
	                                        <col width="2%">
	                                        <col width="2%">
	                                        <col width="2%">
	                                        <col width="2%">
	                                        <col width="2%">
	                                        <col width="2%">
	                                        <col width="2%">
	                                        <col width="2%">
	                                        <col width="2%">
	                                        <col width="2%">
	                                        <col width="2%">
	                                        <col width="2%">
	                                        <col width="2%">
	                                        <col width="2%">
	                                        <col width="2%">
	                                        <col width="2%">
	                                        <col width="2%">
	                                        <col width="2%">
	                                        <col width="2%">
	                                        <col width="2%">
	                                        <col width="2%">
	                                        <col width="2%">
	                                        <col width="2%">
	                                        <col width="2%">
	                                        <col width="2%">
	                                        <col width="2%">
	                                        <col width="2%">
	                                        <col width="2%">
	                                        <col width="2%">
	                                        <col width="2%">
	                                        <col width="2%">
	                                        <col width="2%">
	                                        <col width="2%">
	                                        <col width="2%">
	                                        <col width="2%">
	                                        <col width="2%">
	                                        <col width="2%">
	                                        <col width="2%">
	                                        <col width="2%">
	                                        <col width="2%">
	                                        <col width="2%">
	                                        <col width="2%">
	                                        <col width="2%">
	                                        <col width="2%">
	                                        <col width="2%">
	                                      </colgroup>
	                                      <thead>                             
	                                          <tr>
	                                              <th colspan="2">01</th>
	                                              <th colspan="2">02</th>
	                                              <th colspan="2">03</th>
	                                              <th colspan="2">04</th>
	                                              <th colspan="2">05</th>
	                                              <th colspan="2">06</th>
	                                              <th colspan="2">07</th>
	                                              <th colspan="2">08</th>
	                                              <th colspan="2">09</th>
	                                              <th colspan="2">10</th>
	                                              <th colspan="2">11</th>
	                                              <th colspan="2">12</th>
	                                              <th colspan="2">13</th>
	                                              <th colspan="2">14</th>
	                                              <th colspan="2">15</th>
	                                              <th colspan="2">16</th>
	                                              <th colspan="2">17</th>
	                                              <th colspan="2">18</th>
	                                              <th colspan="2">19</th>
	                                              <th colspan="2">20</th>
	                                              <th colspan="2">21</th>
	                                              <th colspan="2">22</th>
	                                              <th colspan="2">23</th>
	                                              <th class="tar">24</th>
	                                          </tr>
	                                      </thead>
	                                  </table>                            
	                            </div>
	                        </div> 
	                    </div>          
                    </form>
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
        



