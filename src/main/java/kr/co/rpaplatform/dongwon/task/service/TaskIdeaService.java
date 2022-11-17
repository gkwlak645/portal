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
import kr.co.rpaplatform.dongwon.task.dao.TaskIdeaDAO;

/**
 * 과제 서비스
 * @author LSH
 */
@Service
public class TaskIdeaService {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(TaskIdeaService.class);

	/**
	 * 과제 DAO
	 */
	@Resource(name="taskIdeaDAO")
	private TaskIdeaDAO taskIdeaDAO;

	/**
	 * 과제아이디어등록 리스트 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectTaskIdeaListCount(Map<String, Object> map) throws Exception {
		return taskIdeaDAO.selectTaskIdeaListCount(map);
	}
	
	/**
	 * 과제아이디어등록 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectTaskIdeaList(Map<String, Object> map) throws Exception {
		return taskIdeaDAO.selectTaskIdeaList(map);
	}
	
	/**
	 * 과제아이디어등록 등록
	 * @param taskVO
	 * @throws Exception
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void insertTaskIdea(HashMap<String, String> params) throws Exception {
		taskIdeaDAO.insertTaskIdea(params);
	}
	
	
	/**
	 * 과제아이디어등록 > 상세보기
	 * @param taskVO
	 * @throws Exception
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public Map<String, Object> getTaskIdeaDetail(Map<String, Object> params) throws Exception {
		return taskIdeaDAO.getTaskIdeaDetail(params);
	}
	
	/**
	 * 과제아이디어등록 > 상세보기 > 검토완료
	 * @param taskVO
	 * @throws Exception
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void setTaskIdeaReviewComplete(Map<String, Object> params) throws Exception {
		taskIdeaDAO.setTaskIdeaReviewComplete(params);
	}
	
	/**
	 * 과제아이디어등록 > 상세보기 > 저장
	 * @param taskVO
	 * @throws Exception
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void setTaskIdeaDetail(Map<String, Object> params) throws Exception {
		taskIdeaDAO.setTaskIdeaDetail(params);
	}
	
	/**
	 * 과제아이디어등록 > 상세보기 > 등록취소
	 * @param taskVO
	 * @throws Exception
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void setTaskIdeaCancel(Map<String, Object> params) throws Exception {
		taskIdeaDAO.setTaskIdeaCancel(params);
	}
	
	
}
