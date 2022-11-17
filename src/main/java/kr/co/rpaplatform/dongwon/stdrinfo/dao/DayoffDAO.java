package kr.co.rpaplatform.dongwon.stdrinfo.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import kr.co.rpaplatform.dongwon.stdrinfo.vo.DayoffVO;

@Repository
public class DayoffDAO {

	private final Logger logger = LoggerFactory.getLogger(DayoffDAO.class);
	
	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	
	/**
	 * dayoff 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getoffDayList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("getoffDayList",map);
	}


	/**
	 * tenant 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getTenantInfo(Map<String, Object> map)throws Exception {
		return sqlSession.selectList("getTenantInfo",map);
	}
	
	
	/**
	 * dayoff 명칭 개수 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int chkOverlapDayOffName(Map<String, Object> map) {
		return sqlSession.selectOne("chkOverlapDayOffName", map);
	}
	
	
	/**
	 * dayoff 매핑 등록
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void insertDayOff(Map<String, Object> map) {
		sqlSession.insert("insertDayOff", map);
	}
	
	
	/**
	 * dayoff 매핑 삭제
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void deleteDayOff(Map<String, Object> map) {
		sqlSession.delete("deleteDayOff", map);
	}

	
}
