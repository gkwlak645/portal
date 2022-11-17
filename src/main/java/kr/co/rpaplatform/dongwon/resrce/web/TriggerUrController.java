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
import kr.co.rpaplatform.dongwon.resrce.service.RobotService;
import kr.co.rpaplatform.dongwon.resrce.service.TriggerUrService;
import kr.co.rpaplatform.dongwon.resrce.vo.RobotVO;

/**
 * 로봇 컨트롤러
 * @author LSH
 * 2020. 6. 5.
 */
@Controller
@RequestMapping("/resrce/triggerUr")
public class TriggerUrController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(TriggerUrController.class);
	
	/**
	 * 로봇 서비스
	 */
	@Resource(name="triggerUrService")
	private TriggerUrService triggerUrService;
	
	/**
	 * 로봇관리 메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/triggerUrMain")
	public ModelAndView robotMngMain() throws Exception {
		return new ModelAndView("/resrce/triggerUr/triggerUrMain");
	}
	
	
	/**
	 * Trigger(UR) 메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectTriggerUrList")
	@ResponseBody
	public ResponseVO selectTriggerUrList(@RequestBody Map<String, Object> map, HttpServletRequest request) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		CmmnUserVO cmmnUserVO = (CmmnUserVO)request.getSession().getAttribute("sessionUserInfo");
		map.put("cmpnyCd", cmmnUserVO.getTxCmpnyCd());
		
		Map<String, Object> mResult = triggerUrService.selectTriggerUrList(map);
		returnMap.put("paginationInfo", PaginationUtil.getPaginationInfo(map, Integer.parseInt(mResult.get("@odata.count").toString())));
		returnMap.put("resultList", mResult.get("value"));
		return new ResponseVO(returnMap);
	}
	
	/**
	 * Trigger(UR) 사용/사용안함
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/setEnabled")
	@ResponseBody
	public ResponseVO setEnabled(@RequestBody Map<String, Object> map, HttpServletRequest request) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		CmmnUserVO cmmnUserVO = (CmmnUserVO)request.getSession().getAttribute("sessionUserInfo");
		map.put("cmpnyCd", cmmnUserVO.getTxCmpnyCd());
		
		Map<String, Object> mResult = triggerUrService.setEnabled(map);
		return new ResponseVO(returnMap);
	}
	
	
	@RequestMapping(value = "/deleteProcessSchedules")
	@ResponseBody
	public ResponseVO deleteProcessSchedules(@RequestBody Map<String, Object> map, HttpServletRequest request) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		CmmnUserVO cmmnUserVO = (CmmnUserVO)request.getSession().getAttribute("sessionUserInfo");
		map.put("cmpnyCd", cmmnUserVO.getTxCmpnyCd());
		
		Map<String, Object> mResult = triggerUrService.deleteProcessSchedules(map);
		return new ResponseVO(returnMap);
	}

	
	@RequestMapping(value = "/triggerUrRegisterPop")
	public ModelAndView triggerUrRegisterPop() throws Exception {
		return new ModelAndView("/resrce/triggerUr/triggerUrRegisterPop");
	}
	
	@RequestMapping(value = "/searchReleases")
	@ResponseBody
	public ResponseVO searchReleases(@RequestBody Map<String, Object> map, HttpServletRequest request) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		CmmnUserVO cmmnUserVO = (CmmnUserVO)request.getSession().getAttribute("sessionUserInfo");
		map.put("cmpnyCd", cmmnUserVO.getTxCmpnyCd());
		
		Map<String, Object> mResult = triggerUrService.searchReleases(map);
		returnMap.put("paginationInfo", PaginationUtil.getPaginationInfo(map, Integer.parseInt(mResult.get("@odata.count").toString())));
		returnMap.put("resultList", mResult.get("value"));
		return new ResponseVO(returnMap);
	}
	
	@RequestMapping(value = "/searchCalendars")
	@ResponseBody
	public ResponseVO searchCalendars(@RequestBody Map<String, Object> map, HttpServletRequest request) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		CmmnUserVO cmmnUserVO = (CmmnUserVO)request.getSession().getAttribute("sessionUserInfo");
		map.put("cmpnyCd", cmmnUserVO.getTxCmpnyCd());
		
		Map<String, Object> mResult = triggerUrService.searchCalendars(map);
		returnMap.put("paginationInfo", PaginationUtil.getPaginationInfo(map, Integer.parseInt(mResult.get("@odata.count").toString())));
		returnMap.put("resultList", mResult.get("value"));
		return new ResponseVO(returnMap);
	}
	
	@RequestMapping(value = "/searchEnvironmentRobots")
	@ResponseBody
	public ResponseVO searchEnvironmentRobots(@RequestBody Map<String, Object> map, HttpServletRequest request) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		CmmnUserVO cmmnUserVO = (CmmnUserVO)request.getSession().getAttribute("sessionUserInfo");
		map.put("cmpnyCd", cmmnUserVO.getTxCmpnyCd());
		
		Map<String, Object> mResult = triggerUrService.searchEnvironmentRobots(map);
		returnMap.put("paginationInfo", PaginationUtil.getPaginationInfo(map, Integer.parseInt(mResult.get("@odata.count").toString())));
		returnMap.put("resultList", mResult.get("value"));
		return new ResponseVO(returnMap);
	}
	
	@RequestMapping(value = "/searchTimezones")
	@ResponseBody
	public ResponseVO searchTimezones(@RequestBody Map<String, Object> map, HttpServletRequest request) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		CmmnUserVO cmmnUserVO = (CmmnUserVO)request.getSession().getAttribute("sessionUserInfo");
		map.put("cmpnyCd", cmmnUserVO.getTxCmpnyCd());
		
		Map<String, Object> mResult = triggerUrService.searchTimezones(map);
		returnMap.put("resultList", mResult.get("Items"));
		return new ResponseVO(returnMap);
	}
	
	@RequestMapping(value = "/searchQueueDefinitions")
	@ResponseBody
	public ResponseVO searchQueueDefinitionsCallback(@RequestBody Map<String, Object> map, HttpServletRequest request) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		CmmnUserVO cmmnUserVO = (CmmnUserVO)request.getSession().getAttribute("sessionUserInfo");
		map.put("cmpnyCd", cmmnUserVO.getTxCmpnyCd());
		
		Map<String, Object> mResult = triggerUrService.searchQueueDefinitions(map);
		returnMap.put("resultList", mResult.get("value"));
		return new ResponseVO(returnMap);
	}
	
	@RequestMapping(value = "/insertProcessSchedules")
	@ResponseBody
	public ResponseVO insertProcessSchedules(@RequestBody Map<String, Object> map, HttpServletRequest request) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		CmmnUserVO cmmnUserVO = (CmmnUserVO)request.getSession().getAttribute("sessionUserInfo");
		map.put("cmpnyCd", cmmnUserVO.getTxCmpnyCd());
		
		
		Map<String, Object> mResult = triggerUrService.insertProcessSchedules(map);
		
		return new ResponseVO(returnMap);
	}
	
	@RequestMapping(value = "/triggerUrInstantStartPop")
	public ModelAndView triggerUrInstantStartPop() throws Exception {
		return new ModelAndView("/resrce/triggerUr/triggerUrInstantStartPop");
	}
	
	@RequestMapping(value = "/searchInstantStartEnvironmentRobots")
	@ResponseBody
	public ResponseVO searchInstantStartEnvironmentRobots(@RequestBody Map<String, Object> map, HttpServletRequest request) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		CmmnUserVO cmmnUserVO = (CmmnUserVO)request.getSession().getAttribute("sessionUserInfo");
		map.put("cmpnyCd", cmmnUserVO.getTxCmpnyCd());
		
		Map<String, Object> mResult = triggerUrService.searchInstantStartEnvironmentRobots(map);
		returnMap.put("paginationInfo", PaginationUtil.getPaginationInfo(map, Integer.parseInt(mResult.get("@odata.count").toString())));
		returnMap.put("resultList", mResult.get("value"));
		return new ResponseVO(returnMap);
	}
	
	@RequestMapping(value = "/triggerUrInsertInstantStart")
	@ResponseBody
	public ResponseVO triggerUrInsertInstantStart(@RequestBody Map<String, Object> map, HttpServletRequest request) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		CmmnUserVO cmmnUserVO = (CmmnUserVO)request.getSession().getAttribute("sessionUserInfo");
		map.put("cmpnyCd", cmmnUserVO.getTxCmpnyCd());
		
		
		Map<String, Object> mResult = triggerUrService.triggerUrInsertInstantStart(map);
		
		return new ResponseVO(returnMap);
	}
	
	@RequestMapping(value = "/triggerUrDetailTimePop")
	public ModelAndView triggerUrDetailTimePop() throws Exception {
		return new ModelAndView("/resrce/triggerUr/triggerUrDetailTimePop");
	}
	
	@RequestMapping(value = "/getProcessSchedules")
	@ResponseBody
	public ResponseVO getProcessSchedules(@RequestBody Map<String, Object> map, HttpServletRequest request) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		CmmnUserVO cmmnUserVO = (CmmnUserVO)request.getSession().getAttribute("sessionUserInfo");
		map.put("cmpnyCd", cmmnUserVO.getTxCmpnyCd());
		
		Map<String, Object> mResult = triggerUrService.getProcessSchedules(map);
		
		return new ResponseVO(mResult);
	}
	
	@RequestMapping(value = "/getRobotIdsForProcessSchedules")
	@ResponseBody
	public ResponseVO getRobotIdsForProcessSchedules(@RequestBody Map<String, Object> map, HttpServletRequest request) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		CmmnUserVO cmmnUserVO = (CmmnUserVO)request.getSession().getAttribute("sessionUserInfo");
		map.put("cmpnyCd", cmmnUserVO.getTxCmpnyCd());
		
		Map<String, Object> mResult = triggerUrService.getRobotIdsForProcessSchedules(map);
		
		return new ResponseVO(mResult);
	}
	
	
	@RequestMapping(value = "/updateProcessSchedules")
	@ResponseBody
	public ResponseVO updateProcessSchedules(@RequestBody Map<String, Object> map, HttpServletRequest request) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		CmmnUserVO cmmnUserVO = (CmmnUserVO)request.getSession().getAttribute("sessionUserInfo");
		map.put("cmpnyCd", cmmnUserVO.getTxCmpnyCd());
		
		Map<String, Object> mResult = triggerUrService.updateProcessSchedules(map);
		return new ResponseVO(returnMap);
	}
	
	@RequestMapping(value = "/triggerUrDetailQueuePop")
	public ModelAndView triggerUrDetailQueuePop() throws Exception {
		return new ModelAndView("/resrce/triggerUr/triggerUrDetailQueuePop");
	}
	
}
