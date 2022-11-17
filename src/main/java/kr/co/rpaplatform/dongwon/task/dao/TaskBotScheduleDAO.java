/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 7. 14.         LSH        최초 작성
 */
package kr.co.rpaplatform.dongwon.task.dao;

import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

/**
 * ATTENDED BOT 실행정보 관리
 * @author LSH
 */
@Repository
public class TaskBotScheduleDAO {
	
	private final Logger logger = LoggerFactory.getLogger(TaskBotScheduleDAO.class);
	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	
	public int chkBotExistAt(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("TaskBotScheduleMapper.chkBotExistAt", map);
	}
	
	public Map<String, Object> getBotSchedule(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("TaskBotScheduleMapper.getBotSchedule", map);
	}
	
	public void setBotScheduleSttus(Map<String, Object> map) throws Exception {
		sqlSession.insert("TaskBotScheduleMapper.setBotScheduleSttus", map);
	}
}
