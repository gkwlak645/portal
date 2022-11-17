/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 7. 15.         LSH        최초 작성
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.rpaplatform.common.exception.RpaException;
import kr.co.rpaplatform.common.pagination.PaginationInfo;
import kr.co.rpaplatform.common.vo.ResponseVO;
import kr.co.rpaplatform.dongwon.common.util.PaginationUtil;
import kr.co.rpaplatform.dongwon.task.service.TaskBotScheduleService;
import kr.co.rpaplatform.dongwon.task.service.TaskService;

/**
 * ATTENDED BOT 스케쥴러
 * @author LSH
 */
@Controller
@RequestMapping("/task")
public class TaskBotScheduleController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(TaskReviewController.class);
	
	/**
	 * 과제 서비스
	 */
	@Resource(name="taskBotScheduleService")
	private TaskBotScheduleService taskBotScheduleService;
	
	
	
	/**
	 * ATTENDED BOT 실행정보 관리, PROCESS 실헹 스케줄
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/botSchedule/getBotSchedule", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getBotSchedule(@RequestBody Map<String, Object> map) throws Exception {
		
		if(taskBotScheduleService.chkBotExistAt(map) < 1) {
			return new ResponseVO("E200", "등록되지 않은 ROBOT입니다.");
		}
		else {
			Map<String, Object> oReturnSchedule = taskBotScheduleService.getBotSchedule(map);
			if(oReturnSchedule == null) {
				return new ResponseVO("I100", "정상적으로 처리되었습니다.", oReturnSchedule);
			}
			else {
				return new ResponseVO(oReturnSchedule);
			}
			
		}
	}
	
	@RequestMapping(value = "/botSchedule/setBotScheduleSttus", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO setBotScheduleSttus(@RequestBody Map<String, Object> map) throws Exception {
		
		if(taskBotScheduleService.chkBotExistAt(map) < 1) {
			return new ResponseVO("E200", "등록되지 않은 ROBOT입니다.");
		}
		else {
			taskBotScheduleService.setBotScheduleSttus(map);
		}
		
		return new ResponseVO();
	}

}
