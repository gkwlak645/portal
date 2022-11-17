/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 6. 16.         LSH
 */
package kr.co.rpaplatform.dongwon.mntrng.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import kr.co.rpaplatform.dongwon.resrce.dao.DeviceDAO;

/**
 * 로그 DAO
 * @author LSH
 * 2020. 6. 16.
 */
@Repository
public class LogDAO {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(LogDAO.class);
	
	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	/**
	 * 로그 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectLogList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("selectLogList", map);
	}
	
	/**
	 * 로그 리스트 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectLogCount(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("selectLogCount", map);
	}

}
