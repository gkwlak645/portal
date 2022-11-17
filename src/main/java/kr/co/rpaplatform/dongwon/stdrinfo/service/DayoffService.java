package kr.co.rpaplatform.dongwon.stdrinfo.service;

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
import kr.co.rpaplatform.dongwon.resrce.service.RobotService;
import kr.co.rpaplatform.dongwon.stdrinfo.dao.DayoffDAO;
import kr.co.rpaplatform.dongwon.stdrinfo.vo.DayoffVO;
import kr.co.rpaplatform.rpaapi.uipath.api.DayoffApi;

/**
 * 휴무일 서비스
 * @author JYJ
 * 2020. 9. 4.
 */


@Service
public class DayoffService {

	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(RobotService.class);
	
	
	
	/**
	 * 휴무일 API
	 */
	@Resource(name="dayoffApi")
	private DayoffApi dayoffApi;
	
	
	
	/**
	 * dayoffDAO
	 */
	@Resource(name="dayoffDAO")
	private DayoffDAO dayoffDAO;	
	
	
	/**
	 * 등록
	 * @return 
	 */
	public Map<String, Object> registDayoff(Map<String, Object> map) throws Exception {
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		int chkOverName = dayoffDAO.chkOverlapDayOffName(map);
		
		if(0 < chkOverName) {
			//이미 등록된 휴일 입니다.
			throw new RpaException("E00005", "같은 이름의 일정이 존재합니다.");
		}else {
			map.remove("txUserId");
			map.remove("txDeptCd");
			String cmpnyCd = (String)map.get("cmpnyCd");
			resultMap = dayoffApi.registDayoff(map);
			
			Map<String, Object> dayOffMap = new HashMap<String, Object>();
			dayOffMap.put("Id",(int)resultMap.get("Id"));
			dayOffMap.put("Name",(String)resultMap.get("Name"));
			dayOffMap.put("cmpnyCd",cmpnyCd);
			
			List<String> excludedDateList = (List<String>) resultMap.get("ExcludedDates");
			
			if(excludedDateList.size() > 0) {
				for(int i =0; i< excludedDateList.size(); i++) {
					dayOffMap.put("excludeDate",excludedDateList.get(i));
					dayoffDAO.insertDayOff(dayOffMap);
				}
			}else {
				dayOffMap.put("excludeDate","");
				dayoffDAO.insertDayOff(dayOffMap);
			}
			
		}
		
		return resultMap;
		
	}

	/**
	 * 수정
	 */
	public Map<String, Object> editDayoff(Map<String, Object> map) throws Exception {
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		int chkOverName = dayoffDAO.chkOverlapDayOffName(map);
		
		if(1 < chkOverName) {
			//이미 등록된 휴일 입니다.
			throw new RpaException("E00005", "같은 이름의 일정이 존재합니다.");
		}else {
			map.remove("txUserId");
			map.remove("txDeptCd");
			String cmpnyCd = (String)map.get("cmpnyCd");
			resultMap = dayoffApi.editDayoff(map);
			
			dayoffDAO.deleteDayOff(map);
			
			Map<String, Object> dayOffMap = new HashMap<String, Object>();
			dayOffMap.put("Id",(int)resultMap.get("Id"));
			dayOffMap.put("Name",(String)resultMap.get("Name"));
			dayOffMap.put("cmpnyCd",cmpnyCd);
			
			List<String> excludedDateList = (List<String>) resultMap.get("ExcludedDates");
			
			if(excludedDateList.size() > 0) {
				for(int i =0; i< excludedDateList.size(); i++) {
					dayOffMap.put("excludeDate",excludedDateList.get(i));
					dayoffDAO.insertDayOff(dayOffMap);
				}
			}else {
				dayOffMap.put("excludeDate","");
				dayoffDAO.insertDayOff(dayOffMap);
			}
		}
		
		return resultMap;
	}

	/**
	 * 리스트 조회
	 */
	public List<Map<String, Object>> getoffDayList(Map<String, Object> map) throws Exception{
		return dayoffDAO.getoffDayList(map);
	}
	
	/**
	 * 상세조회
	 */
	public Map<String, Object> getoffDay(Map<String, Object> map) throws Exception{
		return dayoffApi.getoffDay(map);
	}

	public List<Map<String, Object>> getTenantInfo(Map<String, Object> map)throws Exception {
		return  dayoffDAO.getTenantInfo(map);
	}
	
	/**
	 * 삭제
	 */
	public void deleteDayoff(Map<String, Object> map) throws Exception {
		dayoffDAO.deleteDayOff(map);
		Map<String, Object> resultMap = dayoffApi.deleteDayoff(map);
	}

	
}
