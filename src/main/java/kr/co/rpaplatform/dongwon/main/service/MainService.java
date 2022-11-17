package kr.co.rpaplatform.dongwon.main.service;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

//import org.apache.log4j.MDC;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.MDC;
import org.springframework.stereotype.Service;

import kr.co.rpaplatform.dongwon.author.service.AuthorService;
import kr.co.rpaplatform.dongwon.author.vo.AuthorVO;
import kr.co.rpaplatform.dongwon.common.vo.CmmnUserVO;
import kr.co.rpaplatform.dongwon.main.dao.MainDAO;
import kr.co.rpaplatform.dongwon.resrce.dao.RobotDAO;


@Service
public class MainService {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(MainService.class);
	
	/**
	 * 로그인 DAO
	 */
	@Resource(name="mainDAO")
	private MainDAO mainDAO;

	/**
	 * 권한 서비스
	 */
	@Resource(name="authorService")
	private AuthorService authorService;
	
	/**
	 * 로봇 DAO
	 */
	@Resource(name="robotDAO")
	private RobotDAO robotDAO;
	
	
	
	/**
	 * 메인 - 로그인 유저 권한 확인
	 * @return
	 * @param map
	 * @throws Exception
	 */
	public String getMainUserRoleCd(Map<String, Object> map) throws Exception {
		return mainDAO.selectMainUserRoleCd(map);
	}
	
	
	/**
	 * 권한 확인 
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getUserAuthor (Map<String, Object> map) throws Exception {
		
		//메인(1_1) - RPA현황					: "/task/manage"
		//메인(2_1) - 나의 프로세스				: "/task/manage"
		//메인(2_2) - 헬프데스크 처리요청 리스트		: "/hlpdsk/requst"
		//메인(2_3) - Automation index		: "/task/manage"
		//메인(2_4) - 시스템작업공지 리스트			: "/cmmnty/sysOpertNotice"
		//메인(2_5) - 실행결과 개수				: "/mntrng/jobmntrng"
		//메인(3_1) - 오늘의 프로세스 실행현황		: "/mntrng/jobmntrng"
		
		AuthorVO screenAuthor = authorService.getUserAuthorByUrl((String)map.get("url"));
		
		if(screenAuthor == null || (screenAuthor.getUntenantAuthor() != null && !"".equals(screenAuthor.getUntenantAuthor()) && !"Y".equals(screenAuthor.getUntenantAuthor()))) {
			String cmpnyCd = "W".equals(MDC.get("txCmpnyCd")) ? "" :  MDC.get("txCmpnyCd");
			map.put("cmpnyCd",cmpnyCd);
			map.put("untenantAuthor", "N");
		}
		
		return map;
	}
	
	
	/**
	 * 읽기 권한 확인 
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getUserRedngAuthor (Map<String, Object> map) throws Exception {
		
		AuthorVO screenAuthor = authorService.getUserAuthorByUrl((String)map.get("url"));
		
		//읽기 권한 체크
		String redngAuthor = screenAuthor == null || screenAuthor.getRedngAuthor() == null || screenAuthor.getRedngAuthor() == ""  ? "N" : screenAuthor.getRedngAuthor();
		map.put("redngAuthor", redngAuthor);
		
		return map;
	}
	
	
	/**
	 * 메인(1_1) - RPA현황
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getRPAStatusCnt(Map<String, Object> map) throws Exception {
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		//user 권한 확인
		map.put("url", "/task/manage");
		map = getUserAuthor(map);
		
		if(map.get("cmpnyCd") != null && !"".equals(map.get("cmpnyCd"))) {
			resultMap.put("cmpnyNm", (String)mainDAO.selectCmpnyNm(map).get("cmpnyNm"));
		}else {
			resultMap.put("cmpnyNm", "전체");
		}
		
		//메인 - 효과금액
		resultMap.put("redcnAmt", mainDAO.selectRedcnAmt(map));
		
		//user 읽기 권한 확인
		map.put("url", "/task/manage/taskManageMain");
		map = getUserRedngAuthor(map);
		resultMap.put("processMngRedngAuthor", map.get("redngAuthor"));
		
		//메인 - RPA현황  / 프로세스 - 운영(O1:운영중) 개수
		resultMap.put("processMngCnt", mainDAO.selectTaskProcessCount(map));
		
		//user 읽기 권한 확인
		map.put("url", "/resrce/robot/robotMngMain");
		map = getUserRedngAuthor(map);
		resultMap.put("robotRedngAuthor", map.get("redngAuthor"));
		
		//메인 - RPA현황  / 봇수
		resultMap.put("robotCnt", robotDAO.selectRobotCount(map));
		
		//메인 - 성공률
		resultMap.put("succesRt", mainDAO.selectSuccesRtCount(map));
				
		//메인 - 절감률
		resultMap.put("redcnRt", mainDAO.selectRedcnRtCount(map));		
				
		
		return resultMap;
	}
	
	
	
	/**
	 * 메인(1_2) - 부분별 프로세스 현황
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	public Map<String, Object> getClsProcessStatusCnt(Map<String, Object> map) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		//user 권한 확인
		map.put("url", "/task/manage");
		map = getUserAuthor(map);
		
		if(map.get("cmpnyCd") != null && !"".equals(map.get("cmpnyCd"))) {
			resultMap.put("cmpnyNm", (String)mainDAO.selectCmpnyNm(map).get("cmpnyNm"));
		}else {
			resultMap.put("cmpnyNm", "전체");
		}
		
		//user 읽기 권한 확인
		map.put("url", "/task/manage/taskManageMain");
		map = getUserRedngAuthor(map);
		resultMap.put("processMngRedngAuthor", map.get("redngAuthor"));
		
		//메인 - 부분별 프로세스 현황
		resultMap.put("clsProcessStatusCntList", mainDAO.selectClsProcessStatusCnt(map));
		
		return resultMap;
	}
	
	
	/**
	 * 메인(2_1) - 나의 프로세스
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getTaskProcessCnt(Map<String,Object> map) throws Exception {
		
		Map<String, Object> responseMap = new HashMap<String, Object>();
		
		//user 권한 확인
		map.put("url", "/task/manage");
		map = getUserAuthor(map);
		
		//TB_CMMN_CLS_CD 공통코드 0037-프로세스상태 //sttus
		List<String> sttusList = new ArrayList<String>();
		
		//메인 - 나의 프로세스  / 운영(O1:운영중,D4:개발완료) 개수
		//user 읽기 권한 확인
		map.put("url", "/task/manage/taskManageMain");
		map = getUserRedngAuthor(map);
		responseMap.put("taskProcessMngAuthor", map.get("redngAuthor"));
		
		sttusList.add("D4");
		sttusList.add("O1");
		map.put("sttusList", sttusList);
		responseMap.put("taskProcessMngCnt", mainDAO.selectMyTaskProcessCount(map));
		
		//메인 - 나의 프로세스  / 개발(D1:개발접수,D3:개발중) 개수
		//user 읽기 권한 확인
		map.put("url", "/task/develop/taskDevelopMain");
		map = getUserRedngAuthor(map);
		responseMap.put("taskProcessDevAuthor", map.get("redngAuthor"));
		sttusList = new ArrayList<String>();
		sttusList.add("D1");
		sttusList.add("D3");
		map.remove("sttusList");
		map.put("sttusList", sttusList);
		responseMap.put("taskProcessDevCnt", mainDAO.selectMyTaskProcessCount(map));
		
		//메인 - 나의 프로세스  / 아이디어(02:등록취소 제외) 개수 
		//user 읽기 권한 확인
		map.put("url", "/task/idea/taskIdeaMain");
		map = getUserRedngAuthor(map);
		responseMap.put("taskIdeaAuthor", map.get("redngAuthor"));
		responseMap.put("taskIdeaCnt", mainDAO.selectMyTaskIdeaCount(map));
		
		return responseMap;
	}

	
	
	/**
	 * 메인(2_2) - 헬프데스크 처리요청 리스트
	 * @return
	 * @throws Exception
	 */
	public List<Map<String,Object>> getHlpdsk(Map<String,Object> map) throws Exception {
		//user 권한 확인
		map.put("url", "/hlpdsk/requst");
		map = getUserAuthor(map);
		return mainDAO.selectHlpdskList(map);
	}
	
	
	/**
	 * 메인(2_3) - Automation index
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getAutomationIndexCnt(Map<String,Object> map) throws Exception {
		
		Map<String, Object> responseMap = new HashMap<String, Object>();
		
		//user 권한 확인
		map.put("url", "/task/manage");
		map = getUserAuthor(map);
		
		//절감시간
		responseMap.put("sumRedcnTm", mainDAO.selectRedcnTm(map));
		
		//개선지수
		responseMap.put("sumImprvm", String.format("%.2f", mainDAO.selectImprvm(map)));
		
		return responseMap;
	}


	/**
	 * 메인(2_4) - 시스템작업공지 리스트
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getSysOpertNoticeList(Map<String, Object> map) throws Exception {
		
		//user 권한 확인
		map.put("url", "/cmmnty/sysOpertNotice");
		map = getUserAuthor(map);
		
		return mainDAO.selectSysOpertNoticeList(map);
	}
	
	
	/**
	 * 메인(2_5) - 실행결과 개수
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getJobsCnt(Map<String, Object> map) throws Exception {
		
		Map<String, Object> responseMap = new HashMap<String, Object>();
		
		//user 권한 확인
		map.put("url", "/mntrng/jobmntrng");
		map = getUserAuthor(map);
		
		List<String> stateList = new ArrayList<String>();
		
		//TB_CMMN_CLS_CD 공통코드 0015-작업상태 //STATE
		
		//실행결과-성공
		stateList.add("5"); //성공
		map.put("stateList", stateList);
		responseMap.put("jobsSucCnt", mainDAO.selectJobsCount(map));
		
		//실행결과-실패
		stateList = new ArrayList<String>();
		stateList.add("2"); //중지중
		stateList.add("3"); //종료중
		stateList.add("4"); //오류발생
		stateList.add("6"); //중지됨
		stateList.add("7"); //일시 중지됨
		stateList.add("8"); //다시 시작됨
		map.remove("stateList");
		map.put("stateList", stateList);
		responseMap.put("jobsFaiCnt", mainDAO.selectJobsCount(map));

		//실행결과-보류
		stateList = new ArrayList<String>();
		stateList.add("0"); //보류중
		map.remove("stateList");
		map.put("stateList", stateList);
		responseMap.put("jobsPenCnt", mainDAO.selectJobsCount(map));
		
		//user 읽기 권한 확인
		map.put("url", "/mntrng/jobmntrng/jobMntrngMain");
		map = getUserRedngAuthor(map);
		responseMap.put("jobsAuthor", map.get("redngAuthor"));
		
		return responseMap;
	}
	
	
	
	/**
	 * 메인(2_6) - 명예의 전당(절감시간)
	 * @return
	 * @param map
	 * @throws Exception
	 */
	public Map<String, Object> getRankRedcnTmList(Map<String, Object> map) throws Exception {
		
		Map<String, Object> responseMap = new HashMap<String, Object>();
		
		//user 권한 확인
		map.put("url", "/cmmnty/cntrbtRank");
		map = getUserAuthor(map);
		
		responseMap.put("rankRedcnTmList", mainDAO.selectRankRedcnTmCntrbtList(map));
		
		//user 읽기 권한 확인
		map.put("url", "/cmmnty/cntrbtRank/cntrbtRankMain");
		map = getUserRedngAuthor(map);
		responseMap.put("rankAuthor", map.get("redngAuthor"));
		
		return responseMap;
	}
	
	
	/**
	 * 메인(2_7) - 명예의 전당(개선지수)
	 * @return
	 * @param map
	 * @throws Exception
	 */
	public Map<String, Object> getRankCntrbtList(Map<String, Object> map) throws Exception {
		
		Map<String, Object> responseMap = new HashMap<String, Object>();
		
		//user 권한 확인
		map.put("url", "/cmmnty/cntrbtRank");
		map = getUserAuthor(map);
		
		responseMap.put("rankCntrbtList", mainDAO.selectRankRedcnTmCntrbtList(map));
		
		//user 읽기 권한 확인
		map.put("url", "/cmmnty/cntrbtRank/cntrbtRankMain");
		map = getUserRedngAuthor(map);
		responseMap.put("rankAuthor", map.get("redngAuthor"));
		
		return responseMap;
	}
	
	
	
	/**
	 * 메인(2_8) - RPA 담당자
	 * @return
	 * @param map
	 * @throws Exception
	 */
	public Map<String, Object> getRpaChargerList(Map<String, Object> map) throws Exception {
		Map<String, Object> responseMap = new HashMap<String, Object>();
		
		//user 권한 확인
		map.put("url", "/orgnzt/user");
		map = getUserAuthor(map);
		
		responseMap.put("rpaChargerList", mainDAO.selectRpaChargerList(map));
		
		//user 읽기 권한 확인
		map.put("url", "/orgnzt/user/userManageListMain");
		map = getUserRedngAuthor(map);
		responseMap.put("chargerAuthor", map.get("redngAuthor"));

		return responseMap;
	}
	
	
	/**
	 * 메인(2_9) - 절감시간 Top3
	 * @return
	 * @param map
	 * @throws Exception
	 */
	public Map<String, Object> getTopRedcnTmList(Map<String, Object> map) throws Exception {
		Map<String, Object> responseMap = new HashMap<String, Object>();
		
		//user 권한 확인
		map.put("url", "/task/manage");
		map = getUserAuthor(map);
		
		responseMap.put("topRedcnTmList", mainDAO.selectTopRedcnTmList(map));
		
		return responseMap;
	}
	
	
	
	/**
	 * 메인(3_1) - 오늘의 프로세스 실행현황
	 * @return
	 * @param map
	 * @throws Exception
	 */
	public Map<String, Object> getTodayProcessList(HttpServletRequest request,Map<String, Object> map) throws Exception {
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		//user 권한 확인
		map.put("url", "/mntrng/jobmntrng");
		map = getUserAuthor(map);
		
		resultMap.put("listType", mainDAO.selectTodayProcessUserRoleCd(map));	
		resultMap.put("todayProcessList", mainDAO.selectTodayProcessList(map));		
		
		if(map.get("untenantAuthor") != null && !"".equals(map.get("untenantAuthor")) && "N".equals(map.get("untenantAuthor"))) {
			resultMap.put("cmpnyCd", map.get("cmpnyCd"));	
		}
		
		//user 읽기 권한 확인
		map.put("url", "/mntrng/jobmntrng/jobMntrngMain");
		map = getUserRedngAuthor(map);
		resultMap.put("jobsAuthor", map.get("redngAuthor"));
		
		return resultMap;
	}
	
	
	/**
	 * 메인(3_2) - 신규등록 프로세스
	 * @return
	 * @param map
	 * @throws Exception
	 */
	public Map<String, Object> getNewProcessList(HttpServletRequest request, Map<String, Object> map) throws Exception {
Map<String, Object> resultMap = new HashMap<String, Object>();
		
		//user 권한 확인
		map.put("url", "/task/manage");
		map = getUserAuthor(map);
		
		//TB_CMMN_CLS_CD 공통코드 0037-프로세스상태 //sttus
		List<String> sttusList = new ArrayList<String>();
		
		if(map.get("listType") != null && "D".equals(map.get("listType")) && "D".equals(map.get("listType"))) {
			//개발(D1:개발접수,D3:개발중) 
			
			//user 읽기 권한 확인
			map.put("url", "/task/develop/taskDevelopMain");
			map = getUserRedngAuthor(map);
			resultMap.put("newDevAuthor", map.get("redngAuthor"));
			
			sttusList.add("D1");
			sttusList.add("D3");
			map.put("sttusList", sttusList);
			
		}else if(map.get("listType") != null && "D".equals(map.get("listType")) && "M".equals(map.get("listType"))) {
			//운영(O1:운영중,D4:개발완료) 개수
			
			//user 읽기 권한 확인
			map.put("url", "/task/manage/taskManageMain");
			map = getUserRedngAuthor(map);
			resultMap.put("newMngAuthor", map.get("redngAuthor"));
			
			sttusList.add("D4");
			sttusList.add("O1");
			map.put("sttusList", sttusList);
			
		}else {}
		
		//resultMap.put("listType", mainDAO.selectTodayProcessUserRoleCd(map));	
		resultMap.put("newProcessList", mainDAO.selectNewProcessList(map));		
		
		return resultMap;
	}
	

	
	/**
	 * 임원메인
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	public Map<String, Object> getOwnerMainList(Map<String, Object> map) throws Exception {
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("resultList", mainDAO.selectOwnerMainList(map));	
		
		return resultMap;
	}
	
	public Map<String, Object> searchType2Card1_1_sch1(Map<String, Object> map) throws Exception {
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("resultList1", mainDAO.searchType2Card1_1_sch1_1(map));
		resultMap.put("resultList2", mainDAO.searchType2Card1_1_sch1_2(map));	
		return resultMap;
	}
	
	
	/**/
	public Map<String, Object> searchType2Card1_1_sch2(Map<String, Object> map) throws Exception {
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("resultList1", mainDAO.searchType2Card1_1_sch2_1(map));
		resultMap.put("resultList2", mainDAO.searchType2Card1_1_sch2_2(map));	
		
		return resultMap;
	}
	
	
	/**/
	/**
	 * 임원메인 - 가동률 조회
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	public Map<String, Object> getOwnerMainOperRateList(Map<String, Object> map) throws Exception {
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("resultList", mainDAO.selectOwnerMainOperRateList(map));
		
		return resultMap;
	}
	
	/**/
	/**
	 * 임원메인 - 성공률 조회
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	public Map<String, Object> getOwnerMainSuccRateList(Map<String, Object> map) throws Exception {
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("resultList", mainDAO.selectOwnerMainSuccRateList(map));
		
		return resultMap;
	}

}
