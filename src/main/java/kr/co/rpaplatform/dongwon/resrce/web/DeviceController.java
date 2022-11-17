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
import kr.co.rpaplatform.dongwon.resrce.service.DeviceService;
import kr.co.rpaplatform.dongwon.resrce.vo.DeviceVO;

/**
 * 디바이스 컨트롤러
 * @author LSH
 * 2020. 6. 5.
 */
@Controller
@RequestMapping("/resrce/device")
public class DeviceController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(DeviceController.class);
	
	/**
	 * 디바이스 서비스
	 */
	@Resource(name="deviceService")
	private DeviceService deviceService;
	
	/**
	 * 디바이스관리 메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/deviceMngMain")
	public ModelAndView deviceMngMain() throws Exception {
		return new ModelAndView("/resrce/device/deviceMngMain");
	}
	
	/**
	 * 디바이스 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getDeviceList", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getDeviceList(@RequestBody Map<String, Object> map) throws Exception {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();

		//디바이스 리스트 카운트 조회
		int totalRecordCount = deviceService.getDeviceCount(map);
		
		//페이징 정보 조회
		PaginationInfo paginationInfo = PaginationUtil.getPaginationInfo(map, totalRecordCount);
		
		//조회조건에 페이징 정보 설정
		map.put("paginationInfo", PaginationUtil.getPaginationInfo(map, totalRecordCount));
		
		//등록 시 중복 체크
		if(paginationInfo.getCurrentPageNo() != 0) {
			//디바이스 리스트 조회
			List<Map<String, Object>> resultList = deviceService.getDeviceList(map);
			returnMap.put("resultList", resultList);
		}

		//결과값 설정
		returnMap.put("paginationInfo", paginationInfo);
		
		return new ResponseVO(returnMap);
	}
	
	/**
	 * 디바이스관리 등록 화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/deviceRegisterPagePop")
	public ModelAndView deviceRegPop() throws Exception {
		return new ModelAndView("/resrce/device/deviceRegisterPagePop");
	}

	/**
	 * 디바이스 등록
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/registerDevice", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO registerDevice(@RequestBody Map<String, Object> map) throws Exception {
		logger.debug("DeviceController registerDevice start!!!!!!!!!!");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = deviceService.registerDevice(map);
		logger.debug("DeviceController registerDevice end!!!!!!!!!!");
		return new ResponseVO(resultMap);
	}

	/**
	 * 디바이스관리 상세 화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/deviceDetailPagePop", method = RequestMethod.GET)
	public ModelAndView deviceDetailPop() throws Exception {
		logger.debug("deviceDetailPop!!!!!!!!!!");
		return new ModelAndView("/resrce/device/deviceDetailPagePop");
	}
	
	/**
	 * 디바이스관리 상세 화면 값 입력
	 * @param DeviceVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/deviceDetailPagePop", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO deviceDetailSelectPage(@RequestBody DeviceVO vo) throws Exception {
		logger.debug("DeviceController deviceDetailSelectPage started !!!");
		
		if(vo.getId() == 0) {
		}
		Map<String, Object> resultData = new HashMap<String, Object>();

		vo = deviceService.deviceDetailSelectPage(vo);
		
		logger.debug("DeviceController deviceDetailSelectPage end !!!");

		return new ResponseVO(vo);
	}
	
	/**
	 * 디바이스관리 수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateDevice")
	@ResponseBody
	public ResponseVO updateDevice(@RequestBody Map<String, Object> map) throws Exception {
		logger.debug("DeviceController updateDevice start!!!!!!!!!!");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = deviceService.updateDevice(map);
		logger.debug("DeviceController updateDevice end!!!!!!!!!!");
		return new ResponseVO(resultMap);
	}
	
	/**
	 * 디바이스관리 삭제
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteDevice")
	@ResponseBody
	public ResponseVO deleteDevice(@RequestBody Map<String, Object> map) throws Exception {
		logger.debug("DeviceController deleteDevice start!!!!!!!!!!");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = deviceService.deleteDevice(map);
		return new ResponseVO(resultMap);
	}
	
	/**
	 * 디바이스 목록 검색, 로봇 등록 화면에 이용
	 * @return ResponseVO
	 * @throws Exception
	 */
	@RequestMapping(value = "/getDeviceNameList", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getDeviceNameList(@RequestBody Map<String, Object> map) throws Exception {
		logger.debug("DeviceController getDeviceNameList start!!!!!!!!!!");
		List<Map<String, Object>> result = deviceService.getDeviceNameList(map);
		logger.debug(result.get(0).get("name")+"");
		logger.debug("DeviceController getDeviceNameList end!!!!!!!!!!");
		return new ResponseVO(result);
	}
}
