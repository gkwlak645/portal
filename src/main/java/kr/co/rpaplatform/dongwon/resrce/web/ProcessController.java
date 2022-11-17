/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 6. 16.         LSH
 */
package kr.co.rpaplatform.dongwon.resrce.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.MDC;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.rpaplatform.common.pagination.PaginationInfo;
import kr.co.rpaplatform.common.vo.ResponseVO;
import kr.co.rpaplatform.dongwon.common.util.PaginationUtil;
import kr.co.rpaplatform.dongwon.resrce.service.ProcessService;
import kr.co.rpaplatform.dongwon.resrce.vo.DeviceVO;

/**
 * 프로세스 컨트롤러
 * @author LSH
 * 2020. 6. 16.
 */
@Controller
@RequestMapping("/resrce/process")
public class ProcessController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(ProcessController.class);
	
	/**
	 * 프로세스 서비스
	 */
	@Resource(name="processService")
	private ProcessService processService;
	
	/**
	 * 프로세스 메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/processMngMain")
	public ModelAndView deviceMngMain() throws Exception {
		return new ModelAndView("/resrce/process/processMngMain");
	}
	
	/**
	 * 프로세스 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getProcessList", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getProcessList(@RequestBody Map<String, Object> map) throws Exception {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();

		//프로세스 리스트 카운트 조회
		int totalRecordCount = processService.getProcessCount(map);
		
		//페이징 정보 조회
		PaginationInfo paginationInfo = PaginationUtil.getPaginationInfo(map, totalRecordCount);
		
		//조회조건에 페이징 정보 설정
		map.put("paginationInfo", PaginationUtil.getPaginationInfo(map, totalRecordCount));

		//프로세스 리스트 조회
		List<Map<String, Object>> resultList = processService.getProcessList(map);

		//결과값 설정
		returnMap.put("resultList", resultList);
		returnMap.put("paginationInfo", paginationInfo);
		
		return new ResponseVO(returnMap);
	}
	
	
	
	/**
	 * 프로세스 등록화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/processRegistPop")
	public ModelAndView processRegistPagePop() throws Exception {
		
		MDC.get("txCmpnyCd");
		
		return new ModelAndView("/resrce/process/processRegistPop");
	}
	
	
	/**
	 * 과제 코드 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getTaskCdList")
	@ResponseBody
	public ResponseVO getTaskCdList(@RequestBody Map<String, Object> map) throws Exception {
		
		List<Map<String, Object>> returnMap = processService.getTaskCdList(map);
		
		return new ResponseVO(returnMap);
	}
	
	
	/**
	 * 과제 프로세스 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getProcessCdList")
	@ResponseBody
	public ResponseVO getProcessCdList(@RequestBody Map<String, Object> map) throws Exception {
		
		List<Map<String, Object>> returnMap = processService.getProcessCdList(map);
		
		return new ResponseVO(returnMap);
	}
	
	/**
	 * 프로세스 리스트 API 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/getProcessAPIList")
	@ResponseBody
	public ResponseVO getProcessAPIList(@RequestBody Map<String, Object> map) throws Exception {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();

		//디바이스 리스트 조회
		List<Map<String, Object>> resultList = processService.getProcessAPIList(map);
		
		return new ResponseVO(resultList);
	}
	
	
	/**
	 * 프로세스 버전 리스트 API 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/getProcessVersionAPIList")
	@ResponseBody
	public ResponseVO getProcessVersionAPIList(@RequestBody Map<String, Object> map) throws Exception {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();

		//디바이스 리스트 조회
		List<Map<String, Object>> resultList = processService.getProcessVersionAPIList(map);
		
		//페이징 정보 조회
		PaginationInfo paginationInfo = PaginationUtil.getPaginationInfo(map, resultList.size());
		
		//조회조건에 페이징 정보 설정
		map.put("paginationInfo", PaginationUtil.getPaginationInfo(map, resultList.size()));
		
		return new ResponseVO(resultList);
	}
	
	
	
	/**
	 * 프로세스 상세화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/processDetailPagePop")
	public ModelAndView processDetailPagePop() throws Exception {
		return new ModelAndView("/resrce/process/processDetailPagePop");
	}

	/**
	 * 프로세스 상세 조회
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getProcessDetail")
	@ResponseBody
	public ResponseVO getProcessDetail(@RequestBody Map<String, Object> map) throws Exception {
		Map<String, Object> resultMap = processService.getProcessDetail(map);
		return new ResponseVO(resultMap);
	}
	
	/**
	 * 프로세스 버전 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getProcessVersionList", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getProcessVersionList(@RequestBody Map<String, Object> map) throws Exception {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();

		//프로세스 버전 리스트 카운트 조회
		int totalRecordCount = processService.getProcessVersionCount(map);
		
		//페이징 정보 조회
		PaginationInfo paginationInfo = PaginationUtil.getPaginationInfo(map, totalRecordCount);
		
		//조회조건에 페이징 정보 설정
		map.put("paginationInfo", PaginationUtil.getPaginationInfo(map, totalRecordCount));

		//프로세스 버전  리스트 조회
		List<Map<String, Object>> resultList = processService.getProcessVersionList(map);

		//결과값 설정
		returnMap.put("resultList", resultList);
		returnMap.put("paginationInfo", paginationInfo);

		return new ResponseVO(returnMap);
	}

	/**
	 * 프로세스 버전 변경
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/changeProcessVersion")
	@ResponseBody
	public ResponseVO changeProcessVersion(@RequestBody Map<String, Object> map) throws Exception {
		processService.changeProcessVersion(map);
		return new ResponseVO();
	}
	
	
	/**
	 * 프로세스 버전 롤백
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/changeProcessVersionRollBack")
	@ResponseBody
	public ResponseVO changeProcessVersionRollBack(@RequestBody Map<String, Object> map) throws Exception {
		processService.changeProcessVersionRollBack(map);
		return new ResponseVO();
	}
	
	/**
	 * 프로세스 버전을 최신 버전으로 업데이트
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateToLatestPackageVersion")
	@ResponseBody
	public ResponseVO updateToLatestPackageVersion(@RequestBody Map<String, Object> map) throws Exception {
		processService.updateToLatestPackageVersion(map);
		return new ResponseVO();
	}
	
	/**
	 * 입출력 파라미터 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getProcessParamterList")
	@ResponseBody
	public ResponseVO getProcessParamterList(@RequestBody Map<String, Object> map) throws Exception {
		
		Map<String, Object> returnMap = processService.getParamterList(map);
		
		return new ResponseVO(returnMap);
	}
	
	
	/**
	 * 프로세스코드
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getProcessCdListByClsCd", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getProcessCdListByClsCd(@RequestBody Map<String, Object> map) throws Exception {
		logger.debug("ProcessController deleteCmmnClsCd started !!!");

		List<Map<String, Object>> resultData = processService.getProcessCdListByClsCd(map);
		
		logger.debug("ProcessController deleteCmmnClsCd end !!!");
	
		return new ResponseVO(resultData);
	}
	
	/**
	 * 프로세스 등록
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/insertProcess", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO insertProcess(@RequestBody Map<String, Object> map) throws Exception {
		logger.debug("ProcessController insertProcess started !!!");

		Map<String, Object> resultData = processService.insertProcess(map);
		
		logger.debug("ProcessController insertProcess end !!!");
	
		return new ResponseVO(resultData);
	}
	
	
	/**
	 * 프로세스 수정
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateProcess", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO updateProcess(@RequestBody Map<String, Object> map) throws Exception {
		logger.debug("ProcessController updateProcess started !!!");

		Map<String, Object> resultData = processService.updateProcess(map);
		
		logger.debug("ProcessController updateProcess end !!!");
	
		return new ResponseVO(resultData);
	}
	
	
	/**
	 * 프로세스 삭제
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteProcess", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO deleteProcess(@RequestBody Map<String, Object> map) throws Exception {
		logger.debug("ProcessController deleteProcess started !!!");

		Map<String, Object> resultData = processService.deleteProcess(map);
		
		logger.debug("ProcessController deleteProcess end !!!");
	
		return new ResponseVO(resultData);
	}
	
	
	

	
}
