package kr.co.rpaplatform.dongwon.stats.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

/**
 * 예상실제비교   DAO
 *
 */
@Repository
public class ExpectRealProcessDAO {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(ExpectRealProcessDAO.class);
	
	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	public int getExpectRealProcessListCount(Map<String, Object> map) {
		return sqlSession.selectOne("getExpectRealProcessListCount", map);
	}
	
	// 예상실제비교
	public List<Map<String, Object>> getExpectRealProcessList(Map<String, Object> map) {
		return sqlSession.selectList("getExpectRealProcessList", map);
	}

	/**
	 * 로봇 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectBotListForExpectRealRobot(Map<String, Object> map) {
		return sqlSession.selectList("selectBotListForExpectRealRobot", map);
	}
}
