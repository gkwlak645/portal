/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 6. 5.         LSH
 */
package kr.co.rpaplatform.dongwon.resrce.web;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

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
import kr.co.rpaplatform.dongwon.common.vo.CmmnUserVO;
import kr.co.rpaplatform.dongwon.resrce.service.LicenseService;
import kr.co.rpaplatform.dongwon.resrce.vo.LicenseVO;



/**
 * 로봇 컨트롤러
 * @author JYJ
 * 2020. 8. 26.
 */
@Controller
@RequestMapping("/resrce/license")
public class LicenseController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(LicenseController.class);
	
	/**
	 * 라이선스 서비스
	 */
	@Resource(name="licenseService")
	private LicenseService licenseService;
	
	/**
	 * 라이선스관리 메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/licenseMngMain")
	public ModelAndView licenseMngMain() throws Exception {
		return new ModelAndView("/resrce/license/licenseMngMain");
	}

	/**
	 * 라이선스관리 조회
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getLicenseList")
	@ResponseBody
	public ResponseVO getLicenseList(@RequestBody Map<String, Object> map, HttpServletRequest request) throws Exception {
		logger.debug("LicenseController getLicenseList start!!");
		
		logger.debug("#############map data 넘어오는 값##############"+ map);	 
		
		CmmnUserVO cmmnUserVO = (CmmnUserVO)request.getSession().getAttribute("sessionUserInfo");
		
		String cmpnyCd = cmmnUserVO.getTxCmpnyCd();
		map.put("cmpnyCd", "W");
		
		Map<String, Object> returnMap = new HashMap<String, Object>();		
		Map<String, Object> resultList = licenseService.getLicenseList(map);
		returnMap.put("resultList", resultList.get("value"));
		returnMap.put("license Type", map );
		
				
		logger.debug("LicenseController getLicenseList end!!");
		return new ResponseVO(returnMap);
	}
	/**
	 * 활성아이디 조회
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getLicenseInfo")
	@ResponseBody
	public ResponseVO getLicenseinfo(@RequestBody LicenseVO vo) throws Exception {
		
		LicenseVO result = licenseService.getLicenseInfo(vo);
		
		return new ResponseVO(result);
	}

	/**
	 * 라이선스 상세 화면
	 * @throws Exception
	 */
	@RequestMapping(value="/licenseDetailPagePop")
	public ModelAndView licenseDetailPagePop() throws Exception {
		return new ModelAndView("/resrce/license/licenseDetailPagePop");
	}
	
	
	/**
	 * 라이선스 상세 조회 API
	 * @return
	 * @throws Exception
	 */	
	@RequestMapping(value = "/getLicenseDetailList")
	@ResponseBody
	public ResponseVO getLicenseDetail(@RequestBody Map<String, Object> map) throws Exception{
		logger.debug("LicenseController getLicenseDetail start!!");
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		Map<String, Object> resultList = licenseService.getLicenseDetailList(map);
		
		logger.debug("map.getvalue"+resultList.values());
		//returnMap.put("resultList", resultList);
		
		logger.debug("#############resultList##############"+resultList);
		logger.debug("#############returnMap##############"+returnMap);	 
		logger.debug("#############val##############"+resultList.get("value"));
		
		List<Map> val = (List<Map>) resultList.get("value");
		
		
		for (Map valMap : val) {
			logger.debug("#############vvalMap##############"+valMap);
		}
		
	
		
		returnMap.put("resultList", val);
	
		logger.debug("LicenseController getLicenseDetail end!!");
		return new ResponseVO(returnMap);			
	}
	
	
	
	/**
	 * 라이선스 상세 조회 API
	 * @return
	 * @throws Exception
	 */	
	@RequestMapping(value = "/getLicenseDetailList2")
	@ResponseBody
	public ResponseVO getLicenseDetail2(@RequestBody Map<String, Object> map) throws Exception{
		logger.debug("LicenseController getLicenseDetail start!!");
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		Map<String, Object> resultList = licenseService.getLicenseDetailList2(map);
		
		logger.debug("&&&&&&&&&&map&&&&&&&&&&&&&"+resultList.values());
		logger.debug("resultList.values"+resultList.values());
		//returnMap.put("resultList", resultList);
		
		logger.debug("#############resultList##############"+resultList);
		logger.debug("#############returnMap##############"+returnMap);	 
		logger.debug("#############SlotType##############"+resultList.get("SlotType"));
		
		List<Map> val = (List<Map>) resultList.get("value");

		
		for (Map valMap : val) {
			logger.debug("#############vvalMap##############"+valMap);
		}
		
		
		
		returnMap.put("resultList", val);
		returnMap.put("resultSlot", resultList.get("SlotType"));
		
		
		logger.debug("LicenseController getLicenseDetail end!!");
		return new ResponseVO(returnMap);			
	}
	
	/**
	 * 라이선스 편집 상세 화면
	 * @throws Exception
	 */
	@RequestMapping(value="/licenseEditPagePop")
	public ModelAndView licenseEditPagePop() throws Exception {
		return new ModelAndView("/resrce/license/licenseEditPagePop");
	}	
	
	/**
	 * 라이선스런타임 수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateRuntime")
	@ResponseBody
	public ResponseVO updateRuntime(@RequestBody Map<String, Object> map) throws Exception {
		
		logger.debug("updateRuntime@@@@@@@@@@@@@@@@@@@@@@@" +map );
		licenseService.updateRuntime(map);
		return new ResponseVO();
	}
	
	
	
	
	
}
