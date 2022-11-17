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
import kr.co.rpaplatform.dongwon.cmmnty.service.NoticeService;
import kr.co.rpaplatform.dongwon.cmmnty.vo.BbsVO;
import kr.co.rpaplatform.dongwon.file.vo.AtchFileVO;


@Controller
@RequestMapping("/cmmnty/notice")
public class NoticeController {

	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(BbsMngController.class);
	
	@Resource(name="noticeService")
	private NoticeService noticeService;
	
	/**
	 * 공지사항 페이지 이동
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/noticeMain", method = RequestMethod.GET)
	public ModelAndView boardNotice(HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView("/cmmnty/notice/noticeMain");
		mav.addObject("boardNo", request.getParameter("boardNo"));
		return mav;
	}
	
	/**
	 * 공지사항 게시판 List
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/getNotice", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getNotice(@RequestBody BbsVO vo) throws Exception {
		logger.debug("NoticeController getNotice start!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		resultData.put("noticeList", noticeService.getNotice(vo));
		
		logger.debug("NoticeController getNotice end!!");
		return new ResponseVO(resultData);
	}
	
	/**
	 * 공지사항 등록 페이지 이동
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/noticeRegPop", method = RequestMethod.GET)
	public ModelAndView boardNoticeReg(HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView("/cmmnty/notice/noticeRegPop");
		return mav;
	}
	
	
	
	/**
	 * 공지사항 게시판 글 등록
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/insertNoticeBoard", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO setNoticeBoard(@RequestBody BbsVO vo) throws Exception {
		logger.debug("NoticeController setNoticeBoard start!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		noticeService.setNoticeBoard(vo);
		
		logger.debug("NoticeController setNoticeBoard end!!");
		return new ResponseVO(resultData);
	}
	
	/**
	 * 공지사항 상세 페이지
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value="/noticeDetailPop", method = RequestMethod.GET)
	@ResponseBody
	public ModelAndView noticeDetail(HttpServletRequest request)throws Exception {
		ModelAndView mav = new ModelAndView("/cmmnty/notice/noticeDetailPop");
		String regId =request.getParameter("registerId");
		if(MDC.get("txUserId").equals(regId)) {
			mav.addObject("flag", true);
		}else {
			mav.addObject("flag", false);
		}
		return mav;
	}
	
	/**
	 * 공지사항 등록 페이지 이동
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/noticeUpdtPop", method = RequestMethod.GET)
	public ModelAndView noticeUpdtPop(HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView("/cmmnty/notice/noticeUpdtPop");
		return mav;
	}
	
	
	/**
	 * 공지사항 상세페이지 값 가져오기 및 조회수
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/getNoticeDetailNumOfHit", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getNoticeDetailNumOfHit(@RequestBody BbsVO vo) throws Exception {
		logger.debug("NoticeController getNoticeDetail start!!");
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"+vo);
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		resultData.put("getNotice", noticeService.getNoticeDetailNumOfHit(vo));
		
		logger.debug("NoticeController getNoticeDetail end!!");
		return new ResponseVO(resultData);
	}
	
	
	/**
	 * 공지사항 상세페이지 값 가져오기
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/getNoticeDetail", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getNoticeDetail(@RequestBody BbsVO vo) throws Exception {
		logger.debug("NoticeController getNoticeDetail start!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		resultData.put("getNotice", noticeService.getNoticeDetail(vo));
		
		logger.debug("NoticeController getNoticeDetail end!!");
		return new ResponseVO(resultData);
	}
	
	/**
	 * 공지사항 상세페이지 수정
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/updtNotice", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO updtNoticeDetail(@RequestBody BbsVO vo) throws Exception {
		logger.debug("NoticeController updtNoticeDetail start!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		noticeService.updtNoticeDetail(vo);
		
		logger.debug("NoticeController updtNoticeDetail end!!");
		return new ResponseVO(resultData);
	}
	
	/**
	 * 공지사항 게시글 삭제
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteNotice", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO deleteNoticeDetail(@RequestBody BbsVO vo) throws Exception {
		logger.debug("NoticeController deleteNotice start!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		List<AtchFileVO> deletedFileList = noticeService.deleteNoticeDetail(vo);
		
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
		
		logger.debug("NoticeController deleteNotice end!!");
		return new ResponseVO(resultData);
	}
	
}
