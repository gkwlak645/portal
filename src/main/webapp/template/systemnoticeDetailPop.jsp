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
                            <h1 class="m-0 text-dark">시스템작업공지</h1>
                        </div>
                        <!-- /.col -->
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
                                <li class="breadcrumb-item">커뮤니티 / 시스템작업공지</li>
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
                    <div class="form-group col-md-12 py-sm-2">
                        <label for="errorCn" class="col-sm-2 col-form-label">공지제목<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-10">
                            <input type="text" id="" class="form-control" style="width:90%;">
                        </div>
                    </div>  
                    <div class="form-group col-md-12">
                        <label for="errorCn" class="col-sm-2 col-form-label">공지내용<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-10">
                            <textarea rows="2" id="" class="form-control" style="width:90%;"></textarea>
                        </div>
                    </div> 
                                      
                    <div class="form-group col-md-12 py-sm-2">
                        <label class="col-sm-2">대상시스템</label>
                        <div class="col-sm-9" class="table" >
                        <input type="button" class="btn btn-outline-primary float-right" id="" name="" value="+추가" />
                        <table class="table float-left" style="padding:0;margin-top:10px;">
                            <colgroup>
                              <col width="25%">
                              <col width="*">
                              <col width="20%">
                            </colgroup>
                            <thead>                             
                                <tr>
                                    <th>시스템코드</th>
                                    <th>시스템명</th>
                                    <th>삭제</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Z001</td>
                                    <td>SAP</td>
                                    <td><input type="button" class="btn btn-outline-success" id="" name="" value="삭제" /></td>
                                  </tr>
                                  <tr>
                                    <td>회사별</td>
                                    <td>동원산업</td>
                                    <td><input type="button" class="btn btn-outline-success" id="" name="" value="삭제" /></td>
                                  </tr>
                              </tbody>
                         </table>
                     </div>   
                   </div>  
                </form>
                <div class="float-right py-sm-3">
                    <button type="button" class="btn btn-primary" id="unmanagtErrorDetailUpdateBtn">저장</button>
                    <button type="button" class="btn btn-primary" id="unmanagtErrorDetailUpdateBtn">삭제</button>
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
            <footer class="main-footer">
                Copyright &copy; 2020 <a href="http://www.echoit.co.kr">에코아이티</a>&nbsp;.&nbsp;All
                rights reserved.    >
            </footer>
        </div>
    </div>
</body>
</html>