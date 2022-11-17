/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 6. 5.         LSH
 */
package kr.co.rpaplatform.dongwon.mntrng.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.rpaplatform.common.pagination.PaginationInfo;
import kr.co.rpaplatform.common.vo.ResponseVO;

import kr.co.rpaplatform.dongwon.common.util.PaginationUtil;
import kr.co.rpaplatform.dongwon.common.vo.CmmnUserVO;
import kr.co.rpaplatform.dongwon.mntrng.service.JobService;
import kr.co.rpaplatform.dongwon.mntrng.service.ResveArService;
import kr.co.rpaplatform.dongwon.resrce.service.RobotService;
import kr.co.rpaplatform.dongwon.resrce.service.TriggerArService;
import kr.co.rpaplatform.dongwon.resrce.service.TriggerUrService;
import kr.co.rpaplatform.dongwon.resrce.vo.RobotVO;

/**
 * 로봇 컨트롤러
 * @author LSH
 * 2020. 6. 5.
 */
@Controller
@RequestMapping("/resrce/resveAr")
public class ResveArController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(ResveArController.class);
	
	/**
	 * 작업 서비스
	 */
	@Resource(name="resveArService")
	private ResveArService resveArService;
	
	
	/**
	 *  메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/resveArMain")
	public ModelAndView triggerArMain() throws Exception {
		return new ModelAndView("/mntrng/resveAr/resveArMain");
	}
	
	/**
	 * 예약작업 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getResveList")
	@ResponseBody
	public ResponseVO getResveJobList(@RequestBody Map<String, Object> map) throws Exception {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();

		//디바이스 리스트 카운트 조회
		int totalRecordCount = resveArService.getResveArCount(map);
		
		if (totalRecordCount > 0) {
		
			//페이징 정보 조회
			PaginationInfo paginationInfo = PaginationUtil.getPaginationInfo(map, totalRecordCount);
			
			//조회조건에 페이징 정보 설정
			map.put("paginationInfo", PaginationUtil.getPaginationInfo(map, totalRecordCount));
	
			//디바이스 리스트 조회
			List<Map<String, Object>> resultList = resveArService.getResveArList(map);
	
			//결과값 설정
			returnMap.put("resultList", resultList);
			returnMap.put("paginationInfo", paginationInfo);
			
		} else {
			
			//결과값 설정
			returnMap.put("resultList", null);
			returnMap.put("paginationInfo", PaginationUtil.getPaginationInfo(map, 0));
			
		}
		
		return new ResponseVO(returnMap);
	}
	
	/**
	 * 예약 삭제
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/delResveAr")
	@ResponseBody
	public ResponseVO delResveAr(@RequestBody Map<String, Object> map) throws Exception {
		resveArService.delResveAr(map);
		return new ResponseVO();
	}
	
		
}
