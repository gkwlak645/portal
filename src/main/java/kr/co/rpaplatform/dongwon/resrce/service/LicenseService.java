package kr.co.rpaplatform.dongwon.resrce.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import kr.co.rpaplatform.dongwon.resrce.dao.LicenseDAO;
import kr.co.rpaplatform.dongwon.resrce.vo.LicenseVO;
import kr.co.rpaplatform.rpaapi.uipath.api.HostLicenseApi;
import kr.co.rpaplatform.rpaapi.uipath.api.LicenseApi;



/**
 * 로봇 서비스
 * @author JYJ
 * 2020. 8. 26.
 */

@Service
public class LicenseService {

	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(RobotService.class);
	

	/**
	 * 라이선스 DAO
	 */
	@Resource(name="licenseDAO")
	private LicenseDAO licenseDAO;
	
	/**
	 * 라이선스 API
	 */
	@Resource(name="licenseApi")
	private LicenseApi licenseApi;
	
	/**
	 * 호스트 라이선스 API
	 */
	@Resource(name="hostLicenseApi")
	private HostLicenseApi hostLicenseApi;

	/**
	 * 라이선스 정보 조회 API
	 */
	public Map<String, Object> getLicenseList(Map<String, Object> map) throws Exception {
		
		return hostLicenseApi.getHostLicenseCnt(map);		
	}
	
	/**
	 * 라이선스 정보 조회 DB
	 */
	public LicenseVO getLicenseInfo( LicenseVO vo)  throws Exception {
						
		return licenseDAO.getLicenseInfo(vo);
	}

	/**
	 * 라이선스 상세조회 API (LicensesNamedUser)
	 */
	public Map<String, Object> getLicenseDetailList(Map<String, Object> map) throws Exception {
		
		return licenseApi.getLicenseDetail(map);
	}
	/**
	 * 라이선스 상세조회 API (LicensesRuntime)
	 */
	public Map<String, Object> getLicenseDetailList2(Map<String, Object> map) throws Exception {
		
		return licenseApi.getLicenseDetail2(map);
	}

	public void updateRuntime(Map<String, Object> map) throws Exception{
		
		logger.debug("updateRuntime###################"  + map);
		
		licenseApi.updateRuntime(map);
		
	}
	
		
	
	
}
