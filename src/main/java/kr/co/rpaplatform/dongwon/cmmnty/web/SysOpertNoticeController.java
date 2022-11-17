package kr.co.rpaplatform.dongwon.cmmnty.web;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.MDC;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.rpaplatform.common.exception.RpaException;
import kr.co.rpaplatform.common.pagination.PaginationInfo;
import kr.co.rpaplatform.common.vo.ResponseVO;
import kr.co.rpaplatform.dongwon.author.vo.AuthorVO;
import kr.co.rpaplatform.dongwon.cmmnty.service.NoticeService;
import kr.co.rpaplatform.dongwon.cmmnty.service.SysOpertNoticeService;
import kr.co.rpaplatform.dongwon.common.service.PortalCommonService;
import kr.co.rpaplatform.dongwon.common.service.SendMailDw;
import kr.co.rpaplatform.dongwon.common.util.PaginationUtil;

@Controller
@RequestMapping("/cmmnty/sysOpertNotice")
public class SysOpertNoticeController {
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(BbsMngController.class);
	
	@Resource(name="portalCommonService")
	private PortalCommonService portalCommonService;
	
	@Resource(name="sysOpertNoticeService")
	private SysOpertNoticeService sysOpertNoticeService;
	
	@Resource(name="sendMailDw")
	private SendMailDw sendMailDw;
	
	/**
	 * 시스템 작업공지 > 메인
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/sysOpertNoticeMain", method = RequestMethod.GET)
	public ModelAndView sysOpertNoticeMain(HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView("/cmmnty/sysOpertNotice/sysOpertNoticeMain");
		//메인- 시스템작업공지 선택시 sonSn 넘김
		if(request.getParameter("sonSn") != null && request.getParameter("sonSn") != "") {
			mav.addObject("sonSn", request.getParameter("sonSn"));
		}
		return mav;
	}
	
	
	/**
	 * 시스템 작업공지 > 메인: 조회
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectSysOpertNoticeList", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO selectSysOpertNoticeList(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		logger.debug("SysOpertNoticeController.selectSysOpertNoticeList end!!");
		Map<String, Object> returnMap = new HashMap<String, Object>();
		//리스트 카운트 조회
		int totalRecordCount = sysOpertNoticeService.selectSysOpertNoticeListCount(params);
		
		//페이징 정보 조회
		PaginationInfo paginationInfo = PaginationUtil.getPaginationInfo(params, totalRecordCount);
		
		//조회조건에 페이징 정보 설정
		params.put("paginationInfo", PaginationUtil.getPaginationInfo(params, totalRecordCount));

		//과제개발 > 메인: 리스트  조회
		List<Map<String, Object>> resultList = sysOpertNoticeService.selectSysOpertNoticeList(params);

		//결과값 설정
		returnMap.put("resultList", resultList);
		returnMap.put("paginationInfo", paginationInfo);
		logger.debug("SysOpertNoticeController.selectSysOpertNoticeList end!!");
		return new ResponseVO(returnMap);
	}
	
	/**
	 * 시스템 작업공지 > 등록
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/sysOpertNoticeRegPop", method = RequestMethod.GET)
	public ModelAndView sysOpertNoticeRegPop(HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView("/cmmnty/sysOpertNotice/sysOpertNoticeRegPop");
		return mav;
	}
	
	/**
	 * 시스템 작업공지 > 등록: 등록
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/insertSysOpertNotice", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO insertSysOpertNotice(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		logger.debug("SysOpertNoticeController insertSysOpertNotice start!!");
		
		AuthorVO oAuthorVO = portalCommonService.getScreenAuthor(req);
		//쓰기/수정 권한자 인지 확인
		if(!oAuthorVO.getWrtngAuthor().equals("Y")) {
			throw new RpaException("E202");//비정상 접근입니다.
		}

		//insert
		params.put("registerId", MDC.get("txUserId"));
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		//저장 번호 가져오기
		int iNextSn = sysOpertNoticeService.getSysOpertNoticeNextSn();
		params.put("sonSn", iNextSn);
		
		//시스템 작업공지 등록
		sysOpertNoticeService.insertSysOpertNotice(params);
		
		//연관시시템 등록
		List<Map<String, Object>> aCntcSysList = (List<Map<String, Object>>)params.get("cntcSysList");
		int iaCntcSysList = aCntcSysList.size();
		for(int i = 0; i < iaCntcSysList; i++) {
			Map<String, Object> oaCntcSysList = aCntcSysList.get(i);
			oaCntcSysList.put("sonSn", iNextSn);
			oaCntcSysList.put("cntcSysNo", i+1);
			sysOpertNoticeService.insertSysOpertNoticeCntcSys(oaCntcSysList); 
		}
		
		//--메일 발송 연동 시작
		//연계 시스템 목록
		List<Map<String, Object>> aSendCntcSysList =  sysOpertNoticeService.selectSysOpertNoticeCntcSys(params);
		
		//공통이 있는지 확인
		int iaSendCntcSysList = aSendCntcSysList.size();
		String sSumCntcSysCd = "";
		for(int i = 0; i < iaSendCntcSysList; i++) {
			Map<String, Object> oaSendCntcSysList = aSendCntcSysList.get(i);
			/*if(((String)oaSendCntcSysList.get("cntcSysCd")).equals("01")) {
				sSumCmpnyCd = "";
				break;
			}
			else {
				String sCmpnyCd = (String)oaSendCntcSysList.get("cmpnyCd"); 
				if(!StringUtils.isEmpty(sCmpnyCd)) {
					sSumCmpnyCd += sSumCmpnyCd.length() > 0 ? "," + "'" + sCmpnyCd + "'": "'" + sCmpnyCd + "'";
				}
			}*/
			
			
			String sCntcSysCd = (String)oaSendCntcSysList.get("cntcSysCd"); 
			sSumCntcSysCd += sSumCntcSysCd.length() > 0 ? "," + "'" + sCntcSysCd + "'": "'" + sCntcSysCd + "'";
		}
		
		params.put("sSumCntcSysCd", sSumCntcSysCd);
		
		//발송 대상자 확인
		List<Map<String, Object>> aSendTrgetList = sysOpertNoticeService.selectSendTrgetList(params);
		int iaSendTrgetList = aSendTrgetList.size();
		if(iaSendTrgetList > 0) {
			//발송 메일의 제목
			String sMailSj = "[RPA운영포털]" + params.get("sj");
		
			//-- 발송 메일의 본문 만들기 시작
			String sMailCn = "";
			
			//메일 본분 FORM String  가져오기
			String fileSeparator = File.separator;
			StringBuffer sFormFilePath = new StringBuffer();
			sFormFilePath.append(req.getServletContext().getRealPath("/"));
			sFormFilePath.append("WEB-INF");
			sFormFilePath.append(fileSeparator);
			sFormFilePath.append("jsp");
			sFormFilePath.append(fileSeparator);
			sFormFilePath.append("cmmnty");
			sFormFilePath.append(fileSeparator);
			sFormFilePath.append("sysOpertNotice");
			sFormFilePath.append(fileSeparator);
			sFormFilePath.append("sendMail_form.html");
			
			File file = new File(sFormFilePath.toString());
			StringBuffer sFileText = new StringBuffer();
			try (BufferedReader br = new BufferedReader(new FileReader(file))) {
			    String line;
			    while ((line = br.readLine()) != null) {
			    	sFileText.append(line);
			    }
			} catch (IOException e) {
			    e.printStackTrace();
			}
			
			// 본문 내용 변경
			StringBuffer sReplaceText = new StringBuffer();
			for(int i = 0; i < iaSendCntcSysList; i++) {
				Map<String, Object> oaSendCntcSysList = aSendCntcSysList.get(i);
				String sCmpnyNm = (String)oaSendCntcSysList.get("cmpnyNm");
				
				sReplaceText.append("<tr>");
				sReplaceText.append("	<td style=\"text-align:center;height:28px; padding:0px 5px 2px 10px;border:1px solid #888888;color:#222222;\">" + oaSendCntcSysList.get("cntcSysClsNm") +"</td>");
				sReplaceText.append("	<td style=\"height:28px; padding:0px 5px 2px 10px;border:1px solid #888888;color:#222222;\">" + (sCmpnyNm == null ? "" : oaSendCntcSysList.get("cmpnyNm")) + "</td>");
				sReplaceText.append("	<td style=\"text-align:center;height:28px; padding:0px 5px 2px 10px;border:1px solid #888888;color:#222222;\">" + oaSendCntcSysList.get("cntcSysCd") +"</td>");
				sReplaceText.append("	<td style=\"text-align:center;height:28px; padding:0px 5px 2px 10px;border:1px solid #888888;color:#222222;\">" + oaSendCntcSysList.get("cntcSysNm") +"</td>");
				sReplaceText.append("</tr>");
			}
			
			sMailCn = sFileText.toString().replace("#★$replaceText#★$", sReplaceText.toString());
			//-- 발송 메일의 본문 만들기 종료
					
			//메일 보내기
			for(int i= 0; i < iaSendTrgetList; i++) {
				Map<String, Object> oaSendTrgetList = aSendTrgetList.get(i);
				sendMailDw.sendMail((String)oaSendTrgetList.get("emailAdr"), sMailSj, sMailCn);
			}
		}
		//메일 발송 연동 종료
		
		logger.debug("SysOpertNoticeController.insertSysOpertNotice end!!");
		return new ResponseVO(resultData);
	}
	
	/**
	 * 시스템 작업공지 > 상세: getData
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/getSysOpertNoticeDetailPopGetData", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getSysOpertNoticeDetailPopGetData(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		logger.debug("SysOpertNoticeController.getSysOpertNoticeDetailPopGetData start!!");

		AuthorVO oAuthorVO = portalCommonService.getScreenAuthor(req);
		//읽기 권한자 인지 확인
		if(!oAuthorVO.getRedngAuthor().equals("Y")) {
			throw new RpaException("E202");//비정상 접근입니다.
		}
		
		Map<String, Object> returnData = sysOpertNoticeService.getSysOpertNoticeDetailPopGetData(params);
		
		logger.debug("SysOpertNoticeController.getSysOpertNoticeDetailPopGetData end!!");
		return new ResponseVO(returnData);
	}
	
	/**
	 * 시스템 작업공지 > 상세: LAYOUT
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/sysOpertNoticeDetailPop", method = RequestMethod.GET)
	public ModelAndView sysOpertNoticeDetailPop(@RequestParam(value="registerId") String registerId) throws Exception {
		
		ModelAndView mav = new ModelAndView("/cmmnty/sysOpertNotice/sysOpertNoticeDetailPop");
		//접속자와 게시자가 같은 사용자 인지 확인
		if(registerId.equals(MDC.get("txUserId"))) {
			mav.addObject("identityFlag", true); 
		}else {
			mav.addObject("identityFlag", false);
		}
		return mav;
	}
	
	/**
	 * 시스템 작업공지 > 상세: 저장
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateSysOpertNotice", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO updateSysOpertNotice(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		logger.debug("SysOpertNoticeController.updateSysOpertNotice start!!");

		AuthorVO oAuthorVO = portalCommonService.getScreenAuthor(req);
		//쓰기/수정 권한자 인지 확인
		if(!oAuthorVO.getWrtngAuthor().equals("Y")) {
			throw new RpaException("E202");//비정상 접근입니다.
		}
		
		Map<String, Object> returnData = sysOpertNoticeService.getSysOpertNoticeDetailPopGetData(params);
		
		//등록자와 동일인 인지 확인
		String sTxUserId = MDC.get("txUserId");
		if(((String)returnData.get("registerId")).equals(sTxUserId)) {
			//update 실행
			params.put("updusrId", sTxUserId);
			sysOpertNoticeService.updateSysOpertNotice(params);
			
			//연관시시템 등록
			List<Map<String, Object>> aCntcSysList = (List<Map<String, Object>>)params.get("cntcSysList");
			int iaCntcSysList = aCntcSysList.size();
			for(int i = 0; i < iaCntcSysList; i++) {
				Map<String, Object> oaCntcSysList = aCntcSysList.get(i);
				oaCntcSysList.put("sonSn", params.get("sonSn"));
				oaCntcSysList.put("cntcSysNo", i+1);
				sysOpertNoticeService.insertSysOpertNoticeCntcSys(oaCntcSysList); 
			}
			
			Map<String, Object> aTemp = new HashMap<String, Object>();
			aTemp.put("sonSn", params.get("sonSn"));
			aTemp.put("cntcSysNo", iaCntcSysList);
			sysOpertNoticeService.deleteSysOpertNoticeCntcSys(aTemp);
			
		}
		else {
			throw new RpaException("E202");//비정상 접근입니다.
		}
		
		logger.debug("SysOpertNoticeController.updateSysOpertNotice end!!");
		return new ResponseVO(new HashMap<String, Object>());
	}
	
	/**
	 * 시스템 작업공지 > 상세: 저장
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteSysOpertNotice", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO deleteSysOpertNotice(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		logger.debug("SysOpertNoticeController.deleteSysOpertNotice start!!");

		AuthorVO oAuthorVO = portalCommonService.getScreenAuthor(req);
		//쓰기/수정 권한자 인지 확인
		if(!oAuthorVO.getWrtngAuthor().equals("Y")) {
			throw new RpaException("E202");//비정상 접근입니다.
		}
		
		Map<String, Object> returnData = sysOpertNoticeService.getSysOpertNoticeDetailPopGetData(params);
		
		//등록자와 동일인 인지 확인
		String sTxUserId = MDC.get("txUserId");
		if(((String)returnData.get("registerId")).equals(sTxUserId)) {
			//update 실행
			params.put("updusrId", sTxUserId);
			sysOpertNoticeService.deleteSysOpertNotice(params);
		}
		else {
			throw new RpaException("E202");//비정상 접근입니다.
		}
		
		logger.debug("SysOpertNoticeController.deleteSysOpertNotice end!!");
		return new ResponseVO(new HashMap<String, Object>());
	}
}
