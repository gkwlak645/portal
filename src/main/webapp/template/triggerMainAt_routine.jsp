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
                            <h1 class="m-0 text-dark">트리거(AT)</h1>
                        </div>
                        <!-- /.col -->
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
                                <li class="breadcrumb-item">자원관리 / 트리거</li>
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
        <h3 class="card-title">정기실행 등록</h3>
    </div>
    <div class="card-body">
        <div class="row" style="min-height:560px;">
            <div class="col-md-12">
                <form class="form-inline" id="">  
                     <div class="form-group col-md-6">
                         <label for="name" class="col-sm-4 col-form-label">이름</label>
                         <div class="col-sm-8">
                             <input style="width:60%;" type="text" id="envrnName" class="form-control" required>
                         </div>
                      </div>
                      <div class="form-group col-md-6" >
                         <label class="col-sm-4 col-form-label" for="inputName">프로세스</label>
                         <div class="col-sm-8">
                             <select class="form-control" id="" style="width:60%;margin-right: 3px;">
                             </select>
                         </div>
                     </div>
                     
                     <div class="form-group col-md-6">
                         <label for="name" class="col-sm-4 col-form-label">실행로봇</label>
                         <div class="col-sm-8">
                             <select class="form-control" id="" style="width:60%;margin-right: 3px;">
                             </select>
                         </div>
                      </div>
                      <div class="form-group col-md-6" >
                         <label class="col-sm-4 col-form-label" for="inputName">휴무일 제한사항</label>
                         <div class="col-sm-8">
                             <select class="form-control" id="" style="width:60%;margin-right: 3px;">
                             </select>
                         </div>
                     </div>
                     
                     <div class="form-group col-md-12">
                        <label for="name" class="col-sm-2 col-form-label">실행기간</label>
                        <div class="col-sm-10 float-left">
                            <div class="input-group date float-left" id="startDeDiv" data-target-input="nearest"style="min-width:200px;width:23.4%;margin-right:5px;">
                                <input type="text" id="startDe" name="startDe" class="form-control datetimepicker-input" data-target="#startDeDiv"/>
                                <div class="input-group-append" data-target="#startDeDiv" data-toggle="datetimepicker">
                                    <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                </div>
                            </div>
                            <div class="input-group date  float-left" id="endDeDiv" data-target-input="nearest"style="min-width:200px;width:23.4%;">
                                <input type="text" id="endDe" name="endDe" class="form-control datetimepicker-input" data-target="#endDeDiv"/>
                                <div class="input-group-append" data-target="#endDeDiv" data-toggle="datetimepicker">
                                    <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                </div>
                            </div>
                        </div>
                     </div>                  
                    
                     <div class="form-group col-md-12" style="display:inline;">                        
                        <div class="col-sm-2 py-sm-1  float-left"><label for="sourcUpdtNm" class="col-form-label"><input type="radio" name="radio choice" class="custom-radio" style="width:18px;height:18px;">  분</label></div>
                        <div class="col-sm-10 py-sm-2 float-left">
                            <input type="text" id="" class="form-control float-left" style="width:90px;margin-right: 3px;">분 간격
                        </div>
                        
                        <div class="col-md-12 line-top py-sm-2 float-left"></div> <!-- 사이점선 -->
                        <div class="col-sm-2 py-sm-1  float-left"><label for="sourcUpdtNm" class="col-form-label"><input type="radio" name="radio choice" class="custom-radio" style="width:18px;height:18px;">  시간</label></div>
                        <div class="col-sm-10 py-sm-2 float-left">
                            <select class="form-control  float-left" style="width:90px; margin-right:3px;">
                                <option value="">1시간</option>
                            </select>                            
                            <input type="text" id="" class="form-control float-left" style="width:90px;margin-right: 3px;">분 간격
                        </div>
                        
                        <div class="col-md-12 line-top py-sm-2 float-left"></div> <!-- 사이점선 -->
                        <div class="col-sm-2 py-sm-1 float-left"><label for="sourcUpdtNm" class="col-form-label"><input type="radio" name="radio choice" class="custom-radio" style="width:18px;height:18px;">  매일</label></div>
                        <div class="col-sm-10 py-sm-2 float-left">
                            <select class="form-control  float-left" style="width:90px; margin-right:3px;">
                                <option value="">12시</option>
                            </select>
                            <input type="text" id="" class="form-control float-left" style="width:90px;margin-right: 3px;">분
                        </div>
                        
                        <div class="col-md-12 line-top float-left"></div> <!-- 사이점선 -->
                        <div class="col-sm-2 py-sm-2 float-left"><label for="sourcUpdtNm" class="col-form-label float-left"  style="padding-top:10px;"><input type="radio" name="radio choice" class="custom-radio" style="width:18px;height:18px;">  매주</label></div>
                        <div class="col-sm-10 py-sm-3 float-left">
                            <input type="checkbox" name="checkbox choice" class="custom-checkbox" style="width:18px;height:18px;">월
                            <input type="checkbox" name="checkbox choice" class="custom-checkbox" style="width:18px;height:18px;margin-left:8px;">화
                            <input type="checkbox" name="checkbox choice" class="custom-checkbox" style="width:18px;height:18px;margin-left:8px;">수
                            <input type="checkbox" name="checkbox choice" class="custom-checkbox" style="width:18px;height:18px;margin-left:8px;">목
                            <input type="checkbox" name="checkbox choice" class="custom-checkbox" style="width:18px;height:18px;margin-left:8px;">금
                            <input type="checkbox" name="checkbox choice" class="custom-checkbox" style="width:18px;height:18px;margin-left:8px;">토
                            <input type="checkbox" name="checkbox choice" class="custom-checkbox" style="width:18px;height:18px;margin-left:8px;">일
                            <div class="m-2"></div><!-- 사이간격 -->
                            <select class="form-control float-left" style="width:90px; margin-right:3px;">
                                <option value="">12시</option>
                            </select>
                            <input type="text" id="" class="form-control float-left" style="width:90px;margin-right: 3px;">분
                        </div>
                        
                        <div class="col-md-12 py-sm-1 line-top float-left" ></div> <!-- 사이점선 -->
                        <div class="col-sm-2 py-sm-2 float-left"><label for="sourcUpdtNm" class="col-form-label float-left"  style="padding-top:9px;"><input type="radio" name="radio choice" class="custom-radio" style="width:18px;height:18px;">  매월</label></div>
                        <div class="col-sm-10 py-sm-1 float-left">
                            <div class="col-sm-2 float-left py-sm-2  text-success"><input type="radio" name="radio choice1" class="custom-radio" style="width:16px;height:16px;margin:0 3px 2px 0;">일   </div> 
                            <div class="col-sm-10 py-sm-2 float-left">                       
                                <select class="form-control float-left" style="width:90px; margin-right:3px; ">
                                    <option value="">01일</option>
                                </select>
                               <select class="form-control float-left" style="width:90px; ">
                                    <option value="">1시</option>
                                </select>
                               <input type="text" id="" class="form-control float-left" style="width:90px;margin-left: 3px;">분
                               
                            </div>
                            
                            <div class="col-sm-2 float-left py-sm-1 text-success"><input type="radio" name="radio choice1" class="custom-radio" style="width:16px;height:16px;margin:0 3px 2px 0;">주차</div> 
                            <div class="col-sm-10 py-sm-1 float-left">   
                                <input type="radio" name="radio choice2" class="custom-checkbox" style="width:14px;height:14px;margin:0;""> 첫째주
                                <input type="radio" name="radio choice2" class="custom-checkbox" style="width:14px;height:14px;margin:0 0 0 10px;"> 둘째주
                                <input type="radio" name="radio choice2" class="custom-checkbox" style="width:14px;height:14px;margin:0 0 0 10px;"> 셋째주
                                <input type="radio" name="radio choice2" class="custom-checkbox" style="width:14px;height:14px;margin:0 0 0 10px;"> 넷째주
                                <input type="radio" name="radio choice2" class="custom-checkbox" style="width:14px;height:14px;margin:0 0 0 10px;"> 마지막주
                                <div class="m-2"></div><!-- 사이간격 -->
                                <input type="checkbox" name="checkbox choice2" class="custom-checkbox" style="width:18px;height:18px;">월
                                <input type="checkbox" name="checkbox choice2" class="custom-checkbox" style="width:18px;height:18px;margin-left:8px;">화
                                <input type="checkbox" name="checkbox choice2" class="custom-checkbox" style="width:18px;height:18px;margin-left:8px;">수
                                <input type="checkbox" name="checkbox choice2" class="custom-checkbox" style="width:18px;height:18px;margin-left:8px;">목
                                <input type="checkbox" name="checkbox choice2" class="custom-checkbox" style="width:18px;height:18px;margin-left:8px;">금
                                <input type="checkbox" name="checkbox choice2" class="custom-checkbox" style="width:18px;height:18px;margin-left:8px;">토
                                <input type="checkbox" name="checkbox choice2" class="custom-checkbox" style="width:18px;height:18px;margin-left:8px;">일
                                <div class="m-2"></div><!-- 사이간격 -->
                                
                                <select class="form-control float-left" style="width:90px; ">
                                    <option value="">1시</option>
                                </select>
                                <input type="text" id="" class="form-control float-left" style="width:90px;margin-left: 6px;"> 분
                            </div>
                        </div>
                    </div>           
                </form>
                <div class="float-right py-sm-2">
                    <button type="button" class="btn btn-primary" id="unmanagtErrorDetailUpdateBtn">저장</button>
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
    

    
</script>
 </div>

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
