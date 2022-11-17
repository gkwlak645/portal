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
                            <h1 class="m-0 text-dark">큐 등록</h1>
                        </div>
                        <!-- /.col -->
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
                                <li class="breadcrumb-item">자원관리 / 큐관리</li>
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
    <div class="card-header" alt="자원관리 >큐관리>큐등록">
        <h3 class="card-title">등록</h3>
    </div>
    <div class="card-body">
        <div class="row">
            <div class="col-md-12">
                <form class="form-inline" id="unmanagtErrorDetail">                    
                    <div class="form-group col-md-12"><h5 class="text-success">⊙  큐추가</h5></div> 
                    
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">이름<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8">
                            <input type="text" id="" class="form-control"  style="width:80%;">
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">고유참조</label>
                        <div class="col-sm-8">
                            <input type="radio" name="radio choice" class="custom-radio" style="width:18px;height:18px;">예 &nbsp;
                            <input type="radio" name="radio choice" class="custom-radio" style="width:18px;height:18px;">아니오
                        </div>
                    </div>
                    
                    <div class="form-group col-md-12">
                        <label for="managtChargerId" class="col-sm-2 col-form-label">설명</label>
                        <div class="col-sm-10">
                            <textarea rows="2" id="" class="form-control" style="width:92.5%;"></textarea>
                        </div>
                    </div>                                   
                    
                    
                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">자동재시도</label>
                        <div class="col-sm-8">
                            <input type="radio" name="radio choice2" class="custom-radio" style="width:18px;height:18px;">예 &nbsp;
                            <input type="radio" name="radio choice2" class="custom-radio" style="width:18px;height:18px;">아니오  &nbsp;                            
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label"  style="display:block;">최대 재시도횟수</label>
                        <div class="col-sm-8"  style="display:block;">
                            <input type="text" id="" class="form-control" style="width:60px;margin-right: 3px;" type="text"> 
                        </div>
                    </div>
                    
                                        
                     
                    <div class="col-md-12 m-3"></div> 
                    
                    <div class="form-group col-md-12"><h5 class="text-success">⊙ 스키마 정의</h5></div>  
                                                         
                    <div class="form-group col-md-12">
                        <label for="managtChargerId" class="col-sm-2 col-form-label">특정데이터첨부</label>
                        <div class="col-sm-10">
                            <div class="form-check2 row"  id="fileUpload"></div>
                        </div>
                   </div>
                   <div class="form-group col-md-12">
                        <label for="managtChargerId" class="col-sm-2 col-form-label">출력데이터첨부</label>
                        <div class="col-sm-10">
                            <div class="form-check2 row"  id="fileUpload2"></div>
                        </div>
                   </div>
                   <div class="form-group col-md-12">
                        <label for="managtChargerId" class="col-sm-2 col-form-label">분석데이터첨부</label>
                        <div class="col-sm-10">
                            <div class="form-check2 row"  id="fileUpload3"></div>
                        </div>
                   </div> 
                                        
                    
                    <div class="col-md-12 m-3"></div> 
                    <div class="form-group col-md-12">
                        <div class="col-sm-4"><h5 class="text-success float-left">⊙ SLA 예측</h5></div>
                        <div class="col-sm-8 custom-control custom-switch float-right">
                            <input type="checkbox" id="customSwitch1" class="custom-control-input float-right"  >
                            <label class="custom-control-label  float-right" for="customSwitch1">이 큐에 대해  SLA활성화</label>
                        </div>
                     </div>
                                        
                     <div class="form-group col-md-12" style="display:visibility;"><!-- 스위치 꺼지면 display:none처리 -->
                     
	                     <div class="form-group col-md-6">
	                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">프로세스</label>
	                        <div class="col-sm-8">
	                            <select class="form-control" style="margin-right:3px; ">
	                                <option value="">프로세스를 선택합니다</option>
	                            </select>                               
	                        </div>
	                     </div>
	                     <div class="form-group col-md-6">
	                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">새로운 큐항목 SLA</label>
	                        <div class="col-sm-4">
                                <input type="number" class="form-control num float-left" style="width:60px; margin-right:2px;"" value="1" min="0">
                                                            일
                            </div>
                            <div class="col-sm-4">                                
                                <input type="number" class="form-control num float-left" style="width:60px; margin-right:2px;"" value="1" min="0">
                                                             시간
                            </div>
	                    </div>
	                    
	                    <div class="col-md-12">                        
                            <div class="col-sm-12 custom-control custom-switch">     
                                <input type="checkbox" id="customSwitch2" class="custom-control-input" >                       
                                <label class="custom-control-label float-right" for="customSwitch2">위험  SLA</label>                         
                            </div>            
                        </div>
                        
                        <div class="form-group col-md-12 py-sm-3" style="display:visibility;"><!-- 스위치 꺼지면 display:none처리2 -->
                            <label for="sourcUpdtNm" class="col-sm-2 col-form-label">위험 SLA</label>
                            <div class="col-sm-2">
                                <input type="number" class="form-control num float-left" style="width:60px; margin-right:2px;"" value="1" min="0">
                                                            일
	                        </div>
	                        <div class="col-sm-8">                                
	                            <input type="number" class="form-control num float-left" style="width:60px; margin-right:2px;"" value="1" min="0">
	                                                             시간                        
                            </div>
                        </div>
                        <!-- 스위치 꺼지면 display:none처리2  END -->    
	                </div>
                    <!-- <!-- 스위치 꺼지면 display:none처리 END -->         
                </form>
                <div class="float-right py-sm-2">
                    <button type="button" class="btn btn-primary" id="unmanagtErrorDetailUpdateBtn">추가하기</button>
                    <button type="button" class="btn btn-primary" id="unmanagtErrorDetailCancelBtn">취소</button>
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
        bbsUpload = new RpaUpload("fileUpload2");
        bbsUpload.draw('',true);
        bbsUpload = new RpaUpload("fileUpload3");
        bbsUpload.draw('',true);
    };
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