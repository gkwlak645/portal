package kr.co.rpaplatform.dongwon.resrce.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import kr.co.rpaplatform.dongwon.resrce.dao.EnvrnDAO;
import kr.co.rpaplatform.rpaapi.uipath.api.EnvrnApi;

/**
 * 환경 서비스
 * @author LSH
 * 2020. 6. 15.
 */
@Service
public class EnvrnService {

	private final Logger logger = LoggerFactory.getLogger(EnvrnService.class);
	
	/**
	 * 환경 DAO
	 */
	@Resource(name="envrnDAO")
	private EnvrnDAO envrnDAO;
	
	/**
	 * 환경 API
	 */
	@Resource(name="envrnApi")
	private EnvrnApi envrnApi;

	/**
	 * 환경 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getEnvrnList(Map<String, Object> map) throws Exception {
		return envrnDAO.selectEnvrnList(map);
	}
	
	/**
	 * 환경 리스트 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int getEnvrnCount(Map<String, Object> map) throws Exception {
		return envrnDAO.selectEnvrnCount(map);
	}
	
	/**
	 * 환경 리스트API 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getEnvrnAPIList(Map<String, Object> map) throws Exception {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		returnMap = envrnApi.selectEnvrnList(map);
		
		return (List<Map<String, Object>>)returnMap.get("value");
	}
	
	/**
	 * 환경 등록
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> registerEnvrn(Map<String, Object> map) throws Exception {
		return envrnApi.registerEnvrn(map);
	}
	
	/**
	 * 환경 등록 - 로봇 목록
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getRobotList(Map<String, Object> map) throws Exception  {
		return envrnDAO.getRobotList(map);
	}
	
	/**
	 * 환경 등록 - 로봇 등록
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> addRobotToEnvrn(Map<String, Object> map) throws Exception  {
		return envrnApi.addRobotToEnvrn(map);
	}
	
	/**
	 * 환경 상세 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> envrnDetailSelectPage(Map<String, Object> map) throws Exception {
		return envrnDAO.envrnDetailSelectPage(map);
	}
	
	/**
	 * 환경 삭제 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> deleteEnvrn(Map<String, Object> map) throws Exception {
		return envrnApi.deleteEnvrn(map);
	}
	
	/**
	 * 환경 수정 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> updateEnvrn(Map<String, Object> map) throws Exception {
		return envrnApi.updateEnvrn(map);
	}
	
	/**
	 * 환경관리 수정 - 환경x로봇 리스트 가져오기
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getEnvrnRobotList(Map<String, Object> map) throws Exception {
		return envrnDAO.getEnvrnRobotList(map);
	}
	
}
