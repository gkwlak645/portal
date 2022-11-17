/**
 * 
 */
package kr.co.rpaplatform.dongwon.execut.service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import kr.co.rpaplatform.dongwon.execut.dao.SchdulDAO;

/**
 * 트리거 서비스
 * @author LSH
 *
 */
@Service
public class SchdulService {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(SchdulService.class);
	
	/**
	 * 스케줄 DAO
	 */
	@Resource(name="schdulDAO")
	private SchdulDAO schdulDAO;
	
	/**
	 * 스케줄 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getSchdulList(Map<String, Object> map) throws Exception {
		
		List<Map<String, Object>> resultList = null;
		
		List<Map<String, Object>> triggerList = schdulDAO.selectSchdulList(map);
		
		if (triggerList != null && triggerList.size() > 0) {
			
			resultList = new ArrayList<Map<String, Object>>();

			for (Map<String, Object> trigger : triggerList) {
					
				if (trigger.get("queueDefinitionId") != null) {
					trigger.put("cronDetail", trigger.get("queueName"));
					trigger.put("nextOccurrence", "해당없음");
				} else {
					String cronDetail = getCronDetail((String)trigger.get("startProcessCronDetails"));
					String nextOccurrence = getNextOccurrence((Boolean)trigger.get("enabled"), (String)trigger.get("startProcessCronDetails"));
					trigger.put("cronDetail", cronDetail);
					trigger.put("nextOccurrence", nextOccurrence);
				}
				
				resultList.add(trigger);
			}
		
		}
		
		return resultList;
	}
	
	/**
	 * 스케줄 리스트 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int getSchdulCount(Map<String, Object> map) throws Exception {
		return schdulDAO.selectSchdulCount(map);
	}
	
	/**
	 * 스케줄 세부 정보 구하기
	 * @param jsonObject
	 * @return
	 * @throws Exception
	 */
	private String getCronDetail(String startProcessCronDetails) throws Exception {
		
		String cronDetail = "";
		
		JSONParser parser = new JSONParser();
		
		JSONObject jsonObject = (JSONObject)parser.parse(startProcessCronDetails);
		
		logger.debug("jsonObject : {}", jsonObject.toJSONString());

		Long type = (Long)jsonObject.get("type");
		
		switch (type.intValue()) {
			case 0: {
				JSONObject minutely = (JSONObject)jsonObject.get("minutely");
				if (minutely.get("atMinute") != null) {
					cronDetail = "매" + (String)minutely.get("atMinute") + "분";
				}
				break;
			}
			case 1: {
				JSONObject hourly = (JSONObject)jsonObject.get("hourly");
				if (hourly.get("frequencyInHours") != null) {
					cronDetail = "매" + (String)hourly.get("frequencyInHours") + "시간";
				}
				break;
			}
			default : {
				cronDetail = "";
				break;
			}
		}

		logger.debug("cronDetail : {}", cronDetail);
		
		
		return cronDetail;
	}
	
	/**
	 * 트리거 다음 실행 시간 정보 구하기
	 * @param enabled
	 * @param jsonObject
	 * @return
	 * @throws Exception
	 */
	private String getNextOccurrence(Boolean enabled, String startProcessCronDetails) throws Exception {
		
		String nextOccurrence = "";
		
		if (!enabled.booleanValue()) {
			return "사용안함";
		}
		
		JSONParser parser = new JSONParser();
		
		JSONObject jsonObject = (JSONObject)parser.parse(startProcessCronDetails);
		
		logger.debug("jsonObject : {}", jsonObject.toJSONString());

		Long type = (Long)jsonObject.get("type");
		
		switch (type.intValue()) {
			case 0: {
				JSONObject minutely = (JSONObject)jsonObject.get("minutely");
				if (minutely.get("atMinute") != null) {
					nextOccurrence = getOccurrenceMinute((Long)minutely.get("atMinute"));
				}
				break;
			}
			case 1: {
				JSONObject hourly = (JSONObject)jsonObject.get("hourly");
				if (hourly.get("frequencyInHours") != null) {
					nextOccurrence = getOccurrenceHour((String)hourly.get("frequencyInHours"));
				}
				break;
			}
			default : {
				nextOccurrence = "";
				break;
			}
		}

		logger.debug("nextOccurrence : {}", nextOccurrence);
		
		
		return nextOccurrence;
	}
	
	/**
	 * 다음 발생 분 구하기
	 * @param atMinute
	 * @return
	 * @throws Exception
	 */
	private String getOccurrenceMinute(Long atMinute) throws Exception {
		Calendar cal = Calendar.getInstance();
		int minute = cal.get(Calendar.MINUTE);
		int second = cal.get(Calendar.SECOND);
		int baseMinute = atMinute.intValue();
		int nextMinute = (baseMinute - (minute % baseMinute));
		String nextMinuteStr = "";
		if (nextMinute > 1) {	//일분 이상 차이인 경우
			nextMinuteStr = (baseMinute - (minute % baseMinute)) + "분 후";
		} else {	//일분 이내인 경우
			nextMinuteStr = (60 - second) + "초 후";
		}
		return nextMinuteStr;
	}
	
	/**
	 * 다음 발생 시간 구하기
	 * @param frequencyInHours
	 * @return
	 * @throws Exception
	 */
	private String getOccurrenceHour(String frequencyInHours) throws Exception {
		Calendar cal = Calendar.getInstance();
		int hour = cal.get(Calendar.HOUR_OF_DAY);
		int minute = cal.get(Calendar.MINUTE);
		int second = cal.get(Calendar.SECOND);
		logger.debug("hour : {}", hour);
		int baseHour = Integer.parseInt(frequencyInHours);
		logger.debug("baseHour : {}", baseHour);
		int nextHour = baseHour - (hour % baseHour);
		logger.debug("nextHour : {}", nextHour);
		String nextHourStr = "";
		if (nextHour > 1) {	//한 시간 이상 차이인 경우
			nextHourStr = nextHour + "시간 후";
		} else {	//한 시간 이내인 경우
			if (minute >= 59) {	//일분 이내인 경우
				nextHourStr = (60 - second) + "초 후";
			} else {
				nextHourStr = (60 - minute) + "분 후";
			}
		}
		
		return nextHourStr;
	}

}
