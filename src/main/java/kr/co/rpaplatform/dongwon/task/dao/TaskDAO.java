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

import kr.co.rpaplatform.dongwon.task.vo.TaskPrcuseSysVO;
import kr.co.rpaplatform.dongwon.task.vo.TaskReviewVO;
import kr.co.rpaplatform.dongwon.task.vo.TaskVO;

/**
 * 과제 DAO
 * @author LSH
 */
@Repository
public class TaskDAO {
	
	private final Logger logger = LoggerFactory.getLogger(TaskDAO.class);
	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	/**
	 * 과제요청 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectTaskRequstList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("selectTaskRequstList", map);
	}
	
	/**
	 * 과제요청 리스트 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectTaskRequstCount(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("selectTaskRequstCount", map);
	}

	/**
	 * 과제번호 채번
	 * @return
	 * @throws Exception
	 */
	public String selectNextTaskNo() throws Exception {
		return sqlSession.selectOne("selectNextTaskNo");
	}
	
	/**
	 * 과제 등록
	 * @param taskVO
	 * @throws Exception
	 */
	public void insertTask(TaskVO taskVO) throws Exception {
		sqlSession.insert("TaskIdeaMapper.insertTask", taskVO);
	}
	
	/**
	 * 과제검토번호 채번
	 * @param taskNo
	 * @return
	 * @throws Exception
	 */
	public String selectNextTaskReviewNo(String taskNo) throws Exception {
		return sqlSession.selectOne("selectNextTaskReviewNo", taskNo);
	}
	
	/**
	 * 과제검토 등록
	 * @param taskReviewVO
	 * @throws Exception
	 */
	public void insertTaskReview(TaskReviewVO taskReviewVO) throws Exception {
		sqlSession.insert("insertTaskReview", taskReviewVO);
	}
	
	/**
	 * 과제활용시스템 등록
	 * @param taskPrcuseSysVO
	 * @throws Exception
	 */
	public void insertTaskPrcuseSys(TaskPrcuseSysVO taskPrcuseSysVO) throws Exception {
		sqlSession.insert("insertTaskPrcuseSys", taskPrcuseSysVO);
	}
	
	/**
	 * 해당 과제의 과제활용시스템 삭제
	 * @param taskNo
	 * @throws Exception
	 */
	public void deleteTaskPrcuseSysForTask(String taskNo) throws Exception {
		sqlSession.delete("deleteTaskPrcuseSysForTask", taskNo);
	}
	
	/**
	 * 과제 조회
	 * @param taskNo
	 * @return
	 * @throws Exception
	 */
	public TaskVO selectTask(String taskNo) throws Exception {
		return sqlSession.selectOne("selectTask", taskNo);
	}
	
	/**
	 * 과제요청 최종 과제검토 조회
	 * @param taskNo
	 * @return
	 * @throws Exception
	 */
	public TaskReviewVO selectLastRequstTaskReview(String taskNo) throws Exception {
		return sqlSession.selectOne("selectLastRequstTaskReview", taskNo);
	}
	
	/**
	 * 과제활용시스템 리스트 조회
	 * @param taskNo
	 * @return
	 * @throws Exception
	 */
	public List<TaskPrcuseSysVO> selectTaskPrcuseSysList(String taskNo) throws Exception {
		return sqlSession.selectList("selectTaskPrcuseSysList", taskNo);
	}
}
