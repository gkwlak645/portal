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

import kr.co.rpaplatform.dongwon.resrce.dao.DeviceDAO;
import kr.co.rpaplatform.dongwon.resrce.vo.DeviceVO;
import kr.co.rpaplatform.rpaapi.uipath.api.DeviceApi;

/**
 * 디바이스 서비스
 * @author LSH
 * 2020. 6. 8.
 */
@Service
public class DeviceService {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(DeviceService.class);

	/**
	 * 디바이스 DAO
	 */
	@Resource(name="deviceDAO")
	private DeviceDAO deviceDAO;
	
	/**
	 * 디바이스 API
	 */
	@Resource(name="deviceApi")
	private DeviceApi deviceApi;

	/**
	 * 디바이스 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getDeviceList(Map<String, Object> map) throws Exception {
		return deviceDAO.selectDeviceList(map);
	}
	
	/**
	 * 디바이스 리스트 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int getDeviceCount(Map<String, Object> map) throws Exception {
		return deviceDAO.selectDeviceCount(map);
	}

	/**
	 * 디바이스 등록
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> registerDevice(Map<String, Object> map) throws Exception {
		logger.debug("DeviceService registerDevice start!!!!!!");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = deviceApi.registerDevice(map);
		logger.debug("DeviceService registerDevice end!!!!!!");
		return resultMap;
	}

	/**
	 * 디바이스 삭제
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> deleteDevice(Map<String, Object> map) throws Exception {
		return deviceApi.deleteDevice(map);
	}
	
	/**
	 * 디바이스 상세화면 정보 조회
	 * @param DeviceVO
	 * @return
	 * @throws Exception
	 */
	public DeviceVO deviceDetailSelectPage(DeviceVO vo) throws Exception {
		return deviceDAO.deviceDetailSelectPage(vo);
	}
	
	/**
	 * 디바이스 수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> updateDevice(Map<String, Object> map) throws Exception {
		return deviceApi.updateDevice(map);
	}
	
	/**
	 * 디바이스 목록 검색, 로봇 등록 화면에 이용
	 * @return map
	 * @throws Exception
	 */
	public List<Map<String, Object>> getDeviceNameList(Map<String, Object> map) throws Exception {
		return deviceDAO.getDeviceNameList(map);
	}
	
}
