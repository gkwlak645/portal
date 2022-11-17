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
                            <h1 class="m-0 text-dark">프로세스 상세</h1>
                        </div>
                        <!-- /.col -->
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
                                <li class="breadcrumb-item">과제 / 과제개발</li>
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
    <div class="card-header" alt="과제 >과제개발>프로세스상세">
        <h3 class="card-title">상세</h3>
    </div>
    <div class="card-body">
        <div class="row">
            <div class="col-md-12">
                <form class="form-inline" id="unmanagtErrorDetail">                    
                    <div class="form-group col-sm-12 "><h5 class="text-success">⊙ 과제정보</h5></div>
                    
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">과제코드<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8">
                            <select id="" class="form-control" style="width:80%;margin-right: 3px;">
                                <option value="">H001</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">과제명<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8">
                            <input type="text" id="" class="form-control"  style="width:80%;" disabled>
                        </div>
                    </div>
                    <div class="form-group col-md-12  py-sm-1">
                        <label for="errorCn" class="col-sm-2 col-form-label">과제설명<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-10">
                            <textarea rows="2" id="" class="form-control" style="width:92.5%;" disabled></textarea>
                        </div>
                    </div>                   
                    
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">회사<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8">
                            <select class="form-control" style="width:80%; margin-right:3px;" disabled>
                                <option value="">동원</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">분류<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8">
                            <select id="" class="form-control" style="width:80%;margin-right: 3px;" disabled>
                                <option value="">영업</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">업무담당부서<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8">
                            <select id="" class="form-control" style="width:80%;margin-right: 3px;"disabled>
                                <option value="">혁신팀</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">업무담당자<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8">
                            <select id="" class="form-control" style="width:80%;margin-right: 3px;" disabled>
                                <option value="">홍길동</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">업무시간</label>
                        <div class="col-sm-8">
                            <input type="text" id="" class="form-control float-left" style="width:120px;margin-right: 3px;" value="264" type="text" disabled>H
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">빈도</label>
                        <div class="col-sm-8">
                            <select id="" class="form-control float-left" style="width:30%;margin-right: 10px;" disabled>
                                <option value="">월</option>
                            </select>
                            <input type="text" id="" class="form-control float-left" style="width:120px;margin-right: 3px;" type="text" value="22"disabled>회
                        </div>
                    </div>    
                    
                    
                     
                    <div class="col-md-12 m-3"></div> 
                    
                    <div class="form-group col-sm-12 "><h5 class="text-success float-left">⊙ 프로세스정보</h5></div>
                                                         
                    <div class="form-group col-md-12">
                        <label for="errorTyCd" class="col-sm-2 col-form-label">제목</label>
                        <div class="col-sm-10">
                            <input type="text" id="" class="form-control"  style="width:92.5%;"/>
                        </div>
                    </div>
                    
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">프로세스코드</label>
                        <div class="col-sm-8">
                            <input type="text" id="" class="form-control"  style="width:80%;" value="H00101">
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">프로세스명</label>
                        <div class="col-sm-8">
                            <input type="text" id="" class="form-control"  style="width:80%;">
                        </div>
                    </div>
                    
                    <div class="form-group col-md-12  py-sm-1">
                        <label for="errorCn" class="col-sm-2 col-form-label">업무설명</label>
                        <div class="col-sm-10">
                            <textarea rows="2" id="" class="form-control" style="width:92.5%;"></textarea>
                        </div>
                    </div> 
                    
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">업무분류</label>
                        <div class="col-sm-8">
                            <select id="" class="form-control" style="width:80%;margin-right: 3px;">
                                <option value="">영업</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">RPA분류</label>
                        <div class="col-sm-8">
                            <select id="" class="form-control" style="width:80%;margin-right: 3px;">
                                <option value="">RPA</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">회사</label>
                        <div class="col-sm-8">
                            <input type="text" id="" class="form-control"  style="width:80%;" value="동원">
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">부서</label>
                        <div class="col-sm-8">
                            <input type="text" id="" class="form-control"  style="width:80%;" value="혁신팀">
                        </div>
                    </div>
                    
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">담당자</label>
                        <div class="col-sm-8 float-left">
                            <input type="text" id="" class="form-control float-left"  style="width:70px;margin-right:5px;" value="홍길동"  /> 
                            <input type="text" id="" class="form-control float-left"  style="width:200px;margin-right: 10px;" value="hgd@dongwon.com" />
                        </div>
                    </div>    
                     
                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">연락처</label>
                        <div class="col-sm-8">
                            <input type="text" id="" class="form-control"  style="width:150px;" value="010-0000-0000" />  
                        </div>
                    </div>    
                    
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">업무시간</label>
                        <div class="col-sm-8">
                            <input type="text" id="" class="form-control float-left" style="width:120px;margin-right: 3px;" value="264">H
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">절감시간</label>
                        <div class="col-sm-8">
                            <input type="text" id="" class="form-control float-left" style="width:120px;margin-right: 3px;" value="264">H
                        </div>
                    </div>
                    
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">예상절감금액</label>
                        <div class="col-sm-8">
                            <input type="text" id="" class="form-control float-left" style="width:120px;margin-right: 3px;" value="8,712,000">원
                        </div>
                    </div>
                    
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">실행주기</label>
                        <div class="col-sm-8">
                            <select id="" class="form-control float-left" style="width:30%;margin-right: 10px;" >
                                <option value="">월</option>
                            </select>
                            <input type="text" id="" class="form-control float-left" style="width:120px;margin-right: 3px;" type="text" value="22">회
                        </div>
                    </div>
                                    
                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">실행시간</label>
                        <div class="col-sm-8">
                            <input type="text" id="" class="form-control float-left" style="width:120px;margin-right: 3px;" value="1">H
                        </div>
                    </div>     
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">긴급대응</label>
                        <div class="col-sm-8">
                            <select id="" class="form-control" style="width:80%;margin-right: 3px;">
                                <option value="">1시간 내 재실행</option>
                            </select>
                        </div>    
                    </div>
                    
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">개발공수</label>
                        <div class="col-sm-8">
                            <input type="text" id="" class="form-control float-left" style="width:120px;margin-right: 3px;" value="10">일
                        </div>
                    </div>                    
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">예상개발금액</label>
                        <div class="col-sm-8">
                            <input type="text" id="" class="form-control float-left" style="width:120px;margin-right: 3px;" value="2,805,000">원
                        </div>
                    </div>                   
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">RTO</label>
                        <div class="col-sm-8">
                            <input type="text" id="" class="form-control float-left" style="width:120px;margin-right: 3px;" value="1">H
                        </div>
                    </div>
                                       
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">ROI평가</label>
                        <div class="col-sm-8">
                            <select id="" class="form-control" style="width:60%;margin-right: 3px;">
                                <option value="">OK</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="form-group col-md-12">
                        <label for="errorCn" class="col-sm-2 col-form-label">업무설명</label>
                        <div class="col-sm-10">
                            <textarea rows="2" id="" class="form-control" style="width:92.5%;"></textarea>
                        </div>
                    </div>
                    
                    <div class="form-group col-md-12">
                        <label for="managtChargerId" class="col-sm-2 col-form-label">첨부파일 </label>
                        <div class="col-sm-10">
                            <div class="form-check2 row"  id="fileUpload"></div>
                        </div>
                   </div>
                   
                   <div class="form-group col-md-12">
                        <label for="managtChargerId" class="col-sm-2 col-form-label">연관문서 </label>
                        <div class="col-sm-10">
                            <input type="text" id="" class="form-control"  style="width:92.5%;"value="개발지침.pptx">
                       </div>
                   </div>
                   
                   
                   <div class="form-group col-md-12 m-3"></div>
                    
                   <div class="form-group col-sm-4"><h5 class="text-success float-left">⊙ 담당자 정보</h5></div>
                   <div class="col-sm-8">
                       <button type="button" id="btnSave"class="btn btn-secondary float-right" style="margin: 0;">+ 추가</button>
                   </div> 
                   
                   
                   <div class="form-group col-sm-12">                                 
	                   <div class="form-group col-md-6">
	                       <label for="sourcUpdtNm" class="col-sm-4 col-form-label">부서</label>
	                       <div class="col-sm-8">
	                           <input type="text" id="" class="form-control"  style="width:80%;" value="혁신팀">
	                       </div>
	                   </div>                    
	                   <div class="form-group col-md-6">
	                       <label for="sourcUpdtNm" class="col-sm-4 col-form-label">성명</label>
	                       <div class="col-sm-8 float-left">
	                           <input type="text" id="" class="form-control float-left"  style="width:30%; margin:2px 5px 0 0;" value="홍길동">
	                           <input type="button" class="btn btn-outline-primary float-left" id="" name="" value="사원검색" />
	                           <input type="button" class="btn btn-outline-secondary float-left" id="" name="" value="삭제" />
	                       </div>
	                   </div>
	                </div>
                    
                    <div class="form-group col-sm-12">                                 
                       <div class="form-group col-md-6">
                           <label for="sourcUpdtNm" class="col-sm-4 col-form-label">부서</label>
                           <div class="col-sm-8">
                               <input type="text" id="" class="form-control"  style="width:80%;" value="혁신팀">
                           </div>
                       </div>                    
                       <div class="form-group col-md-6">
                           <label for="sourcUpdtNm" class="col-sm-4 col-form-label">성명</label>
                           <div class="col-sm-8 float-left">
                               <input type="text" id="" class="form-control float-left"  style="width:30%; margin:2px 5px 0 0;" value="홍길동">
                               <input type="button" class="btn btn-outline-primary float-left" id="" name="" value="사원검색" />
                               <input type="button" class="btn btn-outline-secondary float-left" id="" name="" value="삭제" />
                           </div>
                       </div>
                    </div>
                    
                    <div class="form-group col-sm-12">                                 
                       <div class="form-group col-md-6">
                           <label for="sourcUpdtNm" class="col-sm-4 col-form-label">부서</label>
                           <div class="col-sm-8">
                               <input type="text" id="" class="form-control"  style="width:80%;" value="혁신팀">
                           </div>
                       </div>                    
                       <div class="form-group col-md-6">
                           <label for="sourcUpdtNm" class="col-sm-4 col-form-label">성명</label>
                           <div class="col-sm-8 float-left">
                               <input type="text" id="" class="form-control float-left"  style="width:30%; margin:2px 5px 0 0;" value="홍길동">
                               <input type="button" class="btn btn-outline-primary float-left" id="" name="" value="사원검색" />
                               <input type="button" class="btn btn-outline-secondary float-left" id="" name="" value="삭제" />
                           </div>
                       </div>
                    </div>
                    
                    
                    <div class="form-group col-md-12 m-3"></div>
                    
                   <div class="form-group col-sm-4"><h5 class="text-success float-left">⊙ 개인별 절감시간</h5></div>
                   <div class="col-sm-8">
                       <button type="button" id="btnSave"class="btn btn-secondary float-right" style="margin: 0;">+ 추가</button>
                   </div> 
                   
                   
                   <div class="form-group col-sm-12">           
	                    <div class="form-group col-md-3">
	                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">부서</label>
	                        <div class="col-sm-8">
	                            <input type="text" id="" class="form-control"  style="width:75%;" value="혁신팀" readonly>
	                        </div>
	                    </div>                    
	                    <div class="form-group col-md-4">
	                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">성명</label>
	                        <div class="col-sm-8 float-left">
	                            <input type="text" id="" class="form-control float-left"  style="width:48%;margin:2px 5px 0 0;" value="홍길동" readonly>
	                            <input type="button" class="btn btn-outline-primary float-left" id="" name="" value="사원검색" />
	                        </div>
	                    </div>
	                    <div class="form-group col-md-5">
	                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">절감시간(hour)</label>
	                        <div class="col-sm-8 float-left">
	                            <input type="text" id="" class="form-control float-left" style="width:48%; margin:2px 5px 0 0;" value="132"> <input type="button" class="btn btn-outline-secondary float-left" id="" name="" value="삭제" />  
	                        </div> 
	                    </div>
	                 </div>
	                 
	                 <div class="form-group col-md-12"> 
                        <div class="form-group col-md-3">
                            <label for="sourcUpdtNm" class="col-sm-4 col-form-label">부서</label>
                            <div class="col-sm-8">
                                <input type="text" id="" class="form-control"  style="width:75%;" value="혁신팀" readonly>
                            </div>
                        </div>                    
                        <div class="form-group col-md-4">
                            <label for="sourcUpdtNm" class="col-sm-4 col-form-label">성명</label>
                            <div class="col-sm-8 float-left">
                                <input type="text" id="" class="form-control float-left"  style="width:48%;margin:2px 5px 0 0;" value="홍길동" readonly>
                                <input type="button" class="btn btn-outline-primary float-left" id="" name="" value="사원검색" />
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label for="sourcUpdtNm" class="col-sm-4 col-form-label">절감시간(hour)</label>
                            <div class="col-sm-8 float-left">
                                <input type="text" id="" class="form-control float-left" style="width:48%; margin:2px 5px 0 0;" value="132"> <input type="button" class="btn btn-outline-secondary float-left" id="" name="" value="삭제" />  
                            </div> 
                        </div>
                     </div>
                    
                    
                     <div class="form-group col-md-12 py-sm-1 line-footer">
                        <div class="form-group col-md-7"></div> 
                        <div class="form-group col-md-5">
                            <label for="sourcUpdtNm" class="col-sm-4 col-form-label text-warning" >합계(hour)</label>
                            <div class="col-sm-8">
                                <input type="text" id="" class="form-control text-warning" style="width:48%; " value="264" disabled>   
                            </div>
                        </div> 
                    </div> 
                                        
                    
                    <div class="col-md-12 m-3"></div> 
                    <div class="form-group col-sm-4"><h5 class="text-success float-left">⊙ 개인별 기여도</h5></div>
                    <div class="col-sm-8">
                        <button type="button" id="btnSave"class="btn btn-secondary float-right" style="margin: 0;">+ 추가</button>
                     </div>
                     <div class="form-group col-md-12">
	                     <div class="form-group col-md-3">
	                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">부서</label>
	                        <div class="col-sm-8">
	                            <input type="text" id="" class="form-control"  style="width:80%;" value="혁신팀" readonly>
	                        </div>
	                    </div>                    
	                    <div class="form-group col-md-4">
                            <label for="sourcUpdtNm" class="col-sm-4 col-form-label">성명</label>
                            <div class="col-sm-8 float-left">
                                <input type="text" id="" class="form-control float-left"  style="width:48%;margin:2px 5px 0 0;" value="홍길동" readonly>
                                <input type="button" class="btn btn-outline-primary float-left" id="" name="" value="사원검색" />
                            </div>
                        </div>
	                    <div class="form-group col-md-5">
	                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">기여도(%)</label>
	                        <div class="col-sm-8 float-left">
	                            <input type="text" id="" class="form-control float-left" style="width:48%; margin:2px 5px 0 0;" value="70"> <input type="button" class="btn btn-outline-secondary float-left" id="" name="" value="삭제" />  
	                        </div> 
	                    </div> 
	                </div>  
                    
                    <div class="form-group col-md-12">
                         <div class="form-group col-md-3">
                            <label for="sourcUpdtNm" class="col-sm-4 col-form-label">부서</label>
                            <div class="col-sm-8">
                                <input type="text" id="" class="form-control"  style="width:80%;" value="혁신팀" readonly>
                            </div>
                        </div>                    
                        <div class="form-group col-md-4">
                            <label for="sourcUpdtNm" class="col-sm-4 col-form-label">성명</label>
                            <div class="col-sm-8 float-left">
                                <input type="text" id="" class="form-control float-left"  style="width:48%;margin:2px 5px 0 0;" value="홍길동" readonly>
                                <input type="button" class="btn btn-outline-primary float-left" id="" name="" value="사원검색" />
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label for="sourcUpdtNm" class="col-sm-4 col-form-label">기여도(%)</label>
                            <div class="col-sm-8 float-left">
                                <input type="text" id="" class="form-control float-left" style="width:48%; margin:2px 5px 0 0;" value="70"> <input type="button" class="btn btn-outline-secondary float-left" id="" name="" value="삭제" />  
                            </div> 
                        </div> 
                    </div>
                    
                    <div class="form-group col-md-12 py-sm-1 line-footer">
                        <div class="form-group col-md-7"></div>
                        <div class="form-group col-md-5"> 
                            <label for="sourcUpdtNm" class="col-sm-4 col-form-label text-warning" >합계(%)</label>
	                        <div class="col-sm-8">
	                            <input type="text" id="" class="form-control float-left text-warning" style="width:48%;"  value="100" readonly>   
	                        </div>
	                     </div> 
                    </div> 
                    
                    <div class="col-md-12 m-3"></div> 
                    
                    <div class="form-group col-sm-12 "><h5 class="text-success float-left">⊙ 실행정보</h5></div>
                    
                    <div class="form-group col-md-12">
                        <label for="sourcUpdtNm" class="col-sm-2 col-form-label">프로세스파일</label>
                        <div class="col-sm-10 float-left">
                            <!--<div class="form-check2 row"  id="fileUpload2"></div><input type="button" class="btn btn-outline-primary float-left" id="" name="" value="다운로드" />-->
                            <input type="file" class="float-left" id="" name="file" style="margin:4px 5px 0px 0;width:30%;min-width:60px;line-height:130%" value="Telecom-Discount.csv" /><input type="button" class="btn btn-outline-secondary float-left" id="btnDownFile'+idx+'" name="downFile" value="다운로드" /> <input type="button" class="btn btn-outline-secondary float-left" style="margin:0 15px 0 2px;" id="btnDelFile'+idx+'" name="delFile" value="삭제" />
                                       
                        </div> 
                    </div>
                    <div class="form-group col-md-12">
                        <label for="managtChargerId" class="col-sm-2 col-form-label">실행구분</label>
                        <div class="col-sm-10">
                           <select id="" class="form-control" style="width:45%;">
                                <option value="">정기실행</option>
                            </select> 
                        </div>
                    </div>
                                        
                    <div class="form-group col-md-12">
                        <label class="col-sm-4 float-left">연관 시스템</label>
                        <div class="col-sm-8 float-right">
                            <button type="button" id="btnSave"class="btn btn-secondary float-right" style="margin-left: 3px;">+ 추가</button>
                            <button type="button" id="btnSave"class="btn btn-secondary float-right" style="margin-left: 0;">- 삭제</button>
                        </div>
                     </div> 
                     <div class="form-group col-md-12">
                           <table class="table" style="padding:0">
					        <colgroup>
					          <col width="10%">
					          <col width="20%">
					          <col width="22%">
					          <col width="20%">
					          <col width="*">
					        </colgroup>
					        <thead>						        
						        <tr>
						            <th><input type="checkbox" class="custom-checkbox" style="width:18px;height:18px;"></th>
						            <th>분류</th>
						            <th>회사</th>
						            <th>시스템코드</th>
						            <th>시스템명</th>
						        </tr>
						    </thead>
					        <tbody>
				                <tr>
                                    <td><input type="checkbox" class="custom-checkbox" style="width:18px;height:18px;"></td>
                                    <td>공통</td>
                                    <td>-</td>
                                    <td>Z001</td>
                                    <td>SAP</td>
                                  </tr>
                                  <tr>
                                    <td><input type="checkbox" class="custom-checkbox" style="width:18px;height:18px;"></td>
                                    <td>회사별</td>
                                    <td>동원산업</td>
                                    <td>I001</td>
                                    <td>SCM</td>
                                  </tr>
                              </tbody>
					    </table>
                     </div> 
                     
                    <div class="col-md-12 m-2"></div>
                    <div class="form-group col-sm-12 "><h5 class="text-success float-left">⊙  상태</h5></div>
                    <div class="form-group col-md-12">
                        <label for="sourcUpdtNm" class="col-sm-3 col-form-label">프로세스상태</label>
                        <div class="col-sm-9">
                            <select id="" class="form-control" style="width:45%;margin-right: 3px;">
                                <option value="">개발완료</option>
                            </select> 
                        </div>
                    </div>
                    
                    
                    <div class="col-md-12 m-3"></div>
                    <div class="form-group col-sm-12 "><h5 class="text-success float-left">⊙  변경내용</h5></div>
                    <div class="form-group col-md-12">
                        <label for="sourcUpdtNm" class="col-sm-3 col-form-label">변경사유 및 내용<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-9">
                            <textarea rows="2" id="" class="form-control" style="width:92.5%;"></textarea>
                        </div>
                    </div>
                    
                    
                    <div class="col-md-12 m-3"></div>
                    <div class="form-group col-sm-12 "><h5 class="text-success float-left">⊙  프로세스 변경이력</h5></div>
                    <div class="col-md-12 m-1"></div>
                    <div class="form-group col-md-12">
                           <table class="table" style="padding:0">
                            <colgroup>
                              <col width="25%">
                              <col width="18%">
                              <col width="15%">
                              <col width="*">
                            </colgroup>
                            <thead>                             
                                <tr>
                                    <th>일시</th>
                                    <th>상태</th>
                                    <th>작업자</th>
                                    <th>변경사유 및 내용</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>2020-07-20 13:20:01</td>
                                    <td>개발접수</td>
                                    <td>홍길동</td>
                                    <td>..</td>
                                  </tr> 
                                  <tr>
                                    <td>2020-07-21 13:21:01</td>
                                    <td>개발중</td>
                                    <td>홍길동</td>
                                    <td>..</td>
                                  </tr>
                                  <tr>
                                    <td>2020-07-22 13:20:01</td>
                                    <td>개발접수</td>
                                    <td>홍길동</td>
                                    <td>..</td>
                                  </tr>                                 
                              </tbody>
                        </table>
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
    

    function pageInit(){
        bbsUpload = new RpaUpload("fileUpload");
        bbsUpload.draw(0 ,true);
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