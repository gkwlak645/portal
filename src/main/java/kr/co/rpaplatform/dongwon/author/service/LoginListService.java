package kr.co.rpaplatform.dongwon.author.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import kr.co.rpaplatform.dongwon.author.dao.LoginListDAO;
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
public class LoginListService {
	
	private final Logger logger = LoggerFactory.getLogger(LoginListService.class);
	
	/**
	 * Bot별 동작현황 DAO
	 */
	@Resource(name="loginListDAO")
	private LoginListDAO loginListDAO;
	
	
	public int searchPortalLoginListCount(Map<String, Object> map) {
		return loginListDAO.searchPortalLoginListCount(map);
	}
	
	public List<Map<String, Object>> searchPortalLoginList(Map<String, Object> map) throws Exception {
		return loginListDAO.searchPortalLoginList(map);
	}
	
	public List<Map<String, Object>> loginCountPerCmpList(Map<String, Object> map) throws Exception {
		return loginListDAO.loginCountPerCmpList(map);
	}
	
	public List<Map<String, Object>> loginCountPerRoleList(Map<String, Object> map) throws Exception {
		return loginListDAO.loginCountPerRoleList(map);
	}
	
	public List<Map<String, Object>> searchRoleList(Map<String, Object> map) throws Exception {
		return loginListDAO.searchRoleList(map);
	}
}
