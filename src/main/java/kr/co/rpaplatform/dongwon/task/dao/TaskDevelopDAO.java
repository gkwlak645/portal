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

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import kr.co.rpaplatform.dongwon.task.vo.TaskPrcuseSysVO;
import kr.co.rpaplatform.dongwon.task.vo.TaskReviewVO;
import kr.co.rpaplatform.dongwon.task.vo.TaskVO;

/**
 * 과제 DAO
 * @author LSH
 */
@Repository
public class TaskDevelopDAO {
	
	private final Logger logger = LoggerFactory.getLogger(TaskDevelopDAO.class);
	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	/**
	 * 과제개발 > 메인: 리스트 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectTaskDevelopListCount(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("TaskDevelopMapper.selectTaskDevelopListCount", map);
	}
	
	/**
	 * 과제개발 > 메인: 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectTaskDevelopList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("TaskDevelopMapper.selectTaskDevelopList", map);
	}
	
	/**
	 * 과제개발 > 과제등록: 자동채번
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public String getTaskDevelopMaxTaskCd(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("TaskDevelopMapper.getTaskDevelopMaxTaskCd", map);
	}
	
	
	/**
	 * 과제개발 > 과제등록 > 등록: 과제코드 중복확인
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int chkTaskDevelopTaskCd(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("TaskDevelopMapper.chkTaskDevelopTaskCd", map);
	}
	
	
	/**
	 * 과제개발 > 등록화면 > 등록 > insert
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void insertTaskDevelop(Map<String, Object> map) throws Exception {
		sqlSession.insert("TaskDevelopMapper.insertTaskDevelop", map);
	}
	
	
	/**
	 * 과제개발 > 과제 상세 > getData
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getTaskDevelopDetail(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("TaskDevelopMapper.getTaskDevelopDetail", map);
	}
	
	/**
	 * 과제개발 > 과제 상세 > 저장
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void updateTaskDevelop(Map<String, Object> map) throws Exception {
		sqlSession.update("TaskDevelopMapper.updateTaskDevelop", map);
	}
	

	/**
	 * 과제개발 > 과제 상세 > 삭제: 과제에 속한 프로세스 수
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int getTaskDevelopProcessCnt(Map<String, Object> map) throws Exception {
		 return sqlSession.update("TaskDevelopMapper.getTaskDevelopProcessCnt", map);
	}
	
	/**
	 * 과제개발 > 과제 상세 > 삭제: 삭제 실행
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void deleteTaskDevelop(Map<String, Object> map) throws Exception {
		sqlSession.update("TaskDevelopMapper.deleteTaskDevelop", map);
	}
	
	/**
	 * 과제개발 > 프로세스 등록 사용자 번호, 이메일 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getUserInfo(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("TaskDevelopMapper.getUserInfo", map);
	}
	
	public int chkOverlapProcessCd(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("TaskDevelopMapper.chkOverlapProcessCd", map);
	}
	
	public int chkOverlapProcessCdType2(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("TaskDevelopMapper.chkOverlapProcessCdType2", map);
	}
	
	public int chkOverlapProcessCdType3(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("TaskDevelopMapper.chkOverlapProcessCdType3", map);
	}
	
	/**
	 * 과제개발 > 프로세스 등록화면 > 프로세스 SN 채번
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getMaxProcessNo(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("TaskDevelopMapper.getMaxProcessNo", map);
	}
	
	/**
	 * 과제개발 > 프로세스 등록화면 > 등록 > insert
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void insertTaskProcess(Map<String, Object> map) throws Exception {
		sqlSession.insert("TaskDevelopMapper.insertTaskProcess", map);
	}
	
	public void insertTaskProcessCharger(Map<String, Object> map) throws Exception {
		sqlSession.insert("TaskDevelopMapper.insertTaskProcessCharger", map);
	}
	
	public void deleteTaskProcessCharger(Map<String, Object> map) throws Exception {
		sqlSession.delete("TaskDevelopMapper.deleteTaskProcessCharger", map);
	}
	
	public void insertTaskProcessRedcnTm(Map<String, Object> map) throws Exception {
		sqlSession.insert("TaskDevelopMapper.insertTaskProcessRedcnTm", map);
	}
	
	public void deletTaskProcessRedcnTm(Map<String, Object> map) throws Exception {
		sqlSession.insert("TaskDevelopMapper.deletTaskProcessRedcnTm", map);
	}
	
	public void insertTaskProcessContribute(Map<String, Object> map) throws Exception {
		sqlSession.insert("TaskDevelopMapper.insertTaskProcessContribute", map);
	}
	
	public void deleteTaskProcessContribute(Map<String, Object> map) throws Exception {
		sqlSession.insert("TaskDevelopMapper.deleteTaskProcessContribute", map);
	}
	
	
	/**
	 * 과제개발 > 프로세스 상세: getData
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getTaskDevelopProcessDetail(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("TaskDevelopMapper.getTaskDevelopProcessDetail", map);
	}
	
	/**
	 * 과제개발 > 프로세스 엑셀 다운로드: getData
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getTaskDevelopProcessDetail2(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("TaskDevelopMapper.getTaskDevelopProcessDetail2", map);
	}
	
	/**
	 * 과제개발 > 프로세스 상세 > 연관시스템 검색: 리스트 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectCntcSysListCount(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("TaskDevelopMapper.selectCntcSysListCount", map);
	}
	
	/**
	 * 과제개발 > 프로세스 상세 > 연관시스템 검색: 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCntcSysList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("TaskDevelopMapper.selectCntcSysList", map);
	}
	
	
	/**
	 * 과제 코드 조회
	 * @return 
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getTaskCdListByClsCd(Map<String, Object> map) {
		return sqlSession.selectList("getTaskCdListByClsCd", map);
	}
	
	/**
	 * 과제개발 > 프로세스 상세 > 저장: 프로세스 이력번호 생성
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int getTaskProcessHistNo(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("TaskDevelopMapper.getTaskProcessHistNo", map);
	}
	
	
	/**
	 * 과제개발 > 프로세스 상세 > 저장: 프로세스 과거 이력 저장
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void insertTaskProcessHist(Map<String, Object> map) throws Exception {
		sqlSession.insert("TaskDevelopMapper.insertTaskProcessHist", map);
	}
	
	/**
	 * 과제개발 > 프로세스 상세 > 저장: 프로세스 변경 이력 저장
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void insertTaskProcessChangeHist(Map<String, Object> map) throws Exception {
		sqlSession.insert("TaskDevelopMapper.insertTaskProcessChangeHist", map);
	}
	
	/**
	 * 과제개발 > 프로세스 상세 > 저장: 프로세스 정보 업데이트
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void updateTaskProcess(Map<String, Object> map) throws Exception {
		sqlSession.update("TaskDevelopMapper.updateTaskProcess", map);
	}
	
	
	/**
	 * 과제개발 개발요청,운영취소 > 결재완료 후 프로세스 상태 업데이트 
	 * @param map
	 * @return 
	 * @return
	 * @throws Exception
	 */
	public int updateTaskProcessSttus(Map<String, Object> map) throws Exception {
		return sqlSession.update("TaskDevelopMapper.updateTaskProcessSttus", map);
	}
	
	/**
	 * 과제개발 > 프로세스 상세 > 저장: 담당자 정보 이력 저장
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void insertTaskProcessChargerHist(Map<String, Object> map) throws Exception {
		sqlSession.insert("TaskDevelopMapper.insertTaskProcessChargerHist", map);
	}
	
	/**
	 * 과제개발 > 프로세스 상세 > 저장: 개인별 절감시간 이력 저장
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void insertTaskProcessRedcnTmHist(Map<String, Object> map) throws Exception {
		sqlSession.insert("TaskDevelopMapper.insertTaskProcessRedcnTmHist", map);
	}
	
	/**
	 * 과제개발 > 프로세스 상세 > 저장: 개인별 기여도 정보 저장
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void insertTaskProcessContributeHist(Map<String, Object> map) throws Exception {
		sqlSession.insert("TaskDevelopMapper.insertTaskProcessContributeHist", map);
	}
	
	/**
	 * 과제개발 > 프로세스 상세 > 저장: 연관 시스템 이력 저장
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void insertTaskDevlopProcessCntcSysHist(Map<String, Object> map) throws Exception {
		sqlSession.insert("TaskDevelopMapper.insertTaskDevlopProcessCntcSysHist", map);
	}
	
	/**
	 * 과제개발 > 프로세스 상세 > 저장: 연관 시스템 저장
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void insertTaskDevlopProcessCntcSys(Map<String, Object> map) throws Exception {
		sqlSession.insert("TaskDevelopMapper.insertTaskDevlopProcessCntcSys", map);
	}
	
	
	/**
	 * 과제개발 > 프로세스 상세 > 저장: 연관 시스템 저장 정보외 나머지 삭제
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void deleteTaskDevlopProcessCntcSys(Map<String, Object> map) throws Exception {
		sqlSession.delete("TaskDevelopMapper.deleteTaskDevlopProcessCntcSys", map);
	}
	
	
	
	/**
	 * 과제개발 > 프로세스 등록화면 > 결재요청 > fail
	 * @param map
	 * @return
	 * @throws Exception
	 */
	//과제별 프로세스 개인별 기여도 delete
	public void deleteTaskProcessContribute2(Map<String, Object> map) throws Exception {
		sqlSession.delete("TaskDevelopMapper.deleteTaskProcessContribute2", map);
	}
	
	//과제별 프로세스 과제별 절감시간 delete
	public void deletTaskProcessRedcnTm2(Map<String, Object> map) throws Exception {
		sqlSession.delete("TaskDevelopMapper.deletTaskProcessRedcnTm2", map);
	}
	
	//과제별 프로세스 담당자 delete
	public void deleteTaskProcessCharger2(Map<String, Object> map) throws Exception {
		sqlSession.insert("TaskDevelopMapper.deleteTaskProcessCharger2", map);
	}
	
	//프로세스 delete
	public void deleteTaskProcess(Map<String, Object> map) throws Exception {
		sqlSession.insert("TaskDevelopMapper.deleteTaskProcess", map);
	}
	
	
}
