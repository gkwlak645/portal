<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="card card-primary" id = "cardDiv">
    <div class="card-header"  alt="자원>디바이스관리 상세">
        <h3 class="card-title">상세조회</h3>
    </div>
    <div class="card-body" style="min-height:654px; overflow:auto;">
        <div class="row">                                                                
             <div class="col-md-12">
                <div class="form-inline">
                    <div class="form-group col-md-12 py-sm-3">
                        <label class="col-sm-2 col-form-label">회사<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-10">
                            <select class="form-control" id="cmpnyCd" style="width:80%;  max-width:220px;margin-right: 3px;">
                                <option value="">선택</option>
                            </select>
                        </div>  
                    </div>                          
                    <div class="form-group col-md-12 py-sm-2">
                        <label for="inputName" class="col-sm-2 col-form-label">이름 <b style="color: red;">*</b></label>
                        <div class="col-sm-10">
                            <input style="width:100%;margin-right: 3px;"type="text" id="deviceName" class="form-control" value="" disabled>
                             <p style="color:#4b5eb5;font-size:12px;">The machine name has to be an exact match to the name of the workstation the Robot is installed on.</p>
                        </div>
                    </div> 
                    <div class="form-group col-md-12 py-sm-3">
                         <label class="col-sm-2 col-form-label"for="inputDescription">머신 키</label>
                         <div class="col-sm-10">
                             <input type="hidden" id="deviceId">
                             <input style="width:100%;margin-right: 3px;"type="text" id="deviceKey" class="form-control" disabled>
                         </div>                
                  </div>
                  <div class="form-group col-md-12 py-sm-2" >
                         <label for="inputDescription" class="col-sm-2 col-form-label">설명</label>
                         <div class="col-sm-10">
                            <input style="width:100%;margin-right: 3px;"type="text" id="deviceDescription" class="form-control">
                         </div>
                  </div>
                </div> 
             </div> 
                        
<!--              <div class="col-md-12"> -->
<!--                   <div class="form-inline">  -->
<!--                       <div class="form-group col-md-6 py-sm-2" > -->
<!--                           <label class="col-sm-4 col-form-label" for="inputStatus" >비운영슬롯</label> -->
<!--                           <div class="col-sm-8"> -->
<!--                               <input style="width:50%;margin-right: 3px;"type="number" id="nonProductionSlots" class="form-control" min="0" numberOnly> -->
<!--                           </div> -->
<!--                       </div> -->
<!--                       <div class="form-group col-md-6 py-sm-2"> -->
<!--                           <label for="inputStatus" class="col-sm-4 col-form-label">unattended슬롯</label> -->
<!--                           <div class="col-sm-8"> -->
<!--                               <input style="width:50%;margin-right: 3px;"type="number" id="unattendedSlots" class="form-control" min="0" numberOnly> -->
<!--                           </div> -->
<!--                       </div>                       -->
<!--                   </div>                     -->
<!--               </div>                -->
                
<!--               <div class="col-md-12"> -->
<!--                     <div class="form-inline">  -->
<!--                         <div class="form-group col-md-6 py-sm-2" > -->
<!--                             <label class="col-sm-4 col-form-label" for="inputStatus">headless슬롯</label> -->
<!--                             <div class="col-sm-8"> -->
<!--                                 <input style="width:50%;margin-right: 3px;"type="number" id="headlessSlots" class="form-control" min="0" numberOnly> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                         <div class="form-group col-md-6 py-sm-2" > -->
<!--                             <label for="inputStatus" class="col-sm-4 col-form-label">테스트자동화슬롯</label> -->
<!--                             <div class="col-sm-8"> -->
<!--                                 <input style="width:50%;margin-right: 3px;"type="number" id="testAutomationSlots" class="form-control" min="0" numberOnly> -->
<!--                             </div> -->
<!--                         </div>                       -->
<!--                     </div>                     -->
<!--                 </div>                 -->
             </div>   
                
             <div class="float-right">
                  <button type="button" class="btn btn-primary" id="cancel">목록으로</button>
                  <c:if test="${txScreenAuthor != null}">
                      <c:if test="${txScreenAuthor.wrtngAuthor eq 'Y'}">
                          <button type="button" class="btn btn-primary" id="deviceModify">저장</button>
                          <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal-lg3">삭제</button>
                          <button type="button" class="btn btn-primary" id="deviceCancel">취소</button>
                      </c:if>
                  </c:if>
              </div>
          </div>
    </div>
</div>

<div class="modal fade-dept" id="modal-lg3">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header" style="background-color: #007bff;color: white;"><h5>삭제</h5></div>
            <div class="modal-body" >
                <h5>해당 디바이스를 삭제하시겠습니까?</h5>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary" id="deleteDevice">삭제</button>
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
    	
    	var params = [];
        if("${txScreenAuthor.untenantAuthor}" == 'Y'){
            params.push({"id" : "cmpnyCd", "clsCd" : "0024", "disable" : "Y"});    //회사
        }else{
            params.push({"id" : "cmpnyCd", "clsCd" : "0024", "disable" : "Y"});    //회사
        }
        //params.push({"id" : "cmpnyCd", "clsCd" : "0024"});
        requestCmmnCd(params);
        
    }
    /*
     * 이벤트 바인딩
     * @param
     * @return
     */
    function bindEvent() {
        
        $("#cancel").on("click", function() {
            $(".over").remove();
        });
        
        $("#deviceCancel").on("click", function() {
            $(".over").remove();
        });
        
        $("#deviceDescription").on('keyup', function(){
            if($(this).val().length > 500){
                $(this).val($(this).val().substring(0, 500));
                alert("최대 입력 글자 수는 500입니다.");
            }
        });
        
        $("#nonProductionSlots").on("keyup", function() {
            $(this).val($(this).val().replace(/[^0-9]/g,""));
        });

        $("#unattendedSlots").on("keyup", function() {
            $(this).val($(this).val().replace(/[^0-9]/g,""));
        });

//         $("#headlessSlots").on("keyup", function() {
//             $(this).val($(this).val().replace(/[^0-9]/g,""));
//         });

//         $("#testAutomationSlots").on("keyup", function() {
//             $(this).val($(this).val().replace(/[^0-9]/g,""));
//         });
        
        $("#deviceModify").on("click", function() {
//             if($("#nonProductionSlots").val() == null || $("#nonProductionSlots").val() == '') {
//                 alert("비운영슬롯을 입력해주세요.");
//             } else if($("#unattendedSlots").val() == null || $("#unattendedSlots").val() == '') {
//                 alert("unattended를 입력해주세요.");
//             } else if($("#headlessSlots").val() == null || $("#headlessSlots").val() == '') {
//                 alert("headless를 입력해주세요.");
//             } else if($("#testAutomationSlots").val() == null || $("#testAutomationSlots").val() == '') {
//                 alert("테스트자동화슬롯을 입력해주세요.");
//             } else {
                deviceModify();
//             }
            
        });
        
        $("#deleteDevice").on("click", function() {
            console.log('삭제버튼 클릭');
            $("#modal-lg3").modal("hide");
            deleteDevice();
        });
    }

    /*
     * 디바이스 삭제
     * @param
     * @return
     */
    function deleteDevice() {
        var deviceId = $("#deviceId").val();
        var url = "/resrce/device/deleteDevice";
        var param = {
        		  "Id" : deviceId
        		, "cmpnyCd" : $("#cmpnyCd").val()
        	};
        console.log("device 삭제");
        callSyncAjax(url,param, "closePopReload");
     }
      
    /*
     * 디바이스 수정
     * @param
     * @return
     */
    function deviceModify() {
        console.log('device 수정');
        var url = "/resrce/device/updateDevice";
        var param = new Object();                     
        param.cmpnyCd              = $("#cmpnyCd").val();
        param.LicenseKey           = $("#deviceKey").val();
        param.Id                   = $("#deviceId").val();          
        param.Name                 = $("#deviceName").val();
        param.Description          = $("#deviceDescription").val();   
//         param.NonProductionSlots   = $("#nonProductionSlots").val();  
//         param.UnattendedSlots      = $("#unattendedSlots").val();     
//         param.HeadlessSlots        = $("#headlessSlots").val();       
//         param.TestAutomationSlots  = $("#testAutomationSlots").val(); 
        console.log(param);
        callAsyncAjax(url,param,'closePopReload');
    }
 </script>