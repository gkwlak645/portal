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
public class JobDAO {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(JobDAO.class);
	
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
	public List<Map<String, Object>> selectJobList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("selectJobList", map);
	}
	
	/**
	 * 작업 리스트 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectJobCount(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("selectJobCount", map);
	}
	
	/**
	 * 작업 상세 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectJobDetail(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("selectJobDetail", map);
	}

}
