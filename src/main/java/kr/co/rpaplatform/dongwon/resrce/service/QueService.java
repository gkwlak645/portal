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

import kr.co.rpaplatform.common.exception.RpaException;
import kr.co.rpaplatform.dongwon.resrce.dao.QueDAO;
import kr.co.rpaplatform.rpaapi.uipath.api.QueApi;
import kr.co.rpaplatform.rpaapi.uipath.api.ReleasesApi;
import kr.co.rpaplatform.rpaapi.uipath.common.RestApi;

/**
 * que 서비스
 * @author LSH
 */
@Service
public class QueService {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(QueService.class);
	
	/**
	 * que DAO
	 */
	@Resource(name="queDAO")
	private QueDAO queDAO;
	
	@Resource(name="queApi")
	private QueApi queApi;
	
	@Resource(name="releasesApi")
	private ReleasesApi releasesApi;
	
	/**
	 * que 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getQueList(Map<String, Object> map) throws Exception {
		return queDAO.selectQueList(map);
	}
	
	/**
	 * que 리스트 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int getQueCount(Map<String, Object> map) throws Exception {
		return queDAO.selectQueCount(map);
	}

	/**
	 * que 상세 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public Map<String, Object> getQueDetail(Map<String, Object> map) throws Exception {
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		Map<String, Object> queDetailMap = queApi.getQue(map);
		
		
		String cmpnyCd = "";
		if(map.get("Id") != null && !"".equals(map.get("Id"))) {
			cmpnyCd = queDAO.selectQueCmpny(map);
			queDetailMap.put("cmpnyCd", cmpnyCd);
			map.put("cmpnyCd", cmpnyCd);
		}
		
		resultMap.put("queDetail", queDetailMap);
		resultMap.put("queItmDetail", queApi.getQueItm(map));
		
		if(queDetailMap.get("ReleaseId") != null && !"".equals(queDetailMap.get("ReleaseId"))) {
			Map<String, Object> schMap = new HashMap<String, Object>();
			schMap.put("cmpnyCd", cmpnyCd);
			schMap.put("Id", queDetailMap.get("ReleaseId"));
			resultMap.put("queRlseDetail", releasesApi.getReleases(schMap));
		}
		
		return resultMap;
	}

	
	/**
	 * que 상세 등록
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> registQue(Map<String, Object> map) throws Exception {
		
		Map<String, Object> queMap = queDAO.selectQue(map);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		if(queMap == null || queMap.get("Id") == null || "".equals(queMap.get("Id"))) {
			//api 등록시 필요없는 파라미터 삭제
			map.remove("txDeptCd");
			map.remove("txUserId");
			resultMap = queApi.registerQue(map);
		}else {
			throw new RpaException("E00001");
		}
		
		
		return resultMap;
	}

	
	/**
	 * que 상세 수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> updateQue(Map<String, Object> map) throws Exception {
		Map<String, Object> resultMap = queApi.updateQue(map);
		return resultMap;
	}

	
	/**
	 * que 상세 삭제
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> deleteQue(Map<String, Object> map) throws Exception {
		Map<String, Object> resultMap = queApi.deleteQue(map);
		return resultMap;
	}
	
	
	/**
	 * 프로세스 list 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getRlseList(Map<String, Object> map) throws Exception {
		//return queDAO.selectRlseList(map);
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		returnMap = releasesApi.selectReleasesAPIList(map);
		
		return (List<Map<String, Object>>)returnMap.get("value");
	}

	

}
