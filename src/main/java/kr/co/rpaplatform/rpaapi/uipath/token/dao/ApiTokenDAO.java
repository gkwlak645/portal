/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 6. 9.         LSH
 */
package kr.co.rpaplatform.rpaapi.uipath.token.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

/**
 * API 토큰 DAO
 * @author LSH
 * 2020. 6. 9.
 */
@Repository
public class ApiTokenDAO {
	
	private final Logger logger = LoggerFactory.getLogger(ApiTokenDAO.class);
	
	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	/**
	 * API 토큰 리스트 조회
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectApiTknList() throws Exception {
		return sqlSession.selectList("selectApiTknList");
	}

	/**
	 * API 토큰 정보 수정
	 * @param map
	 * @throws Exception
	 */
	public void updateApiTkn(Map<String, Object> map) throws Exception {
		logger.debug("********************************");
		logger.debug(map.toString());
		logger.debug("********************************");
		sqlSession.update("updateApiTkn", map);
	}
	
	/**
	 * API 토큰 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectTknValue(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("selectApiTkn", map);
	}
}
