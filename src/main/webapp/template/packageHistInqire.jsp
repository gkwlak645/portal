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
    
    function packageLibrayList(data){
        console.log(data);
        var url = "/resrce/package/packageLibraryHistInqireList";
        var param ={"identifier" : data
        		    ,"checked" : $('input:radio[name="checkRadio"]:checked').val()
        		   };
        if($('input:radio[name="checkRadio"]:checked').val() == 'package'){
        	callAsyncAjax(url, param, "drawPackageList");
        } else {
        	callAsyncAjax(url, param, "drawLibraryList");
        }
        
    }
    
    function drawPackageList(data){
        console.log(data)
        var params = data.result.resultList;
    
       $("#packageLibraryGrid"). jsGrid({
            height : "auto"
          , width : "100%"
          , autoload: true
          , sorting : true
          , align : "center"
          , data : params
          , fields : [
               {name: "version"      , title : "버전" , type : "text" , width : 100, align : "center"}
             , {name: "authors"      , title : "작성자"   , type : "text" , width : 150, align : "center"}
             , {name: "created"      , title : "개시일"  , type : "text" , width : 80, align : "center"}
             , {name: "statement"    , title : "활성"   , type : "text" , width : 80, align : "center"}
             , {name: "description"  , title : "설명"   , type : "text" , width : 80, align : "center"}
            
         ]
     }); 
    }
    
    function drawLibraryList(data){
        console.log(data)
        var params = data.result.resultList;
    
       $("#packageLibraryGrid"). jsGrid({
            height : "auto"
          , width : "100%"
          , autoload: true
          , sorting : true
          , align : "center"
          , data : params
          , fields : [
               {name: "version"      , title : "버전" , type : "text" , width : 100, align : "center"}
             , {name: "authors"      , title : "작성자"   , type : "text" , width : 150, align : "center"}
             , {name: "created"      , title : "개시일"  , type : "text" , width : 80, align : "center"}
             , {name: "description"  , title : "설명"   , type : "text" , width : 80, align : "center"}
            
         ]
     }); 
    }
    
 </script>