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
public class ResveArDAO {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(ResveArDAO.class);
	
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
	public List<Map<String, Object>> selectResveArList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("ResveArMapper.selectResveArList", map);
	}
	
	/**
	 * 작업 리스트 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectResveArCount(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("ResveArMapper.selectResveArCount", map);
	}
	
	/**
	 * 작업 리스트 상태 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public String selectResveArSttus(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("ResveArMapper.selectResveArSttus", map);
	}

	/**
	 * 작업 리스트 삭제
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void delResveAr(Map<String, Object> map) throws Exception {
		sqlSession.update("ResveArMapper.delResveAr", map);
	}
}
