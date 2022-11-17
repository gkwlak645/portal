/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 7. 14.         LSH        최초 작성
 */
package kr.co.rpaplatform.dongwon.task.dao;


import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 * 과제 DAO
 * @author LSH
 */
@Repository
public class TaskPaymentDAO {
	
	private final Logger logger = LoggerFactory.getLogger(TaskPaymentDAO.class);
	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	
	
	
	/**
	 * 과제개발, 과재운영 > 프로세스 상세 > 결재요청 :  mkey 중복 여부 확인
	 * @param int
	 * @return
	 * @throws Exception
	 */
	public int chkOverlapMkey(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("TaskPaymentMapper.chkOverlapMkey", map);
	}
	
	
	/**
	 * 과제개발, 과재운영 > 프로세스 상세 > 결재요청 : 프로세스 결재정보 등록
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void insertTaskPayment(Map<String, Object> map) throws Exception {
		sqlSession.insert("TaskPaymentMapper.insertTaskPayment", map);
	}
	
	/**
	 * 과제개발, 과재운영 > 프로세스 상세 > 결재요청 : 프로세스 결재정보 업데이트
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void updateTaskPayment(Map<String, Object> map) throws Exception {
		sqlSession.update("TaskPaymentMapper.updateTaskPayment", map);
	}
	
	
	/**
	 * 과제개발, 과재운영 > 프로세스 상세 > 결재요청 : 프로세스 결재정보 이력 번호 생성
	 * @param int
	 * @return
	 * @throws Exception
	 */
	public int getTaskOverlapMkeyHistNo(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("TaskPaymentMapper.getTaskOverlapMkeyHistNo", map);
	}
	
	
	/**
	 * 과제개발, 과재운영 > 프로세스 상세 > 결재요청 : 프로세스 결재정보 이력 등록
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void insertTaskPaymentHist(Map<String, Object> map) throws Exception {
		sqlSession.insert("TaskPaymentMapper.insertTaskPaymentHist", map);
	}
	
	/**
	 * 과제개발, 과재운영 > 프로세스 상세 > 결재요청 : fail
	 * @param map
	 * @return
	 * @throws Exception
	 */
	//프로세스 결재요청 이력 delete
	public void deleteTaskPaymentHist(Map<String, Object> map) throws Exception {
		sqlSession.delete("TaskPaymentMapper.deleteTaskPaymentHist", map);
	}

	//프로세스 결재요청 delete
	public void deleteTaskPayment(Map<String, Object> map) throws Exception {
		sqlSession.delete("TaskPaymentMapper.deleteTaskPayment", map);
	}
	
	
}
