package kr.co.rpaplatform.dongwon.mntrng.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import kr.co.rpaplatform.dongwon.common.vo.CmmnUserVO;
import kr.co.rpaplatform.dongwon.mntrng.dao.BotMntrngDAO;
import kr.co.rpaplatform.dongwon.mntrng.dao.JobErrorDAO;
import kr.co.rpaplatform.dongwon.mntrng.dao.RealTimeLogDAO;

/**
 * 작업 서비스
 * @author LSH
 *
 */
@Service
public class RealTimeLogService {
	
	private final Logger logger = LoggerFactory.getLogger(RealTimeLogService.class);
	
	/**
	 * Bot별 동작현황 DAO
	 */
	@Resource(name="realTimeLogDAO")
	private RealTimeLogDAO realTimeLogDAO;
	
	public int selectRealTimeLogCount(Map<String, Object> map) {
		return realTimeLogDAO.selectRealTimeLogCount(map);
	}
	
	public List<Map<String, Object>> selectRealTimeLogList(Map<String, Object> map) {
		return realTimeLogDAO.selectRealTimeLogList(map);
	}
}
