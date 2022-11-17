package kr.co.rpaplatform.dongwon.mntrng.service;

import java.util.HashMap;
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
import kr.co.rpaplatform.rpaapi.uipath.api.PackageApi;
import kr.co.rpaplatform.rpaapi.uipath.api.ProcessSchedulesApi;

/**
 * 작업 서비스
 * @author LSH
 *
 */
@Service
public class BotMntrngService {
	
	private final Logger logger = LoggerFactory.getLogger(BotMntrngService.class);
	
	/**
	 * Bot별 동작현황 DAO
	 */
	@Resource(name="botMntrngDAO")
	private BotMntrngDAO botMntrngDAO;
	
	/**
	 * 패키지 API
	 */
	@Resource(name="processSchedulesApi")
	private ProcessSchedulesApi processSchedulesApi;
	
	// 등록된 회사인지
	public int selectCountLoginCmpny(Map<String, Object> map) {
		return botMntrngDAO.selectCountLoginCmpny(map);
	}
	
	public List<Map<String, Object>> selectBotMntrngList(Map<String, Object> map) throws Exception {
		return botMntrngDAO.selectBotMntrngList(map);
	}
	
	public List<Map<String, Object>> selectBotList(Map<String, Object> map) throws Exception {
		return botMntrngDAO.selectBotList(map);
	}

	public List<Map<String, Object>> selectFutureProcessSchedulesList(Map<String, Object> map) throws Exception {	
		Map<String, Object> returnMap = new HashMap<String, Object>();	
		returnMap = processSchedulesApi.selectFutureProcessSchedulesList(map);
		return (List<Map<String, Object>>)returnMap.get("value");	
	}
	
	public List<Map<String, Object>> selectTriggerArScheduleList(Map<String, Object> map) throws Exception {
		return botMntrngDAO.selectTriggerArScheduleList(map);
	}
	
	public List<Map<String, Object>> selectTriggerUrScheduleList(Map<String, Object> map) throws Exception {
		return botMntrngDAO.selectTriggerUrScheduleList(map);
	}
}
