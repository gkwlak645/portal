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
import kr.co.rpaplatform.dongwon.resrce.dao.TriggerArDAO;
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
public class TriggerArService {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(TriggerArService.class);
	
	@Resource(name="triggerArDAO")
	private TriggerArDAO triggerArDAO;
	
	public int getTriggerArListCount(Map<String, Object> map) throws Exception {
		return triggerArDAO.getTriggerArListCount(map);
	}
	
	public List<Map<String, Object>> selectTriggerArList(Map<String, Object> map) throws Exception {
		return triggerArDAO.selectTriggerArList(map);
	}
	
	public List<Map<String, Object>> triggerArInstantSearchReleases(Map<String, Object> map) throws Exception {
		return triggerArDAO.triggerArInstantSearchReleases(map);
	}
	
	public List<Map<String, Object>> triggerArInstantSearchRobot(Map<String, Object> map) throws Exception {
		return triggerArDAO.triggerArInstantSearchRobot(map);
	}
	
	// Trigger AR 수정 팝업창 정보를 얻기 위함
	public List<Map<String, Object>> triggerArSelectInfoForUpdate(Map<String, Object> map) throws Exception {
		return triggerArDAO.triggerArSelectInfoForUpdate(map);
	}
	
	
	// Trigger AR 수정 팝업창 정보를 얻기 위함 - 프로세스 코드로 운영 중인 프로세스 조회
	public List<Map<String, Object>> triggerArSelectProcessForUpdate(Map<String, Object> map) throws Exception {
		return triggerArDAO.triggerArSelectProcessForUpdate(map);
	}
		
	
	
	// Not Disable → Disable TB_TEMP_RESRVE_BOT 수정
	public void convertTodisableSchdule(Map<String, Object> map) throws Exception {
		triggerArDAO.convertTodisableSchdule(map);
	}
	
	// Not Disable → Disable TB_TASK_DEVLOP_PROCESS_SCHDULE 수정
	public void convertTodisableInfo(Map<String, Object> map) throws Exception {
		triggerArDAO.convertTodisableInfo(map);
	}
	
	// Disable → Not Disable TB_TEMP_RESRVE_BOT 수정
	public void convertToNotdisableSchdule(Map<String, Object> map) throws Exception {
		triggerArDAO.convertToNotdisableSchdule(map);
	}
	
	// Disable → Not Disable TB_TASK_DEVLOP_PROCESS_SCHDULE 수정
	public void convertToNotdisableInfo(Map<String, Object> map) throws Exception {
		triggerArDAO.convertToNotdisableInfo(map);
	}
	
	
	
	
	
	public void insertInstantStart(Map<String, Object> map) throws Exception {
		triggerArDAO.insertInstantStart(map);
	};
	
	public void insertResveStart(Map<String, Object> map) throws Exception {
		triggerArDAO.insertResveStart(map);
	};
	
	public String getCompareTime(Map<String, Object> map) throws Exception {
		return triggerArDAO.getCompareTime(map);
	};
}


