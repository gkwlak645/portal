package kr.co.rpaplatform.dongwon.mntrng.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import kr.co.rpaplatform.dongwon.mntrng.dao.JobDAO;
import kr.co.rpaplatform.rpaapi.uipath.api.JobApi;

/**
 * 작업 서비스
 * @author LSH
 *
 */
@Service
public class JobService {
	
	private final Logger logger = LoggerFactory.getLogger(JobService.class);
	
	@Resource(name="jobApi")
	private JobApi jobApi;
	
	/**
	 * 작업 DAO
	 */
	@Resource(name="jobDAO")
	private JobDAO jobDAO;
	
	/**
	 * 작업 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getJobList(Map<String, Object> map) throws Exception {
		return jobDAO.selectJobList(map);
	}
	
	/**
	 * 작업 리스트 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int getJobCount(Map<String, Object> map) throws Exception {
		return jobDAO.selectJobCount(map);
	}
	
	
	/**
	 * 작업 리스트 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> stopJob(Map<String, Object> map) throws Exception {
		return jobApi.stopJob(map);
	}
	
	/**
	 * 작업 상세 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getJobDetail(Map<String, Object> map) throws Exception {
		return jobDAO.selectJobDetail(map);
	}


}
