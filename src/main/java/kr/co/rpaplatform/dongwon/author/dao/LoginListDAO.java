package kr.co.rpaplatform.dongwon.author.dao;

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
public class LoginListDAO {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(LoginListDAO.class);
	
	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	public int searchPortalLoginListCount(Map<String, Object> map) {
		return sqlSession.selectOne("LoginListMapper.searchPortalLoginListCount", map);
	}
	
	public List<Map<String, Object>> searchPortalLoginList(Map<String, Object> map) {
		return sqlSession.selectList("LoginListMapper.searchPortalLoginList", map);
	}
	
	public List<Map<String, Object>> loginCountPerCmpList(Map<String, Object> map) {
		return sqlSession.selectList("LoginListMapper.loginCountPerCmpList", map);
	}
	
	public List<Map<String, Object>> loginCountPerRoleList(Map<String, Object> map) {
		return sqlSession.selectList("LoginListMapper.loginCountPerRoleList", map);
	}
	
	public List<Map<String, Object>> searchRoleList(Map<String, Object> map) {
		return sqlSession.selectList("LoginListMapper.searchRoleList", map);
	}
}
