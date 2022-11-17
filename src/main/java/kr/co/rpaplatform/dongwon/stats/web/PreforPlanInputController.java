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

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
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
import kr.co.rpaplatform.dongwon.stats.service.PreforPlanInputService;

/**
 * 실적계획입력  Controller
 * @author LSH
 * 2020. 6. 10.
 */
@Controller
@RequestMapping("/stats/perforPlanInput")
public class PreforPlanInputController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(PreforPlanInputController.class);
	
	
	@Resource(name="preforPlanInputService")
	private PreforPlanInputService preforPlanInputService;
	
	
	/**
	 * 실적계획입력 메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/perforPlanInputMain")
	public ModelAndView perforPlanInputMain() throws Exception {
		return new ModelAndView("/stats/perforPlanInput/perforPlanInputMain");
	}
	

	/**
	 * 실적계획입력 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getPreforPlanList")
	@ResponseBody
	public ResponseVO getPreforPlanList(@RequestBody Map<String, Object> params) throws Exception {
        Map<String, Object> returnMap = preforPlanInputService.getPreforPlanList(params);
		return new ResponseVO(returnMap);
	}
	
	
	/**
	 * 실적계획입력 저장
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/updatePreforPlan")
	@ResponseBody
	public ResponseVO updatePreforPlan(@RequestBody Map<String, Object> params) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		preforPlanInputService.updatePreforPlan(params);
		return new ResponseVO(returnMap);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
