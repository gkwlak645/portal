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

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import kr.co.rpaplatform.dongwon.task.vo.TaskPrcuseSysVO;
import kr.co.rpaplatform.dongwon.task.vo.TaskReviewVO;
import kr.co.rpaplatform.dongwon.task.vo.TaskVO;

/**
 * 과제 DAO
 * @author LSH
 */
@Repository
public class TaskIdeaDAO {
	
	private final Logger logger = LoggerFactory.getLogger(TaskIdeaDAO.class);
	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	/**
	 * 과제아이디어등록 리스트 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectTaskIdeaListCount(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("TaskIdeaMapper.selectTaskIdeaListCount", map);
	}
	
	/**
	 * 과제아이디어등록 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectTaskIdeaList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("TaskIdeaMapper.selectTaskIdeaList", map);
	}
	
	/**
	 * 과제아이디어등록 > 등록
	 * @param taskVO
	 * @throws Exception
	 */
	public void insertTaskIdea(HashMap<String, String> params) throws Exception {
		sqlSession.insert("TaskIdeaMapper.insertTaskIdea", params);
	}
	
	/**
	 * 과제아이디어등록 > 상세보기
	 * @param 
	 * @throws Exception
	 */
	public Map<String, Object> getTaskIdeaDetail(Map<String, Object> params) throws Exception {
		return sqlSession.selectOne("TaskIdeaMapper.getTaskIdeaDetail", params);
	}
	
	/**
	 * 과제아이디어등록 > 상세보기 > 검토완료
	 * @param taskVO
	 * @throws Exception
	 */
	public void setTaskIdeaReviewComplete(Map<String, Object> params) throws Exception {
		sqlSession.update("TaskIdeaMapper.setTaskIdeaReviewComplete", params);
	}
	
	/**
	 * 과제아이디어등록 > 상세보기 > 저장
	 * @param taskVO
	 * @throws Exception
	 */
	public void setTaskIdeaDetail(Map<String, Object> params) throws Exception {
		sqlSession.update("TaskIdeaMapper.setTaskIdeaDetail", params);
	}
	
	/**
	 * 과제아이디어등록 > 상세보기 > 등록취소
	 * @param taskVO
	 * @throws Exception
	 */
	public void setTaskIdeaCancel(Map<String, Object> params) throws Exception {
		sqlSession.update("TaskIdeaMapper.setTaskIdeaCancel", params);
	}
}
