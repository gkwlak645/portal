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
public class JobErrorDAO {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(JobErrorDAO.class);
	
	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	public int getJobErrorCount(Map<String, Object> map) {
		return sqlSession.selectOne("getJobErrorCount", map);
	}
	
	public List<Map<String, Object>> selectJobErrorList(Map<String, Object> map) {
		return sqlSession.selectList("selectJobErrorList", map);
	}
	
	public Map<String, Object> getJobErrorDetail(Map<String, Object> map) {
		return sqlSession.selectOne("getJobErrorDetail", map);
	}

	public void updateJobError(Map<String, Object> map) {
		 sqlSession.insert("updateJobError", map);
	}
	
	/**
	 * 로봇 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectBotList(Map<String, Object> map) {
		return sqlSession.selectList("selectBotListForJobError", map);
	}

}
