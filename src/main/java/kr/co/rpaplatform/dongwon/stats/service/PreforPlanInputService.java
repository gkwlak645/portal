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

import kr.co.rpaplatform.dongwon.stats.dao.PreforPlanInputDAO;

/**
 * 실적계획입력 서비스
 * @author LSH
 */
@Service
public class PreforPlanInputService {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(PreforPlanInputService.class);

	/**
	 * 통계 DAO
	 */
	@Resource(name="preforPlanInputDAO")
	private PreforPlanInputDAO preforPlanInputDAO;
	

	/**
	 * 실적계획입력 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getPreforPlanList(Map<String, Object> map) throws Exception {
		
		Map<String, Object> responseMap = new HashMap<String, Object>();
		
		responseMap.put("cmpnyCdList", preforPlanInputDAO.selectTknList(map));
		
		Map<String, Object> preforPlanList = new HashMap<String, Object>();
		
		if(map.get("cmpnyCd") == null || "".equals(map.get("cmpnyCd"))) {
			List<Map<String, Object>> tknPreforPlanInList = preforPlanInputDAO.selectTknPreforPlanInList(map);
			if(tknPreforPlanInList != null && tknPreforPlanInList.size() > 0) {
				for(Map<String, Object> tknPreforPlanIn : tknPreforPlanInList) {
					String cmpnyCd = (String) tknPreforPlanIn.get("cmpnyCd");
					map.put("cmpnyCd", cmpnyCd);
					preforPlanList.put(cmpnyCd, preforPlanInputDAO.selectPreforPlanList(map));
				}
			}
		}else {
			List<Map<String, Object>> preforPlanList2 = preforPlanInputDAO.selectPreforPlanList(map);
			String cmpnyCd = (String) map.get("cmpnyCd");
			if(preforPlanList2 != null && preforPlanList2.size() > 0) {
				preforPlanList.put(cmpnyCd, preforPlanInputDAO.selectPreforPlanList(map));
			}
		}
		
		responseMap.put("preforPlanList", preforPlanList);
		
		return responseMap;
	}
	
	
	/**
	 * 실적계획입력 저장
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void updatePreforPlan(Map<String, Object> map) throws Exception {
		List<Map<String, Object>> preforPlanList = (List<Map<String, Object>>) map.get("preforPlanList");
		
		for(Map<String, Object> preforPlan: preforPlanList) {
			preforPlanInputDAO.updatePreforPlan(preforPlan);
		}
		
	}


	
	
	
	
	
	
	
	
	
	
	
}
