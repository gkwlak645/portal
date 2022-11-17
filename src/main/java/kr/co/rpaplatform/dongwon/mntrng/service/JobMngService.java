package kr.co.rpaplatform.dongwon.mntrng.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import kr.co.rpaplatform.dongwon.common.vo.CmmnUserVO;
import kr.co.rpaplatform.dongwon.mntrng.dao.JobErrorDAO;
import kr.co.rpaplatform.dongwon.mntrng.dao.JobMngDAO;

/**
 * 작업 서비스
 * @author LSH
 *
 */
@Service
public class JobMngService {
	
	private final Logger logger = LoggerFactory.getLogger(JobMngService.class);
	
	/**
	 * 작업 DAO
	 */
	@Resource(name="jobMngDAO")
	private JobMngDAO jobMngDAO;

	public int getJobMngCount(Map<String, Object> map) {
		return jobMngDAO.getJobMngCount(map);
	}
	
	public List<Map<String, Object>> selectJobMngList(Map<String, Object> map) {
		return jobMngDAO.selectJobMngList(map);
	}

	/**
	 * 로봇리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectBotList(Map<String, Object> map) throws Exception {
		return jobMngDAO.selectBotList(map);
	}
	
	/**
	 * JOB이력관리 사유 등록 및 수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void updateJobMngResn(Map<String, Object> map) throws Exception {
		jobMngDAO.updateJobMngResn(map);	
	}
}