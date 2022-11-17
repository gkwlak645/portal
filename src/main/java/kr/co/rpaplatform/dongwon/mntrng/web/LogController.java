/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 6. 16.         LSH
 */
package kr.co.rpaplatform.dongwon.mntrng.web;

import java.util.HashMap;
import java.util.List;
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

import kr.co.rpaplatform.common.pagination.PaginationInfo;
import kr.co.rpaplatform.common.vo.ResponseVO;
import kr.co.rpaplatform.dongwon.common.util.PaginationUtil;
import kr.co.rpaplatform.dongwon.mntrng.service.LogService;
import kr.co.rpaplatform.dongwon.resrce.web.DeviceController;

/**
 * 로그 컨트롤러
 * @author LSH
 * 2020. 6. 16.
 */
@Controller
@RequestMapping("/mntrng/logmntrng")
public class LogController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(DeviceController.class);
	
	/**
	 * 로그 서비스
	 */
	@Resource(name="logService")
	private LogService logService;
	
	
	/**
	 * 로그모니터링 메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/logMntrngMain")
	public ModelAndView logMntrngMngMain() throws Exception {
		return new ModelAndView("/mntrng/logmntrng/logMntrngMain");
	}
	
	/**
	 * 로그 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getLogList")
	@ResponseBody
	public ResponseVO getLogList(@RequestBody Map<String, Object> map) throws Exception {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();

		//디바이스 리스트 카운트 조회
		int totalRecordCount = logService.getLogCount(map);
		
		if (totalRecordCount > 0) {
		
			//페이징 정보 조회
			PaginationInfo paginationInfo = PaginationUtil.getPaginationInfo(map, totalRecordCount);
			
			//조회조건에 페이징 정보 설정
			map.put("paginationInfo", PaginationUtil.getPaginationInfo(map, totalRecordCount));
	
			//디바이스 리스트 조회
			List<Map<String, Object>> resultList = logService.getLogList(map);
	
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

}
