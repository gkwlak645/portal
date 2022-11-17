/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 6. 8.         LSH
 */
package kr.co.rpaplatform.dongwon.resrce.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.sun.mail.iap.Response;

import kr.co.rpaplatform.common.exception.RpaException;
//import kr.co.rpaplatform.dongwon.cmmnty.vo.BbsQnaVO;
import kr.co.rpaplatform.dongwon.resrce.dao.RobotDAO;
import kr.co.rpaplatform.dongwon.resrce.vo.RobotVO;
import kr.co.rpaplatform.rpaapi.uipath.api.HostLicenseApi;
import kr.co.rpaplatform.rpaapi.uipath.api.PackageApi;
import kr.co.rpaplatform.rpaapi.uipath.api.RobotApi;
import kr.co.rpaplatform.rpaapi.uipath.api.TriggerUrApi;

/**
 * 로봇 서비스
 * @author LSH
 * 2020. 6. 8.
 */
@Service
public class TriggerUrService {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(TriggerUrService.class);
	
	/**
	 * API
	 */
	@Resource(name="triggerUrApi")
	private TriggerUrApi triggerUrApi;
	
	public Map<String, Object> selectTriggerUrList(Map<String, Object> map) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		returnMap = triggerUrApi.selectTriggerUrList(map);
		
		return returnMap;
	}

	
	public Map<String, Object> setEnabled(Map<String, Object> map) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		returnMap = triggerUrApi.setEnabled(map);
		
		return returnMap;
	}
	
	public Map<String, Object> deleteProcessSchedules(Map<String, Object> map) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		returnMap = triggerUrApi.deleteProcessSchedules(map);
		return returnMap;
	}
	
	public Map<String, Object> searchReleases(Map<String, Object> map) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		returnMap = triggerUrApi.searchReleases(map);
		return returnMap;
	}
	
	public Map<String, Object> searchCalendars(Map<String, Object> map) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		returnMap = triggerUrApi.searchCalendars(map);
		return returnMap;
	}
	
	public Map<String, Object> searchEnvironmentRobots(Map<String, Object> map) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		returnMap = triggerUrApi.searchEnvironmentRobots(map);
		return returnMap;
	}
	
	public Map<String, Object> searchTimezones(Map<String, Object> map) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		returnMap = triggerUrApi.searchTimezones(map);
		return returnMap;
	}
	
	public Map<String, Object> searchQueueDefinitions(Map<String, Object> map) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		returnMap = triggerUrApi.searchQueueDefinitions(map);
		return returnMap;
	}
	
	public Map<String, Object> insertProcessSchedules(Map<String, Object> map) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		returnMap = triggerUrApi.insertProcessSchedules(map);
		return returnMap;
	}
	
	public Map<String, Object> searchInstantStartEnvironmentRobots(Map<String, Object> map) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		returnMap = triggerUrApi.searchInstantStartEnvironmentRobots(map);
		return returnMap;
	}
	
	public Map<String, Object> triggerUrInsertInstantStart(Map<String, Object> map) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		returnMap = triggerUrApi.triggerUrInsertInstantStart(map);
		return returnMap;
	}
	
	public Map<String, Object> getProcessSchedules(Map<String, Object> map) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		returnMap = triggerUrApi.getProcessSchedules(map);
		return returnMap;
	}
	
	public Map<String, Object> getRobotIdsForProcessSchedules(Map<String, Object> map) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		returnMap = triggerUrApi.getRobotIdsForProcessSchedules(map);
		return returnMap;
	}
	
	public Map<String, Object> updateProcessSchedules(Map<String, Object> map) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		returnMap = triggerUrApi.updateProcessSchedules(map);
		return returnMap;
	}
}


