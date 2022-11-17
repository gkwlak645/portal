package kr.co.rpaplatform.dongwon.gwpwr.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

/**
 * 그룹웨어 사용자 DAO
 * @author LSH
 */
@Repository
public class GwpwrUserDAO {
	
	/**
	 * sqlSession
	 */
	@Resource(name="groupwareSession")
	private SqlSession sqlSession;
	
	/**
	 * 그룹웨어 사용자 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectGwpwrUserList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("selectGwpwrUserList", map);
	}
	
	/**
	 * 그룹웨어 사용자 카운트
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectGwpwrUserCount(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("selectGwpwrUserCount", map);
	}
	
	/**
	 * 그룹웨어 사용자 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectGwpwrUserListV2(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("selectGwpwrUserListV2", map);
	}
	
	/**
	 * 그룹웨어 사용자 카운트
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectGwpwrUserCountV2(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("selectGwpwrUserCountV2", map);
	}

}
