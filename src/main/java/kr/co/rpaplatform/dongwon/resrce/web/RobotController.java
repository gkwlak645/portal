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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.rpaplatform.common.pagination.PaginationInfo;
import kr.co.rpaplatform.common.vo.ResponseVO;

import kr.co.rpaplatform.dongwon.common.util.PaginationUtil;
import kr.co.rpaplatform.dongwon.resrce.service.RobotService;
import kr.co.rpaplatform.dongwon.resrce.vo.RobotVO;

/**
 * 로봇 컨트롤러
 * @author LSH
 * 2020. 6. 5.
 */
@Controller
@RequestMapping("/resrce/robot")
public class RobotController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(RobotController.class);
	
	/**
	 * 로봇 서비스
	 */
	@Resource(name="robotService")
	private RobotService robotService;
	
	/**
	 * 로봇관리 메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/robotMngMain")
	public ModelAndView robotMngMain() throws Exception {
		return new ModelAndView("/resrce/robot/robotMngMain");
	}

	/**
	 * 로봇 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/getRobotList")
	@ResponseBody
	public ResponseVO getRobotList(@RequestBody Map<String, Object> map) throws Exception {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();

		//디바이스 리스트 카운트 조회
		int totalRecordCount = robotService.getRobotCount(map);
		
		//페이징 정보 조회
		PaginationInfo paginationInfo = PaginationUtil.getPaginationInfo(map, totalRecordCount);
		
		//조회조건에 페이징 정보 설정
		map.put("paginationInfo", PaginationUtil.getPaginationInfo(map, totalRecordCount));

		//디바이스 리스트 조회
		List<Map<String, Object>> resultList = robotService.getRobotList(map);

		//결과값 설정
		returnMap.put("resultList", resultList);
		returnMap.put("paginationInfo", paginationInfo);

		return new ResponseVO(returnMap);
	}
	
	/**
	 * 로봇관리 등록 화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/robotRegisterPagePop")
	public ModelAndView robotRegPop() throws Exception {
		return new ModelAndView("/resrce/robot/robotRegisterPagePop");
	}
	
	/**
	 * 로봇 등록
	 * @param map
	 * @throws Exception
	 */
	@RequestMapping(value="/registerRobot")
	@ResponseBody
	/*public void registerRobot(@RequestBody Map<String, Object> map) throws Exception {
		this.logger.debug("RobotController registerRobot start!!");
		
		System.out.println("Map 넘어오는값?????" + map);
		
				
		robotService.registerRobot(map);
		
		this.logger.debug("RobotController registerRobot end!!");
	}*/
	
	
	public ResponseVO registerRobot(@RequestBody Map<String, Object> map) throws Exception {
		
		this.logger.debug("RobotController registerRobot start!!");
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = robotService.registerRobot(map);
		
						
	
		this.logger.debug("RobotController registerRobot end!!");
		return new ResponseVO(resultMap);
		

	}	
	
	/**
	 * 로봇관리 상세 화면
	 * @throws Exception
	 */
	@RequestMapping(value="/robotDetailPagePop")
	public ModelAndView robotDetailPagePop() throws Exception {
		return new ModelAndView("/resrce/robot/robotDetailPagePop");
	}
	
	/**
	 * 로봇관리 상세 화면 내역 조회
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/getRobotDetail")
	@ResponseBody
	public ResponseVO getRobotDetail(@RequestBody RobotVO vo) throws Exception {

		RobotVO result = robotService.robotDetailSelectPage(vo);
		
		this.logger.debug("result값은????????" + result);
		
		return new ResponseVO(result);
	}
	
	/**
	 * 로봇관리 삭제
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteRobot")
	@ResponseBody
	public ResponseVO deleteRobot(@RequestBody Map<String, Object> map) throws Exception {
		robotService.deleteRobot(map);
		return new ResponseVO();
	}
	
	/**
	 * 로봇관리 수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateRobot")
	@ResponseBody
	public ResponseVO updateRobot(@RequestBody Map<String, Object> map) throws Exception {
		robotService.updateRobot(map);
		return new ResponseVO();
	}
	
	/**
	 * 로봇관리 로봇명 중복 체크
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/idDplctCheck")
	@ResponseBody
	public ResponseVO idDplctCheck(@RequestBody RobotVO vo) throws Exception {
		this.logger.debug("RobotController idDplctCheck start!!");
		Map<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put("chk", robotService.idDplctCheck(vo));
		this.logger.debug("RobotController idDplctCheck end!!");
		return new ResponseVO(returnMap);
	}
	
	
}
