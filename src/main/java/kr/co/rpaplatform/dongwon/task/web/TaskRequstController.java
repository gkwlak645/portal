/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 7. 8.         LSH        최초 작성
 */
package kr.co.rpaplatform.dongwon.task.web;

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
import kr.co.rpaplatform.dongwon.task.service.TaskService;
import kr.co.rpaplatform.dongwon.task.vo.TaskVO;

/**
 * 과제 컨트롤러
 * @author LSH
 */
@Controller
@RequestMapping("/task")
public class TaskRequstController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(TaskRequstController.class);
	
	/**
	 * 과제 서비스
	 */
	@Resource(name="taskService")
	private TaskService taskService;
	
	
	/**
	 * 과제 요청 메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/requst/taskRequstMain")
	public ModelAndView taskRequstMain() throws Exception {
		return new ModelAndView("/task/requst/taskRequstMain");
	}
	
	/**
	 * 과제 요청 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/requst/getTaskRequstList")
	@ResponseBody
	public ResponseVO getTaskRequstList(@RequestBody Map<String, Object> map) throws Exception {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();

		//과제 요청 리스트 카운트 조회
		int totalRecordCount = taskService.getTaskRequstCount(map);
		
		//페이징 정보 조회
		PaginationInfo paginationInfo = PaginationUtil.getPaginationInfo(map, totalRecordCount);
		
		//조회조건에 페이징 정보 설정
		map.put("paginationInfo", PaginationUtil.getPaginationInfo(map, totalRecordCount));

		//과제 요청 리스트 조회
		List<Map<String, Object>> resultList = taskService.getTaskRequstList(map);

		//결과값 설정
		returnMap.put("resultList", resultList);
		returnMap.put("paginationInfo", paginationInfo);
		
		return new ResponseVO(returnMap);
	}

	/**
	 * 과제 요청 팝업 페이지
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/requst/taskRequstRegisterPop")
	public ModelAndView taskRequestPop() throws Exception {
		return new ModelAndView("/task/requst/taskRequstRegisterPop");
	}
	
	/**
	 * 과제요청 등록
	 * @param taskVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/requst/createTaskRequst")
	@ResponseBody
	public ResponseVO createTaskRequst(@RequestBody TaskVO taskVO) throws Exception {
		
		//과제요청 등록
		taskService.createTaskRequst(taskVO);
		
		return new ResponseVO();
	}
	
	/**
	 * 과제 요청 상세 페이지
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/requst/taskRequstDetailPop")
	public ModelAndView taskRequstDetailPop() throws Exception {
		return new ModelAndView("/task/requst/taskRequstDetailPop");
	}
	
	/**
	 * 과제 요청 상세 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/requst/getTaskRequstDetail")
	@ResponseBody
	public ResponseVO getTaskRequstDetail(@RequestBody Map<String, Object> params) throws Exception {
		
		//과제 요청 상세 조회
		Map<String, Object> resultMap = taskService.getTaskRequstDetail((String)params.get("taskNo"));
		
		return new ResponseVO(resultMap);
	}
	
}
