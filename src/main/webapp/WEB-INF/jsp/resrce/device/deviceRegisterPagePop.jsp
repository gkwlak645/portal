<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <div class="card card-primary" id = "cardDiv">
        <div class="card-header" alt="자원>디바이스관리 등록">
            <h3 class="card-title">등록</h3>
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
                                    <div class="form-group col-md-12 py-sm-3">
                                        <label for="inputName" class="col-sm-2 col-form-label">이름 <b style="color: red;">*</b></label>
                                        <div class="col-sm-10">
                                            <input style="width:100%;margin-right: 3px;"type="text" id="deviceName" class="form-control" >
                                            <p style="color:#4b5eb5;font-size:12px;">The machine name has to be an exact match to the name of the workstation the Robot is installed on.</p>
                                        </div>
                                    </div>
                                    <div class="form-group col-md-12 py-sm-1">
                                        <label for="inputDescription"class="col-sm-2 col-form-label">설명</label>
                                        <div class="col-sm-10">
                                           <input style="width:100%;margin-right: 3px;"type="text" id="deviceDescription" class="form-control">
                                        </div>
                                    </div>
                                </div> 
                             </div> 
<!--                             <div class="col-md-12"> -->
<!--                                 <div class="form-inline">  -->
<!--                                     <div class="form-group col-md-6 py-sm-2"> -->
<!--                                         <label class="col-sm-4 col-form-label" for="inputStatus">비운영슬롯</label> -->
<!--                                         <div class="col-sm-8"> -->
<!--                                             <input style="width:50%;margin-right: 3px;"type="number" id="nonProductionSlots" class="form-control" min="0" numberOnly> -->
<!--                                         </div> -->
<!--                                     </div> -->
<!--                                     <div class="form-group col-md-6 py-sm-2" > -->
<!--                                         <label for="inputStatus"class="col-sm-4 col-form-label">unattended슬롯</label> -->
<!--                                         <div class="col-sm-8"> -->
<!--                                             <input style="width:50%;margin-right: 3px;"type="number" id="unattendedSlots" class="form-control" min="0" numberOnly> -->
<!--                                         </div> -->
<!--                                     </div>                       -->
<!--                                 </div>                     -->
<!--                             </div>                -->
                                
<!--                            <div class="col-md-12"> -->
<!--                                 <div class="form-inline">  -->
<!--                                     <div class="form-group col-md-6 py-sm-2" > -->
<!--                                         <label class="col-sm-4 col-form-label" for="inputStatus">headless슬롯</label> -->
<!--                                         <div class="col-sm-8"> -->
<!--                                             <input style="width:50%;margin-right: 3px;"type="number" id="headlessSlots" class="form-control" min="0" numberOnly> -->
<!--                                         </div> -->
<!--                                     </div> -->
<!--                                     <div class="form-group col-md-6 py-sm-2" > -->
<!--                                         <label for="inputStatus"class="col-sm-4 col-form-label">테스트자동화슬롯</label> -->
<!--                                         <div class="col-sm-8"> -->
<!--                                             <input style="width:50%;margin-right: 3px;"type="number" id="testAutomationSlots" class="form-control" min="0" numberOnly> -->
<!--                                         </div> -->
<!--                                     </div>                       -->
<!--                                 </div>  -->
<!--                            </div>  -->
                       </div>
                       <div class="float-right">
                                 <button type="button" class="btn btn-primary" id="deviceRegister">등록</button>
                                 <button type="button" class="btn btn-primary" id="cancel">취소</button>
                       </div>
                    </div>
    
    
    
    <script>
        var resultCategory = '';
        var searchId = "";
        var searchNm = "";
        var userList = "";
        
        $(document).ready(function() {

            if (typeof pageInit === 'function') {
                pageInit();
            }
            if (typeof bindEvent === 'function') {
                bindEvent();
            }
        });

        function pageInit() {
            
            var params = [];
            if("${txScreenAuthor.untenantAuthor}" == 'Y'){
                params.push({"id" : "cmpnyCd", "clsCd" : "0024"});    //회사
            }else{
                params.push({"id" : "cmpnyCd", "clsCd" : "0024", "disable" : "Y", "selectValue": "${sessionUserInfo.txCmpnyCd}"});    //회사
            }
            //params.push({"id" : "cmpnyCd", "clsCd" : "0024"});
            requestCmmnCd(params);
        
        }

        function bindEvent() {
            
            $("#deviceName").on('keyup', function(){
                if($(this).val().length > 50){
                    $(this).val($(this).val().substring(0, 50));
                    alert("최대 입력 글자 수는 50입니다.");
                }
            });
            
            $("#deviceDescription").on('keyup', function(){
                if($(this).val().length > 500){
                    $(this).val($(this).val().substring(0, 500));
                    alert("최대 입력 글자 수는 500입니다.");
                }
            });
            
//             $("#nonProductionSlots").on("keyup", function() {
//                 $(this).val($(this).val().replace(/[^0-9]/g,""));
//             });

//             $("#unattendedSlots").on("keyup", function() {
//                 $(this).val($(this).val().replace(/[^0-9]/g,""));
//             });

//          $("#headlessSlots").on("keyup", function() {
//              $(this).val($(this).val().replace(/[^0-9]/g,""));
//          });

//          $("#testAutomationSlots").on("keyup", function() {
//              $(this).val($(this).val().replace(/[^0-9]/g,""));
//          });

            $("#deviceRegister").on("click", function() {
                if($("#deviceName").val() == null || $("#deviceName").val() == ''){
                    alert("디바이스명을 입력해주세요.");
                } else if($("#cmpnyCd").val() == null || $("#cmpnyCd").val() == '') {
                    alert("회사를 입력해주세요.");
//                 } else if($("#nonProductionSlots").val() == null || $("#nonProductionSlots").val() == '') {
//                     alert("비운영슬롯을 입력해주세요.");
//                 } else if($("#unattendedSlots").val() == null || $("#unattendedSlots").val() == '') {
//                     alert("unattended를 입력해주세요.");
//              } else if($("#headlessSlots").val() == null || $("#headlessSlots").val() == '') {
//                  alert("headless를 입력해주세요.");
//              } else if($("#testAutomationSlots").val() == null || $("#testAutomationSlots").val() == '') {
//                  alert("테스트자동화슬롯을 입력해주세요.");
                } else {
                    checkName();
                }
            });

            $("#cancel").on("click", function() {
                $(".over").remove();
            });
                        
        } 
        
        function checkName() {
            var url = "/resrce/device/getDeviceList";
            var param = new Object();
            param.name = $("#deviceName").val();
            callSyncAjax(url, param, 'checkNameCallback');
        }
        
        function checkNameCallback(data) {
            var checkCount = data.result.paginationInfo.totalRecordCount;
            
            if(checkCount != 0){
                alert("이미 존재하는 이름입니다.");
            } else {
                deviceRegister();
            }
        }
        
        function deviceRegister() {
            var url = "/resrce/device/registerDevice";
            var param = new Object();
            param.cmpnyCd              = $("#cmpnyCd").val();
            param.Name                 = $("#deviceName").val();
            param.Description          = $("#deviceDescription").val();
//          param.NonProductionSlots   = $("#nonProductionSlots").val();
//          param.UnattendedSlots      = $("#unattendedSlots").val();
//          param.HeadlessSlots        = $("#headlessSlots").val();
//          param.TestAutomationSlots  = $("#testAutomationSlots").val();
            callSyncAjax(url, param, 'closePopReload');
//             $.ajax({
//                 type: "POST",
//                 url: url,
//                 data: param,
//                 async : false,
//                 contentType: false,
//                 cache: false,
//                 success: function (data) {
// //                     console.log(data);
// //                     console.log(data.responseCode);
// //                     if(data.responseCode == 'E101'){
// //                         alert("사용할 수 있는 슬롯의 개수를 초과하였습니다.");
// //                     } else {
//                         closePopReload();
// //                     }
//                 },
//                 error: function (e) {
//                 }
//             });
            
        }
    
           
    </script>