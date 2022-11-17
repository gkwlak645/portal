/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 7. 14.         LSH        최초 작성
 */
package kr.co.rpaplatform.dongwon.task.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.MDC;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import kr.co.rpaplatform.common.exception.RpaException;
import kr.co.rpaplatform.dongwon.file.dao.AtchFileDAO;
import kr.co.rpaplatform.dongwon.file.vo.AtchFileVO;
import kr.co.rpaplatform.dongwon.orgnzt.dao.UserDAO;
import kr.co.rpaplatform.dongwon.orgnzt.vo.UserVO;
import kr.co.rpaplatform.dongwon.task.dao.TaskDevelopDAO;
import kr.co.rpaplatform.dongwon.task.dao.TaskManageDAO;
import kr.co.rpaplatform.dongwon.task.dao.TaskPaymentDAO;

/**
 * 과제결재 서비스
 * @author LSH
 */
@Service
public class TaskPaymentService {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(TaskPaymentService.class);

	/**
	 * 과제 DAO
	 */
	@Resource(name="taskDevelopDAO")
	private TaskDevelopDAO taskDevelopDAO;
	
	/**
	 * 과제 결재 DAO
	 */
	@Resource(name="taskPaymentDAO")
	private TaskPaymentDAO taskPaymentDAO;
	
	/**
	 * 과제운영 DAO
	 */
	@Resource(name="taskManageDAO")
	private TaskManageDAO taskManageDAO;
	
	/**
	 * user DAO
	 */
	@Resource(name="userDAO")
	private UserDAO userDAO;
	
	/**
	 * 첨부파일 DAO
	 */
	@Resource(name="atchFileDAO")
	private AtchFileDAO atchFileDAO;
	
	
	/**
	 * RPA URL
	 */
	@Value("${url.attach}")
	private String URL;
	
	/**
	 * 동원 다이렉트 URL
	 */
	@Value("${url.direct.dongwon}")
	private String dwTaskURL;
	
	/**
	 * 동원 다이렉트 결재 URL
	 */
	@Value("${url.taskPayment.dongwon}")
	private String dwTaskPaymentURL;
	
	
	/**
	 * 과제 결재, 운영취소 결재 상신 
	 * @param map
	 * @return 
	 * @return 
	 * @return
	 * @throws Exception
	 */	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public Map<String, Object> requestTaskPayment(Map<String, Object> map) throws Exception {
		//결재요청 : Z_20_001_04   //운영취소 : Z_20_002_02
		
		String formPrefix 	= String.valueOf( map.get("formPrefix"));
		String devlopSn 	= String.valueOf( map.get("devlopSn"));
		String processNo 	= String.valueOf( map.get("processNo"));
		String mkey 		= "";
		String htmlForm 	= "";
			
		if(devlopSn != null && !"".equals(devlopSn) && processNo != null && !"".equals(processNo) && formPrefix != null && !"".equals(formPrefix)) {
			mkey = formPrefix + "|" + devlopSn + "|" + processNo;
			map.put("mKey", mkey);
		}else {
			throw new RpaException("E60011", "잘못 된 mKey입니다.");	 //잘못 된 mKey입니다.
		}
		
		//mkey 중복여부 확인
		int chkOverMkey = taskPaymentDAO.chkOverlapMkey(map);
		
		if(chkOverMkey > 0) {
			taskPaymentDAO.updateTaskPayment(map);
		}else {
			taskPaymentDAO.insertTaskPayment(map);
		}
		
		//프로세스 결재요청 : 프로세스 이력번호 생성
		int mkeyHistNo =  taskPaymentDAO.getTaskOverlapMkeyHistNo(map);
		map.put("mkeyHistNo", mkeyHistNo);
		
		//결재 상신 아이디 설정
		map.put("userid", MDC.get("txUserId"));
		
		if("Z_20_001_04".equals(formPrefix)) {
			map.put("formName","RPA 개발요청서");
			htmlForm = returnDevelopHtmlForm(map);
		}else if("Z_20_002_02".equals(formPrefix)) {
			map.put("formName","RPA 운영 취소 요청서");
			htmlForm = returnCancelHtmlForm(map);
		}else {
			throw new RpaException("E60011", "잘못 된 mKey입니다.");	 //잘못 된 mKey입니다.
		}
		
		map.put("bodies", htmlForm);
		map.put("url", dwTaskPaymentURL);
		
		//프로세스 결재요청 이력 insert
		taskPaymentDAO.insertTaskPaymentHist(map);
		
		return map;
	}
	
	
	
	/**
	 * 과제-등록 html Form return
	 * @param map
	 * @return 
	 * @return
	 * @throws Exception
	 */	
	public String returnDevelopHtmlForm(Map<String, Object> map) throws Exception {
		
		String htmlForm 	= "";
		String sj = map.get("sj") == null || map.get("sj") == "" ? "" : (String)map.get("sj");
		String processNm = map.get("processNm") == null || map.get("processNm") == "" ? "" : (String)map.get("processNm");
		String processCd = map.get("processCd") == null || map.get("processCd") == "" ? "" : (String)map.get("processCd");
		String jobDc = map.get("jobDc") == null || map.get("jobDc") == "" ? "" : (String)map.get("jobDc");
		String cmpnyNm = map.get("pCmpnyNm") == null || map.get("pCmpnyNm") == "" ? "" : (String)map.get("pCmpnyNm");
		//String clsNm = map.get("pJobClsCd") == null || map.get("pJobClsCd") == "" ? "" : (String)map.get("pJobClsCd");
		//String rpaClsNm = map.get("pRpaClsCd") == null || map.get("pRpaClsCd") == "" ? "" : (String)map.get("pRpaClsCd");
		
		//String processJobTm = map.get("pJobTm") == null || map.get("pJobTm") == "" ? "" : (String)map.get("pJobTm")+" H";
		String redcnTm = map.get("pRedcnTm") == null || map.get("pRedcnTm") == "" ? "" : (String)map.get("pRedcnTm")+" H";
		String fqNm = map.get("pFqCd") == null || map.get("pFqCd") == "" ? "" : (String)map.get("pFqCd");
		String executCnt = map.get("executCnt") == null || map.get("executCnt") == "" ? "" : (String)map.get("executCnt")+"회";
		String expectRedcnAmt = map.get("pExpectRedcnAmt") == null || map.get("pExpectRedcnAmt") == "0" ? "" : (String)map.get("pExpectRedcnAmt");
		
		String executTm = map.get("pExecutTm") == null || map.get("pExecutTm") == "" ? "" : (String)map.get("pExecutTm")+" H";
		String emrgncyCrspnd = map.get("emrgncyCrspnd") == null || map.get("emrgncyCrspnd") == "" ? "" : (String)map.get("emrgncyCrspnd");
		String rto = map.get("pRto") == null || map.get("pRto") == "" ? "" : (String)map.get("pRto");
		String devlopWdcnt = map.get("pDevlopWdcnt") == null || map.get("pDevlopWdcnt") == "" ? "" : (String)map.get("pDevlopWdcnt")+"일";
		String roiEvaluate = map.get("roiEvaluate") == null || map.get("roiEvaluate") == "" ? "" : (String)map.get("roiEvaluate");
		String expectDevlopCt = map.get("pExpectDevlopCt") == null || map.get("pExpectDevlopCt") == "" ? "0" : (String)map.get("pExpectDevlopCt");
		String devlopResn = map.get("devlopResn") == null || map.get("devlopResn") == "" ? "" : (String)map.get("devlopResn");
		String insideDevlopAt = map.get("pInsideDevlopAt") == null || map.get("pInsideDevlopAt") == "" ? "" : (String)map.get("pInsideDevlopAt");
		
		String relateDoc = map.get("relateDoc") == null || map.get("relateDoc") == "" ? "" : (String)map.get("relateDoc");
		
		/*htmlForm += "<table class='table_10' summary='' cellpadding='0' cellspacing='0' >";
		htmlForm += "<colgroup>";
		htmlForm += "<col style='width:15%' />";
		htmlForm += "<col style='width:85%' />";
		htmlForm += "</colgroup>";                
		htmlForm += "<tr>";
		htmlForm += "<th>제목</th>";
		htmlForm += "<td><span  style='font-size:12pt; ime-mode: active;' >"+sj+"</span></td>";
		htmlForm += "</tr>";
		htmlForm += "</table>";     */     
		
		htmlForm += "<br />";
		htmlForm += "<strong>프로세스 정보</strong>";

		htmlForm += "<table id='' border=\"1\" class='table_10' summary='' cellpadding='0' cellspacing='0' >";
		htmlForm += "<colgroup>";
		htmlForm += "<col style='width:15%' />";
		htmlForm += "<col style='width:35%' />";
		htmlForm += "<col style='width:15%' />";
		htmlForm += "<col style='width:35%' />";
		/*htmlForm += "<col style='width:150px' />";
		htmlForm += "<col style='width:250px' />";
		htmlForm += "<col style='width:150px' />";
		htmlForm += "<col style='width:250px' />";*/
		htmlForm += "</colgroup>";

		htmlForm += "<tr>";
		htmlForm += "<th>프로세스명</th>";
		htmlForm += "<td>"+processNm+"</td>";
		htmlForm += "<th>프로세스코드</th>";
		htmlForm += "<td>"+processCd+"</td>";
		htmlForm += "</tr>";

		htmlForm += "<tr>";
		htmlForm += "<th>업무설명</th>";
		htmlForm += "<td colspan='3'>";
		htmlForm += jobDc;
		htmlForm += "</td>";
		htmlForm += "</tr>";
        
		htmlForm += "<tr>";
		htmlForm += "<th>회사</th>";
		htmlForm += "<td colspan='3'>"+cmpnyNm+"</td>";
		htmlForm += "</tr>";
		
		/*htmlForm += "<tr>";
		htmlForm += "<th>분류</th>";
		htmlForm += "<td >"+clsNm+"</td>";
		htmlForm += "<th>RPA분류</th>";
		htmlForm += "<td>"+rpaClsNm+"</td>";
		htmlForm += "</tr>";*/
		
		
		
		/*htmlForm += "<tr>";
		htmlForm += "<th>업무시간</th>";
		htmlForm += "<td>"+processJobTm+"</td>";
		htmlForm += "<th>절감시간 ①</th>";
		htmlForm += "<td>"+redcnTm+"</td>";
		htmlForm += "</tr>";*/
		
		htmlForm += "<tr>";
		htmlForm += "<th>절감시간 ①</th>";
		htmlForm += "<td>"+redcnTm+"</td>";
		htmlForm += "<th>예상절감금액<span style=\"font-size:12px;font-weight:normal\">(① x 33,000원)</span></th>";
		htmlForm += "<td align=\"right\"><span style=\"width:99%; height:24px; font-size:12pt;\"><strong>"+expectRedcnAmt+" 원</strong></span></td>";
		htmlForm += "</tr>";
		
		
		htmlForm += "<tr>";
		htmlForm += "<th>실행주기</th>";
		htmlForm += "<td>"+fqNm+" "+executCnt+"</td>";
		htmlForm += "<th>시간</th>";
		htmlForm += "<td>"+executTm+"</td>";
		htmlForm += "</tr>";
		
		htmlForm += "<tr>";
		htmlForm += "<th>개발공수②</th>";
		htmlForm += "<td>"+devlopWdcnt+"</td>";
		htmlForm += "<th>예상개발비용<br /><span style='font-size:11px;font-weight:normal'>(② x 8.5Hr x 33,000원)</span></th>";
		htmlForm += "<td align=\"right\"><span style=\"width:99%; height:24px; font-size:12pt;\"><strong>"+expectDevlopCt+" 원</strong></span></td>";
		htmlForm += "</tr>";
		
		
		htmlForm += "<tr>";
		htmlForm += "<th>긴급대응</th>";
		htmlForm += "<td>"+emrgncyCrspnd+"</td>";
		htmlForm += "<th>RTO</th>";
		htmlForm += "<td>"+rto+"H</td>";
		htmlForm += "</tr>";
		
		
		
		htmlForm += "<tr>";
		htmlForm += "<th>ROI평가<br /><span style=\\\"font-size:12px;font-weight:normal\\\">(② x 10 ≤ → OK)</span></th>";
		htmlForm += "<td colspan='3'>"+roiEvaluate+"</td>";
		htmlForm += "</tr>";
		
		
		htmlForm += "<tr>";
		htmlForm += "<th>개발사유</th>";
		htmlForm += "<td colspan='3'>"+devlopResn+"</td>";
		htmlForm += "</tr>";
		
		htmlForm += "<tr>";
		htmlForm += "<th>내부개발여부</th>";
		htmlForm += "<td colspan='3'>"+insideDevlopAt+"</td>";
		htmlForm += "</tr>";
		
		htmlForm += "</table>";
		
		
		//업무담당자
		List<Map<String, Object>> aChargerList = (List<Map<String, Object>>)map.get("chargerList");
		int iaChargerList = aChargerList.size();
		
		if(iaChargerList > 0) {
			
			htmlForm += "<br />";
			htmlForm += "<strong>담당자 정보</strong>";
			
			htmlForm += "<table id='' class='table_10' summary='' cellpadding='0' cellspacing='0'>";
			htmlForm += "<colgroup>";
			htmlForm += "<col style='width:15%' />";
			htmlForm += "<col style='width:35%' />";
			htmlForm += "<col style='width:15%' />";
			htmlForm += "<col style='width:35%' />";
			htmlForm += "</colgroup>";
			
			
			for(int i = 0; i < iaChargerList; i++) {
				
				/*htmlForm += "<tr>";
				htmlForm += "<th>업무담당</th>";
				htmlForm += "<td>SCM혁신팀 장혜미</td>";
				htmlForm += "<th>연락처</th>";
				htmlForm += "<td>010-2640-8614 / wkdal5523@dongwon.com</td>";
				htmlForm += "</tr>";*/
				
				Map<String, Object> aCharger = aChargerList.get(i);
				
				String chargerUserId = aCharger.get("chargerUserId") == null || aCharger.get("chargerUserId") == "" ? "" : (String)aCharger.get("chargerUserId");
				
				UserVO responseUserVO = new UserVO();
				
				if(chargerUserId != null && chargerUserId != "") {
					UserVO vo = new UserVO();
					vo.setUserId(chargerUserId);
					responseUserVO = userDAO.selectDetailUserValue(vo);
					
				}
				
				String chargerDeptNm = aCharger.get("chargerDeptNm") == null || aCharger.get("chargerDeptNm") == "" ? "" : (String)aCharger.get("chargerDeptNm");
				String chargerUserNm = aCharger.get("chargerUserNm") == null || aCharger.get("chargerUserNm") == "" ? "" : (String)aCharger.get("chargerUserNm");
				String telNo = responseUserVO.getTelno() == null || responseUserVO.getTelno() == "" ? "" : responseUserVO.getTelno();
				String emailAdr = responseUserVO.getEmailAdr() == null || responseUserVO.getEmailAdr() == "" ? "" : responseUserVO.getEmailAdr();
				
				htmlForm += "<tr>";
				htmlForm += "<th>업무담당</th>";
				htmlForm += "<td>"+chargerDeptNm+" "+chargerUserNm+"</td>";
				htmlForm += "<th>연락처</th>";
				htmlForm += "<td>"+telNo+" "+emailAdr+"</td>";
				htmlForm += "</tr>";
				
			}
			
			htmlForm += "</table>";
			
		}/*else {
			htmlForm += "<tr>";
			htmlForm += "<th>업무담당</th>";
			htmlForm += "<td></td>";
			htmlForm += "<th>연락처</th>";
			htmlForm += "<td></td>";
			htmlForm += "</tr>";
		}*/
		
		
		
		//개인별 절감시간
		List<Map<String, Object>> aRedcnTmList = (List<Map<String, Object>>)map.get("redcnTmList");
		int iredcnTmList= aRedcnTmList.size();
		
		if(iredcnTmList > 0) {
			
			htmlForm += "<br />";
			htmlForm += "<strong>개인별 절감시간</strong>";
			
			htmlForm += "<table id='' class='table_10' summary='' cellpadding='0' cellspacing='0'>";
			htmlForm += "<colgroup>";
			htmlForm += "<col style='width:15%' />";
			htmlForm += "<col style='width:35%' />";
			htmlForm += "<col style='width:15%' />";
			htmlForm += "<col style='width:35%' />";
			htmlForm += "</colgroup>";
			
			int aRedcnTmRedcnTmTot = 0;
			
			for(int i = 0; i < iredcnTmList; i++) {
				
				Map<String, Object> aRedcnTm = aRedcnTmList.get(i);
				
				String redcnTmDeptNm = aRedcnTm.get("redcnTmDeptNm") == null || aRedcnTm.get("redcnTmDeptNm") == "" ? "" : (String)aRedcnTm.get("redcnTmDeptNm");
				String redcnTmUserNm = aRedcnTm.get("redcnTmUserNm") == null || aRedcnTm.get("redcnTmUserNm") == "" ? "" : (String)aRedcnTm.get("redcnTmUserNm");
				int redcnTmRedcnTm = aRedcnTm.get("redcnTmRedcnTm") == null || aRedcnTm.get("redcnTmRedcnTm") == "" ? 0 : Integer.parseInt((String)aRedcnTm.get("redcnTmRedcnTm"));
				
				htmlForm += "<tr>";
				htmlForm += "<th>업무담당</th>";
				htmlForm += "<td>"+redcnTmDeptNm+" "+redcnTmUserNm+"</td>";
				htmlForm += "<th>절감시간(hour)</th>";
				htmlForm += "<td>"+redcnTmRedcnTm+"</td>";
				htmlForm += "</tr>";
				
				aRedcnTmRedcnTmTot = aRedcnTmRedcnTmTot + redcnTmRedcnTm;
				
			}
			
			htmlForm += "<tr>";
			htmlForm += "<th colspan='2'></th>";
			//htmlForm += "<td></td>";
			htmlForm += "<th>합계(hour)</th>";
			htmlForm += "<td>"+aRedcnTmRedcnTmTot+"</td>";
			htmlForm += "</tr>";
			
			htmlForm += "</table>";
			
		}/*else {
			htmlForm += "<tr>";
			htmlForm += "<th>업무담당</th>";
			htmlForm += "<td></td>";
			htmlForm += "<th>절감시간(hour)</th>";
			htmlForm += "<td></td>";
			htmlForm += "</tr>";
		}*/
		
		
		//개인별 기여도
		List<Map<String, Object>> aContributeList = (List<Map<String, Object>>)map.get("contributeList");
		int iContributeList = aContributeList.size();
		
		if(iContributeList > 0) {
			
			htmlForm += "<br />";
			htmlForm += "<strong>개인별 기여도</strong>";
			
			htmlForm += "<table id='' class='table_10' summary='' cellpadding='0' cellspacing='0'>";
			htmlForm += "<colgroup>";
			htmlForm += "<col style='width:15%' />";
			htmlForm += "<col style='width:35%' />";
			htmlForm += "<col style='width:15%' />";
			htmlForm += "<col style='width:35%' />";
			htmlForm += "</colgroup>";
			
			int contributeRateTot = 0;
			
			for(int i = 0; i < iContributeList; i++) {
				
				Map<String, Object> aContribute = aContributeList.get(i);
				
				String contributeDeptNm = aContribute.get("contributeDeptNm") == null || aContribute.get("contributeDeptNm") == "" ? "" : (String)aContribute.get("contributeDeptNm");
				String contributeUserNm = aContribute.get("contributeUserNm") == null || aContribute.get("contributeUserNm") == "" ? "" : (String)aContribute.get("contributeUserNm");
				int contributeRate = aContribute.get("contributeRate") == null || aContribute.get("contributeRate") == "" ? 0 : Integer.parseInt((String)aContribute.get("contributeRate"));
				
				htmlForm += "<tr>";
				htmlForm += "<th>업무담당</th>";
				htmlForm += "<td>"+contributeDeptNm+" "+contributeUserNm+"</td>";
				htmlForm += "<th>기여도(%)</th>";
				htmlForm += "<td>"+contributeRate+"</td>";
				htmlForm += "</tr>";
				
				contributeRateTot = contributeRateTot + contributeRate;
				
			}
			
			
			htmlForm += "<tr>";
			htmlForm += "<th colspan='2'></th>";
			//htmlForm += "<td></td>";
			htmlForm += "<th>합계(%)</th>";
			htmlForm += "<td>"+contributeRateTot+"</td>";
			htmlForm += "</tr>";
			
			htmlForm += "</table>";
			
		}/*else {
			htmlForm += "<tr>";
			htmlForm += "<th>업무담당</th>";
			htmlForm += "<td></td>";
			htmlForm += "<th>기여도(%)</th>";
			htmlForm += "<td></td>";
			htmlForm += "</tr>";
		}*/
		
		htmlForm += "<br />";
		//htmlForm += "<strong>첨부파일</strong>";
		
		htmlForm += "<table class='table_10' summary='' cellpadding='0' cellspacing='0'>";
		htmlForm += "<colgroup>";
		htmlForm += "<col style='width:15%' />";
		htmlForm += "<col style='width:85%' />";
		htmlForm += "</colgroup>"; 
		
		List<AtchFileVO> atchmnflList = atchFileDAO.selectAtchmnflList((int) map.get("fileGrpNo"));
		int iatchmnflList = atchmnflList.size();
		String fileForm = "";
		
		if(iatchmnflList > 0) {
			for(int i = 0; i < iatchmnflList; i++) {
				AtchFileVO atchFileVO = atchmnflList.get(i);
				if(atchFileVO != null) {
					String fileUrl = URL+"/file/templateDownloadAtchmnfl?fileGrpNo="+atchFileVO.getFileGrpNo()+"&fileNo="+atchFileVO.getFileNo();
					
					String imgForm = "";
					String oriFileNm = atchFileVO.getOriFileNm() != null && !"".equals(atchFileVO.getOriFileNm()) ? atchFileVO.getOriFileNm() : "";
					
					if(oriFileNm != "") {
						String [] aOriFileNm = oriFileNm.split("\\.");
						imgForm = "<img src='"+dwTaskURL+"/Images/Images/Board/data_"+aOriFileNm[1]+".gif' class='img_align4'>";
					}
					
					fileForm += "<p style='padding-bottom:2pt;'>";

					fileForm += imgForm;

					fileForm += "<a href='"+fileUrl+"' >"+atchFileVO.getOriFileNm()+" ("+atchFileVO.getFileSz()+"MB)</a><br/>";

					fileForm += "</p>";
					
				}
			}
		}
		
		htmlForm += "<tr>";
		htmlForm += "<th>첨부파일</th>";
		htmlForm += "<td>"+fileForm+"</td>";
		htmlForm += "</tr>";
		
		
		/*htmlForm += "<tr>";
		htmlForm += "<th>연관문서</th>";
		htmlForm += "<td>"+relateDoc+"</td>";
		htmlForm += "</tr>";*/
		
		htmlForm += "</table>";    
		
		
		return htmlForm;
		
	}
	
	

	/**
	 * 과제-운영취소 html Form return
	 * @param map
	 * @return 
	 * @return 
	 * @return
	 * @throws Exception
	 */	
	public String returnCancelHtmlForm(Map<String, Object> map) throws Exception {
		String htmlForm 	= "";
		
		String processCd = map.get("processCd") == null || map.get("processCd") == "" ? "" : (String)map.get("processCd");

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("processCd", processCd);
		Map<String, Object> responseMap = taskManageDAO.getTaskManageProcessDetail(params);
		
		String sj = responseMap.get("pSj") == null || responseMap.get("pSj") == "" ? "" : (String)responseMap.get("pSj");
		String processNm = responseMap.get("processNm") == null || responseMap.get("processNm") == "" ? "" : (String)responseMap.get("processNm");
		String cmpnyNmPrc = responseMap.get("cmpnyNmPrc") == null || responseMap.get("cmpnyNmPrc") == "" ? "" : (String)responseMap.get("cmpnyNmPrc");
		String clsNm = responseMap.get("jobClsNm") == null || responseMap.get("jobClsNm") == "" ? "" : (String)responseMap.get("jobClsNm");
		int jobTmPrc = responseMap.get("jobTmPrc") == null || responseMap.get("jobTmPrc") == "" ? 0 :(int)Float.parseFloat(String.valueOf(responseMap.get("jobTmPrc")));
		int redcnTm = responseMap.get("redcnTm") == null || responseMap.get("redcnTm") == "" ? 0 :(int)Float.parseFloat(String.valueOf(responseMap.get("redcnTm")));
		String expectRedcnAmt = responseMap.get("expectRedcnAmt") == null || responseMap.get("expectRedcnAmt") == "" ? "0" : responseMap.get("expectRedcnAmtFormat")  +" 원";
		
		String reason = map.get("reason") == null || map.get("reason") == "" ? "" : (String)map.get("reason");
		String mergeTarget = map.get("mergeTarget") == null || map.get("mergeTarget") == "" ? "" : (String)map.get("mergeTarget");
		String proceMatter = map.get("proceMatter") == null || map.get("proceMatter") == "" ? "" : (String)map.get("proceMatter");
		
		//담당자
		String chargerUserId = responseMap.get("jobChargerId") == null || responseMap.get("jobChargerId") == "" ? "" : (String)responseMap.get("jobChargerId");
		
		UserVO responseUserVO = new UserVO();
		
		if(chargerUserId != null && chargerUserId != "") {
			UserVO vo = new UserVO();
			vo.setUserId(chargerUserId);
			responseUserVO = userDAO.selectDetailUserValue(vo);
		}
		
		String chargerDeptNm = responseMap.get("jobChrgDeptNm") == null || responseMap.get("jobChrgDeptNm") == "" ? "" : (String)responseMap.get("jobChrgDeptNm");
		String chargerUserNm = responseMap.get("jobChargerNm") == null || responseMap.get("jobChargerNm") == "" ? "" : (String)responseMap.get("jobChargerNm");
		String telNo = responseUserVO.getTelno() == null || responseUserVO.getTelno() == "" ? "" : responseUserVO.getTelno();
		String emailAdr = responseUserVO.getEmailAdr() == null || responseUserVO.getEmailAdr() == "" ? "" : responseUserVO.getEmailAdr();
		
		
		htmlForm += "<br />";
		htmlForm += "<strong>프로세스 정보</strong>";
		
		/*htmlForm += "<table class='table_10' summary='' cellpadding='0' cellspacing='0' >";
		htmlForm += "<colgroup>";
		htmlForm += "<col style='width:15%' />";
		htmlForm += "<col style='width:85%' />";
		htmlForm += "</colgroup>";                
		htmlForm += "<tr>";
		htmlForm += "<th>제목</th>";
		htmlForm += "<td><span  style='font-size:12pt; ime-mode: active;' >"+sj+"</span></td>";
		htmlForm += "</tr>";
		htmlForm += "</table>"; */         

		htmlForm += "<table id='' class='table_10' summary='' cellpadding='0' cellspacing='0'>";
		htmlForm += "<colgroup>";
		htmlForm += "<col style='width:15%' />";
		htmlForm += "<col style='width:35%' />";
		htmlForm += "<col style='width:15%' />";
		htmlForm += "<col style='width:35%' />";
		htmlForm += "</colgroup>";
		
		htmlForm += "<tr>";
		htmlForm += "<th>순번</th>";
		htmlForm += "<th colspan=\"2\">프로세스명</th>";
		htmlForm += "<th>프로세스코드</th>";
		htmlForm += "</tr>";

		htmlForm += "<tr>";
		htmlForm += "<th>1</th>";
		htmlForm += "<td colspan=\"2\">"+processNm+"</td>";
		htmlForm += "<td>"+processCd+"</td>";
		htmlForm += "</tr>";
		
		htmlForm += "</table>";
		
		
		htmlForm += "<table id='' class='table_10' summary='' cellpadding='0' cellspacing='0'>";
		htmlForm += "<colgroup>";
		htmlForm += "<col style='width:15%' />";
		htmlForm += "<col style='width:5%' />";
		htmlForm += "<col style='width:15%' />";
		htmlForm += "<col style='width:15%' />";
		htmlForm += "<col style='width:15%' />";
		htmlForm += "<col style='width:35%' />";
		htmlForm += "</colgroup>";
		
		htmlForm += "<tr>";
		htmlForm += "<th>회사</th>";
		htmlForm += "<td colspan=\"3\">"+cmpnyNmPrc+"</td>";
		htmlForm += "<th>분류</th>";
		htmlForm += "<td>"+clsNm+"</td>";
		htmlForm += "</tr>";
		
		htmlForm += "<tr>";
		htmlForm += "<th>업무시간</th>";
		htmlForm += "<td>"+jobTmPrc+"H</td>";
		htmlForm += "<th>절감시간 ①</th>";
		htmlForm += "<td>"+redcnTm+"H</td>";
		htmlForm += "<th>비용환산<br /><span style=\"font-size:12px;font-weight:normal\">(① x 33,000원)</span></th>";
		htmlForm += "<td align=\"right\"><span style=\"width:99%; height:24px; font-size:12pt;\"><strong>"+expectRedcnAmt+"</strong></span></td>";
		htmlForm += "</tr>";
		
		htmlForm += "<tr>";
		htmlForm += "<th>취소사유</th>";
		htmlForm += "<td colspan=\"5\">"+reason+"</td>";
		htmlForm += "</tr>";
		
		htmlForm += "<tr>";
		htmlForm += "<th>병합대상</th>";
		htmlForm += "<td colspan=\"5\">"+mergeTarget+"</td>";
		htmlForm += "</tr>";
		
		htmlForm += "<tr>";
		htmlForm += "<th>처리사항</th>";
		htmlForm += "<td colspan=\"5\">"+proceMatter+"</td>";
		htmlForm += "</tr>";
		
		htmlForm += "</table>"; 
		
		
		htmlForm += "<br />";
		htmlForm += "<strong>담당자 정보</strong>";
		
		htmlForm += "<table id='' class='table_10' summary='' cellpadding='0' cellspacing='0'>";
		htmlForm += "<colgroup>";
		htmlForm += "<col style='width:15%' />";
		htmlForm += "<col style='width:35%' />";
		htmlForm += "<col style='width:15%' />";
		htmlForm += "<col style='width:35%' />";
		htmlForm += "</colgroup>";
		
		htmlForm += "<tr>";
		htmlForm += "<th>업무담당</th>";
		htmlForm += "<td>"+chargerDeptNm+" "+chargerUserNm+"</td>";
		htmlForm += "<th>연락처</th>";
		htmlForm += "<td>"+telNo+" "+emailAdr+"</td>";
		htmlForm += "</tr>";
		
		htmlForm += "</table>";
		
		
		//업무담당자
		/*List<Map<String, Object>> aChargerList = (List<Map<String, Object>>)map.get("chargerList");
		int iaChargerList = aChargerList.size();
		
		if(iaChargerList > 0) {
			
			htmlForm += "<br />";
			htmlForm += "<strong>담당자 정보</strong>";
			
			htmlForm += "<table id='' class='table_10' summary='' cellpadding='0' cellspacing='0' >";
			htmlForm += "<colgroup>";
			htmlForm += "<col style='width:15% />";
			htmlForm += "<col style='width:35%' />";
			htmlForm += "<col style='width:15%' />";
			htmlForm += "<col style='width:35%' />";
			htmlForm += "</colgroup>";
			
			
			for(int i = 0; i < iaChargerList; i++) {
				
				htmlForm += "<tr>";
				htmlForm += "<th>업무담당</th>";
				htmlForm += "<td>SCM혁신팀 장혜미</td>";
				htmlForm += "<th>연락처</th>";
				htmlForm += "<td>010-2640-8614 / wkdal5523@dongwon.com</td>";
				htmlForm += "</tr>";
				
				Map<String, Object> aCharger = aChargerList.get(i);
				
				String chargerUserId = aCharger.get("chargerUserId") == null || aCharger.get("chargerUserId") == "" ? "" : (String)aCharger.get("chargerUserId");
				
				UserVO responseUserVO = new UserVO();
				
				if(chargerUserId != null && chargerUserId != "") {
					UserVO vo = new UserVO();
					vo.setUserId(chargerUserId);
					responseUserVO = userDAO.selectDetailUserValue(vo);
					
				}
				
				String chargerDeptNm = aCharger.get("chargerDeptNm") == null || aCharger.get("chargerDeptNm") == "" ? "" : (String)aCharger.get("chargerDeptNm");
				String chargerUserNm = aCharger.get("chargerUserNm") == null || aCharger.get("chargerUserNm") == "" ? "" : (String)aCharger.get("chargerUserNm");
				String telNo = responseUserVO.getTelno() == null || responseUserVO.getTelno() == "" ? "" : responseUserVO.getTelno();
				String emailAdr = responseUserVO.getEmailAdr() == null || responseUserVO.getEmailAdr() == "" ? "" : responseUserVO.getEmailAdr();
				
				htmlForm += "<tr>";
				htmlForm += "<th>업무담당</th>";
				htmlForm += "<td>"+chargerDeptNm+" "+chargerUserNm+"</td>";
				htmlForm += "<th>연락처</th>";
				htmlForm += "<td>"+telNo+" "+emailAdr+"</td>";
				htmlForm += "</tr>";
				
			}
			
			htmlForm += "</table>";
			
		}*//*else {
			htmlForm += "<tr>";
			htmlForm += "<th>업무담당</th>";
			htmlForm += "<td></td>";
			htmlForm += "<th>연락처</th>";
			htmlForm += "<td></td>";
			htmlForm += "</tr>";
		}*/
		
		htmlForm += "<br />";
		
		htmlForm += "<table class='table_10' summary='' cellpadding='0' cellspacing='0'>";
		htmlForm += "<colgroup>";
		htmlForm += "<col style='width:15%' />";
		htmlForm += "<col style='width:85%' />";
		htmlForm += "</colgroup>"; 
		
		List<AtchFileVO> atchmnflList = atchFileDAO.selectAtchmnflList(Integer.parseInt(String.valueOf(map.get("fileGrpNo"))));
		int iatchmnflList = atchmnflList.size();
		String fileForm = "";
		
		if(iatchmnflList > 0) {
			for(int i = 0; i < iatchmnflList; i++) {
				AtchFileVO atchFileVO = atchmnflList.get(i);
				
				if(atchFileVO != null) {
					String fileUrl = URL+"/file/templateDownloadAtchmnfl?fileGrpNo="+atchFileVO.getFileGrpNo()+"&fileNo="+atchFileVO.getFileNo();
					
					String imgForm = "";
					String oriFileNm = atchFileVO.getOriFileNm() != null && !"".equals(atchFileVO.getOriFileNm()) ? atchFileVO.getOriFileNm() : "";
					
					if(oriFileNm != "") {
						String [] aOriFileNm = oriFileNm.split("\\.");
						imgForm = "<img src='"+dwTaskURL+"/Images/Images/Board/data_"+aOriFileNm[1]+".gif' class='img_align4'>";
					}
					
					fileForm += "<p style='padding-bottom:2pt;'>";

					fileForm += imgForm;

					fileForm += "<a href='"+fileUrl+"' >"+atchFileVO.getOriFileNm()+" ("+atchFileVO.getFileSz()+"MB)</a><br/>";

					fileForm += "</p>";
					
				}
			}
		}
		
		htmlForm += "<tr>";
		htmlForm += "<th>첨부파일</th>";
		htmlForm += "<td>"+fileForm+"</td>";
		htmlForm += "</tr>";
		
		/*htmlForm += "<tr>";
		htmlForm += "<th>연관문서</th>";
		htmlForm += "<td></td>";
		htmlForm += "</tr>";*/
		
		htmlForm += "</table>";    
		
		return htmlForm; 
	}
	
	
	
	/**
	 * 과재 운영취소 상신 실패시 RollBack - 상태코드 O6(운영취소 결재 대기중) >  O1(운영중) 롤백
	 * @param map
	 * @return 
	 * @return
	 * @throws Exception
	 */	
	public void requestTaskManageProcessCancelRollBack(Map<String, Object> map) throws Exception {
		//운영취소 : Z_20_002_02
		map.put("processSttus","O1");
		//프로세스 상태 변경
		taskDevelopDAO.updateTaskProcessSttus(map);
	}
	
	
	
	/**
	 * 과재 결재, 운영취소 상신 실패시 RollBack - ASIS 
	 * @param map
	 * @return 
	 * @return
	 * @throws Exception
	 */	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void requestTaskPaymentRollBack(Map<String, Object> map) throws Exception {
		//결재요청 : Z_20_001_04   //운영취소 : Z_20_002_02
		
		//-------------------------프로세스 결재 삭제---------------------------------------------
		
		//프로세스 결재요청 이력 delete
		taskPaymentDAO.deleteTaskPaymentHist(map);
		
		int chkOverMkey = taskPaymentDAO.chkOverlapMkey(map);
		
		if(1 >= chkOverMkey) {
			//프로세스 결재요청 delete
			taskPaymentDAO.deleteTaskPayment(map);
		}
		
		//-------------------------프로세스 삭제-------------------------------------------
		
		String formPrefix 	= String.valueOf( map.get("formPrefix"));
		
		if("Z_20_001_04".equals(formPrefix)) {
			//결재요청 : Z_20_001_04
			
			//과제별 프로세스 개인별 기여도 delete
			taskDevelopDAO.deleteTaskProcessContribute2(map);
			
			//과제별 프로세스 과제별 절감시간 delete
			taskDevelopDAO.deletTaskProcessRedcnTm2(map);
			
			//과제별 프로세스 담당자 delete
			taskDevelopDAO.deleteTaskProcessCharger2(map);
			
			//프로세스 delete
			taskDevelopDAO.deleteTaskProcess(map);
			
		}else if("Z_20_002_02".equals(formPrefix)) {
			//운영취소 : Z_20_002_02
			map.put("processSttus","O1");
			//프로세스 상태 변경
			taskDevelopDAO.updateTaskProcessSttus(map);
		}else {}
		
	}
	
 

	/**
	 * 과재 결재상신연동 API 호출
	 * @param map
	 * @return 
	 * @return
	 * @throws Exception
	 */
	public void updateTaskPaymentResult(Map<String, Object> map) throws Exception {
		
		logger.debug("TaskPaymentService updateTaskPaymentResult 과제 결재 상신 API 호출");
		
		String mkey = (String)map.get("mkey");
		String formPrefix = "";
		String responseCode = "";
		
		Map<String, Object> requestMap = new HashMap<String, Object>();
		
		if(mkey == null || "".equals(mkey)) {
			logger.debug("TaskPaymentService updateTaskPaymentResult mkey가 존재하지 않습니다. ");
			
			//mkey가 존재하지 않습니다.
			throw new RpaException("E60009", "mkey가 존재하지 않습니다.");	//mkey가 존재하지 않습니다.
		}
		
		//mkey : 양식코드|DEVLOP_SN|PROCESS_NO
		String[] mkeyVal = mkey.split("\\|");
		formPrefix = mkeyVal[0];
		requestMap.put("devlopSn", mkeyVal[1]);
		requestMap.put("processNo", mkeyVal[2]);
		
		int chkOverlapProcessCd =  taskDevelopDAO.chkOverlapProcessCdType3(requestMap);
		
		if(chkOverlapProcessCd > 0) {
			
			responseCode = (String)map.get("responseCode");
			
			if(responseCode != null && !"".equals(responseCode)) {
				//결재요청 : Z_20_001_04   //운영취소 : Z_20_002_02
				
				if("0".equals(responseCode)){
					//responseCode 0:결재완료  
					//D1 = 개발접수 //O3 = 운영취소
					logger.debug("TaskPaymentService updateTaskPaymentResult responseCode 0:결재완료 ");
					if("Z_20_001_04".equals(formPrefix)) {
						requestMap.put("processSttus","D1");
					}else if("Z_20_002_02".equals(formPrefix)) {
						requestMap.put("processSttus","O3");
					}else {
						throw new RpaException("E60011", "잘못 된 mKey입니다.");	 //잘못 된 mKey입니다.
					}
					
				}else if("1".equals(responseCode)){
					//responseCode 1:반려
					//P2 = 개발 결제반려 //O3 = 운영취소 반려
					//throw new RpaException("E60009", (String)map.get("responseMessage"));	//결재요청이 반려되었습니다.
					
					logger.debug("TaskPaymentService updateTaskPaymentResult responseCode 1:반려 ");
					
					if("Z_20_001_04".equals(formPrefix)) {
						requestMap.put("processSttus","P2");
					}else if("Z_20_002_02".equals(formPrefix)) {
						requestMap.put("processSttus","O4");
					}else {
						throw new RpaException("E60011", "잘못 된 mKey입니다.");	 //잘못 된 mKey입니다.
					}
					
					
				}else if("2".equals(responseCode)){
					//responseCode 2:상신
					//P1 = 개발 결재중 //O2 = 운영취소 결재중
					
					logger.debug("TaskPaymentService updateTaskPaymentResult responseCode 2:상신 ");
					
					if("Z_20_001_04".equals(formPrefix)) {
						requestMap.put("processSttus","P1");
					}else if("Z_20_002_02".equals(formPrefix)) {
						requestMap.put("processSttus","O2");
					}else {
						throw new RpaException("E60011", "잘못 된 mKey입니다.");	 //잘못 된 mKey입니다.
					}
					
				}else if("3".equals(responseCode)){
					//responseCode 3:기안취소
					// P3 = 상신자 - 개발 기안취소 // O5 = 상신자 - 운영 기안취소
					// P4 = 상신자 - 임시저장(다이렉트의 '진행함'에서 '회수'버튼 클릭 시)
					
					logger.debug("TaskPaymentService updateTaskPaymentResult responseCode 3:기안취소 ");
					
					if("Z_20_001_04".equals(formPrefix)) {
						requestMap.put("processSttus","P4");
						requestMap.put("changeCn","최초 작성자가 회수하였음");
						requestMap.put("registerId",MDC.get("txUserId"));
					}else if("Z_20_002_02".equals(formPrefix)) {
						requestMap.put("processSttus","O5");
					}else {
						throw new RpaException("E60011", "잘못 된 mKey입니다.");	 //잘못 된 mKey입니다.
					}
					
				}else {
					//responseCode가 존재하지 않습니다.
					throw new RpaException("E60010", "responseCode가 존재하지 않습니다.");	//responseCode가 존재하지 않습니다.
				}
				
				requestMap.put("updusrId","taskPayment");
				
				//프로세스 상태 변경
				taskDevelopDAO.updateTaskProcessSttus(requestMap);
				
				//프로세스 이력번호 생성
				int iProcessHistNo = taskDevelopDAO.getTaskProcessHistNo(requestMap);
				requestMap.put("processHistNo", iProcessHistNo);
				requestMap.put("registerId","taskPayment");
				
				//프로세스 변경 이력 저장
				taskDevelopDAO.insertTaskProcessChangeHist(requestMap);
				
			}else {
				//responseCode가 존재하지 않습니다.
				throw new RpaException("E60010", "responseCode가 존재하지 않습니다.");	//responseCode가 존재하지 않습니다.
			}
					
		}else {
			//프로세스가 존재하지 않습니다.
			throw new RpaException("E60008", "프로세스가 존재하지 않습니다.");	//프로세스가 존재하지 않습니다.
		}
		
		logger.debug("TaskPaymentService updateTaskPaymentResult 과제 결재 상신 API 완료");
		
	}




	
}
