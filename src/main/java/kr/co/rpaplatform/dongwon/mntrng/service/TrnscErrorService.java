package kr.co.rpaplatform.dongwon.mntrng.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import kr.co.rpaplatform.dongwon.mntrng.dao.TrnscErrorDAO;


/**
 * 작업 서비스
 * @author LSH
 *
 */
@Service
public class TrnscErrorService {
	
	private final Logger logger = LoggerFactory.getLogger(TrnscErrorService.class);
	
	/**
	 * 작업 DAO
	 */
	@Resource(name="trnscErrorDAO")
	private TrnscErrorDAO trnscErrorDAO;
	
	
	public int getTrnscErrorCount(Map<String, Object> map) {
		return trnscErrorDAO.getTrnscErrorCount(map);
	}
	
	public List<Map<String, Object>> selectTrnscErrorList(Map<String, Object> map) {
		return trnscErrorDAO.selectTrnscErrorList(map);
	}
	
	public Map<String, Object> getTrnscErrorDetail(Map<String, Object> map) {
		return trnscErrorDAO.getTrnscErrorDetail(map);
	}

	public void updateTrnscError(Map<String, Object> map) {
		trnscErrorDAO.updateTrnscError(map);
	}

	public Map<String, Object> getOverTrnscErrorDetail(Map<String, Object> map) {
		
		return trnscErrorDAO.getTrnscErrorDetail(map);
	}

	public void updateOverTrnscErrorDetail(Map<String, Object> map) {
		List<Map<String, Object>> updateOverList = (List<Map<String, Object>>)map.get("updateTrancList");
		if(updateOverList != null && updateOverList.size() > 0) {
			for (Map<String, Object> updateOverrMap : updateOverList) {
				trnscErrorDAO.updateTrnscError(updateOverrMap);
			}
		}
	}
	
	public int getOverlapTrnscErrorCount(Map<String, Object> map) {
		return trnscErrorDAO.getOverlapTrnscErrorCount(map);
	}
	
	public List<Map<String, Object>> selectOverlapTrnscErrorList(Map<String, Object> map) {
		return trnscErrorDAO.selectOverlapTrnscErrorList(map);
	}
	
	public Map<String, Object> setOverlapTrnscError(Map<String, Object> map){
		Map<String, Object> aReturn = new HashMap<String, Object>();
		
		String sUnity = (String)map.get("unity");
		int iErrorUnitySn = Integer.parseInt((String) map.get("errorUnitySn"));
		List<String> aWhere  = (List<String>)map.get("where");
		int iaWhere = aWhere.size();
		
		//중복오류해제, 중복오류통합 적용하기
		for(int i = 0; i < iaWhere; i++) {
			Map<String, Object> aParams = new HashMap<String, Object>();
			aParams.put("errorUnitySn", iErrorUnitySn);
			aParams.put("sn", Integer.parseInt(aWhere.get(i)));
			if(sUnity.equals("Y")) {
				trnscErrorDAO.setOverlapTrnscErrorUnity(aParams);
			}
			else {
				trnscErrorDAO.setOverlapTrnscErrorNotUnity(aParams);
			}
		}
		
		//대표 정보 확인
		int iErrorUnityCount =  trnscErrorDAO.getTbTrnscError2ErrorUnityCount(map);
		String sReprsntAt  = iErrorUnityCount > 0 ? "Y" : "N";
		iErrorUnityCount++;
		map.put("reprsntAt", sReprsntAt);
		
		
		//대표 정보 변경
		
		map.put("errorUnityCnt", iErrorUnityCount);
		trnscErrorDAO.setTbTrnscError2ReprsntAt(map);
		
		
		aReturn.put("errorUnityCount", iErrorUnityCount);
		aReturn.put("reprsntAt", sReprsntAt);
		return aReturn;
	}


	/**
	 * 로봇리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectBotList(Map<String, Object> map) throws Exception {
		return trnscErrorDAO.selectBotList(map);
	}


}
