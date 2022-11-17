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

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import kr.co.rpaplatform.dongwon.resrce.vo.DeviceVO;

/**
 * 디바이스 DAO
 * @author LSH
 * 2020. 6. 8.
 */
@Repository
public class DeviceDAO {
	
	private final Logger logger = LoggerFactory.getLogger(DeviceDAO.class);
	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	/**
	 * 디바이스 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectDeviceList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("selectDeviceList", map);
	}
	
	/**
	 * 디바이스 리스트 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectDeviceCount(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("selectDeviceCount", map);
	}
	/**
	 * 디바이스 상세화면 내용 조회
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public DeviceVO deviceDetailSelectPage(DeviceVO vo) {
		return sqlSession.selectOne("selectDeviceDetail", vo);
	}
	/**
	 * 디바이스 목록 검색, 로봇 등록 화면에 이용
	 * @return map
	 * @throws Exception
	 */
	public List<Map<String, Object>> getDeviceNameList(Map<String, Object> map) {
		return sqlSession.selectList("getDeviceNameList", map);
	}
	

}
