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
                            <h1 class="m-0 text-dark">트리거(UA)</h1>
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
					<div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h4 class="modal-title">trig_time_police 작업시작</h4>
                             <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                 <span aria-hidden="true">×</span>
                             </button>
                            </div>
                            <div class="modal-body" >
                                <form class="form-inline" onSubmit="return false;">
                                    <!--  
                                    <div class="form-group col-sm-12">
                                        <label for="schCmpny" class="col-sm-2 col-form-label">이름</label>
                                         <div class="col-sm-10">trig_time_police</div>
                                     </div>
                                     -->
                                    <div class="form-group col-sm-12">
                                        <label for="schCmpny" class="col-sm-2 col-form-label">프로세스</label>
                                         <div class="col-sm-5">
                                            <select class="form-control" id="schCmpny" style="width:90%;" disabled >
                                             <option value="proc_police" selected>proc_police</option>
                                            </select>
                                         </div>
                                         <label for="schCmpny" class="col-sm-2 col-form-label">우선순위</label>
                                         <div class="col-sm-3">
                                            <select class="form-control" id="schCmpny" style="width:90%;" disabled >
                                             <option value="">일반</option>
                                            </select>
                                        </div>
                                     </div>
                                  </div>
                              </form> 
                                
                              <form class="form-inline" onSubmit="return false;">     
                                <div class="card-body2" style="overflow:auto;">
                                  <!-- 실행타겟 -->
                                  <div style="display:block;">
                                    <div class="form-group col-md-12"> 
                                        <div class="tabmenu_area">
                                            <a href="" class="target active">실행타겟</a>
                                            <a href="" class="parameter">파라미터</a>
                                         </div>
                                    </div>
                                  
                                    <div class="form-group row col-md-10 py-sm-3">
                                        <!-- <input type="radio" name="checkRadio" id="target" value="robot_all" class="custom-radio" style="width:18px;height:18px;"> 모든 로봇 &nbsp; &nbsp; &nbsp; -->
                                        <input type="radio" name="checkRadio" id="parameter" value="robot_choice" class="custom-radio" style="width:18px;height:18px;" checked>특정 로봇 &nbsp; &nbsp; &nbsp;
                                        <input type="radio" name="checkRadio" id="auto" value="binding"class="custom-radio" style="width:18px;height:18px;" >동적으로 할당
                                     </div>
                                     
                                     <!-- 구분점선 -->
                                     <div class="form-group col-md-12 py-sm-2 line-top"></div>
                                     
                                     <!-- 동적할당 DIV -->
                                     <div class="form-group row col-md-12" name="" style="display:none;">
                                        <label for="schCmpny" class="col-sm-4 col-form-label">프로세스 실행</label>
                                         <div class="col-sm-8">
                                            <input type="text" name="schQueName" class="form-control float-left" id="schQueName"style="width:20%;margin-right:5px;"> 회
                                         </div>
                                     </div>
                                     <!-- 특정로봇 DIV -->
                                     <div class="form-group row col-md-12" name="" style="display:block;">
                                       <label id=""class="col-sm-2 col-form-label float-left" >검색</label>
                                       <div class="col-sm-5 float-left">
                                            <input type="text" class="form-control float-left" id="txtSearchKwrd" name="searchKwrd" style="width:60%;min-width:75px;" value="" /><button type="button" id="btnSearch" class="btn btn-info float-left">조회</button>
                                       </div>
                                       <label id=""class="col-sm-2 col-form-label float-left" >상태</label>
                                       <div class="col-sm-3 float-left">
                                            <select class="form-control float-left" id="schCmpny" style="width:90%;" >
                                                <option value=""></option>
                                            </select>
                                       </div>
                                       <div class="form-group col-md-12 triggertableDiv_wrap" style="height: 130px;" >
                                           
                                           <table id="" class="table">
                                               <colgroup>
                                                  <col width="10%">
                                                  <col width="35%">
                                                  <col width="*">
                                                  <col width="20%">
                                                </colgroup>
                                               <thead>
                                                   <tr>
                                                       <th><input type="checkbox" class="custom-checkbox" style="width:18px;height:18px;"></th>
                                                       <th>로봇</th>
                                                       <th>머신</th>
                                                       <th>상태</th>
                                                   </tr>
                                               </thead>
                                               <tr>
                                                   <td><input type="checkbox" class="custom-checkbox" style="width:18px;height:18px;"></td>
                                                   <td>echorpa4</td>
                                                   <td>ECHORPA4</td>
                                                   <td>사용가능</td>
                                               </tr>
                                               <tr>
                                                   <td><input type="checkbox" class="custom-checkbox" style="width:18px;height:18px;"></td>
                                                   <td>echorpa4</td>
                                                   <td>ECHORPA4</td>
                                                   <td>연결끊김</td>
                                               </tr>
                                               <tr>
                                                   <td><input type="checkbox" class="custom-checkbox" style="width:18px;height:18px;"></td>
                                                   <td>echorpa4</td>
                                                   <td>ECHORPA4</td>
                                                   <td>사용가능</td>
                                               </tr>
                                               <tr>
                                                   <td><input type="checkbox" class="custom-checkbox" style="width:18px;height:18px;"></td>
                                                   <td>echorpa4</td>
                                                   <td>ECHORPA4</td>
                                                   <td>사용가능</td>
                                               </tr>
                                               <tr>
                                                   <td><input type="checkbox" class="custom-checkbox" style="width:18px;height:18px;"></td>
                                                   <td>echorpa4</td>
                                                   <td>ECHORPA4</td>
                                                   <td>연결끊김</td>
                                               </tr>
                                               <tr>
                                                   <td><input type="checkbox" class="custom-checkbox" style="width:18px;height:18px;"></td>
                                                   <td>echorpa4</td>
                                                   <td>ECHORPA4</td>
                                                   <td>연결끊김</td>
                                               </tr>
                                               <tr>
                                                   <td><input type="checkbox" class="custom-checkbox" style="width:18px;height:18px;"></td>
                                                   <td>echorpa4</td>
                                                   <td>ECHORPA4</td>
                                                   <td>연결끊김</td>
                                               </tr>
                                            </table>
                                          </div>
                                          <div class="form-group col-md-12">
                                           <p style="color:#4b5eb5;font-size:12px;">※  O행이 선택되었습니다.</p>
                                          </div> 
                                     </div>
                                   </div>
                                   <!-- 실행타겟 END -->
                                    
                                   <!-- 파라미터 -->
                                   <div style="display:none;">
                                        <div class="form-group col-md-12"> 
                                            <div class="tabmenu_area">
                                                <a href="" class="target">실행타겟</a>
                                                <a href="" class="parameter active">파라미터</a>
                                             </div>
                                        </div>
                                        <div class="form-group col-md-12 py-sm-2">
                                            <div class="card-body p-10">
                                                <p style="color:#4b5eb5;font-size:12px;">※  이 버전에 대한 입력 파라미터가 정의되지 않았습니다.</p>
                                                <table id="tblInput" class="table">
                                                    <colgroup>
                                                      <col width="50%">
                                                      <col width="*">
                                                    </colgroup>
                                                    <thead>
                                                        <tr>
                                                            <th>파라미터</th>
                                                            <th>값</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>                                                                     
                                                        <tr>
                                                            <td>Int32 <br/>input</td>
                                                            <td><input type="text" id="input_input" style="width:30%;"value="60">
                                                            <input type="button" class="btn btn-outline-primary" value="수정">
                                                            <input type="button" class="btn btn-outline-secondary" value="삭제"></td>
                                                        </tr> 
                                                    </tbody>                                               
                                                </table>
                                            </div>
                                        </div>
                                   </div>
                                   <!-- 파라미터 END -->
                                </div>
                             </form>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                                <button type="button" class="btn btn-primary">시작</button>
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