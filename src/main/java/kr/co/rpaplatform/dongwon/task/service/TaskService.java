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
import kr.co.rpaplatform.dongwon.task.dao.TaskDAO;
import kr.co.rpaplatform.dongwon.task.vo.TaskPrcuseSysVO;
import kr.co.rpaplatform.dongwon.task.vo.TaskReviewVO;
import kr.co.rpaplatform.dongwon.task.vo.TaskVO;

/**
 * 과제 서비스
 * @author LSH
 */
@Service
public class TaskService {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(TaskService.class);

	/**
	 * 과제 DAO
	 */
	@Resource(name="taskDAO")
	private TaskDAO taskDAO;

	/**
	 * 과제요청 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getTaskRequstList(Map<String, Object> map) throws Exception {
		return taskDAO.selectTaskRequstList(map);
	}
	
	/**
	 * 과제요청 리스트 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int getTaskRequstCount(Map<String, Object> map) throws Exception {
		return taskDAO.selectTaskRequstCount(map);
	}
	
	/**
	 * 과제요청 등록
	 * @param taskVO
	 * @throws Exception
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void createTaskRequst(TaskVO taskVO) throws Exception {
		
		//과제번호 채번
		String taskNo = taskDAO.selectNextTaskNo();
		
		//과제 등록
		taskVO.setTaskNo(taskNo);
		taskDAO.insertTask(taskVO);
		
		//과제활용시스템 등록
		List<TaskPrcuseSysVO> taskPrcuseSysList = taskVO.getTaskPrcuseSysList();
		if (taskPrcuseSysList != null && taskPrcuseSysList.size() > 0) {
			for (TaskPrcuseSysVO taskPrcuseSysVO : taskPrcuseSysList) {
				taskPrcuseSysVO.setTaskNo(taskNo);
				taskDAO.insertTaskPrcuseSys(taskPrcuseSysVO);
			}
		}
		
		//과제검토번호 채번
		String taskReviewNo = taskDAO.selectNextTaskReviewNo(taskNo);
		
		//과제검토 등록
		TaskReviewVO taskReviewVO = new TaskReviewVO();
		taskReviewVO.setTaskNo(taskNo);
		taskReviewVO.setTaskReviewNo(taskReviewNo);
		taskReviewVO.setPrgrStpCd(Const.PRGR_STP_REQUST);
		taskReviewVO.setSttusCd(Const.STTUS_REQUST);
		taskDAO.insertTaskReview(taskReviewVO);
	}
	
	/**
	 * 과제요청 상세 조회
	 * @param taskNo
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getTaskRequstDetail(String taskNo) throws Exception {
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		//과제조회
		TaskVO taskVO = taskDAO.selectTask(taskNo);
		
		//과제활용시스템 조회
		List<TaskPrcuseSysVO> taskPrcuseSysList = taskDAO.selectTaskPrcuseSysList(taskNo);
		
		if (taskVO != null) {
			taskVO.setTaskPrcuseSysList(taskPrcuseSysList);
		}
		
		//최종 과제검토 조회
		TaskReviewVO taskReviewVO = taskDAO.selectLastRequstTaskReview(taskNo);
		
		resultMap.put("task", taskVO);
		resultMap.put("taskReview", taskReviewVO);
		
		return resultMap;
	}

}
