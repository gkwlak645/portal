package kr.co.rpaplatform.dongwon.gwpwr.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

/**
 * 그룹웨어 부서 DAO
 * @author LSH
 */
@Repository
public class GwpwrDeptDAO {
	
	/**
	 * sqlSession
	 */
	@Resource(name="groupwareSession")
	private SqlSession sqlSession;
	
	/**
	 * 그룹웨어 부서 리스트 조회
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectAllGwpwrDeptList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("selectAllGwpwrDeptList",map);
	}

}
