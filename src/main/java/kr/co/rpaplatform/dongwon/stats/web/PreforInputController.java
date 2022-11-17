/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 6. 10.         LSH
 */
package kr.co.rpaplatform.dongwon.stats.web;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.rpaplatform.common.vo.ResponseVO;
import kr.co.rpaplatform.dongwon.stats.service.PreforInputService;

/**
 * 실적계획입력  Controller
 * @author LSH
 * 2020. 6. 10.
 */
@Controller
@RequestMapping("/stats/perforInput")
public class PreforInputController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(PreforInputController.class);
	
	
	@Resource(name="preforInputService")
	private PreforInputService preforInputService;
	
	
	/**
	 * 실적계획입력 메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/perforInputMain")
	public ModelAndView perforInputMain() throws Exception {
		return new ModelAndView("/stats/perforInput/perforInputMain");
	}
	

	/**
	 * 실적계획입력 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getPreforList")
	@ResponseBody
	public ResponseVO getPreforList(@RequestBody Map<String, Object> params) throws Exception {
        Map<String, Object> returnMap = preforInputService.getPreforList(params);
		return new ResponseVO(returnMap);
	}
	
	
	/**
	 * 실적계획입력 저장
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/updatePrefor")
	@ResponseBody
	public ResponseVO updatePrefor(@RequestBody Map<String, Object> params) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		preforInputService.updatePrefor(params);
		return new ResponseVO(returnMap);
	}
	

}
