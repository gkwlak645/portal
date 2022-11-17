/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 7. 14.         LSH        최초 작성
 */
package kr.co.rpaplatform.crontab.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import kr.co.rpaplatform.crontab.dao.CronSchedulDAO;
import kr.co.rpaplatform.dongwon.common.cont.Const;
import kr.co.rpaplatform.dongwon.task.dao.TaskManageDAO;

/**
 * 과제운영 서비스
 * @author LSH
 */
@Service
public class CronSchedulService {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(CronSchedulService.class);

	/**
	 * 과제운영 DAO
	 */
	
	@Resource(name="cronSchedulDAO")
	private CronSchedulDAO cronSchedulDAO;
	
	/*@Resource(name="cronSchedulDAO")
	private CronSchedulDAO cronSchedulDAO;*/

	
	/**
	 * 크론탭 스케쥴 Send Api 리스트 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectSendScheduleCount(Map<String, Object> map) throws Exception {
		return cronSchedulDAO.selectSendScheduleCount(map);
	}
	
	public int selectResveExecutListCount(Map<String, Object> map) throws Exception {
		return cronSchedulDAO.selectResveExecutListCount(map);
	}
	
	/**
	 * 크론탭 스케쥴 Send Api 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSendScheduleList(Map<String, Object> map) throws Exception {
		return cronSchedulDAO.selectSendScheduleList(map);
	}
	
	public List<Map<String, Object>> selectResveExecutList(Map<String, Object> map) throws Exception {
		return cronSchedulDAO.selectResveExecutList(map);
	}
	
	/**
	 * 크론탭 스케쥴 Send Data 수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void updateCronSchedul(Map<String, Object> map) throws Exception {
		cronSchedulDAO.updateCronSchedul(map);
	}
	
	/**
	 * 휴일관리 확인 get data
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getCalendarChkVal(Map<String, Object> map) throws Exception {
		return cronSchedulDAO.getCalendarChkVal(map);
	}
	
	/**
	 * 휴일관리 포함  확인
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectCalendarCount(Map<String, Object> map) throws Exception {
		return cronSchedulDAO.selectCalendarCount(map);
	}
	
	/**
	 * 로그 통계자료 변환 등록
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void insertDailyStsTotLog(Map<String, Object> map) throws Exception {
		cronSchedulDAO.insertDailyStsTotLog(map);
	}

	/**
	 * 하루치 BOT별 동작현황 MERGE INTO
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void insertOrUpdateBotMntrng() throws Exception {
		cronSchedulDAO.insertOrUpdateBotMntrng();
	}
	
	/**
	 * 하루치 BOT별 동작현황 MERGE INTO
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void botMntrngBatchResult() throws Exception {
		cronSchedulDAO.botMntrngBatchResult();
	}
	
	/**
	 * 절감시간 이슈 관리(매월 1일 오전 1시)
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int insertSavingTimeIssueMng() throws Exception {
		return cronSchedulDAO.insertSavingTimeIssueMng();
	}
	
	/**
	 * 절감시간 이슈 관리 - 사유 테이블에 INSERT
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void insertSavingTimeIssueMngResn(Map<String, Object> map) throws Exception {
		cronSchedulDAO.insertSavingTimeIssueMngResn(map);
	}
	
	/**
	 * 절감 시간 이슈 관리 배치 결과
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void savingTimeIssueMngBatchResult() throws Exception {
		cronSchedulDAO.savingTimeIssueMngBatchResult();
	}
	
	/**
	 * BATCH_RESULT 테이블 로그 삭제
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void deleteBatchResult() throws Exception {
		cronSchedulDAO.deleteBatchResult();
	}
	

	/**
	 * 하루치 BOT별 동작현황 기록(성공 여부)
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void insertBotMntrngBatchResult() throws Exception {
		cronSchedulDAO.insertBotMntrngBatchResult();
	}
	
	/**
	 * 맵핑 안된 스케줄 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSchduleInfo() throws Exception {
		return cronSchedulDAO.selectSchduleInfo();
	}
	
	/**
	 * 프로세스 실행 이력 등록
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int insertDailyReExecutLog() throws Exception {
		return cronSchedulDAO.insertDailyReExecutLog();
	}
	
	/**
	 * 재실행 정보 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectReExecutInfo(Map<String, Object> map) throws Exception {
		return cronSchedulDAO.selectReExecutInfo(map);
	}
	
/*	*//**
	 * AR 스케줄러 원본데이터 조회
	 * @param map
	 * @return
	 * @throws Exception
	 *//*
	public Map<String, Object> selectArSchedulInfo(Map<String, Object> map) throws Exception {
		return cronSchedulDAO.selectArSchedulInfo(map);
	}*/
	
	/**
	 * 크론탭 스케쥴 Send Data 수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void updateOriginTrgetAt(Map<String, Object> map) throws Exception {
		cronSchedulDAO.updateOriginTrgetAt(map);
	}
	
	/**
	 * 원본아이디 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int getTargetId(Map<String, Object> map) throws Exception {
		return cronSchedulDAO.getTargetId(map);
	}
	
	/**
	 * 재실행 정보에 원본데이터 추가
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void updateTargetId(Map<String, Object> map) throws Exception {
		cronSchedulDAO.updateTargetId(map);
	}
	
	/**
	 * 재실행 정보 등록
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void insertArReExcInfo(Map<String, Object> map) throws Exception {
		cronSchedulDAO.insertArReExcInfo(map);
	}
	
	/**
	 * AR스케줄 적용여부 변경
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void updateSchApplyAt(Map<String, Object> map) throws Exception {
		cronSchedulDAO.updateSchApplyAt(map);
	}
	
	/**
	 * 성공시 원본데이터 대상여부 N 변경
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void updateRetryTrgetAt(Map<String, Object> map) throws Exception {
		cronSchedulDAO.updateRetryTrgetAt(map);
	}
	
	/**
	 * 성공시 재실행데이터 적용여부 변경
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void updateRetryApplyAt(Map<String, Object> map) throws Exception {
		cronSchedulDAO.updateRetryApplyAt(map);
	}
	
	/**
	 * 파워유저 실행 이력 등록 배치
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int insertPoUserExecutHist() throws Exception {
		return cronSchedulDAO.insertPoUserExecutHist();
	}
	
	/**
	 * 파워유저 실행 이력 등록 배치 for 개발 서버
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int insertPoUserExecutHistForDevServer() throws Exception {
		return cronSchedulDAO.insertPoUserExecutHistForDevServer();
	}
	
	
	/**
	 * 동의어 또는 테이블 이름에 DEV가 있는지 개수 반환
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int isExistDevTableName() throws Exception {
		return cronSchedulDAO.isExistDevTableName();
	}
		
	/**
	 * 종료 다음날 24시가 지나면 재사용 허용금지
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void updateAfterdayRetryInfo() throws Exception {
		cronSchedulDAO.updateAfterdayRetryInfo();
	}
	
	/**
	 * 프로세스별 통계 자료 등록 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void insertStsProc(Map<String, Object> map) throws Exception {
		cronSchedulDAO.insertStsProc(map);
	}
	
	
	/**
	 * 매시 15분에 회사 코드 업데이트
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void updateCmpnyCd() throws Exception {
		cronSchedulDAO.updateCmpnyCd();
	}
	
	
	
	/**
	 * 과제별 통계 자료 등록 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void insertStsTask(Map<String, Object> map) throws Exception {
		cronSchedulDAO.insertStsTask(map);
	}
	
	/**
	 * 로봇별 통계 자료 등록 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void insertStsBot(Map<String, Object> map) throws Exception {
		cronSchedulDAO.insertStsBot(map);
	}
	
	
	/**
	 * Trigger AR 스케줄 생성
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> makeTriggerArSchedule(Map<String, Object> map) throws Exception {
		return cronSchedulDAO.makeTriggerArSchedule(map);
	}
	
	/**
	 * Trigger AR 스케줄 생성 배치 결과
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void makeTriggerArScheduleBatchResult(Map<String, Object> map) throws Exception {
		cronSchedulDAO.makeTriggerArScheduleBatchResult(map);
	}
	
	/**
	 * JOBS이력관리 테이블에서 max(jobid)를 구함
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectJobsMngMaxJobId(Map<String, Object> map) throws Exception {
		return cronSchedulDAO.selectJobsMngMaxJobId(map);
	}
	
	/**
	 * JOBS이력관리  - 배치 스케줄 매일 01:00
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void insertBatchForJobsMng(Map<String, Object> map) throws Exception {
		cronSchedulDAO.insertBatchForJobsMng(map);
	}
}