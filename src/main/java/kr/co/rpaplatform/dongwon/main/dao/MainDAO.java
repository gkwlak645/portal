package kr.co.rpaplatform.dongwon.main.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

@Repository
public class MainDAO {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(MainDAO.class);

	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	
	/**
	 * 메인 - 로그인 유저 권한 확인
	 * @return
	 * @param map
	 * @throws Exception
	 */
	public String selectMainUserRoleCd(Map<String, Object> map) throws Exception{
		return sqlSession.selectOne("MainMapper.selectMainUserRoleCd", map);
	}
	
	/**
	 * 메인 - 회사명 찾기
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectCmpnyNm(Map<String, Object> map) throws Exception{
		return sqlSession.selectOne("MainMapper.selectCmpnyNm", map);
	}
	
	/**
	 * 메인(1_1) - RPA현황  / 효과금액
	 * @return
	 * @throws Exception
	 */
	public int selectRedcnAmt(Map<String, Object> map) throws Exception{
		return sqlSession.selectOne("MainMapper.selectRedcnAmt", map);
	}
	
	/**
	 * 메인(1_1) - RPA현황  / 프로세스
	 * @return
	 * @throws Exception
	 */
	public int selectTaskProcessCount(Map<String, Object> map) throws Exception{
		return sqlSession.selectOne("MainMapper.selectTaskProcessCount", map);
	}
	
	
	/**
	 * 메인(1_1) - RPA현황  / 성공률
	 * @return
	 * @throws Exception
	 */
	public int selectSuccesRtCount(Map<String, Object> map) throws Exception{
		return sqlSession.selectOne("MainMapper.selectSuccesRtCount", map);
	}
	
	/**
	 * 메인(1_1) - RPA현황  / 절감률
	 * @return
	 * @throws Exception
	 */
	public int selectRedcnRtCount(Map<String, Object> map) throws Exception{
		return sqlSession.selectOne("MainMapper.selectRedcnRtCount", map);
	}
	
	
	/**
	 * 메인(1_2) - 부분별 프로세스 현황
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectClsProcessStatusCnt(Map<String, Object> map) throws Exception{
		return sqlSession.selectList("MainMapper.selectClsProcessStatusCnt", map);
	}
	
	
	/**
	 * 메인(2_1) - 나의 프로세스  / 아이디어 개수
	 * @return
	 * @throws Exception
	 */
	public int selectMyTaskIdeaCount(Map<String, Object> map) throws Exception{
		return sqlSession.selectOne("MainMapper.selectMyTaskProcessCount", map);
	}
	
	
	/**
	 * 메인(2_1) - 나의 프로세스  / 운영(O1:운영중), 개발(D3:개발중,D4:개발완료) 개수 
	 * @return
	 * @throws Exception
	 */
	public int selectMyTaskProcessCount(Map<String, Object> map) throws Exception{
		return sqlSession.selectOne("MainMapper.selectMyTaskProcessCount", map);
	}
	

	/**
	 * 메인(2_2) - 헬프데스크 처리요청 리스트
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectHlpdskList(Map<String, Object> map) throws Exception{
		return sqlSession.selectList("MainMapper.selectMainHlpdskList", map);
	}
	
	
	/**
	 * 메인(2_3) - Automation Index  / 절감시간
	 * @return
	 * @throws Exception
	 */
	public int selectRedcnTm(Map<String, Object> map) throws Exception{
		return sqlSession.selectOne("MainMapper.selectRedcnTm", map);
	}
	
	
	/**
	 * 메인(2_3) - Automation Index  / 개선지수
	 * @return
	 * @throws Exception
	 */
	public float selectImprvm(Map<String, Object> map) throws Exception{
		return sqlSession.selectOne("MainMapper.selectImprvm", map);
	}


	/**
	 * 메인(2_4) - 시스템작업공지 리스트
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSysOpertNoticeList(Map<String, Object> map) throws Exception{
		return sqlSession.selectList("MainMapper.selectSysOpertNoticeList", map);
	}
	
	
	/**
	 * 메인(2_5) - 실행결과 개수
	 * @return
	 * @throws Exception
	 */
	public int selectJobsCount(Map<String, Object> map) throws Exception{
		return sqlSession.selectOne("MainMapper.selectJobsCount", map);
	}
	
	
	/**
	 * 메인(2_6) - 명예의 전당(절감시간) / 메인(2_7) - 명예의 전당(개선지수)
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectRankRedcnTmCntrbtList(Map<String, Object> map) throws Exception{
		return sqlSession.selectList("MainMapper.selectRankRedcnTmCntrbtList", map);
	}
	
	
	/**
	 * 메인(2_8) - RPA 담당자
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectRpaChargerList(Map<String, Object> map) {
		return sqlSession.selectList("MainMapper.selectRpaChargerList", map);
	}
	
	/**
	 * 메인(2_9) - 절감시간 Top3
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectTopRedcnTmList(Map<String, Object> map) {
		return sqlSession.selectList("MainMapper.selectTopRedcnTmList", map);
	}
	
	
	/**
	 * 메인(3_1) - 오늘의 프로세스 실행현황
	 * @return
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectTodayProcessList(Map<String, Object> map) throws Exception{
		return sqlSession.selectList("MainMapper.selectTodayProcessList", map);
	}
	
	/**
	 * 메인(3_1) - 오늘의 프로세스 실행현황 로그인 사용자의 역활정보 체크
	 * @return
	 * @param map
	 * @throws Exception
	 */
	public String selectTodayProcessUserRoleCd(Map<String, Object> map) throws Exception{
		return sqlSession.selectOne("MainMapper.selectTodayProcessUserRoleCd", map);
	}
	
	
	/**
	 * 메인(3_2) - 신규등록 프로세스
	 * @return
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectNewProcessList(Map<String, Object> map) throws Exception{
		return sqlSession.selectList("MainMapper.selectNewProcessList", map);
	}
	
	
	/**
	 * 임원메인
	 * @return
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectOwnerMainList(Map<String, Object> map) throws Exception{
		return sqlSession.selectList("MainMapper.selectOwnerMainList", map);
	}

	/**/
	/**
	 * 임원용 대시보드 > 절감시간, 환산인원
	 * @return
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> searchType2Card1_1_sch1_1(Map<String, Object> map) throws Exception{
		return sqlSession.selectList("MainMapper.searchType2Card1_1_sch1_1", map);
	}
	
	/**
	 * 임원용 대시보드 > 개발과제
	 * @return
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> searchType2Card1_1_sch1_2(Map<String, Object> map) throws Exception{
		return sqlSession.selectList("MainMapper.searchType2Card1_1_sch1_2", map);
	}
	
	
	/**
	 * 임원용 대시보드 > 개발자수
	 * @return
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> searchType2Card1_1_sch2_1(Map<String, Object> map) throws Exception{
		return sqlSession.selectList("MainMapper.searchType2Card1_1_sch2_1", map);
	}
	
	/**
	 * 임원용 대시보드 > 운영봇수
	 * @return
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> searchType2Card1_1_sch2_2(Map<String, Object> map) throws Exception{
		return sqlSession.selectList("MainMapper.searchType2Card1_1_sch2_2", map);
	}

	/**/
	/**
	 * 임원메인 - 가동률 조회
	 * @return
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectOwnerMainOperRateList(Map<String, Object> map) throws Exception{
		return sqlSession.selectList("MainMapper.selectOwnerMainOperRateList", map);
	}
	/**/
	/**
	 * 임원메인 - 성공률 조회
	 * @return
	 * @param map
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectOwnerMainSuccRateList(Map<String, Object> map) throws Exception{
		return sqlSession.selectList("MainMapper.selectOwnerMainSuccRateList", map);
	}
	
}
