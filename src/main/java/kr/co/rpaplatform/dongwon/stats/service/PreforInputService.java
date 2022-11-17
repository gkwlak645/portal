/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 7. 14.         LSH        최초 작성
 */
package kr.co.rpaplatform.dongwon.stats.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import kr.co.rpaplatform.dongwon.stats.dao.PreforInputDAO;

/**
 * 실적계획입력 서비스
 * @author LSH
 */
@Service
public class PreforInputService {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(PreforInputService.class);

	/**
	 * 통계 DAO
	 */
	@Resource(name="preforInputDAO")
	private PreforInputDAO preforInputDAO;
	

	/**
	 * 실적계획입력 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getPreforList(Map<String, Object> map) throws Exception {
		
		Map<String, Object> responseMap = new HashMap<String, Object>();
		
		responseMap.put("cmpnyCdList", preforInputDAO.selectTknList(map));
		
		Map<String, Object> preforList = new HashMap<String, Object>();
		
		if(map.get("cmpnyCd") == null || "".equals(map.get("cmpnyCd"))) {
			List<Map<String, Object>> tknPreforInList = preforInputDAO.selectTknPreforInList(map);
			if(tknPreforInList != null && tknPreforInList.size() > 0) {
				for(Map<String, Object> tknPreforIn : tknPreforInList) {
					String cmpnyCd = (String) tknPreforIn.get("cmpnyCd");
					map.put("cmpnyCd", cmpnyCd);
					preforList.put(cmpnyCd, preforInputDAO.selectPreforList(map));
				}
			}
		}else {
			List<Map<String, Object>> preforList2 = preforInputDAO.selectPreforList(map);
			String cmpnyCd = (String) map.get("cmpnyCd");
			if(preforList2 != null && preforList2.size() > 0) {
				preforList.put(cmpnyCd, preforInputDAO.selectPreforList(map));
			}
		}
		
		responseMap.put("preforList", preforList);
		
		return responseMap;
	}
	
	
	/**
	 * 실적계획입력 저장
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void updatePrefor(Map<String, Object> map) throws Exception {
		List<Map<String, Object>> preforList = (List<Map<String, Object>>) map.get("preforList");
		
		for(Map<String, Object> prefor: preforList) {
			preforInputDAO.updatePrefor(prefor);
		}
		
	}

	
	
}
