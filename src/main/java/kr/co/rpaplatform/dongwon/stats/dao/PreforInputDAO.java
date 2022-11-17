/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 7. 14.         LSH        최초 작성
 */
package kr.co.rpaplatform.dongwon.stats.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

/**
 * 실적계획입력 DAO
 * @author LSH
 */
@Repository
public class PreforInputDAO {
	
	private final Logger logger = LoggerFactory.getLogger(PreforInputDAO.class);
	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	/**
	 * 회사코드 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectTknList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("PreforInputMapper.selectTknList", map);
	}
	
	
	/**
	 * 실적계획이 존재하는 회사코드 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectTknPreforInList(Map<String, Object> map) {
		return sqlSession.selectList("PreforInputMapper.selectTknPreforInList", map);
	}
	
	
	/**
	 * 실적계획입력 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectPreforList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("PreforInputMapper.selectPreforList", map);
	}
	
	
	/**
	 * 실적계획입력 저장
 	 * @return 
	 * @return
	 * @throws Exception
	 */
	public void updatePrefor(Map<String, Object> map) throws Exception {
		sqlSession.update("PreforInputMapper.updatePrefor", map);
	}


	

	








	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
