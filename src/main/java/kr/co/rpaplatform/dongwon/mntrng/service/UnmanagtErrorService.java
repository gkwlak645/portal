package kr.co.rpaplatform.dongwon.mntrng.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import kr.co.rpaplatform.dongwon.mntrng.dao.UnmanagtErrorDAO;


/**
 * 작업 서비스
 * @author LSH
 *
 */
@Service
public class UnmanagtErrorService {
	
	private final Logger logger = LoggerFactory.getLogger(UnmanagtErrorService.class);
	
	/**
	 * 작업 DAO
	 */
	@Resource(name="unmanagtErrorDAO")
	private UnmanagtErrorDAO unmanagtErrorDAO;
	
	
	public int getUnmanagtErrorCount(Map<String, Object> map) {
		return unmanagtErrorDAO.getUnmanagtErrorCount(map);
	}
	
	public List<Map<String, Object>> selectUnmanagtErrorList(Map<String, Object> map) {
		return unmanagtErrorDAO.selectUnmanagtErrorList(map);
	}
	
	public void saveUnmanagtErrorData(Map<String, Object> map) {
		unmanagtErrorDAO.saveUnmanagtErrorData(map);
	}
	
	public Map<String, Object> getManagtErrorDetail(Map<String, Object> map) {
		return unmanagtErrorDAO.getManagtErrorDetail(map);
	}

	public void updateUnmanagtError(Map<String, Object> map) {
		unmanagtErrorDAO.updateUnmanagtError(map);
	}
	
	
	

	


}
