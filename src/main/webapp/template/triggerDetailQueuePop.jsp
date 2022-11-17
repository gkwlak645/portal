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
					<div class="card card-primary card-tabs">
                        <div class="card-header">
					        <h3 class="card-title">큐상세</h3>
					    </div>                      
                        <div class="card-body" >
                            <div class="tab-content" id="">  
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="card card-default">
                                            <form class="form-inline" onSubmit="return false;">
                                                <div class="card-body" >
                                                    <div class="form-group col-sm-12">
                                                        <label for="schCmpny" class="col-sm-2 col-form-label">이름</label>
                                                         <div class="col-sm-10">
                                                            <input type="text" name="schQueName" value="trig_time_police" class="form-control float-left" id="schQueName"style="width:97%;">
                                                        </div>
                                                     </div>
                                                    <div class="form-group col-sm-12">
                                                        <label for="schCmpny" class="col-sm-2 col-form-label">프로세스</label>
                                                         <div class="col-sm-5">
                                                            <select class="form-control" id="schCmpny" style="width:90%;">
                                                             <option value="" >echorpa4</option>
                                                            </select>
                                                         </div>
                                                         <label for="schCmpny" class="col-sm-2 col-form-label">우선순위</label>
                                                         <div class="col-sm-3">
                                                            <select class="form-control" id="schCmpny" style="width:90%;" >
                                                             <option value=""></option>
                                                            </select>
                                                        </div>
                                                     </div>
                                                  </div>
                                              </form> 
                                                
                                              <form class="form-inline" onSubmit="return false;">     
                                                <div class="card-body2" style="overflow:auto;">  
                                                   <!-- 파라미터 -->
                                                   <div style="display:block;">                                                       
                                                        <div class="form-group col-md-12">
                                                             <p style="color:#4b5eb5;font-size:12px;">※  이 버전에 대한 입력 파라미터가 정의되지 않았습니다.</p>
                                                             <div class="triggertableDiv_wrap" style="height: 238px;">                                                             
                                                                <table id="tblInput" class="table" >
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
                                                                        <tr>
                                                                            <td>Int32 <br/>input</td>
                                                                            <td><input type="text" id="input_input" style="width:30%;"value="60">
                                                                            <input type="button" class="btn btn-outline-primary" value="수정">
                                                                            <input type="button" class="btn btn-outline-secondary" value="삭제"></td>
                                                                        </tr> 
                                                                        <tr>
                                                                            <td>Int32 <br/>input</td>
                                                                            <td><input type="text" id="input_input" style="width:30%;"value="60">
                                                                            <input type="button" class="btn btn-outline-primary" value="수정">
                                                                            <input type="button" class="btn btn-outline-secondary" value="삭제"></td>
                                                                        </tr> 
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
                                        </div>
                                    </div>
                                 
                                    <!-- 우측영역 -->
                                    <div class="col-md-6" >
                                        <div class="card card-default">
                                            <form class="form-inline" onSubmit="return false;">
                                                <div class="card-body2">                                                    
                                                  <div class="form-group col-sm-12">
                                                      <label for="schCmpny" class="col-sm-4 col-form-label">큐</label>
                                                       <div class="col-sm-8">
                                                          <select class="form-control" id="schCmpny" style="width:90%;" >
                                                           <option value="">trig_queue</option>
                                                          </select>
                                                      </div>
                                                   </div>
                                                            
                                                   <!-- 구분점선 -->
                                                   <div class="form-group col-md-12 py-sm-1"></div>                                                   
                                                   <div class="form-group col-md-12 line-top"></div> 
                                                   <p style="color:red;font-size:12px;margin: 15px 0 0 15px;">※  큐 트리거가 선택된 프로세스에 연결된 환경에서 실행됩니다.</p>                                                         
                                                    
                                                   <div for="" class="col-sm-7 float-left">· 첫 번째 작업을 트리거할 최소 항목 수</div>                                                  
                                                   <div class="col-sm-5 float-left"><input type="number" class="form-control num"  value="1" min="0" style="width:20%;margin-right: 5px;">항목</div>    
                                                   
                                                   <div for="" class="col-sm-7 float-left">· 동시에 허용되는 최대 보류 및 실행 작업 수</div>                                                  
                                                   <div class="col-sm-5 float-left"><input type="number" class="form-control num"  value="1" min="0" style="width:20%;margin-right: 5px;">작업</div> 
                                                   
                                                   <div for="" class="col-sm-7 float-left">· 각각 다른 작업이 트리거되는 항목</div>                                                  
                                                   <div class="col-sm-5 float-left"><input type="number" class="form-control num"  value="1" min="0" style="width:20%;margin-right: 5px;">새항목</div> 
                                                   
                                                                                                      
                                                   <!-- 구분점선 -->                                                   
                                                   <div class="form-group col-md-12 line-top"></div> 
                                                   <div class="form-group col-md-12 py-sm-1"></div> 
                                                   <div class="form-group col-sm-12">
                                                        <label for="schCmpny" class="col-sm-4 col-form-label">표준시간대</label>
                                                         <div class="col-sm-8">
                                                            <select class="form-control" id="schCmpny" style="width:90%;" >
                                                             <option value=""></option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                    
                                                    <!-- 구분점선 --> 
                                                   <div class="form-group col-md-12 py-sm-1"></div>                                                  
                                                   <div class="form-group col-md-12 line-top"></div> 
                                                   <div class="form-group col-md-12 py-sm-1"></div> 
                                                   <div class="form-group col-sm-12">
                                                        <label for="schCmpny" class="col-sm-4 col-form-label">휴무일 제한사항</label>
                                                         <div class="col-sm-8">
                                                            <select class="form-control" id="schCmpny" style="width:90%;" >
                                                             <option value=""></option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                    
                                                    <!-- 구분점선 -->
                                                     <div class="form-group col-md-12 py-sm-1"></div> 
                                                     <div class="form-group col-md-12 line-top"></div>          
                                                     
                                                     <!-- 다음트리거 -->
                                                     <div class="form-group col-md-12 py-sm-1"></div>
                                                     <div class="col-sm-12 custom-control custom-switch float-right">
                                                        <input type="checkbox" id="customSwitch2" class="custom-control-input float-right" >
                                                        <label class="custom-control-label  float-right" for="customSwitch2">다음 트리거 사용안함</label>
                                                    </div>
                                                    <!-- 다음트리거 사용안함체크시 -->
                                                    <div style="display:none;">
                                                         <div class="col-sm-9 float-left">
                                                             <div for="" class="col-sm-2 float-left">시점</div>                                                  
                                                             <div class="col-sm-10 float-left"> 
                                                                  <div class="input-group date float-left" id="unmanagtDeDiv" data-target-input="nearest" style="width:40%;min-width:160px;margin-right:5px;">
                                                                     <input type="text" id="unmanagtDe" name="unmanagtDe" class="form-control datetimepicker-input" data-target="#unmanagtErrorSave #unmanagtDeDiv"/>
                                                                     <div class="input-group-append" data-target="#unmanagtDeDiv" data-toggle="datetimepicker">
                                                                        <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                                                     </div>
                                                                  </div>
                                                                  <div class="float-left">
                                                                      <select id="tyCd" class="form-control float-left"  style="min-width: 160px;width:70%;">
                                                                          <option value=''>시간선택</option>
                                                                      </select>
                                                                  </div>
                                                             </div> 
                                                          </div>                                                     
                                                     </div>  
                                                    <!-- 작업중지 실행시 END-->                                                 
                                                </div>
                                             </form>
                                         </div>
                                         
                                         <div class="form-group float-right">
                                              <button type="button" class="btn btn-primary float-right" id=""  style="margin:5px 0 15px 4px;">업데이트</button>
                                              <button type="button" class="btn btn-primary float-right" id=""  style="margin:5px 0 15px 1px;">취소</button>
                                          </div>
                                     </div>
                                     <!-- 우측영역 End -->
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