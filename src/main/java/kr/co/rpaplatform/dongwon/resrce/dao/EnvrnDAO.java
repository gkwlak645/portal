package kr.co.rpaplatform.dongwon.resrce.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

/**
 * 환경 DAO
 * @author LKA
 * 2020. 6. 15.
 */
@Repository
public class EnvrnDAO {

	private final Logger logger = LoggerFactory.getLogger(EnvrnDAO.class);
	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	/**
	 * 디바이스 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectEnvrnList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("selectEnvrnList", map);
	}
	
	/**
	 * 디바이스 리스트 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectEnvrnCount(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("selectEnvrnCount", map);
	}
	/**
	 * 환경 등록 - 로봇 목록
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getRobotList(Map<String, Object> map) throws Exception  {
		logger.debug("EnvrnDAO getRobotList start!!!!!!");
		return sqlSession.selectList("getRobotList", map);
	}

	public Map<String, Object> envrnDetailSelectPage(Map<String, Object> map) throws Exception  {
		return sqlSession.selectOne("envrnDetailSelectPage", map);
	}

	public List<Map<String, Object>> getEnvrnRobotList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("getEnvrnRobotList", map);
	}
}
