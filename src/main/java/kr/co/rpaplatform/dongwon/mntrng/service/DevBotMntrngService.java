package kr.co.rpaplatform.dongwon.mntrng.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import kr.co.rpaplatform.dongwon.mntrng.dao.DevBotMntrngDAO;

/**
 * 작업 서비스
 * @author LSH
 *
 */
@Service
public class DevBotMntrngService {
	
	private final Logger logger = LoggerFactory.getLogger(DevBotMntrngService.class);
	
	/**
	 * 작업 DAO
	 */
	@Resource(name="devBotMntrngDAO")
	private DevBotMntrngDAO devBotMntrngDAO;
	
	/**
	 * 작업 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getDevBotMntrngList(Map<String, Object> map) throws Exception {
		return devBotMntrngDAO.selectDevBotMntrngList(map);
	}
	
	/**
	 * 작업 리스트 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int getDevBotMntrngCount(Map<String, Object> map) throws Exception {
		return devBotMntrngDAO.selectDevBotMntrngCount(map);
	}
	
}
