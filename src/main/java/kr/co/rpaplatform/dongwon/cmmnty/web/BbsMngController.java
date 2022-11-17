/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 6. 4.         LSH
 */
package kr.co.rpaplatform.dongwon.cmmnty.web;


import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.rpaplatform.common.vo.ResponseVO;
import kr.co.rpaplatform.dongwon.cmmnty.vo.BbsMngVO;
import kr.co.rpaplatform.dongwon.cmmnty.service.BbsMngService;

/**
 * @author jyj
 * 2020. 6. 11.
 */
@Controller
@RequestMapping("/cmmnty/bbsmng")
public class BbsMngController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(BbsMngController.class);
	
	/**
	 * 보드 서비스
	 */
	@Resource(name="bbsMngService")
	private BbsMngService bbsMngService;
	
	/**
	 * 메인화면 이동
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/bbsMngMain")
	public ModelAndView boardMain() throws Exception{
		return new ModelAndView("/cmmnty/bbsmng/bbsMngMain");
	}
	
	/**
	 * 등록 화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/bbsCreate")
	public ModelAndView bbsCreate() throws Exception {
		logger.debug("hubController 도착");
		return new ModelAndView("/cmmnty/bbsmng/bbsCreate");
	}
	
	/**
	 * 상세 화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/bbsDetail", method = RequestMethod.GET)
	public ModelAndView bbsDetail() throws Exception {
		logger.debug("bbsDetail도착!!!!!!!!!!");
		return new ModelAndView("/cmmnty/bbsmng/bbsDetail");
	}
	
	/**
	 * 게시판 유형 검색시 속성 넘겨주기
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value= "/selectBoardTyproperty", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO selectBoardTyproperty(@RequestBody BbsMngVO vo)throws Exception {
		
		logger.debug("BbsMngController selectBoardTyproperty start!!");
		Map<String, Object> returnData = new HashMap<String, Object>();
		returnData.put("boardList", bbsMngService.selectBoardTyproperty(vo));
		
		logger.debug("BbsMngController selectBoardTyproperty end!!");
		return new ResponseVO(returnData);
	}
	
	/**
	 * 게시판 컬럼 선택시 속성 넘겨주기
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value= "/getProperty", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getProperty(@RequestBody BbsMngVO vo)throws Exception {
		
		logger.debug("BbsMngController getProperty start!!");
		Map<String, Object> returnData = new HashMap<String, Object>();
		returnData.put("boardList", bbsMngService.getProperty(vo));
		
		logger.debug("BbsMngController getProperty end!!");
		return new ResponseVO(returnData);
	}
	
	/**
	 * 게시판 리스트 조회
	 * @return
	 * @param map
	 * @throws Exception
	 */
	@RequestMapping(value = "/getBoardList", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getBoardList(@RequestBody BbsMngVO vo) throws Exception {
		logger.debug("BbsMngController getBoardList start!!");
		Map<String, Object> returnData = new HashMap<String, Object>();
		returnData.put("boardList", bbsMngService.getBoardList(vo));
		logger.debug("BbsMngController getBoardList end!!");
		return new ResponseVO(returnData);
	}
	
	/**
	 * 게시판 타입 조회
	 * @return
	 * @param map
	 * @throws Exception
	 */
	@RequestMapping(value = "/getBoardType", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getBoardType(@RequestBody BbsMngVO vo) throws Exception {
		logger.debug("BbsMngController getBoardType start!!");
		Map<String, Object> returnData = new HashMap<String, Object>();
		returnData.put("boardList", bbsMngService.getBoardType(vo));
		
		logger.debug("BbsMngController getBoardType end!!");
		return new ResponseVO(returnData);
	}
	
	/**
	 * 게시판 상세 조회
	 * @return
	 * @param map
	 * @throws Exception
	 *//*
	@RequestMapping(value = "/boardDetail", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO boardDetail(@RequestBody BbsMngVO vo) throws Exception {
		logger.debug("BbsMngController boardDetail start!!");
		
		Map<String, Object> returnData = new HashMap<String, Object>();
		returnData.put("boardDetail", bbsMngService.getBoardDetail(vo));
		
		logger.debug("BbsMngController boardDetail end!!");
		return new ResponseVO(returnData);
	}
*/	
	/**
	 * 게시판 추가
	 * @return
	 * @param map
	 * @throws Exception
	 */
	@RequestMapping(value = "/insertBoardManage", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO inserBoardManage(@RequestBody BbsMngVO vo) throws Exception {
		logger.debug("BbsMngController insertBoardManage start!!");
		
		Map<String, Object> returnData = new HashMap<String, Object>();
		bbsMngService.insertBoardManage(vo);
		
		logger.debug("BbsMngController insertBoardManage end!!");
		return new ResponseVO(returnData);
	}
	
	/**
	 * 게시판 수정
	 * @return
	 * @param map
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateBoardManage", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO updateBoardManage(@RequestBody BbsMngVO vo) throws Exception {
		logger.debug("BbsMngController updateBoardManage start!!");
		
		Map<String, Object> returnData = new HashMap<String, Object>();
		bbsMngService.updateBoardManage(vo);
		
		logger.debug("BbsMngController updateBoardManage end!!");
		return new ResponseVO(returnData);
	}
	
	/**
	 * 게시판 삭제
	 * @return
	 * @param map
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteBoardManage", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO deleteBoardManage(@RequestBody BbsMngVO vo) throws Exception {
		logger.debug("BbsMngController deleteBoardManage start!!");
		
		Map<String, Object> returnData = new HashMap<String, Object>();
		bbsMngService.deleteBoardManage(vo);
		
		logger.debug("BbsMngController deleteBoardManage end!!");
		return new ResponseVO(returnData);
	}
}