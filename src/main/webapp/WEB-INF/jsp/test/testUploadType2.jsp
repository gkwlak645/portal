<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>메인화면</title>
        <!-- Tell the browser to be responsive to screen width -->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="/resources/plugins/fontawesome-free/css/all.min.css">
        <!-- Ionicons -->
        <!-- <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css"> -->
        <link rel="stylesheet" href="/resources/css/ionicons/css/ionicons.min.css">
        <!-- Tempusdominus Bbootstrap 4 -->
        <link rel="stylesheet" href="/resources/plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
        <!-- iCheck -->
        <link rel="stylesheet" href="/resources/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
        <!-- JQVMap -->
        <link rel="stylesheet" href="/resources/plugins/jqvmap/jqvmap.min.css">
        <!-- Theme style -->
        <link rel="stylesheet" href="/resources/css/dist/adminlte.css">
        <!-- overlayScrollbars -->
        <link rel="stylesheet" href="/resources/plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
        <!-- Daterange picker -->
        <link rel="stylesheet" href="/resources/plugins/daterangepicker/daterangepicker.css">
        <!-- summernote -->
        <link rel="stylesheet" href="/resources/plugins/summernote/summernote-bs4.css">
        <!-- Google Font: Source Sans Pro -->
        <!-- <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet"> -->
        <link rel="stylesheet" href="/resources/css/opensans/opensans.css">
        <!-- jsGrid -->
        
        <link rel="stylesheet" href="/resources/plugins/jsgrid/jsgrid.css">
        
        <link rel="stylesheet" href="/resources/plugins/jsgrid/jsgrid.min.css">
        <link rel="stylesheet" href="/resources/plugins/jsgrid/jsgrid-theme.min.css">
        <link rel="stylesheet" href="/resources/css/custom.css">
        <!-- jstree -->
        <link rel="stylesheet" href="/resources/js/jstree/themes/default/style.min.css">
        <link rel="stylesheet" href="/resources/js/jstree/themes/proton/style.min.css">
        
        <!-- calendar -->
        <link rel="stylesheet" href="/resources/plugins/fullcalendar/main.min.css">
        <link rel="stylesheet" href="/resources/plugins/fullcalendar-daygrid/main.min.css">
        <link rel="stylesheet" href="/resources/plugins/fullcalendar-timegrid/main.min.css">
        <link rel="stylesheet" href="/resources/plugins/fullcalendar-bootstrap/main.min.css">
        
        <script src="/resources/plugins/moment/moment.min.js"></script>
        <script src="/resources/plugins/fullcalendar/main.min.js"></script>
        <script src="/resources/plugins/fullcalendar-daygrid/main.min.js"></script>
        <script src="/resources/plugins/fullcalendar-timegrid/main.min.js"></script>
        <script src="/resources/plugins/fullcalendar-interaction/main.min.js"></script>
        <script src="/resources/plugins/fullcalendar-bootstrap/main.min.js"></script>
        
        <!-- jQuery -->
        <script src="/resources/plugins/jquery/jquery.min.js"></script>
        <script src="/resources/js/jquery/jquery.form.min.js"></script>
        <!-- jQuery UI 1.11.4 -->
        <script src="/resources/plugins/jquery-ui/jquery-ui.min.js"></script>
        <!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
        <script>
        $.widget.bridge('uibutton', $.ui.button)
        </script>
        <!-- Bootstrap 4 -->
        <script src="/resources/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
        <!-- ChartJS -->
        <script src="/resources/plugins/chart.js/Chart.min.js"></script>
        <!-- Sparkline -->
        <script src="/resources/plugins/sparklines/sparkline.js"></script>
        <!-- JQVMap -->
        <script src="/resources/plugins/jqvmap/jquery.vmap.min.js"></script>
        <script src="/resources/plugins/jqvmap/maps/jquery.vmap.usa.js"></script>
        <!-- jQuery Knob Chart -->
        <script src="/resources/plugins/jquery-knob/jquery.knob.min.js"></script>
        <!-- daterangepicker -->
        <script src="/resources/plugins/moment/moment.min.js"></script>
        <!-- daterangepicker 한글 적용 -->
        <script src="/resources/plugins/moment/locale/ko.js"></script>
        <script src="/resources/plugins/daterangepicker/daterangepicker.js"></script>
        <!-- Tempusdominus Bootstrap 4 -->
        <script src="/resources/plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
        <!-- Summernote -->
        <script src="/resources/plugins/summernote/summernote-bs4.min.js"></script>
        <!-- overlayScrollbars -->
        <script src="/resources/plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
        <!-- AdminLTE App -->
        <script src="/resources/js/dist/adminlte.js"></script>
        <!-- AdminLTE dashboard demo (This is only for demo purposes) -->
        <script src="/resources/js/dist/pages/dashboard.js"></script>
        <!-- AdminLTE for demo purposes -->
        <script src="/resources/plugins/jsgrid/jsgrid.min.js"></script>
        
        <script src="/resources/js/common.js"></script>
        <script src="/resources/js/common-ajax.js"></script>
        <script src="/resources/js/file-upload.js"></script>
        <!-- jstree -->
        <script src="/resources/js/jstree/jstree.min.js"></script>
        
        <!-- Summernote -->
        <script src="/resources/plugins/summernote/summernote-bs4.min.js"></script>
        <script>
        
        $(document).ready(function(){
            if (typeof pageInit === 'function') {
                pageInit();
            }
            if (typeof bindEvent === 'function') {
                bindEvent();
            }
        });
        </script>
    </head>
<body>
-------------------------------------------------<br/>
--  type1<br/>
<div class="form-check2 row" id="fileUpload"></div>
<input type="button" class="btn btn-secondary float-left" id="btnFileUpload" style="padding:3px 15px;" name="add" value="파일업로드" />
<br/><br/>
-Edit<br/>
<div class="form-check2 row" id="fileUploadEdit"></div><br/>
<br/>
<br/>
-View<br/>
<div id="atchFile"><ul class="mailbox-attachments d-flex align-items-stretch clearfix"></ul></div>
<br><br>
--  type1(복수 업로드 영역 확인 용)<br/>
<div class="form-check2 row" id="fileUpload_2"></div>
<input type="button" class="btn btn-secondary float-left" id="btnFileUpload_2" style="padding:3px 15px;" name="add" value="파일업로드" />
<br/><br/>
-Edit<br/>
<div class="form-check2 row" id="fileUploadEdit_2"></div><br/>
<br/>
<br/>
-View<br/>
<div id="atchFile_2"><ul class="mailbox-attachments d-flex align-items-stretch clearfix"></ul></div>
<br/>
-------------------------------------------------<br/>
--  type2<br/>
- REG
<div class="form-check2 row" id="fileUploadType2Upload"></div>
<input type="button" class="btn btn-secondary float-left" id="btnFileUploadType2" style="padding:3px 15px;" name="add" value="파일업로드" />
<br/><br/><br/>
- EDIT
<div class="form-check2 row" id="fileUploadType2Edit"></div>


    
<script type="text/javascript">
var fileGrpNo = '';
var oRpaUploadUpload;
var oRpaUploadEdit
var oRpaUploadView

var fileGrpNo_2 = '';
var oRpaUploadUpload_2;
var oRpaUploadEdit_2;
var oRpaUploadView_2;

var fileGrpNoType2 = '';
var oRpaUploadType2Upload;
var oRpaUploadType2Edit;

function bindEvent(){
	oRpaUploadUpload = new RpaUploadV2("fileUpload");
	oRpaUploadUpload = new RpaUploadV2("fileUpload");
	oRpaUploadEdit = new RpaUploadV2("fileUploadEdit");
	oRpaUploadView = new RpaUploadV2("atchFile");
	
	if(fileGrpNo != "" && fileGrpNo != "0" && fileGrpNo != null){
		oRpaUploadUpload.draw(fileGrpNo,true);
    }
    else{
    	oRpaUploadUpload.draw('',true);
    }
	
	$("#btnFileUpload").on("click", function() { 
		fileGrpNo = oRpaUploadUpload.upload();
        //표시
		if(fileGrpNo != "" && fileGrpNo != "0" && fileGrpNo != null){
			oRpaUploadEdit.draw(fileGrpNo,true);
			var url = "/file/getAtchmnflList";
	        var param = {
	                fileGrpNo : fileGrpNo
	        };
	        callAsyncAjax(url, param, "getAtchFile");
	    }
	    else{
	    	oRpaUploadEdit.draw('',true);
	    }
    });
	
	oRpaUploadUpload_2 = new RpaUploadV2("fileUpload_2");
    oRpaUploadUpload_2 = new RpaUploadV2("fileUpload_2");
    oRpaUploadEdit_2 = new RpaUploadV2("fileUploadEdit_2");
    oRpaUploadView_2 = new RpaUploadV2("atchFile_2");
    
    if(fileGrpNo_2 != "" && fileGrpNo_2 != "0" && fileGrpNo_2 != null){
        oRpaUploadUpload_2.draw(fileGrpNo_2,true);
    }
    else{
        oRpaUploadUpload_2.draw('',true);
    }
    
    $("#btnFileUpload_2").on("click", function() { 
        fileGrpNo_2 = oRpaUploadUpload_2.upload();
        //표시
        if(fileGrpNo_2 != "" && fileGrpNo_2 != "0" && fileGrpNo_2 != null){
            oRpaUploadEdit_2.draw(fileGrpNo_2,true);
            var url = "/file/getAtchmnflList";
            var param = {
                    fileGrpNo : fileGrpNo_2
            };
            callAsyncAjax(url, param, "getAtchFile_2");
        }
        else{
            oRpaUploadEdit_2.draw('',true);
        }
    });
	
	
	
//--    Type2	
	
	
	oRpaUploadType2Upload = new RpaUploadType2("fileUploadType2Upload")
	oRpaUploadType2Edit = new RpaUploadType2("fileUploadType2Edit")
	if(fileGrpNoType2 != "" && fileGrpNoType2 != "0" && fileGrpNoType2 != null){
		oRpaUploadType2Upload.draw(fileGrpNo,true);
    }
    else{
    	oRpaUploadType2Upload.draw('',true);
    }

	$("#btnFileUploadType2").on("click", function() { 
		fileGrpNoType2 = oRpaUploadType2Upload.upload();
		
		//표시
		oRpaUploadType2Edit.draw(fileGrpNoType2,true);
    });
}

/*파일 다운로드 영역*/
function getAtchFile(fileInfoList){
    var html = "";
    var fileGrpNo = fileInfoList.result[0].fileGrpNo;
    var szUnit = "byte";
    var convertSz = 0;
    
    html += '<input type="hidden" id="fileGrpNo" name="fileGrpNo" value="'+fileGrpNo+'" />';
    $.each(fileInfoList.result, function(index,item){
        html += '<li id="upload'+index+'">';
        html +=     '<span class="mailbox-attachment-icon"><i class="far fa-file-pdf"></i></span>';
        html +=     '<div class="mailbox-attachment-info">';
        html +=         '<a href="#" class="mailbox-attachment-name"><i class="fas fa-paperclip"></i>'+item.oriFileNm+'</a>';
        html +=         '<span class="mailbox-attachment-size clearfix mt-1">';
        if(item.fileSz < 1024){
            convertSz = item.fileSz;
        }else if(item.fileSz/1024 < 1024){
            var tmp = item.fileSz/1024;
            szUnit = "KB";
            convertSz = tmp.toString().substring(0,tmp.toString().indexOf(".")+2);
        }else{
            var tmp = (item.fileSz/1024)/1024;
            szUnit = "MB";
            convertSz = tmp.toString().substring(0,tmp.toString().indexOf(".")+2);
        }
        html +=             '<span>'+ convertSz+szUnit +'</span>';
        html +=             '<input type="hidden" id="fileNo'+index+'" name="fileNo" value="'+item.fileNo+'" />';
        html +=             '<a href="#" class="btn btn-default btn-sm float-right" id="btnDownFile'+index+'">';
        html +=                 '<i class="fas fa-cloud-download-alt"></i>';
        html +=             '</a>';
        html +=         '</span>';
        html +=     '</div>';
        html += '</li>';
    });
    
    $("#atchFile ul").html(html);
    
    $("#atchFile ul [id^='btnDownFile']").on("click", function(){
        downloadFile("atchFile", fileGrpNo, $(this).closest("li").attr("id"));
    });
}

/*파일 다운로드 영역*/
function getAtchFile_2(fileInfoList){
    var html = "";
    var fileGrpNo = fileInfoList.result[0].fileGrpNo;
    var szUnit = "byte";
    var convertSz = 0;
    
    html += '<input type="hidden" id="fileGrpNo" name="fileGrpNo" value="'+fileGrpNo+'" />';
    $.each(fileInfoList.result, function(index,item){
        html += '<li id="upload'+index+'">';
        html +=     '<span class="mailbox-attachment-icon"><i class="far fa-file-pdf"></i></span>';
        html +=     '<div class="mailbox-attachment-info">';
        html +=         '<a href="#" class="mailbox-attachment-name"><i class="fas fa-paperclip"></i>'+item.oriFileNm+'</a>';
        html +=         '<span class="mailbox-attachment-size clearfix mt-1">';
        if(item.fileSz < 1024){
            convertSz = item.fileSz;
        }else if(item.fileSz/1024 < 1024){
            var tmp = item.fileSz/1024;
            szUnit = "KB";
            convertSz = tmp.toString().substring(0,tmp.toString().indexOf(".")+2);
        }else{
            var tmp = (item.fileSz/1024)/1024;
            szUnit = "MB";
            convertSz = tmp.toString().substring(0,tmp.toString().indexOf(".")+2);
        }
        html +=             '<span>'+ convertSz+szUnit +'</span>';
        html +=             '<input type="hidden" id="fileNo'+index+'" name="fileNo" value="'+item.fileNo+'" />';
        html +=             '<a href="#" class="btn btn-default btn-sm float-right" id="btnDownFile'+index+'">';
        html +=                 '<i class="fas fa-cloud-download-alt"></i>';
        html +=             '</a>';
        html +=         '</span>';
        html +=     '</div>';
        html += '</li>';
    });
    
    $("#atchFile_2 ul").html(html);
    
    $("#atchFile_2 ul [id^='btnDownFile']").on("click", function(){
        downloadFile("atchFile", fileGrpNo, $(this).closest("li").attr("id"));
    });
}

/*다운로드*/
function downloadFile(divId, fileGrpNo, liId) {
    var fileNo = $("#" + divId + " #"+liId+" input[id^='fileNo']").val();
    $("#"+divId+ "_downloadFileGrpNo").val(fileGrpNo);
    $("#"+divId+ "_downloadFileNo").val(fileNo);
    $("#"+divId+ "_downloadForm")[0].submit();
 }



</script>

</body>