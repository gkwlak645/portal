/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 7. 14.         LSH        최초 작성
 */
package kr.co.rpaplatform.crontab.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

/**
 * 과제운영 DAO
 * @author LSH
 */
@Repository
public class CronSchedulDAO {
	
	private final Logger logger = LoggerFactory.getLogger(CronSchedulDAO.class);
	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	/**
	 * 크론탭 스케쥴 Send Api 리스트 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectSendScheduleCount(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("CronSchedulMapper.selectSendScheduleCount", map);
	}
	
	public int selectResveExecutListCount(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("CronSchedulMapper.selectResveExecutListCount", map);
	}
	
	/**
	 * 크론탭 스케쥴 Send Api 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSendScheduleList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("CronSchedulMapper.selectSendScheduleList", map);
	}
	
	
	public List<Map<String, Object>> selectResveExecutList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("CronSchedulMapper.selectResveExecutList", map);
	}

	/**
	 * 크론탭 스케쥴 Send Data 수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void updateCronSchedul(Map<String, Object> map) throws Exception {
		sqlSession.update("CronSchedulMapper.updateCronSchedul", map);
	}

	/**
	 * 휴일관리 확인 get data
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getCalendarChkVal(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("CronSchedulMapper.getCalendarChkVal", map);
	}
	
	/**
	 * 휴일관리 포함  확인
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectCalendarCount(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("CronSchedulMapper.selectCalendarCount", map);
	}

	/**
	 * 로그 통계자료 변환 등록
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void insertDailyStsTotLog(Map<String, Object> map) throws Exception {
		sqlSession.insert("CronSchedulMapper.insertDailyStsTotLog", map);
	}
	
	/**
	 * 하루치 BOT별 동작현황 MERGE INTO
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void insertOrUpdateBotMntrng() throws Exception {
		sqlSession.insert("CronSchedulMapper.insertOrUpdateBotMntrng");
	}
	
	/**
	 * 하루치 BOT별 동작현황 배치 결과 기록
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void botMntrngBatchResult() throws Exception {
		sqlSession.insert("CronSchedulMapper.botMntrngBatchResult");
	}
	
	
	
	/**
	 * 절감시간 이슈 관리(매월 1일 오전 1시)
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int insertSavingTimeIssueMng() throws Exception {
		return sqlSession.insert("CronSchedulMapper.insertSavingTimeIssueMng");
	}	
	
	/**
	 * 절감시간 이슈 관리 - 사유 테이블에 INSERT
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void insertSavingTimeIssueMngResn(Map<String, Object> map) throws Exception {
		sqlSession.insert("CronSchedulMapper.insertSavingTimeIssueMngResn", map);
	}	

	/**
	 * 절감시간 이슈 관리 배치 결과
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void savingTimeIssueMngBatchResult() throws Exception {
		sqlSession.insert("CronSchedulMapper.savingTimeIssueMngBatchResult");
	}
	
	/**
	 * BATCH_RESULT 테이블 로그 삭제
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void deleteBatchResult() throws Exception {
		sqlSession.delete("CronSchedulMapper.deleteBatchResult");
	}
	
	/**
	 * 하루치 BOT별 동작현황 기록(성공 여부)
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void insertBotMntrngBatchResult() throws Exception {
		sqlSession.insert("CronSchedulMapper.insertBotMntrngBatchResult");
	}
	
	/**
	 * 맵핑 안된 스케줄 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSchduleInfo() throws Exception {
		return sqlSession.selectList("CronSchedulMapper.selectSchduleInfo");
	}
	
	/**
	 * 프로세스 실행 이력 등록
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int insertDailyReExecutLog() throws Exception {
		return sqlSession.insert("CronSchedulMapper.insertDailyReExecutLog");
	}
	
	/**
	 * 재실행 정보 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectReExecutInfo(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("CronSchedulMapper.selectReExecutInfo", map);
	}
	
	/**
	 * AR 스케줄러 원본데이터 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectArSchedulInfo(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("CronSchedulMapper.selectArSchedulInfo", map);
	}
	
	/**
	 * 크론탭 스케쥴 Send Data 수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void updateOriginTrgetAt(Map<String, Object> map) throws Exception {
		sqlSession.update("CronSchedulMapper.updateOriginTrgetAt", map);
	}
	
	/**
	 * 원본아이디 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int getTargetId(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("CronSchedulMapper.getTargetId", map);
	}
	
	/**
	 * 재실행 데이터에 원본데이터 추가
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void updateTargetId(Map<String, Object> map) throws Exception {
		sqlSession.update("CronSchedulMapper.updateTargetId", map);
	}
	
	/**
	 * 재실행 정보 등록
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void insertArReExcInfo(Map<String, Object> map) throws Exception {
		sqlSession.insert("CronSchedulMapper.insertArReExcInfo", map);
	}
	
	/**
	 * AR스케줄 적용여부 변경
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void updateSchApplyAt(Map<String, Object> map) throws Exception {
		sqlSession.update("CronSchedulMapper.updateSchApplyAt", map);
	}
	
	/**
	 * 성공시 원본데이터 대상여부 N 변경
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void updateRetryTrgetAt(Map<String, Object> map) throws Exception {
		sqlSession.update("CronSchedulMapper.updateRetryTrgetAt", map);
	}
	
	/**
	 * 성공시 재실행 데이터 적용여부 1 변경
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void updateRetryApplyAt(Map<String, Object> map) throws Exception {
		sqlSession.update("CronSchedulMapper.updateRetryApplyAt", map);
	}
	
	/**
	 * 파워유저 실행 이력 등록 배치
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int insertPoUserExecutHist() throws Exception {
		return sqlSession.insert("CronSchedulMapper.insertPoUserExecutHist");
	}
	
	/**
	 * 파워유저 실행 이력 등록 배치 for 개발 서버
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int insertPoUserExecutHistForDevServer() throws Exception {
		return sqlSession.insert("CronSchedulMapper.insertPoUserExecutHistForDevServer");
	}	
	
	/**
	 * 파워유저 실행 이력 등록 배치
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int isExistDevTableName() throws Exception {
		return sqlSession.selectOne("CronSchedulMapper.isExistDevTableName");
	}
	
	/**
	 * 종료 다음날 24시가 지나면 재사용 허용금지
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void updateAfterdayRetryInfo() throws Exception {
		sqlSession.update("CronSchedulMapper.updateAfterdayRetryInfo");
	}
	
	/**
	 * 프로세스별 통계자료 등록
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void insertStsProc(Map<String, Object> map) throws Exception {
		sqlSession.insert("CronSchedulMapper.insertStsProc", map);
	}

	/**
	 * 매 15분에 회사 코드 업데이트
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void updateCmpnyCd() throws Exception {
		sqlSession.update("CronSchedulMapper.updateCmpnyCd");
	}
	
	
	/**
	 * 과제별 통계자료 등록
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void insertStsTask(Map<String, Object> map) throws Exception {
		sqlSession.insert("CronSchedulMapper.insertStsTask", map);
	}
	
	/**
	 * 로봇별 통계자료 등록
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void insertStsBot(Map<String, Object> map) throws Exception {
		sqlSession.insert("CronSchedulMapper.insertStsBot", map);
	}
	
	
	
	/**
	 * Trigger AR 스케줄 생성
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> makeTriggerArSchedule(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("CronSchedulMapper.makeTriggerArSchedule", map);
	}
	
	/**
	 * JOBS이력관리 테이블에서 max(jobid)를 구함
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectJobsMngMaxJobId(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("CronSchedulMapper.selectJobsMngMaxJobId", map);
	}
	
	
	/**
	 * JOBS이력관리  - 배치 스케줄 매일 01:00
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void insertBatchForJobsMng(Map<String, Object> map) throws Exception {
		sqlSession.insert("CronSchedulMapper.insertBatchForJobsMng", map);
	}
	
	
	/**
	 * 하루치 BOT별 동작현황 기록(성공 여부)
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void makeTriggerArScheduleBatchResult(Map<String, Object> map) throws Exception {
		sqlSession.insert("CronSchedulMapper.makeTriggerArScheduleBatchResult", map);
	}
}
