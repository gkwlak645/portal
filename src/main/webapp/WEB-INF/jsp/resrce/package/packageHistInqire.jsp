<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="card card-primary" id = "cardDiv">
    <div class="card-header">
        <h3 class="card-title">이력조회</h3>
    </div>
    <div class="card-body">
        <div class="row">
            <div id="packageLibraryGrid"></div>
                <div class="col-md-6">
                <div class="float-right">
                    <button type="button" class="btn btn-primary" id="cancel">닫기</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>

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
        });
        
    }
    
    function packageLibrayList(data, cd){
        console.log(data);
        
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
                     drawPackageList(data.result);      
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
                    drawLibraryList(data.result);      
                },
                error: function (e) {
                }
            });
        }
        
    }
    
    function drawPackageList(data){
        console.log(data)
    
       $("#packageLibraryGrid"). jsGrid({
            height : "auto"
          , width : "100%"
          , autoload: true
          , sorting : true
          , align : "center"
          , data : data
          , fields : [
               {name: "Version"      , title : "버전" , type : "text" , width : 100, align : "center"}
             , {name: "Authors"      , title : "작성자"   , type : "text" , width : 150, align : "center"}
             , {name: "Published"    , title : "게시일"  , type : "text" , width : 80, align : "center",
                 itemTemplate:function(value){
                     return moment(value).format('YYYY-MM-DD');
               }}
             , {name: "IsActive"    , title : "활성"   , type : "text" , width : 80, align : "center"
            	 , itemTemplate: function(value, item) {
                     if(item.IsActive.toString() == "true") { 
                         return $("<IsActive>").text("활성");
                     }
                     else {
                         return $("<IsActive>").text("비활성");
                     }
                 }
               }
             , {name: "Description"  , title : "설명"   , type : "text" , width : 80, align : "center"}
            
         ]
     }); 
    }
    
    function drawLibraryList(data){
        console.log(data)
    
       $("#packageLibraryGrid"). jsGrid({
            height : "auto"
          , width : "100%"
          , autoload: true
          , sorting : true
          , align : "center"
          , data : data
          , fields : [
        	  {name: "Version"      , title : "버전" , type : "text" , width : 100, align : "center"}
              , {name: "Authors"      , title : "작성자"   , type : "text" , width : 150, align : "center"}
              , {name: "Published"    , title : "게시일"  , type : "text" , width : 80, align : "center",
                  itemTemplate:function(value){
                      return moment(value).format('YYYY-MM-DD');
                }}
              , {name: "Description"  , title : "설명"   , type : "text" , width : 80, align : "center"}            
         ]
     }); 
    }
    
 </script>