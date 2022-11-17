/**
 * 
 */
package kr.co.rpaplatform.dongwon.execut.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

/**
 * 스케줄 DAO
 * @author LSH
 *
 */
@Repository
public class SchdulDAO {
	
	private final Logger logger = LoggerFactory.getLogger(SchdulDAO.class);
	
	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	/**
	 * 스케줄 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSchdulList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("selectSchdulList", map);
	}
	
	/**
	 * 스케줄 리스트 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectSchdulCount(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("selectSchdulCount", map);
	}

}
