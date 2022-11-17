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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.rpaplatform.common.vo.ResponseVO;
import kr.co.rpaplatform.dongwon.cmmnty.service.BbsAnswerService;
import kr.co.rpaplatform.dongwon.cmmnty.vo.BbsAnswerVO;
import kr.co.rpaplatform.dongwon.cmmnty.vo.BbsVO;
import kr.co.rpaplatform.dongwon.cmmnty.web.BbsMngController;
import kr.co.rpaplatform.dongwon.file.vo.AtchFileVO;


/**
 * @author jw.lee
 * 2020. 6. 15.
 */
@Controller
@RequestMapping("/cmmnty/answer")
public class BbsAnswerController {

	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(BbsMngController.class);
	
	@Resource(name="bbsAnswerService")
	private BbsAnswerService bbsAnswerService;
	
	/**
	 * 댓글 게시판 페이지 이동
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/bbsAnswerMain", method = RequestMethod.GET)
	public ModelAndView boardAnswer(HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView("/cmmnty/answer/bbsAnswerMain");
		mav.addObject("boardNo", request.getParameter("boardNo"));
		return mav;
	}
	
	/**
	 * 댓글 게시판 수정페이지
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/bbsAnswerUpdtPop", method = RequestMethod.GET)
	public ModelAndView boardAnswerUpdatePop() throws Exception{
		return new ModelAndView("/cmmnty/answer/bbsAnswerUpdtPop");
	}
	
	/**
	 * 댓글 게시판 상세보기
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/bbsAnswerDetailPop", method = RequestMethod.GET)
	public ModelAndView boardAnswerDetailPop(@RequestParam(value="regId") String regId) throws Exception{
		ModelAndView mav = new ModelAndView("/cmmnty/answer/bbsAnswerDetailPop");
		if(MDC.get("txUserId").equals(regId)) {
			mav.addObject("flag", true);
		}else {
			mav.addObject("flag", false);
		}
		return mav;
	}
	
	/**
	 * 댓글 게시판 게시글 등록
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/bbsRegAnswerPop", method = RequestMethod.GET)
	public ModelAndView boardRegisterAnswerPop() throws Exception{
		return new ModelAndView("/cmmnty/answer/bbsRegAnswerPop");
	}
	
	/**
	 * 댓글 게시판 조회
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/getBoard", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getBoard(@RequestBody BbsVO vo) throws Exception {
		logger.debug("BbsAnswerController getBoard start!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		resultData.put("answerList", bbsAnswerService.getBoard(vo));
		
		logger.debug("BbsAnswerController getBoard end!!");
		return new ResponseVO(resultData);
	}
	
	/**
	 * 댓글 게시판 상세페이지 뿌려주기
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/boardAnswerDetailPop", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO boardAnswerDetailPop(@RequestBody BbsVO vo) throws Exception {
		logger.debug("BbsAnswerController boardAnswerDetailPop start!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		resultData.put("answerValue", bbsAnswerService.selectBoardDetail(vo));
		
		logger.debug("BbsAnswerController boardAnswerDetailPop end!!");
		return new ResponseVO(resultData);
	}
	
	/**
	 * 댓글 게시판 상세페이지 댓글쓰기
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/insertAnswer", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO insertAnswer(@RequestBody BbsAnswerVO vo) throws Exception {
		logger.debug("BbsAnswerController insertAnswer start!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		bbsAnswerService.insertAnswer(vo);
		
		logger.debug("BbsAnswerController insertAnswer end!!");
		return new ResponseVO(resultData);
	}
	
	/**
	 * 댓글 게시판 상세페이지 댓글보여주기
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/getAnswers", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getAnswers(@RequestBody BbsAnswerVO vo) throws Exception {
		logger.debug("BbsAnswerController getAnswers start!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		resultData.put("answerList", bbsAnswerService.getAnswers(vo));
		
		logger.debug("BbsAnswerController getAnswers end!!");
		return new ResponseVO(resultData);
	}
	
	/**
	 * 댓글 게시판 상세페이지 댓글삭제하기
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteAnswer", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO deleteAnswer(@RequestBody BbsAnswerVO vo) throws Exception {
		logger.debug("BbsAnswerController deleteAnswer start!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		bbsAnswerService.deleteAnswer(vo);
		
		logger.debug("BbsAnswerController deleteAnswer end!!");
		return new ResponseVO(resultData);
	}
	
	/**
	 * 댓글 게시판 상세페이지 답글삭제하기
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteReply", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO deleteReply(@RequestBody BbsAnswerVO vo) throws Exception {
		logger.debug("BbsAnswerController deleteReply start!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		bbsAnswerService.deleteReply(vo);
		
		logger.debug("BbsAnswerController deleteReply end!!");
		return new ResponseVO(resultData);
	}
	
	/**
	 * 댓글 게시판 상세페이지 게시글삭제하기
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/boardDelete", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO boardDelete(@RequestBody BbsVO vo) throws Exception {
		logger.debug("BbsAnswerController boardDelete start!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		List<AtchFileVO> deletedFileList = bbsAnswerService.deleteBoard(vo);
		
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
		
		logger.debug("BbsAnswerController boardDelete end!!");
		return new ResponseVO(resultData);
	}
	
	/**
	 * 댓글 게시판 수정페이지 데이터뿌리기
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/boardAnswerUpdatePop", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO boardAnswerUpdatePop(@RequestBody BbsVO vo) throws Exception {
		logger.debug("BbsAnswerController boardAnswerUpdatePop start!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		resultData.put("boardValue", bbsAnswerService.boardAnswerUpdatePop(vo));
		
		logger.debug("BbsAnswerController boardAnswerUpdatePop end!!");
		return new ResponseVO(resultData);
	}
	
	/**
	 * 댓글 게시판 수정페이지 업데이트
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateBoard", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO updateBoard(@RequestBody BbsVO vo) throws Exception {
		logger.debug("BbsAnswerController updateBoard start!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		bbsAnswerService.updateBoard(vo);
		
		logger.debug("BbsAnswerController updateBoard end!!");
		return new ResponseVO(resultData);
	}
	
	/**
	 * 댓글 게시판 게시글 등록
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/insertBoard", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO insertBoard(@RequestBody BbsVO vo) throws Exception {
		logger.debug("BbsAnswerController insertBoard start!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		bbsAnswerService.insertBoard(vo);
		
		logger.debug("BbsAnswerController insertBoard end!!");
		return new ResponseVO(resultData);
	}
}
