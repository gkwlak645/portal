package kr.co.rpaplatform.dongwon.cmmnty.web;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.MDC;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.rpaplatform.common.vo.ResponseVO;
import kr.co.rpaplatform.dongwon.cmmnty.service.FaqService;
import kr.co.rpaplatform.dongwon.cmmnty.vo.BbsVO;
import kr.co.rpaplatform.dongwon.cmmnty.vo.FaqVO;
import kr.co.rpaplatform.dongwon.file.vo.AtchFileVO;


@Controller
@RequestMapping("/cmmnty/faq")
public class FaqController {

	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(BbsMngController.class);
	
	@Resource(name="faqService")
	private FaqService faqService;
	
	/**
	 * FAQ 페이지 이동
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/faqMain", method = RequestMethod.GET)
	public ModelAndView boardFaq(HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView("/cmmnty/faq/faqMain");
		mav.addObject("boardNo", request.getParameter("boardNo"));
		return mav;
	}
	
	/**
	 * FAQ 게시판 List
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/getFaq", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getFaq(@RequestBody FaqVO vo) throws Exception {
		logger.debug("FAQController getNotice start!!");

		Map<String, Object> resultData = new HashMap<String, Object>();
		System.out.println("@@@@@@@@@@@@@@@@@@@"+faqService.getFaq(vo));
		resultData.put("faqList", faqService.getFaq(vo));
		
		logger.debug("FAQController getNotice end!!");
		return new ResponseVO(resultData);
	}
	
	/**
	 * FAQ 등록 페이지 이동
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/faqRegPop", method = RequestMethod.GET)
	public ModelAndView boardFaqReg(HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView("/cmmnty/faq/faqRegPop");
		return mav;
	}
	
	
	
	/**
	 * FAQ 게시판 글 등록
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/insertFaqBoard", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO setFaqBoard(@RequestBody FaqVO vo) throws Exception {
		logger.debug("FAQController setFaqBoard start!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		faqService.setFaqBoard(vo);
		
		logger.debug("FAQController setFaqBoard end!!");
		return new ResponseVO(resultData);
	}
	
	/**
	 * FAQ 상세 페이지
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value="/faqDetailPop", method = RequestMethod.GET)
	@ResponseBody
	public ModelAndView faqDetail(HttpServletRequest request)throws Exception {
		ModelAndView mav = new ModelAndView("/cmmnty/faq/faqDetailPop");
		String regId =request.getParameter("registerId");
		if(MDC.get("txUserId").equals(regId)) {
			mav.addObject("flag", true);
		}else {
			mav.addObject("flag", false);
		}
		return mav;
	}
	
	/**
	 * FAQ 수정 페이지 이동
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/faqUpdtPop", method = RequestMethod.GET)
	public ModelAndView noticeUpdtPop(HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView("/cmmnty/faq/faqUpdtPop");
		return mav;
	}
	
	
	/**
	 * FAQ 상세페이지 값 가져오기
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/getFaqDetail", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getFaqDetail(@RequestBody FaqVO vo) throws Exception {
		logger.debug("FAQController getFaqDetail start!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		resultData.put("getFaq", faqService.getFaqDetail(vo));
		
		logger.debug("FAQController getFaqDetail end!!");
		return new ResponseVO(resultData);
	}
	
	/**
	 * 공지사항 상세페이지 수정
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/updtFaq", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO updtFaqDetail(@RequestBody FaqVO vo) throws Exception {
		logger.debug("FAQController updtFaqDetail start!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		faqService.updtFaqDetail(vo);
		
		logger.debug("FAQController updtFaqDetail end!!");
		return new ResponseVO(resultData);
	}
	
	/**
	 * 공지사항 게시글 삭제
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteFaq", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO deleteFaqDetail(@RequestBody FaqVO vo) throws Exception {
		logger.debug("FAQController deleteFaqDetail start!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		List<AtchFileVO> deletedFileList = faqService.deleteFaqDetail(vo);
		
		if (deletedFileList != null) {
			if (deletedFileList != null && deletedFileList.size() > 0) {
				for (AtchFileVO atchUploadFileVO : deletedFileList) {
					String path = atchUploadFileVO.getSavePath() + File.separator + atchUploadFileVO.getSaveFileNm();
					File file = new File(path);
					if (file.exists()) {
						file.delete();
					}
				}
			}
		}
		
		logger.debug("FAQController deleteFaqDetail end!!");
		return new ResponseVO(resultData);
	}
	
}
