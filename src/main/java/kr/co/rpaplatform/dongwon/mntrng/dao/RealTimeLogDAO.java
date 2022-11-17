package kr.co.rpaplatform.dongwon.mntrng.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

/**
 * Bot별 동작현황 DAO
 * @author 박해선
 *
 */
@Repository
public class RealTimeLogDAO {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(RealTimeLogDAO.class);
	
	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;

	
	public int selectRealTimeLogCount(Map<String, Object> map) {
		return sqlSession.selectOne("RealTimeLogMapper.selectRealTimeLogCount", map);
	}
	
	public List<Map<String, Object>> selectRealTimeLogList(Map<String, Object> map) {
		return sqlSession.selectList("RealTimeLogMapper.selectRealTimeLogList", map);
	}
}
