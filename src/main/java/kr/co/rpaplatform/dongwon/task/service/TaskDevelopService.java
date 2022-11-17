/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 7. 14.         LSH        최초 작성
 */
package kr.co.rpaplatform.dongwon.task.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import kr.co.rpaplatform.dongwon.common.cont.Const;
import kr.co.rpaplatform.dongwon.task.dao.TaskDevelopDAO;
import kr.co.rpaplatform.dongwon.task.dao.TaskIdeaDAO;

/**
 * 과제 서비스
 * @author LSH
 */
@Service
public class TaskDevelopService {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(TaskDevelopService.class);

	/**
	 * 과제 DAO
	 */
	@Resource(name="taskDevelopDAO")
	private TaskDevelopDAO taskDevelopDAO;
	
	/**
	 * 과제개발 > 메인: 리스트 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectTaskDevelopListCount(Map<String, Object> map) throws Exception {
		return taskDevelopDAO.selectTaskDevelopListCount(map);
	}
	
	/**
	 * 과제개발 > 메인: 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectTaskDevelopList(Map<String, Object> map) throws Exception {
		return taskDevelopDAO.selectTaskDevelopList(map);
	}

	/**
	 * 과제개발 > 과제 등록 > 자동채번
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public String getTaskDevelopMaxTaskCd(Map<String, Object> params) throws Exception {
		return taskDevelopDAO.getTaskDevelopMaxTaskCd(params);
	}
	

	/**
	 * 과제개발 > 과제 등록 > 등록 > 과제코드 중복확인
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int chkTaskDevelopTaskCd(Map<String, Object> params) throws Exception {
		return taskDevelopDAO.chkTaskDevelopTaskCd(params);
	}
	

	/**
	 * 과제개발 > 과제 등록 > 등록 > insert
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void insertTaskDevelop(Map<String, Object> params) throws Exception {
		taskDevelopDAO.insertTaskDevelop(params);
	}
	
	
	/**
	 * 과제개발 > 과제 상세: getData 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getTaskDevelopDetail(Map<String, Object> params) throws Exception {
		return taskDevelopDAO.getTaskDevelopDetail(params);
	}
	
	/**
	 * 과제개발 > 과제 상세 > 저장
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void updateTaskDevelop(Map<String, Object> params) throws Exception {
		taskDevelopDAO.updateTaskDevelop(params);
	}
	
	/**
	 * 과제개발 > 과제 상세 > 삭제: 과제에 속한 프로세스 수
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int getTaskDevelopProcessCnt(Map<String, Object> params) throws Exception {
		return taskDevelopDAO.getTaskDevelopProcessCnt(params);
	}
	
	/**
	 * 과제개발 > 과제 상세 > 삭제: 삭제 실행
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void deleteTaskDevelop(Map<String, Object> params) throws Exception {
		 taskDevelopDAO.deleteTaskDevelop(params);
	}
	
	
	public Map<String, Object> getUserInfo(Map<String, Object> params) throws Exception {
		return taskDevelopDAO.getUserInfo(params);
	}
	
	
	public int chkOverlapProcessCd(Map<String, Object> params) throws Exception {
		return taskDevelopDAO.chkOverlapProcessCd(params);
	}
	
	public int chkOverlapProcessCdType2(Map<String, Object> params) throws Exception {
		return taskDevelopDAO.chkOverlapProcessCdType2(params);
	}
	
	/**
	 * 과제개발 > 프로세스 등록화면 > 프로세스 SN 채번
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getMaxProcessNo(Map<String, Object> params) throws Exception {
		return taskDevelopDAO.getMaxProcessNo(params);
	}
	
	/**
	 * 과제개발 > 프로세스 등록화면 > 등록 > insert
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void insertTaskProcess(Map<String, Object> params) throws Exception {
		taskDevelopDAO.insertTaskProcess(params);
	}
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void insertTaskProcessCharger(Map<String, Object> params) throws Exception {
		taskDevelopDAO.insertTaskProcessCharger(params);
	}
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void deleteTaskProcessCharger(Map<String, Object> params) throws Exception {
		taskDevelopDAO.deleteTaskProcessCharger(params);
	}
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void insertTaskProcessRedcnTm(Map<String, Object> params) throws Exception {
		taskDevelopDAO.insertTaskProcessRedcnTm(params);
	}
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void deletTaskProcessRedcnTm(Map<String, Object> params) throws Exception {
		taskDevelopDAO.deletTaskProcessRedcnTm(params);
	}
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void insertTaskProcessContribute(Map<String, Object> params) throws Exception {
		taskDevelopDAO.insertTaskProcessContribute(params);
	}
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void deleteTaskProcessContribute(Map<String, Object> params) throws Exception {
		taskDevelopDAO.deleteTaskProcessContribute(params);
	}
	
	/**
	 * 과제코드 조회
	 * @param cd
	 * @return
	 * @throws Exception
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public List<Map<String, Object>> getTaskCdListByClsCd(Map<String, Object> map) throws Exception {
		return taskDevelopDAO.getTaskCdListByClsCd(map);
	}
	
	
	/**
	 * 과제개발 > 프로세스 상세: getData
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getTaskDevelopProcessDetail(Map<String, Object> params) throws Exception {
		return taskDevelopDAO.getTaskDevelopProcessDetail(params);
	}
	
	
	/**
	 * 과제개발 > 프로세스 엑셀 다운로드: getData
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getTaskDevelopProcessDetail2(Map<String, Object> params) throws Exception {
		return taskDevelopDAO.getTaskDevelopProcessDetail2(params);
	}
	
	/**
	 * 과제개발 > 프로세스 상세 > 연관시스템 검색: 리스트 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectCntcSysListCount(Map<String, Object> map) throws Exception {
		return taskDevelopDAO.selectCntcSysListCount(map);
	}
	
	/**
	 * 과제개발 > 프로세스 상세 > 연관시스템 검색: 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCntcSysList(Map<String, Object> map) throws Exception {
		return taskDevelopDAO.selectCntcSysList(map);
	}
	
	/**
	 * 과제개발 > 프로세스 상세 > 저장: 프로세스 이력번호 생성
	 * @param map
	 * @return
	 * @throws Exception
	 */
	
	public int getTaskProcessHistNo(Map<String, Object> map) throws Exception {
		return taskDevelopDAO.getTaskProcessHistNo(map);
	}
	
	/**
	 * 과제개발 > 프로세스 상세 > 저장: 프로세스 과거 이력 저장
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void insertTaskProcessHist(Map<String, Object> map) throws Exception {
		taskDevelopDAO.insertTaskProcessHist(map);
	}
	
	/**
	 * 과제개발 > 프로세스 상세 > 저장: 프로세스 변경 이력 저장
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void insertTaskProcessChangeHist(Map<String, Object> map) throws Exception {
		taskDevelopDAO.insertTaskProcessChangeHist(map);
	}
	
	
	/**
	 * 과제개발 > 프로세스 상세 > 저장: 프로세스 정보 업데이트
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateTaskProcess(Map<String, Object> map) throws Exception {
		taskDevelopDAO.updateTaskProcess(map);
	}
	
	
	/**
	 * 과제개발 > 프로세스 상세 > 저장: 담당자 정보 이력 저장
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void insertTaskProcessChargerHist(Map<String, Object> map) throws Exception {
		taskDevelopDAO.insertTaskProcessChargerHist(map);
	}
	
	/**
	 * 과제개발 > 프로세스 상세 > 저장: 개인별 절감시간 이력 저장
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void insertTaskProcessRedcnTmHist(Map<String, Object> map) throws Exception {
		taskDevelopDAO.insertTaskProcessRedcnTmHist(map);
	}
	
	
	/**
	 * 과제개발 > 프로세스 상세 > 저장: 개인별 기여도 이력 저장
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void insertTaskProcessContributeHist(Map<String, Object> map) throws Exception {
		taskDevelopDAO.insertTaskProcessContributeHist(map);
	}
	
	
	/**
	 * 과제개발 > 프로세스 상세 > 저장: 연관 시스템 이력 저장
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void insertTaskDevlopProcessCntcSysHist(Map<String, Object> map) throws Exception {
		taskDevelopDAO.insertTaskDevlopProcessCntcSysHist(map);
	}
	
	/**
	 * 과제개발 > 프로세스 상세 > 저장: 연관 시스템 저장
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void insertTaskDevlopProcessCntcSys(Map<String, Object> map) throws Exception {
		taskDevelopDAO.insertTaskDevlopProcessCntcSys(map);
	}
	
	/**
	 * 과제개발 > 프로세스 상세 > 저장: 연관 시스템 저장 정보외 나머지 삭제
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void deleteTaskDevlopProcessCntcSys(Map<String, Object> map) throws Exception {
		taskDevelopDAO.deleteTaskDevlopProcessCntcSys(map);
	}
	
}
