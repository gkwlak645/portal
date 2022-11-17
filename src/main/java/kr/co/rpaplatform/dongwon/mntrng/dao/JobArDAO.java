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
public class JobArDAO {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(JobArDAO.class);
	
	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	/**
	 * 작업 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectJobArList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("selectJobArList", map);
	}
	
	/**
	 * 작업 리스트 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectJobArListCount(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("selectJobArListCount", map);
	}
	
	/**
	 * 작업 중지전 상태 체크
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public String selectJobArSttus(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("selectJobArSttus", map);
	}
	
	/**
	 * 작업 중지
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void stopJobAr(Map<String, Object> map) throws Exception {
		sqlSession.update("stopJobAr", map);
	}

	/**
	 * '중지중'인 JOB의 상태를 '중지됨'으로 강제 변경
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void convertToStopped(Map<String, Object> map) throws Exception {
		sqlSession.update("convertToStopped", map);
	}
	
	
	/**
	 * 로봇 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectBotList(Map<String, Object> map) {
		return sqlSession.selectList("selectBotListARmntrng", map);
	}
}
