<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="modal fade" id="modal-lg">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">버전관리</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button></div>
            <div class="modal-body" >
		        <div class="row">
		            <div id="packageLibraryVerGrid"></div>
		                <div class="col-md-6">
		                
		                                        입력값
		                  <div id = "inputValue"></div>
		                  
		                                        출력값
		                  <div id="outputValue"></div> 
		                <div class="float-right">
		                    <button type="button" class="btn btn-primary" id="cancel">닫기</button>
		                </div>
		            </div>
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
    
    function packageLibrayVerList(data){
        console.log("@"+data);
        var url = "/resrce/package/packageLibraryHistInqireList";
        var param ={"identifier" : data
                   ,"checked" : $('input:radio[name="checkRadio"]:checked').val()
                   };
        callAsyncAjax(url, param, "drawPackageLibraryVerList");
    }
    
    function drawPackageLibraryVerList(data){
        console.log(data)
        var params = data.result.resultList;
        $("#packageLibraryVerGrid"). jsGrid({
            height : "auto"
          , width : "100%"
          , autoload: true
          , sorting : true
          , align : "center"
          , data : params
          , checkboxes:true
          , fields : [
        	  // {type : "checkbox", title : "<input type=\"checkbox\" id=\"checkAll\">", autosearch: true}
               {name: ""      , title : "상태" , type : "text" , width : 100 }
             , {name: "version"      , title : "버전"   , type : "text" , width : 150}
             , {name: ""      , title : "개시일"  , type : "text" , width : 80, align : "center"}
             , {name: ""             , title : "다운로드"   , type : "text" , width : 80, align : "center"}
            
         ]
     });  
    }
    
 </script>