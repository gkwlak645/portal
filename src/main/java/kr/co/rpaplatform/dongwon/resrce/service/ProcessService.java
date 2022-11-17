/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 6. 16.         LSH
 */
package kr.co.rpaplatform.dongwon.resrce.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import kr.co.rpaplatform.common.exception.RpaException;
import kr.co.rpaplatform.dongwon.resrce.dao.ProcessDAO;
import kr.co.rpaplatform.rpaapi.uipath.api.PackageApi;
import kr.co.rpaplatform.rpaapi.uipath.api.ReleasesApi;

/**
 * 프로세스 서비스
 * @author LSH
 * 2020. 6. 16.
 */
@Service
public class ProcessService {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(ProcessService.class);
	
	/**
	 * 프로세스 DAO
	 */
	@Resource(name="processDAO")
	private ProcessDAO processDAO;
	
	/**
	 * 릴리즈 API
	 */
	@Resource(name="releasesApi")
	private ReleasesApi releasesApi;
	
	/**
	 * 패키지 API
	 */
	@Resource(name="packageApi")
	private PackageApi packageApi;
	
	/**
	 * 프로세스 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getProcessList(Map<String, Object> map) throws Exception {
		return processDAO.selectProcessList(map);
	}
	
	/**
	 * 프로세스 리스트 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int getProcessCount(Map<String, Object> map) throws Exception {
		return processDAO.selectProcessCount(map);
	}
	
	/**
	 * 프로세스 리스트 API 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getProcessAPIList(Map<String, Object> map) throws Exception {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		returnMap = packageApi.selectProcessAPIList(map);
		
		return (List<Map<String, Object>>)returnMap.get("value");
	}
	
	/**
	 * 프로세스 버전 리스트 API 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getProcessVersionAPIList(Map<String, Object> map) throws Exception {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		returnMap = packageApi.selectProcessVersionAPIList(map);
		
		
		List<Map<String, Object>> resultList = (List<Map<String, Object>>)returnMap.get("value");
		
		
		if(resultList != null && resultList.size() > 0) {
			int i = 0;
			for(Map<String, Object> result: resultList) {
				
				Map<String, Object> responseMap = new HashMap<String, Object>();
				
				responseMap.put("Id", map.get("Id"));
				responseMap.put("Version", result.get("Version"));
				responseMap.put("Published", result.get("Published"));
			    
				String openTimeDc = processDAO.selectVersionOpenTimeDc(responseMap);
				String useTimeDc = processDAO.selectVersionUseTimeDc(responseMap);
				
				Map<String, Object> resultMap = resultList.get(i);
				
				resultMap.put("openTimeDc", openTimeDc);
				resultMap.put("useTimeDc", useTimeDc);
				
				resultList.set(i, resultMap);
				
				
				i ++;
			}
		}
		

		
		return (List<Map<String, Object>>)returnMap.get("value");
	}
	
	
	/**
	 * 프로세스 등록
	 * @param cd
	 * @return
	 * @throws Exception
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public Map<String, Object> insertProcess(Map<String, Object> map) throws Exception {
		
		Map<String, Object> requestMap  = new HashMap<String, Object>();
		Map<String, Object> resultMap  = new HashMap<String, Object>();
		
		//************************ 중복여부 확인 ****************************************
		
		//프로세스, 패키지, 환경 등록여부 확인(TB_TASK_DEVELOP_MAPPER : processCd,processKey,EnvironmentId)
		int chkOverlapTDPM = processDAO.chkOverlapTaskDevelopProcessCdMapper(map);
		
		//패키지, 환경 등록여부 확인 (SY_RELEASES : ProcessKey , EnvironmentId)
		int chkOverlapReleases = processDAO.chkOverlapReleases(map);
		
		//프로세스키에 등록된 환경중에서 새로등록 하려는 환경에 로봇이 있는지 확인
		//(SY_RELEASES : ProcessKey , EnvironmentId)
		int chkOverlapRE = processDAO.chkOverlapRobotsXEnvironments(map);
		
		if(0 < chkOverlapTDPM) {
			//이미 등록된 프로세스 입니다.
			throw new RpaException("E00002", "이미 등록된 프로세스 입니다.");
		}else if(0 < chkOverlapReleases) {
			//이미 등록된 패키지 입니다.
			throw new RpaException("E00004", "이미 등록된 패키지 입니다.");
		}else if(0 < chkOverlapRE) {
			//패키지명 이(가) 이 환경의 로봇 중 하나에 배포되어 있지 않은지 확인합니다.
			//ex) Direct_접속이(가) 이 환경의 로봇 중 하나에 배포되어 있지 않은지 확인합니다.
			throw new RpaException("E00003", (String) map.get("ProcessKey"));
		}else {
			requestMap.put("processCd", (String) map.get("processCd"));
			requestMap.put("cmpnyCd", (String) map.get("cmpnyCd"));
			requestMap.put("txUserId", (String) map.get("txUserId"));
			
			//api 등록시 필요없는 파라미터 삭제
			map.remove("processCd");
			map.remove("txDeptCd");
			map.remove("txUserId");
			
			//프로세스 릴리즈 UIPATH Api 등록
			resultMap = releasesApi.registerReleases(map);
			Map<String, Object> Arguments = (Map<String, Object>) resultMap.get("InputArguments");
			
			//response 값 
			requestMap.put("releasesId", (int) resultMap.get("Id"));
			requestMap.put("releasesKey", (String) resultMap.get("Key"));
			requestMap.put("releasesName", (String) resultMap.get("Name"));
			requestMap.put("processKey", (String) resultMap.get("ProcessKey"));
			requestMap.put("EnvironmentId", (int) resultMap.get("EnvironmentId"));
			
			if(Arguments != null) {
				requestMap.put("inputArguments", (String) Arguments.get("Input"));
			}else {
				requestMap.put("inputArguments", "{}");
			}
			
			//과제-프로세스 와 uipath 프로세스(릴리즈) 매핑 등록
			processDAO.insertTaskDevlopProcessMapper(requestMap);
			
		}
		
		return resultMap;
	}
	
	/**
	 * 프로세스 상세 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getProcessDetail(Map<String, Object> map) throws Exception {
		return processDAO.selectProcessDetail(map);
	}
	
	/**
	 * 프로세스 버전 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getProcessVersionList(Map<String, Object> map) throws Exception {
		//return processDAO.selectProcessVersionList(map);
		return processDAO.selectProcessVersionList(map);
	}
	
	
	/**
	 * 프로세스 버전 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int getProcessVersionCount(Map<String, Object> map) throws Exception {
		return processDAO.selectProcessVersionCount(map);
	}
	
	/**
	 * 프로세스 버전 변경
	 * @param map
	 * @throws Exception
	 */
	public void changeProcessVersion(Map<String, Object> map) throws Exception {
		releasesApi.updateToSpecificPackageVersion(map);
	}
	
	/**
	 * 프로세스 버전 롤백
	 * @param map
	 * @throws Exception
	 */
	public void changeProcessVersionRollBack(Map<String, Object> map) throws Exception {
		releasesApi.rollbackToPreviousReleaseVersion(map);
	}
	
	/**
	 * 프로세스 버전 롤백
	 * @param map
	 * @throws Exception
	 */
	public void updateToLatestPackageVersion(Map<String, Object> map) throws Exception {
		releasesApi.updateToLatestPackageVersion(map);
	}
	
	
	/**
	 * 입출력 파라미터 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getParamterList(Map<String, Object> map) throws Exception {
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		//input 파라미터 조회
		Map<String, Object> inputMap = processDAO.selectProcessInputParameterList(map);
		
		if (inputMap != null && !inputMap.isEmpty()) {
			
			List<Map<String, Object>> inputList = new ArrayList<Map<String, Object>>();
			
			JSONParser parser = new JSONParser();
			JSONArray jsonArray = (JSONArray)parser.parse((String)inputMap.get("type"));
			
			JSONObject valueObject = null;
			if(inputMap.get("value") != null && !"".equals((String)inputMap.get("value"))) {
				valueObject = (JSONObject)parser.parse((String)inputMap.get("value"));
			}

			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject object = (JSONObject)jsonArray.get(i);
				logger.debug("JSONString : " + object.toJSONString());
				String name = (String)object.get("name");
				logger.debug("name : " + name);
				String type = ((String)object.get("type"));
				type = type.split("\\,")[0].replace("System.", "");
				logger.debug("type : " + type);
				
				Map<String, Object> inputResultMap = new HashMap<String, Object>();
				inputResultMap.put("name", name);
				inputResultMap.put("type", type);
				
				String value = null;
				if(valueObject != null) {
					value = (String)valueObject.get(name);
					logger.debug("value : " + value);
					
					if(value == null) {
						inputResultMap.put("value", "");
					}else {
						inputResultMap.put("value", value.toString());
					}
					
				}else {
					inputResultMap.put("value", "");
				}
				
				
				inputList.add(inputResultMap);
			}
			
			resultMap.put("input", inputList);

		}
		
		//output 파라미터 조회
		Map<String, Object> outputMap = processDAO.selectProcessOutputParameterList(map);
		
		if (outputMap != null && !outputMap.isEmpty()) {
			
			List<Map<String, Object>> outputList = new ArrayList<Map<String, Object>>();
			
			JSONParser parser = new JSONParser();
			JSONArray jsonArray = (JSONArray)parser.parse((String)inputMap.get("type"));

			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject object = (JSONObject)jsonArray.get(i);
				logger.debug("JSONString : " + object.toJSONString());
				String name = (String)object.get("name");
				logger.debug("name : " + name);
				String type = ((String)object.get("type"));
				type = type.split("\\,")[0].replace("System.", "");
				logger.debug("type : " + type);
				
				Map<String, Object> outputResultMap = new HashMap<String, Object>();
				outputResultMap.put("name", name);
				outputResultMap.put("type", type);
				
				outputList.add(outputResultMap);
			}
			
			resultMap.put("output", outputList);

		}

		
		return resultMap;
	}
	
	
	/**
	 * 프로세스 조회
	 * @param cd
	 * @return
	 * @throws Exception
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public List<Map<String, Object>> getProcessCdListByClsCd(Map<String, Object> map) throws Exception {
		return processDAO.getProcessCdListByClsCd(map);
	}
	
	/**
	 * 과제 코드 조회
	 * @param cd
	 * @return
	 * @throws Exception
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public List<Map<String, Object>> getTaskCdList(Map<String, Object> map) throws Exception {
		return processDAO.selectTaskCdList(map);
	}
	
	
	/**
	 * 과제 프로세스 조회
	 * @param cd
	 * @return
	 * @throws Exception
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public List<Map<String, Object>> getProcessCdList(Map<String, Object> map) throws Exception {
		return processDAO.selectProcessCdList(map);
	}

	
	/**
	 * 프로세스 수정
	 * @param cd
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> updateProcess(Map<String, Object> map) throws Exception {
		
		//프로세스 수정		
		
		Map<String, Object> resultMap = releasesApi.updateReleases(map);
		
		//프로세스 가져오기
		Map<String, Object> releases = releasesApi.getReleases(map);
		Map<String, Object> Arguments =  (Map<String, Object>) releases.get("Arguments");
		
		Map<String, Object> requestMap  = new HashMap<String, Object>();
		
		requestMap.put("processCd", (String) map.get("processCd"));
		requestMap.put("inputArguments", (String)Arguments.get("Input"));
		
		//과제-프로세스 와 uipath inputArguments 수정
		processDAO.updateIATaskDevlopProcessMapper(requestMap);
		return resultMap;
	}
	
	
	/**
	 * 프로세스 삭제
	 * @param cd
	 * @return
	 * @throws ExceptionupdateProcess
	 * 
	 */
	public Map<String, Object> deleteProcess(Map<String, Object> map) throws Exception {
		
		Map<String, Object> resultMap = releasesApi.deleteReleases(map);
		
		//과제-프로세스 와 uipath 프로세스(릴리즈) 매핑 사용여부 수정
		map.put("useAt", "N");
		processDAO.updateUseAtTaskDevlopProcessMapper(map);
		
		return resultMap;
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
