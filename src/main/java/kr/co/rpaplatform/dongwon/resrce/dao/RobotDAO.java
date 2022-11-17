/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 6. 8.         LSH
 */
package kr.co.rpaplatform.dongwon.resrce.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import kr.co.rpaplatform.dongwon.resrce.vo.RobotVO;

/**
 * 로봇 DAO
 * @author LSH
 * 2020. 6. 8.
 */
@Repository
public class RobotDAO {

	private final Logger logger = LoggerFactory.getLogger(RobotDAO.class);
	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	/**
	 * 로봇 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectRobotList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("selectRobotList", map);
	}
	
	/**
	 * 로봇 리스트 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectRobotCount(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("selectRobotCount", map);
	}
	/**
	 * 로봇 상세화면 내용 조회
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public RobotVO robotDetailSelectPage(RobotVO vo) throws Exception {
		logger.debug("RobotDAO robotDetailSelectPage start!!!!!!");
		
		logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ Dao에 vo 넘어온 값 : " + vo);
		
		logger.debug("RobotDAO robotDetailSelectPage end!!!!!!");
		
		return  sqlSession.selectOne("selectRobotDetail", vo);	
	}
	
	/**
	 * 로봇명 중복체크
	 * @param int
	 * @return
	 * @throws Exception
	 */
	public int idDplctCheck(RobotVO vo) throws Exception {
		return sqlSession.selectOne("idDplctCheck", vo);
	}

	/**
	 * 로봇 정보 삽입
	 * @param 
	 * @return
	 * @throws Exception
	 */
	public void insertRobot(Map<String, Object> map) throws Exception {
		logger.debug("RobotDAO insertRobot start!!!!!!");
		
		logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ Dao에 resultMap 넘어온 값 : " + map);
				
		this.sqlSession.insert("insertRobot", map);
		
		logger.debug("RobotDAO insertRobot end!!!!!!");
	}
	
	/**
	 * 로봇 업데이트
	 * @param 
	 * @return
	 * @throws Exception
	 */
	public void updateRobot(Map<String, Object> map) throws Exception{
		logger.debug("RobotDAO updateRobot start!!!!!!");
		
		logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ Dao에 Map 넘어온 값 : " + map);
		
		this.sqlSession.update("updateRobot", map);
		
		logger.debug("RobotDAO updateRobot end!!!!!!");
	}
	
	/**
	 * CMPNYCD 로 TENANTID 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectTenant(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("selectTenant", map);
	}
	
}
