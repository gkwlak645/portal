/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 6. 16.         LSH
 */
package kr.co.rpaplatform.dongwon.resrce.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import kr.co.rpaplatform.dongwon.stdrinfo.vo.CmmnCdVO;

/**
 * 프로세스 DAO
 * @author LSH
 * 2020. 6. 16.
 */
@Repository
public class ProcessDAO {
	
	private final Logger logger = LoggerFactory.getLogger(ProcessDAO.class);
	
	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	/**
	 * 프로세스 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectProcessList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("selectProcessList", map);
	}
	
	/**
	 * 프로세스 리스트 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectProcessCount(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("selectProcessCount", map);
	}
	
	/**
	 * 프로세스 상세 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectProcessDetail(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("selectProcessDetail", map);
	}
	
	/**
	 * 프로세스 버전 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectProcessVersionList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("selectProcessVersionList", map);
	}
	
	/**
	 * 프로세스 버전 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectProcessVersionCount(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("selectProcessVersionCount", map);
	}
	
	
	/**
	 * 프로세스 버전 날짜 조회 - 게시일
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public String selectVersionOpenTimeDc(Map<String, Object> map) {
		return sqlSession.selectOne("selectVersionOpenTimeDc", map);
	}
	
	/**
	 * 프로세스 버전 날짜 조회 - 사용일
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public String selectVersionUseTimeDc(Map<String, Object> map) {
		return sqlSession.selectOne("selectVersionUseTimeDc", map);
	}
	
	/**
	 * 입력 파라미터 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectProcessInputParameterList(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("selectProcessInputParameterList", map);
	}
	
	/**
	 * 출력 파라미터 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectProcessOutputParameterList(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("selectProcessOutputParameterList", map);
	}
	
	/**
	 * 프로세스 설정 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectProcessEstbs(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("selectProcessEstbs", map);
	}
	
	/**
	 * 프로세스 설정 업데이트를 위한 정보 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectProcessEstbsUpdate(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("selectProcessEstbsUpdate", map);
	}
	
	/**
	 * 과제코드 리스트 조회
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectTaskCdList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("selectTaskCdList", map);
	}
	
	/**
	 * 프로세스 코드 리스트 조회
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectProcessCdList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("selectProcessCdList", map);
	}
	
	/**
	 * 프로세스 코드 조회
	 * @return 
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getProcessCdListByClsCd(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("getProcessCdListByClsCd", map);
	}
	
	
	/**
	 * 프로세스 매핑 등록 > 프로세스, 패키지, 환경 등록여부 확인(TB_TASK_DEVELOP_MAPPER : processCd,processKey,EnvironmentId)
	 * @return 
	 * @return
	 * @throws Exception
	 */
	public int chkOverlapTaskDevelopProcessCdMapper(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("chkOverlapTaskDevelopProcessCdMapper", map);
	}
	
	/**
	 * 프로세스 매핑 등록 > 패키지, 환경 등록여부 확인 (SY_RELEASES : ProcessKey , EnvironmentId)
	 * @return 
	 * @return
	 * @throws Exception
	 */
	public int chkOverlapReleases(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("chkOverlapReleases", map);
	}
	
	/**
	 * 프로세스 매핑 등록 > 프로세스키에 등록된 환경중에서 새로등록 하려는 환경에 로봇이 있는지 확인
		//(SY_RELEASES : ProcessKey , EnvironmentId)
	 * @return 
	 * @return
	 * @throws Exception
	 */
	public int chkOverlapRobotsXEnvironments(Map<String, Object> map) {
		return sqlSession.selectOne("chkOverlapRobotsXEnvironments", map);
	}
	
	
	/**
	 * 프로세스 매핑 등록
	 * @return 
	 * @return
	 * @throws Exception
	 */
	public void insertTaskDevlopProcessMapper(Map<String, Object> map) throws Exception {
		sqlSession.insert("insertTaskDevlopProcessMapper", map);
	}
	
	/**
	 * 프로세스 매핑 inputArguments 수정
 	 * @return 
	 * @return
	 * @throws Exception
	 */
	public void updateIATaskDevlopProcessMapper(Map<String, Object> map) throws Exception {
		sqlSession.update("updateIATaskDevlopProcessMapper", map);
	}

	
	/**
	 * 프로세스 매핑 사용여부 수정 Y > N
 	 * @return 
	 * @return
	 * @throws Exception
	 */
	public void updateUseAtTaskDevlopProcessMapper(Map<String, Object> map) throws Exception {
		sqlSession.update("updateUseAtTaskDevlopProcessMapper", map);
	}




}
