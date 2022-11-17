package kr.co.rpaplatform.dongwon.hlpdsk.web;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.MDC;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.rpaplatform.common.vo.ResponseVO;
import kr.co.rpaplatform.dongwon.common.service.SendMailDw;
import kr.co.rpaplatform.dongwon.common.vo.CmmnUserVO;
import kr.co.rpaplatform.dongwon.file.dao.AtchFileDAO;
import kr.co.rpaplatform.dongwon.file.vo.AtchFileVO;
import kr.co.rpaplatform.dongwon.hlpdsk.service.HlpdskService;
import kr.co.rpaplatform.dongwon.hlpdsk.vo.HlpdskVO;




@Controller
@RequestMapping("/hlpdsk")
public class hlpdskController {

	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(hlpdskController.class);
	
	@Resource(name="hlpdskService")
	private HlpdskService hlpdskService;
	
	@Resource(name="sendMailDw")
	private SendMailDw sendMailDw;
	
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
	 * 리스트 화면 이동
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/requst/hlpdskMain", method = RequestMethod.GET)
	public ModelAndView boardNotice(HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView("/hlpdsk/requst/hlpdskMain");
		
		//메인- 헬프데스크 선택시 requestSn 넘김
		if(request.getParameter("requestSn") != null && request.getParameter("requestSn") != "") {
			mav.addObject("requestSn", request.getParameter("requestSn"));
		}
		return mav;
	}
	
	/**
	 * 등록 화면 이동
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/requst/hlpdskCreate", method = RequestMethod.GET)
	public ModelAndView bbsCreate() throws Exception {
		ModelAndView mav = new ModelAndView("/hlpdsk/requst/hlpdskCreate");
		return mav;
	}
	
	/**
	 * 상세 화면 이동
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/requst/hlpdskDetail", method = RequestMethod.GET)
	public ModelAndView bbsDetail() throws Exception {
		ModelAndView mav = new ModelAndView("/hlpdsk/requst/hlpdskDetail");
		return mav;
	}
	
	/**
	 * 접수 메인 화면 이동
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/receipt/hlpdskReceiptMain", method = RequestMethod.GET)
	public ModelAndView receiptList() throws Exception {
		ModelAndView mav = new ModelAndView("/hlpdsk/receipt/hlpdskReceiptMain");
		return mav;
	}
	
	/**
	 * 상세 화면 이동
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/receipt/hlpdskReceiptDetail", method = RequestMethod.GET)
	public ModelAndView receiptDetail() throws Exception {
		ModelAndView mav = new ModelAndView("/hlpdsk/receipt/hlpdskReceiptDetail");
		return mav;
	}
		
	// ----------------- view 끝 --------------- //
	
	/**
	 * 헬프데스크 처리요청 리스트
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/requst/getHlpdsk", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getHlpdsk(@RequestBody HlpdskVO vo) throws Exception {		
		Map<String, Object> resultData = new HashMap<String, Object>();	
		//vo.setRequstCmpnyCd(MDC.get("txCmpnyCd"));

		resultData.put("hlpdskList", hlpdskService.getHlpdsk(vo));		
		return new ResponseVO(resultData);
	}
	
	/**
	 * 헬프데스크 처리요청 글등록
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/requst/insertHlpdsk", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO createHlpdsk(@RequestBody HlpdskVO vo, HttpServletRequest request) throws Exception {		
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		if (request.getSession().getAttribute("sessionUserInfo") != null) {
			CmmnUserVO cmmnUserVO = (CmmnUserVO)request.getSession().getAttribute("sessionUserInfo");
			vo.setRequstCmpnyCd(cmmnUserVO.getTxCmpnyCd());
		}
	
		hlpdskService.createHlpdsk(vo);
		
		vo.setRequstCmpnyCd(MDC.get("txCmpnyCd"));

		Map<String, Object> getRequstSnSj = hlpdskService.selectRequstSnSj(vo);	
		
		/*//발송 대상자 확인
		List<Map<String, Object>> hlpSendList =  hlpdskService.selectSendTrgetList();
		int hlpSendListSize = hlpSendList.size();
		if(hlpSendListSize > 0) {
			//발송 메일의 제목
			String sMailSj = "[HelpDesk 처리요청] " + vo.getRequstSj();
				
			//-- 발송 메일의 본문 만들기 시작
			String sMailCn = "";
			
			//메일 본분 FORM String  가져오기
			String fileSeparator = File.separator;
			StringBuffer sFormFilePath = new StringBuffer();
			sFormFilePath.append(request.getServletContext().getRealPath("/"));
			sFormFilePath.append("WEB-INF");
			sFormFilePath.append(fileSeparator);
			sFormFilePath.append("jsp");
			sFormFilePath.append(fileSeparator);
			sFormFilePath.append("hlpdsk");
			sFormFilePath.append(fileSeparator);
			sFormFilePath.append("requst");
			sFormFilePath.append(fileSeparator);
			sFormFilePath.append("sendMail_form_hlpdsk.html");
			
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
			
			sReplaceText.append("<p><b>요청자 아이디 :</b> " + MDC.get("txUserId") + "</p>");
			sReplaceText.append("<p><b>요청자 이름 :</b> " + MDC.get("txUserNm") + "</p>");			
			sReplaceText.append("<p><b>요청 일련번호 :</b> " + vo.getRequstSn() + "</p>");
			sReplaceText.append("<p><b>요청제목 :</b> " + vo.getRequstSj() + "</p>");
			sReplaceText.append("<p><b>요청내용 :</b> " + vo.getRequstCn() + "</p>");
					
			String saveString = "";
			
			saveString += "<br />";
			saveString += "<strong>HelpDesk 처리요청</strong>";
			saveString += "<table id='' border=\"1\" class='table_10' summary='' cellpadding='0' cellspacing='0' >";
			saveString += "<colgroup>";
			saveString += "<col style='width:15%'
			
			 />";
			saveString += "<col style='width:35%' />";
			saveString += "<col style='width:15%' />";
			saveString += "<col style='width:35%' />";
			saveString += "</colgroup>";
			saveString += "<tr>";
			saveString += "<th>요청분류</th>";
			saveString += "<td>요청분류</td>";
			saveString += "</tr>";

			saveString += "<tr>";
			saveString += "<th>아이디</th>";
			saveString += "<td>아이디</td>";
			saveString += "<th>이름</th>";
			saveString += "<td align=\"right\">이름</strong></span></td>";
			saveString += "</tr>";
						
			saveString += "<tr>";
			saveString += "<th>소속</th>";
			saveString += "<td>소속</td>";
			saveString += "</tr>";
					
			saveString += "<tr>";
			saveString += "<th>제목</th>";
			saveString += "<td>제목</td>";
			saveString += "</tr>";
							
			saveString += "<tr>";
			saveString += "<th>내용</th>";
			saveString += "<td colspan='3'>내용</td>";
			saveString += "</tr>";
			saveString += "</table>";
		
			// sReplaceText.append("	<td class=\"tg-c6of\" width=85% style=\"word-break:break-all\">" + MDC.get("txUserId") +"</td>");

			
			StringBuffer sReplaceText = new StringBuffer();
			// 요청 분류
			sReplaceText.append("	<th class=\"tg-c6of\">" + getRequstSnSj.get("cdNm") +"</th>");
			saveString = sFileText.toString().replace("#★$requestKind#★$", sReplaceText.toString());
		
			// 요청자 아이디
			sReplaceText = new StringBuffer();
			sReplaceText.append("	<td class=\"tg-c6of\">" + MDC.get("txUserId") +"</td>");
			saveString = saveString.toString().replace("#★$requestId#★$", sReplaceText.toString());
			
			// 요청자 이름
			sReplaceText = new StringBuffer();
			sReplaceText.append("	<td class=\"tg-c6of\">" + MDC.get("txUserNm") +"</td>");
			saveString = saveString.toString().replace("#★$requestName#★$", sReplaceText.toString());
			
			// 요청자 소속
			sReplaceText = new StringBuffer();
			sReplaceText.append("	<td class=\"tg-c6of\">" + getRequstSnSj.get("cmpNm") + " " + MDC.get("txDeptNm") +"</td>");
			saveString = saveString.toString().replace("#★$requestDept#★$", sReplaceText.toString());
			
			// 제목
			sReplaceText = new StringBuffer();
			sReplaceText.append("	<td class=\"tg-c6of\">" + vo.getRequstSj() +"</td>");
			saveString = saveString.toString().replace("#★$requestTitle#★$", sReplaceText.toString());
			
			// 내용
			sReplaceText = new StringBuffer();
			sReplaceText.append("<tr>");
			sReplaceText.append("	<td class=\"tg-c6of\" colspan=\"2\" style=\"word-break:break-all\">" + vo.getRequstCn() +"</td>");
			sReplaceText.append("</tr>");
			saveString = saveString.toString().replace("#★$requestBody#★$", sReplaceText.toString());		
			
			//첨부파일
			List<AtchFileVO> atchmnflList = atchFileDAO.selectAtchmnflList((int)vo.getRequstFileGrpNo());
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
			else {
				fileForm = "첨부파일이 없습니다.";
			}
			
			sReplaceText = new StringBuffer();
			sReplaceText.append("	<td class=\"tg-c6of\" style=\"word-break:break-all\">" + fileForm +"</td>");
			//-- 발송 메일의 본문 만들기 종료
			sMailCn = saveString.toString().replace("#★$requestFile#★$", sReplaceText.toString());		
		
			//메일 보내기
			for(int i= 0; i < hlpSendListSize; i++) {
				Map<String, Object> oaSendTrgetList = hlpSendList.get(i);				
				sendMailDw.sendMail((String)oaSendTrgetList.get("emailAdr"), sMailSj, sMailCn);						
			}
		}*/
		
		return new ResponseVO(resultData);
	}
	
	/**
	 * 헬프데스크 상세보기
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value= "/requst/detailHlpdsk", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO detailHlpdsk(@RequestBody HlpdskVO vo)throws Exception {		
		Map<String, Object> returnData = new HashMap<String, Object>();
		returnData.put("helpdskDetail", hlpdskService.detailHlpdsk(vo));		
		return new ResponseVO(returnData);
	}
	
	/**
	 * 헬프데스크 처리요청 삭제
	 * @return
	 * @param map
	 * @throws Exception
	 */
	@RequestMapping(value = "/requst/deleteHlpdsk", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO deleteHlpdsk(@RequestBody HlpdskVO vo) throws Exception {		
		Map<String, Object> returnData = new HashMap<String, Object>();
		List<AtchFileVO> deletedFileList = hlpdskService.deleteHlpdsk(vo);		
		if (deletedFileList != null) { 			if (deletedFileList != null && deletedFileList.size() > 0) {
				for (AtchFileVO atchUploadFileVO : deletedFileList) {
					String path = atchUploadFileVO.getSavePath() + File.separator + atchUploadFileVO.getSaveFileNm();
					File file = new File(path);
					if (file.exists()) {
						file.delete();
					}
				}
			}
		}
		return new ResponseVO(returnData);
	}
	
	/**
	 * 헬프데스크 처리요청 수정
	 * @return
	 * @param map
	 * @throws Exception
	 */
	@RequestMapping(value = "/requst/updateHlpdsk", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO updateBoardManage(@RequestBody HlpdskVO vo) throws Exception {		
		Map<String, Object> returnData = new HashMap<String, Object>();
		hlpdskService.updateHlpdsk(vo);
		return new ResponseVO(returnData);
	}
	
	
	// ----------------- 처리요청 끝 --------------- //
	
	
	/**
	 * 헬프데스크 접수처리 리스트
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/receipt/getreceipthlpdsk", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getReceiptList(@RequestBody HlpdskVO vo) throws Exception {		
		Map<String, Object> resultData = new HashMap<String, Object>();		
		vo.setRequstCmpnyCd(MDC.get("txCmpnyCd"));
		resultData.put("hlpdskList", hlpdskService.getReceiptList(vo));		
		return new ResponseVO(resultData);
	}
	
	/**
	 * 헬프데스크 접수처리 상세보기
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value= "/receipt/detailreceipthlpdsk", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO detailReceip(@RequestBody HlpdskVO vo)throws Exception {		
		Map<String, Object> returnData = new HashMap<String, Object>();
		returnData.put("receiptDetail", hlpdskService.detailReceip(vo));		
		return new ResponseVO(returnData);
	}
	
	/**
	 * 헬프데스크 접수처리 수정
	 * @return
	 * @param map
	 * @throws Exception
	 */
	@RequestMapping(value = "/receipt/updatereceipthlpdsk", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO updatereceipt(@RequestBody HlpdskVO vo) throws Exception {		
		Map<String, Object> returnData = new HashMap<String, Object>();
		hlpdskService.updatereceipt(vo);
		return new ResponseVO(returnData);
	}
	
}
