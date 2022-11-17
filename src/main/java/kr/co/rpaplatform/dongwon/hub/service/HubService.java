package kr.co.rpaplatform.dongwon.hub.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import kr.co.rpaplatform.dongwon.hub.dao.HubDAO;
import kr.co.rpaplatform.dongwon.resrce.service.DeviceService;
import kr.co.rpaplatform.dongwon.hub.vo.HubVO;


@Service
public class HubService {

	private final Logger logger = LoggerFactory.getLogger(HubService.class);
	/**
	 * sqlSession
	 */
	@Resource(name="hubDAO")
	private HubDAO hubDAO;
	/**
	 * 디바이스 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getHubList(Map<String, Object> map) throws Exception {
		logger.debug("HubService selectHubList start !!!");
		if(map.get("name") == null) {
			map.put("name", "");
		}
		for(String i : map.keySet()) {
			logger.debug(map.get(i)+"");
		}
		List<Map<String, Object>> list = hubDAO.selectHubList(map);
		logger.debug("HubService selectHubList end !!!");
//		logger.debug(list.get(0).toString());
		return list;

		}
	
	public List<Map<String, Object>> getHub_1List(Map<String, Object> map) throws Exception {
		logger.debug("HubService selectHub_1List start !!!");
		if(map.get("name") == null) {
			map.put("name", "");
		}
		for(String i : map.keySet()) {
			logger.debug(map.get(i)+"");
		}
		List<Map<String, Object>> list = hubDAO.selectHub_1List(map);
		logger.debug("HubService selectHub_1List end !!!");
//		logger.debug(list.get(0).toString());
		return list;

		}
	
	
	
	
	
	
	

	}
