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

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import kr.co.rpaplatform.dongwon.task.vo.TaskPrcuseSysVO;
import kr.co.rpaplatform.dongwon.task.vo.TaskReviewVO;
import kr.co.rpaplatform.dongwon.task.vo.TaskVO;

/**
 * 과제운영 DAO
 * @author LSH
 */
@Repository
public class TaskManageDAO {
	
	private final Logger logger = LoggerFactory.getLogger(TaskManageDAO.class);
	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	/**
	 * 과제운영 리스트 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectTaskManageListCount(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("TaskManageMapper.selectTaskManageListCount", map);
	}
	
	/**
	 * 과제운영 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectTaskManageList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("TaskManageMapper.selectTaskManageList", map);
	}
	
	/**
	 * 과제운영 > 과제 상세 > get data
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getTaskManageDetail(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("TaskManageMapper.getTaskManageDetail", map);
	}
	
	/**
	 * 과제운영 > 프로세스 상세 > get data
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getTaskManageProcessDetail(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("TaskManageMapper.getTaskManageProcessDetail", map);
	}
	
	/**
	 * 프로세스 운영 담당자 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectPrcChargerList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("TaskManageMapper.selectPrcChargerList", map);
	}
	
	/**
	 * 프로세스 운영 절감시간 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectPrcRedcnTmList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("TaskManageMapper.selectPrcRedcnTmList", map);
	}
	
	/**
	 * 프로세스 운영 개인 기여도 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectTaskPrcContribute(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("TaskManageMapper.selectTaskPrcContribute", map);
	}
	
	/**
	 * 프로세스 운영 연관시스템 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectTaskPrcCntcList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("TaskManageMapper.selectTaskPrcCntcList", map);
	}
	
	public List<Map<String, Object>> selectTaskPrcSchlist(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("TaskManageMapper.selectTaskPrcSchlist", map);
	}
	
	public void saveRoutinePlan(Map<String, Object> map) throws Exception {
		sqlSession.insert("TaskManageMapper.saveRoutinePlan", map);
	}
	
	/**
	 * 프로세스 운영 취소 직접 처리 > insert
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void insertTaskManageProcHist(Map<String, Object> map) throws Exception {
		sqlSession.insert("TaskManageMapper.insertTaskManageProcHist", map);
	}

	/**
	 * 프로세스 운영 취소 직접 처리 > 수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void updateTaskManageProcUpdate(Map<String, Object> map) throws Exception {
		sqlSession.update("TaskManageMapper.updateTaskManageProcUpdate", map);
	}
	
	
	
	
	
	/**
	 * 프로세스 운영 시간 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectTaskTimeList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("TaskManageMapper.selectTaskTimeList", map);
	}
	
	/**
	 * 프로세스 운영봇 예약 시간 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectTaskBotReservList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("TaskManageMapper.selectTaskBotReservList", map);
	}
	
	/**
	 * 프로세스 운영 봇 카운트 조회
	 * @param map 
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectTaskBotCountList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("TaskManageMapper.selectTaskBotCountList", map);
	}
	
	/**
	 * 프로세스 운영 정기 계획 텍스트 조회
	 * @param map 
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectRoutineScheduleTextList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("TaskManageMapper.selectRoutineScheduleTextList", map);
	}
	
	/**
	 * 프로세스 운영 정기계획 입력 > insert
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void insertTaskManageProcessPlan(Map<String, Object> map) throws Exception {
		sqlSession.insert("TaskManageMapper.insertTaskManageProcessPlan", map);
	}

	/**
	 * 프로세스 운영 정기계획 삭제 > 삭제
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void deleteTaskManageProcessPlan(Map<String, Object> map) throws Exception {
		sqlSession.delete("TaskManageMapper.deleteTaskManageProcessPlan", map);
	}
	
	/**
	 * 프로세스 운영 정기계획 삭제 > 삭제
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void deleteTaskManageProcessSchdule(Map<String, Object> map) throws Exception {
		sqlSession.delete("TaskManageMapper.deleteTaskManageProcessSchdule", map);
	}
	
	public void updateTaskManageProcessSchdule(Map<String, Object> map) throws Exception {
		sqlSession.update("TaskManageMapper.updateTaskManageProcessSchdule", map);
	}
	
	/**
	 * 과제운영 실행시간 중복 리스트 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectTaskManageProcessReserveCount(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("TaskManageMapper.selectTaskManageProcessReserveCount", map);
	}


	/**
	 * 프로세스 운영 예약계획 입력
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void insertTaskManageProcessReserve(Map<String, Object> map) throws Exception {
		sqlSession.insert("TaskManageMapper.insertTaskManageProcessReserve", map);
	}

	/**
	 * 프로세스 운영 예약계획 삭제
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void deleteTaskManageProcessReserve(Map<String, Object> map) throws Exception {
		sqlSession.delete("TaskManageMapper.deleteTaskManageProcessReserve", map);
	}
	
	/**
	 * 프로세스 운영 예약계획 삭제전 정기계획 확인
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectTaskManageProcessReserveDelChk(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("TaskManageMapper.selectTaskManageProcessReserveDelChk", map);
	}
	
	/**
	 * 프로세스 운영 Attended 입력
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void insertTaskAttendedReserve(Map<String, Object> map) throws Exception {
		sqlSession.insert("TaskManageMapper.insertTaskAttendedReserve", map);
	}
	
	/**
	 * 프로세스 JOB SEND History 입력
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void insertTaskSendHistory(Map<String, Object> map) throws Exception {
		sqlSession.insert("TaskManageMapper.insertTaskSendHistory", map);
	}
	
	/**
	 * 프로세스 운영 TB_TASK_DEVLOP_PROCESS_SCHDULE 입력
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void insertTaskRoutinePlan(Map<String, Object> map) throws Exception {
		sqlSession.insert("TaskManageMapper.insertTaskRoutinePlan", map);
	}
	
	/**
	 * SCHDULE 등록 순번 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getTaskManageschduleNo(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("TaskManageMapper.getTaskManageschduleNo", map);
	}
	
	/**
	 * 과제운영 휴일 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectTaskManageCalendarList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("TaskManageMapper.selectTaskManageCalendarList", map);
	}

	/**
	 * 프로세스 운영 휴일관리 수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void updateCalendarPlan(Map<String, Object> map) throws Exception {
		sqlSession.update("TaskManageMapper.updateCalendarPlan", map);
	}
	
	/**
	 * Trigger AR 스케쥴 등록(크론표현식일 경우만)
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void insertTriggerArSched(List<Map<String, Object> > map) throws Exception {
		sqlSession.insert("TaskManageMapper.insertTriggerArSched", map);
	}
}
