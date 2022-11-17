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
                            <h1 class="m-0 text-dark">휴일관리</h1>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
                                <li class="breadcrumb-item">기준정보 > 휴일관리</li>
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
                <div id="dayoffMainDiv" class="container-fluid wrap">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card">
                                <div class="card-header">
                                    <form name="searchForm" class="form-inline">
                                        <div class="form-group row  col-sm-6">
                                            <label for="licenseKey" class="col-sm-2 col-form-label">회사</label>
                                            <div class="col-sm-10">
                                                <select class="form-control" id="tenant" style="width:37%;min-width:120px;" required>
                                                    <option selected disabled>계열사선택</option>
                                                    <option value="1">동원산업</option>
                                                    <option value="X">동원로엑스</option>
                                                    <option value="F">동원FnB</option>
                                                    <option value="H">동원홈푸드</option>
                                                    <option value="C">동원시스템즈</option>
                                                    <option value="T">테크팩솔루션</option>
                                                    <option value="A">동원건설산업</option>
                                                </select>
                                            </div>
                                        </div>
                
                                        
                                        <div class="form-group row  col-sm-6">
                                            <label for="activeId" class="col-sm-2 col-form-label">날짜</label>
                                            <div class="col-sm-10 float-left">
                                                 <select class="form-control float-left" id="month" style="width:37%;min-width:120px;" required>
                                                       <option value="1">2020년</option> 
                                                       <option value="2">2021년</option> 
                                                </select>
                                                <input type="button" id="searchBtn" class="btn btn-info  float-left" value="조회" /> 
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
                                <div class="card-body wrapper">
                                
                                        <div class="col-sm-12">
                                            <!-- Main content -->
                                            <section class="content">
                                                <div class="container-fluid">
                                                    <div class="row">
                                                    
                                                        <!-- 20201104 수정 - 확인 부탁드립니다 -->
                                                        <div class="col-md-3" style="padding:15px 15px 15px 0;">
                                                            <button type="button" class="btn btn-secondary float-right">+ 추가</button> 
                                                            
                                                            <div id="scNameDiv" class="scNameDiv_wrap"><!-- 클래스 추가-->
                                                                <div class="active"><!-- 활성화  .active 추가-->
                                                                   <select class="form-control">
                                                                       <option selected disabled>동원산업</option>
                                                                       <option value="1">동원산업</option>
                                                                       <option value="X">동원로엑스</option>
                                                                       <option value="F">동원FnB</option>
                                                                       <option value="H">동원홈푸드</option>
                                                                       <option value="C">동원시스템즈</option>
                                                                       <option value="T">테크팩솔루션</option>
                                                                       <option value="A">동원건설산업</option>
                                                                   </select>
                                                                   <input type="text" class="form-control" placeholder="내용입력"/>
                                                                </div>
                                                                <div><!-- 활성화  .active 추가-->
                                                                   <select class="form-control">
                                                                       <option selected disabled>동원산업</option>
                                                                       <option value="1">동원산업</option>
                                                                       <option value="X">동원로엑스</option>
                                                                       <option value="F">동원FnB</option>
                                                                       <option value="H">동원홈푸드</option>
                                                                       <option value="C">동원시스템즈</option>
                                                                       <option value="T">테크팩솔루션</option>
                                                                       <option value="A">동원건설산업</option>
                                                                   </select>
                                                                   <input type="text" class="form-control" placeholder="내용입력"/>
                                                                </div>
                                                                <div><!-- 활성화  .active 추가-->
                                                                   <select class="form-control">
                                                                       <option selected disabled>동원산업</option>
                                                                       <option value="1">동원산업</option>
                                                                       <option value="X">동원로엑스</option>
                                                                       <option value="F">동원FnB</option>
                                                                       <option value="H">동원홈푸드</option>
                                                                       <option value="C">동원시스템즈</option>
                                                                       <option value="T">테크팩솔루션</option>
                                                                       <option value="A">동원건설산업</option>
                                                                   </select>
                                                                   <input type="text" class="form-control" placeholder="내용입력"/>
                                                                </div>
                                                                <div><!-- 활성화  .active 추가-->
                                                                   <select class="form-control">
                                                                       <option selected disabled>동원산업</option>
                                                                       <option value="1">동원산업</option>
                                                                       <option value="X">동원로엑스</option>
                                                                       <option value="F">동원FnB</option>
                                                                       <option value="H">동원홈푸드</option>
                                                                       <option value="C">동원시스템즈</option>
                                                                       <option value="T">테크팩솔루션</option>
                                                                       <option value="A">동원건설산업</option>
                                                                   </select>
                                                                   <input type="text" class="form-control" placeholder="내용입력"/>
                                                                </div>
                                                                <div><!-- 활성화  .active 추가-->
                                                                   <select class="form-control">
                                                                       <option selected disabled>동원산업</option>
                                                                       <option value="1">동원산업</option>
                                                                       <option value="X">동원로엑스</option>
                                                                       <option value="F">동원FnB</option>
                                                                       <option value="H">동원홈푸드</option>
                                                                       <option value="C">동원시스템즈</option>
                                                                       <option value="T">테크팩솔루션</option>
                                                                       <option value="A">동원건설산업</option>
                                                                   </select>
                                                                   <input type="text" class="form-control" placeholder="내용입력"/>
                                                                </div>
                                                                <div><!-- 활성화  .active 추가-->
                                                                   <select class="form-control">
                                                                       <option selected disabled>동원산업</option>
                                                                       <option value="1">동원산업</option>
                                                                       <option value="X">동원로엑스</option>
                                                                       <option value="F">동원FnB</option>
                                                                       <option value="H">동원홈푸드</option>
                                                                       <option value="C">동원시스템즈</option>
                                                                       <option value="T">테크팩솔루션</option>
                                                                       <option value="A">동원건설산업</option>
                                                                   </select>
                                                                   <input type="text" class="form-control" placeholder="내용입력"/>
                                                                </div>
                                                                <div><!-- 활성화  .active 추가-->
                                                                   <select class="form-control">
                                                                       <option selected disabled>동원산업</option>
                                                                       <option value="1">동원산업</option>
                                                                       <option value="X">동원로엑스</option>
                                                                       <option value="F">동원FnB</option>
                                                                       <option value="H">동원홈푸드</option>
                                                                       <option value="C">동원시스템즈</option>
                                                                       <option value="T">테크팩솔루션</option>
                                                                       <option value="A">동원건설산업</option>
                                                                   </select>
                                                                   <input type="text" class="form-control" placeholder="내용입력"/>
                                                                </div>
                                                                <div><!-- 활성화  .active 추가-->
                                                                   <select class="form-control">
                                                                       <option selected disabled>동원산업</option>
                                                                       <option value="1">동원산업</option>
                                                                       <option value="X">동원로엑스</option>
                                                                       <option value="F">동원FnB</option>
                                                                       <option value="H">동원홈푸드</option>
                                                                       <option value="C">동원시스템즈</option>
                                                                       <option value="T">테크팩솔루션</option>
                                                                       <option value="A">동원건설산업</option>
                                                                   </select>
                                                                   <input type="text" class="form-control" placeholder="내용입력"/>
                                                                </div>
                                                             </div>
                                                        </div>
                                                        <!-- // 20201104 수정 - 확인 부탁드립니다 -->
                                                        
                                                        <div class="col-md-9">
                                                                    <!-- THE CALENDAR -->
                                                                    <div id="calendar"></div>
                                                                <!-- /.card-body -->
                                                            <!-- /.card -->
                                                        </div>
                                                    </div>
                                                    <!-- /.row -->
                                                </div>
                                                <!-- /.container-fluid -->
                                            </section>
                                            <!-- /.content -->
                                        </div>                                  
                                        <div class="float-right p-2">
                                        <button type="button" class="btn btn-primary" id="robotRegister">저장</button>
                                        <button type="button" class="btn btn-primary" id="lookup">조회</button>
                                        &nbsp;
                
                                    </div>
                                </div>
                                <!-- /.content-wrapper -->
                
                                <!-- Control Sidebar -->
                                <aside class="control-sidebar control-sidebar-dark">
                                    <!-- Control sidebar content goes here -->
                                </aside>
                                <!-- /.control-sidebar -->
                
                
                
                
                            </div>
                            <!-- ./wrapper -->
                
                
                
                        </div>
                    </div>
                </div>
                </div>
                
                
                <script>
                
                   var regidate = new Object();
                
                    $(document).ready(function() {
                
                        calendar15();
                        
                        //페이지 초기화
                        //pageInit();
                
                        //이벤트 바인딩
                        //bindEvent();
                                                 });
                
                    function bindEvent() {
                
                        //저장 클릭
                        $("#robotRegister").on("click", function() {
                        var type = "edit";
                
                            getTenantInfo(type);
                            $('#calendar').html("");
                            calendar15();
                                                                   });
                        
                        //조회클릭
                        $("#lookup").on("click", function() {
                         var type = "get";
                              
                            getTenantInfo(type);
                            $('#calendar').html("");            
                            calendar15();
                                                             });
                
                                          }
                    
                    //테넌트 아이디 가져오기
                    function getTenantInfo(type){
                        
                        console.log("type은???"+type);
                        
                        
                        var url="/stdrinfo/dayoff/getTenantInfo";               
                        var param = { Tenant : $("#tenant").val()};                         
                        console.log(param);     
                        
                        if(type == "get"){
                            callSyncAjax(url, param, "getoffDay" );
                        }else if(type == "edit") {
                            callSyncAjax(url, param, "editDayoff" );
                        }else{
                            alert("오류발생!!!")            
                        }
                        
                        
                        
                        
                    }
                    
                    
                
                    // 휴무일 생성
                    function regiDayoff(info) {
                
                        console.log(info);
                        
                        //var url = "/stdrinfo/dayoff/registDayoff";
                
                        var param = new Object();
                
                        param.Name = "test05"
                        param.ExcludedDates = [ "2020-09-01", "2020-09-05", "2020-09-15",
                                "2020-09-16" ];
                
                        //callAsyncAjax(url, param, null);
                
                                               }
                    
                    
                    // 휴무일 수정
                       function editDayoff(info) {
                
                           console.log("************info**********"+ info)
                            
                            var url = "/stdrinfo/dayoff/editDayoff";
                
                            var param = new Object();
                
                            param.Id = info.result.id
                            param.Name = "test00"
                            param.ExcludedDates = jsonData;
                            
                            console.log("*******************a**********"+ jsonData)
                            
                            callSyncAjax(url, param, null);
                
                        }
                    
                   
                    // 휴무일 불러오기
                   function getoffDay(info) {
                       
                        console.log("************info**********"+ JSON.stringify(info))
                        //console.log("************info*********3*"+ JSON.stringify(info.result.id))
                     
                      
                        var url = "/stdrinfo/dayoff/getoffDay";
                
                        var param = new Object();
                
                        param.Id = info.result.id
                       
                    
                        callSyncAjax(url, param, "checklog");
                
                    }
                    
                    var jsonData = {};
                     function checklog(data){
                         
                         
                         
                         console.log("저장된 날짜"+JSON.stringify(data));
                         console.log("저장된 날짜"+JSON.stringify(data.result.resultList.ExcludedDates));
                         alert(JSON.stringify(data));
                         jsonData = data.result.resultList.ExcludedDates;
                      
                     }
                     
                     function a(){
                         
                         alert( "*******************a**********"+ jsonData)
                         
                     }
                    
                     ////////////////fullcalendar////////////////////////////////
                        
                     
                     function  calendar15() {
                     
                        
                   
                   
                     //ini_events($('#external-events div.external-event'))
                
                     /* initialize the calendar
                      -----------------------------------------------------------------*/
                     //Date for the calendar events (dummy data)
                     var date = new Date()
                     var d    = date.getDate(),
                         m    = date.getMonth(),
                         y    = date.getFullYear()
                
                     var Calendar = FullCalendar.Calendar;
                    // var Draggable = FullCalendarInteraction.Draggable;
                
                     var containerEl = document.getElementById('external-events');
                     var checkbox = document.getElementById('drop-remove');
                     var calendarEl = document.getElementById('calendar');
                     
                     var strD = jsonData;
                     
                     var endD = '2020-09-08';
                     var k = new Date(2020, 9 -1, 8);
                     
                     
                     console.log("*****jasonData****"+jsonData);
                     console.log(strD.length);
                     console.log(strD[1]);
                   
                    
                     
                     var events = []; //The array
                     for(var i =0; i < strD.length; i++) 
                     {events.push( {start: strD[i], title: "dayoff"} )}  
                     
                
                      var calendar = new Calendar(calendarEl, {
                         
                               
                          dayRender: function() {
                                             
                          },
                          
                     
                      selectable: true,
                     //unselectAuto: false,
                         //unselectCancel: ".my-form",
                     
                      dateClick: function(info) {
                
                       alert('Date:' + info.dateStr); 
                       if(jsonData.includes(info.dateStr + "T00:00:00Z")){     
                           alert('날짜제거'); 
                           jsonData.pop(info.dateStr);
                           var type = "edit";
                           getTenantInfo(type);
                           $('#calendar').html("");            
                           calendar15();
                         
                           
                         }else{
                          alert('날짜추가');
                          jsonData.push(info.dateStr);    
                          var type = "edit";
                          getTenantInfo(type);
                          $('#calendar').html("");          
                          calendar15();
                          var type ="get";
                          getTenantInfo(type);
                          $('#calendar').html("");            
                          calendar15();
                         }
                     
                       
                      
                        console.log(jsonData);
                        
                           },
                           
                       select: function(info) {
                                  //alert('selected ' + info.startStr); 
                                  //alert('selected ' + info.startStr + ' to ' + info.endStr); 
                           },
                      
                         
                      plugins: [ 'bootstrap', 'interaction', 'dayGrid', 'timeGrid' ],
                      header    : {
                        left  : '',
                        center: 'title',
                        right :'prev,next'
                      },
                      'themeSystem': 'bootstrap',
                      //Random default events
                         
                      events    : events,
                            
                      
                   
                      editable  : true,
                      droppable : true, // this allows things to be dropped onto the calendar !!!
                      drop      : function(info) {
                        // is the "remove after drop" checkbox checked?
                        if (checkbox.checked) {
                          // if so, remove the element from the "Draggable Events" list
                          info.draggedEl.parentNode.removeChild(info.draggedEl);
                        }
                      }
                     
                    }); 
                
                         calendar.render();
                                    
                     } 

                     // 20201104 추가 - 리스트 클릭 효과
                     $("#scNameDiv input").on("focus", function(){
                         $(this).parent('div').addClass('active')
                         $(this).parent('div').siblings().removeClass('active')
                     });

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
