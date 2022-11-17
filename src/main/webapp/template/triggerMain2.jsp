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
                            <h1 class="m-0 text-dark">트리거관리</h1>
                        </div>
                        <!-- /.col -->
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
                                <li class="breadcrumb-item">자원관리 / 트리거관리</li>
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
                    <div id="packageLibraryMainDiv" class="container-fluid wrap">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="card">
                                    <div class="card-header">
                                        <form class="form-inline">                                         
                                            <div class="form-group col-md-12">
                                                 <label id=""class="col-sm-2" >이름</label>
                                                 <div class="col-sm-10">
                                                   <input type="text" class="form-control  float-left" id="txtSearchKwrd" name="searchKwrd" style="min-width:210px;" value="" />
                                                 </div>
                                            </div>
                                            
                                            <div class="form-group col-md-6">
                                                 <label id="name" class="col-sm-4">상태</label>
                                                 <div class="col-sm-8">
                                                  <select class="form-control float-left" id="cmpnyCd" style="width:60%;max-width:210px;">
                                                  </select>
                                               </div>
                                            </div>
                                            <div class="form-group col-md-6">
                                                 <label id="name" class="col-sm-4">형식</label>
                                                 <div class="col-sm-8 float-left">
                                                  <select class="form-control float-left" id="cmpnyCd" style="width:60%;max-width:210px;">
                                                  </select>
                                                  <button type="button" id="btnSearch" class="btn btn-info float-left">조회</button>
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
                                        <button type="button" id="" class="btn btn-primary float-right" style="margin:5px 0 15px 2px;">즉시시작</button>
                                         <button type="button" id="btnReg" class="btn btn-primary float-right" style="margin:5px 0 15px 2px;">등록</button>
                                        
                                        <table class="cus_table2">
                                            <colgroup>
                                                <col style="width: 12%">
                                                <col style="width: 12%">
                                                <col style="width: 10%">
                                                <col style="width: 6%">
                                                <col style="width: 15%">
                                                <col style="width: 15%">
                                                <col>
                                                <col>
                                                <col style="width: 8%">
                                                <col style="width: 8%">
                                            </colgroup>
                                            <thead>
                                                <tr>
                                                    <th scope="col">이름</th>
                                                    <th scope="col">프로세스</th>
                                                    <th scope="col">환경</th>
                                                    <th scope="col">형식</th>
                                                    <th scope="col">트리거세부정보</th>
                                                    <th scope="col">다음런타임</th>
                                                    <th scope="col">우선순위</th>
                                                    <th scope="col">다음이후중지</th>
                                                    <th scope="col">즉시시작</th>
                                                    <th scope="col"></th>
                                                </tr>
                                            </thead>
                                            <tbody>                                                
                                                <tr>
                                                    <td>trig_time_naverDataLab</td>
                                                    <td>proc_naverDatalab</td>
                                                    <td>env_echorpa4</td>
                                                    <td>시간</td>
                                                    <td>시간 06:20 오후, 수요일 ..</td>
                                                    <td>2020-12-31 11 :22 33</td>
                                                    <td>상속됨</td>
                                                    <td>0초</td>
                                                    <td><input type="button" class="btn btn-outline-primary icon" style="padding:3px 2px 4px 4px;margin:0px;line-height: 0.9;font-size:8px;" value="▶"></td>
                                                    <td><div class="tip_more-wrap"><!--button--><a href="javascript:;"class="download_txt"><input type="button"class="btn-tip btn btn-outline-success"id=""name=""value=":"style="padding: 0 5px 3px 4px;width:22px;line-height: 18px;"></a><!--menu--><div class="add_file_list active"><ul><li><a class="btn-txt"href="javascript:">편집</a></li><li><a class="btn-txt disabled"href="javascript:">작업보기</a><!--비활성화.disabled추가--></li><li><a class="btn-txt"href="javascript:">사용</a></li><li><a class="btn-txt"href="javascript:">사용안함</a></li><li><a class="btn-txt"href="javascript:">제거</a></li></ul></div></div></td>
                                                </tr>
                                                <tr>
                                                    <td>trig_time_naverDataLab</td>
                                                    <td>proc_naverDatalab</td>
                                                    <td>env_echorpa4</td>
                                                    <td>시간</td>
                                                    <td>시간 06:20 오후, 수요일 ..</td>
                                                    <td>2020-12-31 11 :22 33</td>
                                                    <td>상속됨</td>
                                                    <td>0초</td>
                                                    <td><input type="button" class="btn btn-outline-primary icon" style="padding:3px 2px 4px 4px;margin:0px;line-height: 0.9;font-size:8px;" value="▶"></td>
                                                    <td><div class="tip_more-wrap"><!--button--><a href="javascript:;"class="download_txt"><input type="button"class="btn-tip btn btn-outline-success"id=""name=""value=":"style="padding: 0 5px 3px 4px;width:22px;line-height: 18px;"></a><!--menu--><div class="add_file_list"><ul><li><a class="btn-txt"href="javascript:">편집</a></li><li><a class="btn-txt disabled"href="javascript:">작업보기</a><!--비활성화.disabled추가--></li><li><a class="btn-txt"href="javascript:">사용</a></li><li><a class="btn-txt"href="javascript:">사용안함</a></li><li><a class="btn-txt"href="javascript:">제거</a></li></ul></div></div></td>
                                                </tr>
                                                <tr>
                                                    <td>trig_time_naverDataLab</td>
                                                    <td>proc_naverDatalab</td>
                                                    <td>env_echorpa4</td>
                                                    <td>시간</td>
                                                    <td>시간 06:20 오후, 수요일 ..</td>
                                                    <td>2020-12-31 11 :22 33</td>
                                                    <td>상속됨</td>
                                                    <td>0초</td>
                                                    <td><input type="button" class="btn btn-outline-primary icon" style="padding:3px 2px 4px 4px;margin:0px;line-height: 0.9;font-size:8px;" value="▶"></td>
                                                    <td><div class="tip_more-wrap"><!--button--><a href="javascript:;"class="download_txt"><input type="button"class="btn-tip btn btn-outline-success"id=""name=""value=":"style="padding: 0 5px 3px 4px;width:22px;line-height: 18px;"></a><!--menu--><div class="add_file_list"><ul><li><a class="btn-txt"href="javascript:">편집</a></li><li><a class="btn-txt disabled"href="javascript:">작업보기</a><!--비활성화.disabled추가--></li><li><a class="btn-txt"href="javascript:">사용</a></li><li><a class="btn-txt"href="javascript:">사용안함</a></li><li><a class="btn-txt"href="javascript:">제거</a></li></ul></div></div></td>
                                                </tr> 
                                                <tr>
                                                    <td>trig_time_naverDataLab</td>
                                                    <td>proc_naverDatalab</td>
                                                    <td>env_echorpa4</td>
                                                    <td>시간</td>
                                                    <td>시간 06:20 오후, 수요일 ..</td>
                                                    <td>2020-12-31 11 :22 33</td>
                                                    <td>상속됨</td>
                                                    <td>0초</td>
                                                    <td><input type="button" class="btn btn-outline-primary icon" style="padding:3px 2px 4px 4px;margin:0px;line-height: 0.9;font-size:8px;" value="▶"></td>
                                                    <td><div class="tip_more-wrap"><!--button--><a href="javascript:;"class="download_txt"><input type="button"class="btn-tip btn btn-outline-success"id=""name=""value=":"style="padding: 0 5px 3px 4px;width:22px;line-height: 18px;"></a><!--menu--><div class="add_file_list"><ul><li><a class="btn-txt"href="javascript:">편집</a></li><li><a class="btn-txt disabled"href="javascript:">작업보기</a><!--비활성화.disabled추가--></li><li><a class="btn-txt"href="javascript:">사용</a></li><li><a class="btn-txt"href="javascript:">사용안함</a></li><li><a class="btn-txt"href="javascript:">제거</a></li></ul></div></div></td>
                                                </tr>
                                                <tr>
                                                    <td>trig_time_naverDataLab</td>
                                                    <td>proc_naverDatalab</td>
                                                    <td>env_echorpa4</td>
                                                    <td>시간</td>
                                                    <td>시간 06:20 오후, 수요일 ..</td>
                                                    <td>2020-12-31 11 :22 33</td>
                                                    <td>상속됨</td>
                                                    <td>0초</td>
                                                    <td><input type="button" class="btn btn-outline-primary icon" style="padding:3px 2px 4px 4px;margin:0px;line-height: 0.9;font-size:8px;" value="▶"></td>
                                                    <td><div class="tip_more-wrap"><!--button--><a href="javascript:;"class="download_txt"><input type="button"class="btn-tip btn btn-outline-success"id=""name=""value=":"style="padding: 0 5px 3px 4px;width:22px;line-height: 18px;"></a><!--menu--><div class="add_file_list"><ul><li><a class="btn-txt"href="javascript:">편집</a></li><li><a class="btn-txt disabled"href="javascript:">작업보기</a><!--비활성화.disabled추가--></li><li><a class="btn-txt"href="javascript:">사용</a></li><li><a class="btn-txt"href="javascript:">사용안함</a></li><li><a class="btn-txt"href="javascript:">제거</a></li></ul></div></div></td>
                                                </tr> 
                                                <tr>
                                                    <td>trig_time_naverDataLab</td>
                                                    <td>proc_naverDatalab</td>
                                                    <td>env_echorpa4</td>
                                                    <td>시간</td>
                                                    <td>시간 06:20 오후, 수요일 ..</td>
                                                    <td>2020-12-31 11 :22 33</td>
                                                    <td>상속됨</td>
                                                    <td>0초</td>
                                                    <td><input type="button" class="btn btn-outline-primary icon" style="padding:3px 2px 4px 4px;margin:0px;line-height: 0.9;font-size:8px;" value="▶"></td>
                                                    <td><div class="tip_more-wrap"><!--button--><a href="javascript:;"class="download_txt"><input type="button"class="btn-tip btn btn-outline-success"id=""name=""value=":"style="padding: 0 5px 3px 4px;width:22px;line-height: 18px;"></a><!--menu--><div class="add_file_list"><ul><li><a class="btn-txt"href="javascript:">편집</a></li><li><a class="btn-txt disabled"href="javascript:">작업보기</a><!--비활성화.disabled추가--></li><li><a class="btn-txt"href="javascript:">사용</a></li><li><a class="btn-txt"href="javascript:">사용안함</a></li><li><a class="btn-txt"href="javascript:">제거</a></li></ul></div></div></td>
                                                </tr>
                                                <tr>
                                                    <td>trig_time_naverDataLab</td>
                                                    <td>proc_naverDatalab</td>
                                                    <td>env_echorpa4</td>
                                                    <td>시간</td>
                                                    <td>시간 06:20 오후, 수요일 ..</td>
                                                    <td>2020-12-31 11 :22 33</td>
                                                    <td>상속됨</td>
                                                    <td>0초</td>
                                                    <td><input type="button" class="btn btn-outline-primary icon" style="padding:3px 2px 4px 4px;margin:0px;line-height: 0.9;font-size:8px;" value="▶"></td>
                                                    <td><div class="tip_more-wrap"><!--button--><a href="javascript:;"class="download_txt"><input type="button"class="btn-tip btn btn-outline-success"id=""name=""value=":"style="padding: 0 5px 3px 4px;width:22px;line-height: 18px;"></a><!--menu--><div class="add_file_list"><ul><li><a class="btn-txt"href="javascript:">편집</a></li><li><a class="btn-txt disabled"href="javascript:">작업보기</a><!--비활성화.disabled추가--></li><li><a class="btn-txt"href="javascript:">사용</a></li><li><a class="btn-txt"href="javascript:">사용안함</a></li><li><a class="btn-txt"href="javascript:">제거</a></li></ul></div></div></td>
                                                </tr> 
                                                <tr>
                                                    <td>trig_time_naverDataLab</td>
                                                    <td>proc_naverDatalab</td>
                                                    <td>env_echorpa4</td>
                                                    <td>시간</td>
                                                    <td>시간 06:20 오후, 수요일 ..</td>
                                                    <td>2020-12-31 11 :22 33</td>
                                                    <td>상속됨</td>
                                                    <td>0초</td>
                                                    <td><input type="button" class="btn btn-outline-primary icon" style="padding:3px 2px 4px 4px;margin:0px;line-height: 0.9;font-size:8px;" value="▶"></td>
                                                    <td><div class="tip_more-wrap"><!--button--><a href="javascript:;"class="download_txt"><input type="button"class="btn-tip btn btn-outline-success"id=""name=""value=":"style="padding: 0 5px 3px 4px;width:22px;line-height: 18px;"></a><!--menu--><div class="add_file_list"><ul><li><a class="btn-txt"href="javascript:">편집</a></li><li><a class="btn-txt disabled"href="javascript:">작업보기</a><!--비활성화.disabled추가--></li><li><a class="btn-txt"href="javascript:">사용</a></li><li><a class="btn-txt"href="javascript:">사용안함</a></li><li><a class="btn-txt"href="javascript:">제거</a></li></ul></div></div></td>
                                                </tr>
                                                 <tr>
                                                    <td>trig_time_naverDataLab</td>
                                                    <td>proc_naverDatalab</td>
                                                    <td>env_echorpa4</td>
                                                    <td>시간</td>
                                                    <td>시간 06:20 오후, 수요일 ..</td>
                                                    <td>2020-12-31 11 :22 33</td>
                                                    <td>상속됨</td>
                                                    <td>0초</td>
                                                    <td><input type="button" class="btn btn-outline-primary icon" style="padding:3px 2px 4px 4px;margin:0px;line-height: 0.9;font-size:8px;" value="▶"></td>
                                                    <td><div class="tip_more-wrap"><!--button--><a href="javascript:;"class="download_txt"><input type="button"class="btn-tip btn btn-outline-success"id=""name=""value=":"style="padding: 0 5px 3px 4px;width:22px;line-height: 18px;"></a><!--menu--><div class="add_file_list"><ul><li><a class="btn-txt"href="javascript:">편집</a></li><li><a class="btn-txt disabled"href="javascript:">작업보기</a><!--비활성화.disabled추가--></li><li><a class="btn-txt"href="javascript:">사용</a></li><li><a class="btn-txt"href="javascript:">사용안함</a></li><li><a class="btn-txt"href="javascript:">제거</a></li></ul></div></div></td>
                                                </tr>
                                                <tr>
                                                    <td>trig_time_naverDataLab</td>
                                                    <td>proc_naverDatalab</td>
                                                    <td>env_echorpa4</td>
                                                    <td>시간</td>
                                                    <td>시간 06:20 오후, 수요일 ..</td>
                                                    <td>2020-12-31 11 :22 33</td>
                                                    <td>상속됨</td>
                                                    <td>0초</td>
                                                    <td><input type="button" class="btn btn-outline-primary icon" style="padding:3px 2px 4px 4px;margin:0px;line-height: 0.9;font-size:8px;" value="▶"></td>
                                                    <td><div class="tip_more-wrap"><!--button--><a href="javascript:;"class="download_txt"><input type="button"class="btn-tip btn btn-outline-success"id=""name=""value=":"style="padding: 0 5px 3px 4px;width:22px;line-height: 18px;"></a><!--menu--><div class="add_file_list active up"><ul><li><a class="btn-txt"href="javascript:">편집</a></li><li><a class="btn-txt disabled"href="javascript:">작업보기</a><!--비활성화.disabled추가--></li><li><a class="btn-txt"href="javascript:">사용</a></li><li><a class="btn-txt"href="javascript:">사용안함</a></li><li><a class="btn-txt"href="javascript:">제거</a></li></ul></div></div></td>
                                                </tr>                                               
                                            </tbody>
                                         </table>                                        
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