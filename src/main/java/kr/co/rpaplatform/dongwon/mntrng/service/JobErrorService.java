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

/**
 * 작업 서비스
 * @author LSH
 *
 */
@Service
public class JobErrorService {
	
	private final Logger logger = LoggerFactory.getLogger(JobErrorService.class);
	
	/**
	 * 작업 DAO
	 */
	@Resource(name="jobErrorDAO")
	private JobErrorDAO jobErrorDAO;
	
	
	public int getJobErrorCount(Map<String, Object> map) {
		return jobErrorDAO.getJobErrorCount(map);
	}
	
	public List<Map<String, Object>> selectJobErrorList(Map<String, Object> map) {
		return jobErrorDAO.selectJobErrorList(map);
	}
	
	public Map<String, Object> getJobErrorDetail(Map<String, Object> map) {
		return jobErrorDAO.getJobErrorDetail(map);
	}

	public void updateJobError(Map<String, Object> map) {
		 jobErrorDAO.updateJobError(map);
	}

	/**
	 * 로봇리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectBotList(Map<String, Object> map) throws Exception {
		return jobErrorDAO.selectBotList(map);
	}
}