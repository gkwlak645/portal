<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
    <div class="card card-primary" id = "cardDiv" style="height:auto; min-height:700px">
        <div class="card-header">
            <h3 class="card-title">상세조회</h3>
        </div>
        <div class="card-body" style="padding:50px;">
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label>회사</label> 
                        <div class="row">
                            <div class="col-4">
                                <select class="form-control" id="cmpny" disabled>
                                    <option value=""></option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6"></div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label>사용자 아이디 <!-- <b style="color: red;">*</b> --></label>
                        <div class="row">
                            <div class="col-4">
                                <input type="text" id="userId" class="form-control" disabled>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>이메일 주소</label>
                        <div class="row">
                            <div class="col-4">
                                <input type="email" id="emailAdr" class="form-control" placeholder="Email 끝까지 작성해 주세요" disabled>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>직위</label>
                        <div class="row">
                            <div class="col-4">
                                <select class="form-control" id="pstCd" disabled></select>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>전화번호</label>
                        <div class="row">
                            <div class="col-4">
                                <input type="text" id="telno" class="form-control" disabled>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>사용자 분류</label> 
                        <div class="row">
                            <div class="col-4">
                                <select class="form-control" id="userCls">
                                    <option value="">선택</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label>사용자 명<!-- <b style="color: red;">*</b> --></label>
                        <div class="row">
                            <div class="col-4">
                                <input type="text" id="empNm" class="form-control" disabled>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>사원 번호<!-- <b style="color: red;">*</b> --></label>
                        <div class="row">
                            <div class="col-4">
                                <input type="text" id="empNo" class="form-control" disabled>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>부서</label>
                        <div class="row">
                            <div class="col-3">
                                <input type="text" class="form-control" id="deptNm" disabled>
                            </div>
                            <div class="col-3">
                                <input type="text" class="form-control" id="deptCd" disabled>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>휴대폰번호</label>
                        <div class="row">
                            <div class="col-4">
                                <input type="text" id="mbtlnum" class="form-control" disabled>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>사용 여부 <b style="color: red;">*</b></label> 
                        <div class="row">
                            <div class="col-4">
                                <select class="form-control" id="useAt">
                                    <option value="">선택</option>
                                    <option value="Y">사용</option>
                                    <option value="N">미사용</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div style="display:table-cell;">
                        <br><br><br>
                        <div class="float-right">
                        <c:if test="${txScreenAuthor.wrtngAuthor eq 'N'}">
                            <button type="button" class="btn btn-primary float-right" id="cancel">목록으로</button><br><br>
                        </c:if>
                        <c:if test="${txScreenAuthor.wrtngAuthor eq 'Y'}">
                            <!-- <button type="button" class="btn btn-primary" id="userDel" data-toggle="modal" data-target="#modal-lg3">삭제</button> -->
                            <button type="button" class="btn btn-primary" id="userUpdate">수정</button>
                            &nbsp;
                            <button type="button" class="btn btn-primary" id="userCancel">취소</button>
                        </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

<div class="modal fade-dept" id="modal-lg3">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header"></div>
            <div class="modal-body">
                <span>해당 사용자를 삭제하시겠습니까?</span>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary" id="userDelete">삭제</button>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        bindEvent();
    });

    function bindEvent() {
    	
    	var params = [];
        params.push({"id" : "userCls", "clsCd" : "0044"});    //사용자분류
        requestCmmnCd(params);
        
        
        $("#cancel").on("click", function() {
            backList();
        });
        
        $("#userUpdate").on("click", function() {
            /* if($("#userCls").val() == null || $("#userCls").val() == '') {
                alert("사용자분류를 선택해주세요.");
                $('#userCls').focus();
            } else  */if($("#useAt").val() == null || $("#useAt").val() == '') {
                alert("사용여부를 선택해주세요.");
                $('#useAt').focus();
            } else{
                userUpdate();
            }
        });
        
        $("#userCancel").on("click", function() {
            backList();
        });
        
        $("#userDelete").on("click", function() {
            userDelete();
        });
    }
    
    function userUpdate(){
        var url = "/orgnzt/user/userUpdate";
        var param = {
                 userCls       : $("#userCls").val()
               , useAt         : $("#useAt").val()
               , userId        : $("#userId").val()
               , empNo        : $("#empNo").val()
        };

        callSyncAjax(url, param, "afterUpdate");
    }
    
    function afterUpdate(){
        alert('저장되었습니다.');
        cudBackList();
    }
    
    function userDelete(){
        var url = "/orgnzt/user/userDelete";
        var param = {
            "userId" : $("#userId").val()
        };
        
        callSyncAjax(url, param, "afterDelete");
    }
     
    function afterDelete(){
        $("#modal-lg3").modal("toggle");
        cudBackList();
    }
</script>


