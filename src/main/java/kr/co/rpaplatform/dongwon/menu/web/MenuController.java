/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 6. 2.         LSH
 */
package kr.co.rpaplatform.dongwon.menu.web;

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
import kr.co.rpaplatform.dongwon.menu.service.MenuService;
import kr.co.rpaplatform.dongwon.menu.vo.MenuVO;

/**
 * 메뉴 컨트롤러 클래스
 * @author LSH
 * 2020. 6. 2.
 */
@Controller
@RequestMapping("/menu/menumng")
public class MenuController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(MenuController.class);
	
	@Resource(name="menuService")
	private MenuService menuService;
	
	/**
	 * 메뉴 관리 페이지
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value = "/menuMngMain", method = RequestMethod.GET)
	public ModelAndView menuMngMain() throws Exception {
		ModelAndView mav = new ModelAndView("/menu/menumng/menuMngMain");
		return mav;
	}
	
	/**
	 * 전체 메뉴 리스트
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectMenuList", method = RequestMethod.GET)
	@ResponseBody
	public ResponseVO selectMenuList() throws Exception {
		logger.debug("MenuController selectMenuList started !!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		resultData.put("menuList", menuService.selectMenuList());
		
		logger.debug("MenuController selectMenuList end !!!");
		
		return new ResponseVO(resultData);
	}
	
	/**
	 * 메뉴 상세 정보
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/menuDetail", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO menuDetail(@RequestBody MenuVO vo) throws Exception {
		logger.debug("MenuController menuDetail started !!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		resultData.put("menuDetail", menuService.selectMenuDetail(vo));
		
		logger.debug("MenuController menuDetail end !!!");
		
		return new ResponseVO(resultData);
	}
	
	/**
	 * 메뉴 수정
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/menuUpdate", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO menuUpdate(@RequestBody MenuVO vo) throws Exception {
		logger.debug("MenuController menuUpdate started !!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		menuService.updateMenu(vo);
		
		logger.debug("MenuController menuUpdate end !!!");
		
		return new ResponseVO(resultData);
	}
	
	/**
	 * 메뉴 삭제
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/menuDelete", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO menuDelete(@RequestBody MenuVO vo) throws Exception {
		logger.debug("MenuController menuDelete started !!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		menuService.deleteMenu(vo);
		
		logger.debug("MenuController menuDelete end !!!");
		
		return new ResponseVO(resultData);
	}
	
	/**
	 * 메뉴 정렬 순서 변경
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/menuUpdateOrdr", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO menuUpdateOrdr(@RequestBody MenuVO vo) throws Exception {
		logger.debug("MenuController menuUpdateOrdr started !!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		menuService.updateOrdrMenu(vo);
		
		logger.debug("MenuController menuUpdateOrdr end !!!");
		
		return new ResponseVO(resultData);
	}
	
}
