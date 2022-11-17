package kr.co.rpaplatform.dongwon.gwpwr.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import kr.co.rpaplatform.dongwon.gwpwr.dao.GwpwrDeptDAO;

/**
 * 그룹웨어 부서 서비스
 * @author LSH
 */
@Service
public class GwpwrDeptService {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(GwpwrDeptService.class);
	
	/**
	 * 그룹웨어 부서 DAO
	 */
	@Resource(name="gwpwrDeptDAO")
	private GwpwrDeptDAO gwpwrDeptDAO;
	
	/**
	 * 그룹웨어 부서 리스트 조회
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getAllGwpwrDeptList(Map<String, Object> map) throws Exception {
		return gwpwrDeptDAO.selectAllGwpwrDeptList(map);
	}

}
