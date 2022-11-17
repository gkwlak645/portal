package kr.co.rpaplatform.dongwon.mntrng.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import kr.co.rpaplatform.common.exception.RpaException;
import kr.co.rpaplatform.dongwon.mntrng.dao.JobArDAO;
import kr.co.rpaplatform.dongwon.mntrng.dao.JobDAO;
import kr.co.rpaplatform.rpaapi.uipath.api.JobApi;

/**
 * 작업 서비스
 * @author LSH
 *
 */
@Service
public class JobArService {
	
	private final Logger logger = LoggerFactory.getLogger(JobArService.class);
	
	/**
	 * 작업 DAO
	 */
	@Resource(name="jobArDAO")
	private JobArDAO jobArDAO;
	
	/**
	 * 작업 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getJobArList(Map<String, Object> map) throws Exception {
		return jobArDAO.selectJobArList(map);
	}
	
	/**
	 * 작업 리스트 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int getJobArListCount(Map<String, Object> map) throws Exception {
		return jobArDAO.selectJobArListCount(map);
	}
	
	
	/**
	 * 작업 중지
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void stopJobAr(Map<String, Object> map) throws Exception {
		
		//현재 상태값 체크
		String nowSttus = jobArDAO.selectJobArSttus(map);
		
		//대기중, 실행중 일경우 작업 중지
		if("WAIT".equals(nowSttus) || "START".equals(nowSttus)) {
			 map.put("sttus", nowSttus);
			 jobArDAO.stopJobAr(map);
		}else {
		//그 외 오류 처리
			throw new RpaException("E60013", "작업 중지를 실패 하였습니다. 상태를 다시 한번 확인해 주세요.");	 
		}
		
	}
	
	
	/**
	 * '중지중'인 JOB의 상태를 '중지됨'으로 강제 변경
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void convertToStopped(Map<String, Object> map) throws Exception {
		jobArDAO.convertToStopped(map);
	}

	
	/**
	 * 로봇리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectBotList(Map<String, Object> map) throws Exception {
		return jobArDAO.selectBotList(map);
	}
}
