package kr.co.rpaplatform.dongwon.mntrng.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

/**
 * 작업 DAO
 * @author LSH
 *
 */
@Repository
public class JobMngDAO {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(JobMngDAO.class);
	
	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	public int getJobMngCount(Map<String, Object> map) {
		return sqlSession.selectOne("getJobMngCount", map);
	}
	
	public List<Map<String, Object>> selectJobMngList(Map<String, Object> map) {
		return sqlSession.selectList("selectJobMngList", map);
	}

	/**
	 * 로봇 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectBotList(Map<String, Object> map) {
		return sqlSession.selectList("selectBotListForJobMng", map);
	}

	/**
	 * JOB이력관리 사유 등록 및 수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void updateJobMngResn(Map<String, Object> map) throws Exception {
		sqlSession.update("updateJobMngResn", map);
	}
}
