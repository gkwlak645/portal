<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="card card-primary" id = "cardDiv">
    <div class="card-header">
        <h3 class="card-title">버전정보</h3>
    </div>
    <div class="card-body">
        <div class="row">
            <div id="packageLibraryVerGrid"></div>
                <div class="col-md-6">
                
<!--                                         입력값 -->
<!--                   <div id = "inputValue"></div> -->
                  
<!--                                         출력값 -->
<!--                   <div id="outputValue"></div>  -->
                <div class="float-right">
                    <button type="button" class="btn btn-primary" id="cancel">닫기</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>

var cmpny;
var deletePackageCallbackId;

    $(document).ready(function() {
       
        //페이지 초기화
        pageInit();
        
        //이벤트 바인딩
        bindEvent();
    });

    /*
     * 페이지 초기화
     * @param
     * @return
     */
    function pageInit() {
        
    }
    
    /*
     * 이벤트 바인딩
     * @param
     * @return
     */
    function bindEvent() {
        
        $("#cancel").on("click", function() {
            closePOP();
            
          
          //그리드 초기화
            drawGrid();
            
            //그리드 조회
            searchPackageLibraryList();
         
            $("#checkLibrary").hide();
            
            
        });
        
    }
    
    function packageLibrayVerList(data, cd){
    	 //로딩바 
        $('.dimmed').css({ display: 'block' });
        $('.loading').css({ display: 'block' });
        $('.loading').addClass('show');
        
        console.log("@"+data);
        console.log(cd);
       
        if($('input:radio[name="checkRadio"]:checked').val() == 'package'){
            var url = "/resrce/package/packageVersionInfoList?processId=" + data + "&cmpnyCd=" + cd;
            $.ajax({
                 type: "GET",
                 url: url,
                 processData: false,
                 cache: false,
                 dataType: "json",
                 success: function (data) {
                     console.log("data.result", data.result);
                     drawPackageVerList(data.result);      
                 },
                 error: function (e) {
                 }
            });
        } else {
            var url = "/resrce/package/libraryVersionInfoList?packageId=" + data + "&cmpnyCd=" + cd;
            $.ajax({
                type: "GET",
                url: url,
                dataType: "json",
                processData: false,
                cache: false,
                success: function (data) {
                    console.log("data.result", data.result);
                    drawLibraryVerList(data.result);      
                },
                error: function (e) {
                }
            });
        }
        
     
        
    }
    
    function drawPackageVerList(data){
        console.log(data)
//         var params = data.result.resultList;
        $("#packageLibraryVerGrid").jsGrid({
            height : "auto"
          , width : "100%"
          , autoload: true
          , sorting : true
          , align : "center"
          , data : data
          , checkboxes:true
          , fields : [
               {name: "IsActive"     , title : "상태" , type : "text" , width : 100, align : "center"
                   , itemTemplate: function(value, item) {
                       if(item.IsActive == true) { 
                           return $("<IsActive>").text("활성");
                       }
                       
                       return $("<IsActive>").text("비활성");
                   }
               }
             , {name: "Version"      , title : "버전"   , type : "text" , width : 150, align : "center"}
             , {name: "Published"    , title : "게시일"  , type : "text" , width : 80, align : "center",
                 itemTemplate:function(value){
                     return moment(value).format('YYYY-MM-DD');
               }}
             , {name: ""             , title : "다운로드"   , type : "text" , width : 80, align : "center"
                 , itemTemplate: function(_, item) {
                     var itemIcon = "";

                     itemIcon = '<svg class="bi bi-box-arrow-up" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">';
                     itemIcon += '<path fill-rule="evenodd" d="M4.646 4.354a.5.5 0 0 0 .708 0L8 1.707l2.646 2.647a.5.5 0 0 0 .708-.708l-3-3a.5.5 0 0 0-.708 0l-3 3a.5.5 0 0 0 0 .708z"/>';
                     itemIcon += '<path fill-rule="evenodd" d="M8 11.5a.5.5 0 0 0 .5-.5V2a.5.5 0 0 0-1 0v9a.5.5 0 0 0 .5.5z"/>';
                     itemIcon += '<path fill-rule="evenodd" d="M2.5 14A1.5 1.5 0 0 0 4 15.5h8a1.5 1.5 0 0 0 1.5-1.5V7A1.5 1.5 0 0 0 12 5.5h-1.5a.5.5 0 0 0 0 1H12a.5.5 0 0 1 .5.5v7a.5.5 0 0 1-.5.5H4a.5.5 0 0 1-.5-.5V7a.5.5 0 0 1 .5-.5h1.5a.5.5 0 0 0 0-1H4A1.5 1.5 0 0 0 2.5 7v7z"/>';
                     itemIcon += '</svg>';

                     return $(itemIcon).on("click", function(){packageDownload(item.Id, item.Version)});
                }}
             , {name: ""            , title : "삭제"  , type : "text" , width : 80, align : "center", 
                 itemTemplate: function(_, item) {
                     
                     if(item.IsActive == true) {
                         return "활성화 패키지는 삭제 불가능";
                     }
                     
                     return $("<button class='btn btn-primary' style='padding:2px;min-width:74px;'>").text("삭제").on("click", function() { 
                         packageDelClick(item.Id, item.Version); 
                     });
                 }}
         ]
        });  
        
     // 로딩 끝
        $('.dimmed').css({ display: 'none' });
        $('.loading').css({ display: 'none' });
        $('.loading').removeClass('show');
    }   
        
    
    /* 패키지 삭제(버전마다)
     * @param 페이지번호
     * @return
     */
    function packageDelClick(pId, pVersion){
        if(confirm("선택하신 패키지 "+ pId + "_" + pVersion + "를(을) 삭제 하시겠습니까?")){

            var url = "/resrce/package/deletePackage";
            deletePackageCallbackId = pId;
            var param = {
                    Id: pId
                    , cmpnyCd: cmpny
                    , Version : pVersion
                };  
                             
            callAsyncAjax(url, param, "deletePackageCallback");
            
            //로딩바 
            $('.dimmed').css({ display: 'block' });
            $('.loading').css({ display: 'block' });
            $('.loading').addClass('show');
            
        }
    }
    
    function deletePackageCallback(data){
        alert('삭제되었습니다.');
        packageLibrayVerList(deletePackageCallbackId, cmpny);
        
        $('.dimmed').css({ display: 'none' });
        $('.loading').css({ display: 'none' });
        $('.loading').removeClass('show');
    }
    
    function drawLibraryVerList(data){
         console.log(data)
         $("#packageLibraryVerGrid").jsGrid({
             height : "auto"
           , width : "100%"
           , autoload: true
           , sorting : true
           , align : "center"
           , data : data
           , checkboxes:true
           , fields : [
                {name: "Version"      , title : "버전"   , type : "text" , width : 80, align : "center"}
              , {name: "Published"    , title : "게시일"  , type : "text" , width : 80, align : "center",
                  itemTemplate:function(value){
                      return moment(value).format('YYYY-MM-DD');
                }}
          ]
      }); 
    }
    
    function packageDownload(identifier, version){
    	//로딩바 
        $('.dimmed').css({ display: 'block' });
        $('.loading').css({ display: 'block' });
        $('.loading').addClass('show');

        var url = "/resrce/package/packageDownload?processKey=" + identifier + "&version=" + version;   
    	
    	var xhr = new XMLHttpRequest();
        xhr.responseType = 'blob';
    	xhr.open('GET', url, true); // true로 하면 비동기로 설정. false로 설정하면 너무 느림.
    	xhr.send(null);
    	xhr.onload = function() {
    		if(xhr.status == 200) {
    			var blob = this.response;
                var a = window.document.createElement('a');
                a.href = window.URL.createObjectURL(blob);
                a.download = identifier + "." + version + ".nupkg";
                document.body.appendChild(a);
                a.click();
                document.body.removeChild(a);   
            }
    		else {
    			alert("패키지를 다운로드할 수 없습니다.\n상태코드를 확인하세요.");
    		}
    		
    		$('.dimmed').css({ display: 'none' });
            $('.loading').css({ display: 'none' });
            $('.loading').removeClass('show');
        };
    	
        // 아래 ajax로 파일(nupkg) 다운 받으면 글자 깨짐
        // 위의 var xhr = new XMLHttpRequest();를 활용해야 하는 듯
        /* $.ajax({
            type: "GET",
//             enctype: 'multipart/form-data',
//             dataType: "json",
            url: url,
            processData: false,
            cache: false,
            success: function (data) {
                debugger;
                var a = $("<a style='display: none;'/>");
                var url = window.URL.createObjectURL(new Blob([data], {type: "application/octet-stream"}));
                a.attr("href", url);
                a.attr("download", identifier + "." + version + ".nupkg");
                $("body").append(a);

                a[0].click();
                window.URL.revokeObjectURL(url);
                a.remove();
                console.log("url", url);
               
                $('.dimmed').css({ display: 'none' });
                $('.loading').css({ display: 'none' });
                $('.loading').removeClass('show');
            },
            error: function (e) {
                console.log(e);
                
                $('.dimmed').css({ display: 'none' });
                $('.loading').css({ display: 'none' });
                $('.loading').removeClass('show');
            }
        }); */
    }

 </script>