<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <div class="container-fluid wrap">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <form id="searchForm" name="searchForm" class="form-inline">
                        <div class="form-group col-md-10">
                          <label for="name" class="col-sm-4 col-form-label">디바이스 명</label>
                          <div class="col-sm-8">
                              <input type="text" class="form-control" id="name">
                          </div>
                        </div>
                        <div class="col-md-2">
                            <button type="button" id="btnSearch" class="btn btn-info float-right">조회</button>
                        </div>
                    </form> 
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                   
                                    <button type="button" id="btnReg" class="btn btn-info float-right">등록</button>
                                    <button type="button" id="btnDel" class="btn btn-info float-right">삭제</button>
                    
                </div>
                <div class="card-body">
                    <div id="deviceGrid"></div>
                    <div id="deviceGridPager" style="text-align:center"></div>
                </div>
            </div>
        </div>
    </div>
</div> 
   

   
   
   
   