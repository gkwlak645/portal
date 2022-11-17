package kr.co.rpaplatform.dongwon.gwpwr.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import kr.co.rpaplatform.dongwon.gwpwr.dao.GwpwrUserDAO;

/**
 * 그룹웨어 사용자 서비스
 * @author LSH
 */
@Service
public class GwpwrUserService {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(GwpwrUserService.class);
	
	/**
	 * 그룹웨어 사용자 DAO
	 */
	@Resource(name="gwpwrUserDAO")
	private GwpwrUserDAO gwpwrUserDAO;
	
	/**
	 * 그룹웨어 사용자 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getGwpwrUserList(Map<String, Object> map) throws Exception {
		return gwpwrUserDAO.selectGwpwrUserList(map);
	}
	
	/**
	 * 그룹웨어 사용자 카운트
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int getGwpwrUserCount(Map<String, Object> map) throws Exception {
		return gwpwrUserDAO.selectGwpwrUserCount(map);
	}
	
	/**
	 * 그룹웨어 사용자 리스트 조회V2
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getGwpwrUserListV2(Map<String, Object> map) throws Exception {
		return gwpwrUserDAO.selectGwpwrUserListV2(map);
	}
	
	/**
	 * 그룹웨어 사용자 카운트V2
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int getGwpwrUserCountV2(Map<String, Object> map) throws Exception {
		return gwpwrUserDAO.selectGwpwrUserCountV2(map);
	}

}
