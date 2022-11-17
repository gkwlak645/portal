/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 7. 14.         LSH        최초 작성
 */
package kr.co.rpaplatform.dongwon.task.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import kr.co.rpaplatform.dongwon.common.cont.Const;
import kr.co.rpaplatform.dongwon.task.dao.TaskBotScheduleDAO;
import kr.co.rpaplatform.dongwon.task.dao.TaskDAO;
import kr.co.rpaplatform.dongwon.task.vo.TaskPrcuseSysVO;
import kr.co.rpaplatform.dongwon.task.vo.TaskReviewVO;
import kr.co.rpaplatform.dongwon.task.vo.TaskVO;

/**
 * 과제 서비스
 * @author LSH
 */
@Service
public class TaskBotScheduleService {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(TaskBotScheduleService.class);

	@Resource(name="taskBotScheduleDAO")
	private TaskBotScheduleDAO taskBotScheduleDAO;
	
	
	/**
	 * ATTENDED BOT 실행정보 관리, ROBOT 등록여부
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int chkBotExistAt(Map<String, Object> map) throws Exception {
		return taskBotScheduleDAO.chkBotExistAt(map);
	}

	/**
	 * ATTENDED BOT 실행정보 관리, PROCESS 실헹 스케줄
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getBotSchedule(Map<String, Object> map) throws Exception {
		return taskBotScheduleDAO.getBotSchedule(map);
	}
	
	
	/**
	 * ATTENDED BOT 실행정보 관리, PROCESS 실행 상태 저장
	 * @param taskVO
	 * @throws Exception
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void setBotScheduleSttus(Map<String, Object> map) throws Exception {
		taskBotScheduleDAO.setBotScheduleSttus(map);
	}

}
