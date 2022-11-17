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
import kr.co.rpaplatform.rpaapi.uipath.api.RobotApi;

/**
 * 로봇 서비스
 * @author LSH
 * 2020. 6. 8.
 */
@Service
public class RobotService {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(RobotService.class);

	/**
	 * 로봇 DAO
	 */
	@Resource(name="robotDAO")
	private RobotDAO robotDAO;
	
	/**
	 * 로봇 API
	 */
	@Resource(name="robotApi")
	private RobotApi robotApi;

	/**
	 * 로봇 API
	 */
	@Resource(name="hostLicenseApi")
	private HostLicenseApi hostLicenseApi;
	
	/**
	 * 로봇 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getRobotList(Map<String, Object> map) throws Exception {
		return robotDAO.selectRobotList(map);
	}
	
	/**
	 * 로봇 리스트 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int getRobotCount(Map<String, Object> map) throws Exception {
		return robotDAO.selectRobotCount(map);
	}

	/**
	 * 로봇 등록
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> registerRobot(Map<String, Object> map) throws Exception {
		logger.debug("RobotService registerRobot start!!");
		
		logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@service id11111: " + map.get("Id"));
		logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ map: " + map);
		
		
		// RobotIp 넘길시 api 오류 발생		
		String Ip = map.get("RobotIp").toString(); 
		map.remove("RobotIp");
		String Pw = "";
		if(map.get("Password") != null && !"".equals(map.get("Password"))) {
			// pw 안보이는 문제로 따로 값 저장
			Pw = map.get("Password").toString();
		}
		
		Map<String, Object> cmpny = new HashMap<String, Object>();
		
		//-------------cmpnyCd -> tenantId 변환-----------------------
		
		String cmpnyCd = map.get("cmpnyCd").toString();
		cmpny.put("cmpnyCd", cmpnyCd);
		
		Map<String, Object> resultMapTenant = robotDAO.selectTenant(cmpny);
		
		//-------------cmpnyCd -> tenantId 변환-----------------------
		
		Map<String, Object> tenant = new HashMap<String, Object>();
		
		//----------------------license 개수 조회-----------------------
		
		String tenantId = resultMapTenant.get("TENANT_ID").toString();
		tenant.put("tenantId", tenantId);
		tenant.put("cmpnyCd", "W");
		Map<String, Object> response = hostLicenseApi.getHostLicense(tenant);
		
		Map<String, Object> allowed = (Map<String, Object>) response.get("Allowed");
		Map<String, Object> used = (Map<String, Object>) response.get("Used");
		String TypeText = map.get("TypeText").toString();
		
		if(TypeText.equalsIgnoreCase("Studio") ) {
			TypeText = "Development";
		}
		
		int allowedCnt = Integer.parseInt(allowed.get(TypeText).toString());
		int usedCnt = Integer.parseInt(used.get(TypeText).toString());
		map.remove("TypeText");
		
		//----------------------license 개수 조회-----------------------
		
		Map<String, Object> resultMap = null;
		if(usedCnt < allowedCnt) {
			resultMap = robotApi.registerRobot(map);
		} else {
			throw new RpaException("E00006", "사용 가능한 로봇이 없습니다.\n라이선스를 업데이트하십시오.");
		}
		
		
		logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@service id222222: " + resultMap.get("Id"));
		logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@resultMap: " + resultMap);
		
		resultMap.put("Ip", Ip);
		resultMap.put("Dc", map.get("Description"));
		resultMap.put("Pw", Pw);
		
				
		robotDAO.insertRobot(resultMap);
		 
		logger.debug("RobotService registerRobot end!!");		
		
		return resultMap;
		 	 		 
	}
		
	
	/**
	 * 로봇 상세화면 정보 조회
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public RobotVO robotDetailSelectPage(RobotVO vo) throws Exception {
		return robotDAO.robotDetailSelectPage(vo);
	}
	
	/**
	 * 로봇 삭제
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> deleteRobot(Map<String, Object> map) throws Exception {
		return robotApi.deleteRobot(map);
	}
	
	/**
	 * 로봇 수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void updateRobot(Map<String, Object> map) throws Exception {
		    
		
		logger.debug("updateRobot @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ map: " + map);
	    
		
		// RobotIp 넘길시 api 오류 발생		
		String Ip = map.get("RobotIp").toString(); 
		map.remove("RobotIp");
		// pw 안보이는 문제로 따로 값 수정
		String Pw = map.get("Password").toString();
		
		
	    robotApi.updateRobot(map);
	    
	    map.put("Ip", Ip);
	    map.put("PW", Pw);
	    
		robotDAO.updateRobot(map);								
		
		
	}
	
	/**
	 * 로봇명 중복 체크
	 * @param String
	 * @return
	 * @throws Exception
	 */
	public String idDplctCheck(RobotVO vo) throws Exception{
		
		String res;
		 
		 System.out.println("넘어오는 값 :" + robotDAO.idDplctCheck(vo));
		if(robotDAO.idDplctCheck(vo) > 0) {
			res = "Y";
		}else {
			res = "N";
		}
		System.out.println("res 값 :" + res);
		return res;
	}

	
	
/*	*//**
	 * 로봇 등록
	 * @param map
	 * @return
	 * @throws Exception
	 *//*
	public Map<String, Object> registerRobot(Map<String, Object> map) throws Exception {
		logger.debug("RobotService registerRobot start!!");
		
		
		
		logger.debug("RobotService registerRobot end!!");
		return robotApi.registerRobot(map);
				
		
	}*/
	
	
	/**
	 * 로봇 수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
/*	public Map<String, Object> updateRobot(Map<String, Object> map) throws Exception {		
		
		return robotApi.updateRobot(map);
	}*/
	
	
}


