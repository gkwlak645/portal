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
 * @author 
 *
 */
@Repository
public class DevBotMntrngDAO {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(DevBotMntrngDAO.class);
	
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
	public List<Map<String, Object>> selectDevBotMntrngList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("DevBotMntrngMapper.selectDevBotMntrngList", map);
	}
	
	/**
	 * 작업 리스트 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectDevBotMntrngCount(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("DevBotMntrngMapper.selectDevBotMntrngCount", map);
	}

}
