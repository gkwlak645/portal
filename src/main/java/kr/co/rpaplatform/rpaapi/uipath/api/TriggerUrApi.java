package kr.co.rpaplatform.rpaapi.uipath.api;

import java.net.URLEncoder;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;

import kr.co.rpaplatform.common.exception.RpaException;
import kr.co.rpaplatform.rpaapi.uipath.common.RestApi;

@Component
public class TriggerUrApi {

	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(PackageApi.class);
	
	/**
	 * URL 공통부분
	 */
	private String urlPrefix = "/odata/ProcessSchedules";
	
	/**
	 * RestApi
	 */
	@Resource(name="restApi")
	private RestApi restApi;
	
	public Map<String, Object> selectTriggerUrList(Map<String, Object> map) throws Exception{
		logger.debug("TriggerUrApi selectTriggerUrList Start!!!!!!!!!!!!!");
		
		String url = urlPrefix + "?$top=50&$orderby=Name%20asc";
		
		String searchKwrd = map.get("searchKwrd").toString();
		String searchState = map.get("searchState").toString();
		String searchTy = map.get("searchTy").toString();
		
		String sFilter =  "";
		
		
		if(!searchKwrd.equals("")) {
			sFilter += " ((contains(Name,'" + searchKwrd + "')) or (contains(PackageName,'" + searchKwrd + "')) or (contains(EnvironmentName,'" + searchKwrd + "')))";
		}	
		if(!searchState.equals("")) {
			if(!sFilter.equals("")) {
				sFilter += " and ";
			}
			
			if(searchState.equals("Y")) {
				sFilter += "(Enabled eq true)";
			}
			else {
				sFilter += "(Enabled eq false)";
			}
		}
		
		if(!searchTy.equals("")) {
			if(!sFilter.equals("")) {
				sFilter += " and ";
			}
			
			if(searchTy.equals("T")) {
				sFilter += "(QueueDefinitionId eq null)";
			}
			else {
				sFilter += "(QueueDefinitionId ne null)";
			}
		}
		
		if(!sFilter.equals("")) {
			sFilter = URLEncoder.encode(sFilter, "UTF-8");
			url += "&$filter=" + sFilter; 
		}
		
		int iSkip = (Integer.parseInt(map.get("currentPageNo").toString()) - 1) * 10;
		
		if(iSkip > 0) {
			url += "&$skip=" + iSkip;
		}
		
		

		
		
		ResponseEntity<Map> response = restApi.get(url, map);
		Map<String, Object> returnMap = response.getBody();
		
		logger.debug("PackageApi getPackageAllList End!!!!!!!!!!!!!");
		
		return returnMap;
	}
	
	public Map<String, Object> setEnabled(Map<String, Object> map) throws Exception{
		String url = urlPrefix + "/UiPath.Server.Configuration.OData.SetEnabled";
		ResponseEntity<Map> response = restApi.post(url, map);
		Map<String, Object> returnMap = response.getBody();
		return returnMap;
	}
	
	public Map<String, Object> deleteProcessSchedules(Map<String, Object> map) throws Exception{
		String url = urlPrefix + "(" + map.get("scheduleId") +")";
		ResponseEntity<Map> response = restApi.delete(url, map);
		Map<String, Object> returnMap = response.getBody();
		return returnMap;
	}
	
	public Map<String, Object> searchReleases(Map<String, Object> map) throws Exception{
		logger.debug("TriggerUrApi searchReleases Start!!!!!!!!!!!!!");
		
		String searchKwrd = map.get("searchKwrd").toString();
		
		String url = "/odata/Releases?$select=Id,EnvironmentId,Name,Key,Arguments,InputArguments&$top=50&$orderby=Name&$filter=contains(Name, " + URLEncoder.encode("'" + searchKwrd + "'", "UTF-8") + ")";

		ResponseEntity<Map> response = restApi.get(url, map);
		Map<String, Object> returnMap = response.getBody();
		
		logger.debug("PackageApi searchReleases End!!!!!!!!!!!!!");
		
		return returnMap;
	}
	
	public Map<String, Object> searchCalendars(Map<String, Object> map) throws Exception{
		logger.debug("TriggerUrApi searchCalendars Start!!!!!!!!!!!!!");
		
		String url = "/odata/Calendars";

		ResponseEntity<Map> response = restApi.get(url, map);
		Map<String, Object> returnMap = response.getBody();
		
		logger.debug("PackageApi searchCalendars End!!!!!!!!!!!!!");
		
		return returnMap;
	}
	
	public Map<String, Object> searchEnvironmentRobots(Map<String, Object> map) throws Exception{
		logger.debug("TriggerUrApi searchRobots Start!!!!!!!!!!!!!");
		
		String searchKwrd = map.get("searchKwrd").toString().equals("") ? "" : URLEncoder.encode("'" + map.get("searchKwrd").toString() + "'", "UTF-8");
		String searchEnvironmentId = map.get("searchEnvironmentId").toString();
		String url =
				searchKwrd.equals("") 
				? "/odata/Sessions?$filter=Robot/Environments/any(e:e/Id eq " + searchEnvironmentId + ") and Robot/Type ne 'Attended' and Robot/Environments/any(e:e/Id eq " + searchEnvironmentId + ") and Robot/Type ne 'Attended'&$top=10000&$expand=Robot&$orderby=IsUnresponsive asc,State asc"
				: "/odata/Sessions?$filter=((contains(Robot/Name," + searchKwrd +")) or (contains(HostMachineName, " + searchKwrd +"))) and Robot/Environments/any(e:e/Id eq " + searchEnvironmentId + ") and Robot/Type ne 'Attended' and Robot/Environments/any(e:e/Id eq " + searchEnvironmentId + ") and Robot/Type ne 'Attended'&$top=10000&$expand=Robot&$orderby=HostMachineName asc";
		
		
		ResponseEntity<Map> response = restApi.get(url, map);
		Map<String, Object> returnMap = response.getBody();
		
		logger.debug("PackageApi searchRobots End!!!!!!!!!!!!!");
		
		return returnMap;
	}
	
	public Map<String, Object> searchTimezones(Map<String, Object> map) throws Exception{
		logger.debug("TriggerUrApi searchTimezones Start!!!!!!!!!!!!!");
		
		String url = "/odata/Settings/UiPath.Server.Configuration.OData.GetTimezones";

		ResponseEntity<Map> response = restApi.get(url, map);
		Map<String, Object> returnMap = response.getBody();
		
		logger.debug("PackageApi searchTimezones End!!!!!!!!!!!!!");
		
		return returnMap;
	}
	
	public Map<String, Object> searchQueueDefinitions(Map<String, Object> map) throws Exception{
		logger.debug("TriggerUrApi searchQueueDefinitions Start!!!!!!!!!!!!!");
		String sProcessScheduleId = map.get("ProcessScheduleId") == null ? null : map.get("ProcessScheduleId").toString();
		String url = "/odata/QueueDefinitions?$select=Id,Name&$filter=((startswith(Name,%27%27))%20and%20(((ProcessScheduleId%20eq%20null)%20or%20(ProcessScheduleId%20eq%20"+ (sProcessScheduleId == null ? -1 : sProcessScheduleId) +"))))&$top=100&$orderby=Name";

		ResponseEntity<Map> response = restApi.get(url, map);
		Map<String, Object> returnMap = response.getBody();
		
		logger.debug("PackageApi searchQueueDefinitions End!!!!!!!!!!!!!");
		
		return returnMap;
	}
	
	public Map<String, Object> insertProcessSchedules(Map<String, Object> map) throws Exception{
		logger.debug("TriggerUrApi insertProcessSchedules Start!!!!!!!!!!!!!");
		
		String url = urlPrefix;

		ResponseEntity<Map> response = restApi.post2(url, map);
		Map<String, Object> returnMap = response.getBody();
		
		logger.debug("PackageApi insertProcessSchedules End!!!!!!!!!!!!!");
		
		return returnMap;
	}
	
	public Map<String, Object> searchInstantStartEnvironmentRobots(Map<String, Object> map) throws Exception{
		logger.debug("TriggerUrApi searchRobots Start!!!!!!!!!!!!!");
		
		String searchKwrd = map.get("searchKwrd").toString().equals("") ? "" : URLEncoder.encode("'" + map.get("searchKwrd").toString() + "'", "UTF-8");
		String searchEnvironmentId = map.get("searchEnvironmentId").toString();
		String url =
				searchKwrd.equals("") 
				? "/odata/Sessions?$filter=Robot/Environments/any(e:e/Id eq " + searchEnvironmentId + ") and Robot/Type ne 'Attended' and Robot/Environments/any(e:e/Id eq " + searchEnvironmentId + ") and Robot/Type ne 'Attended'&$top=10000&$expand=Robot&$orderby=IsUnresponsive asc,State asc"
				: "/odata/Sessions?$filter=((contains(Robot/Name," + searchKwrd +")) or (contains(HostMachineName, " + searchKwrd +"))) and Robot/Environments/any(e:e/Id eq " + searchEnvironmentId + ") and Robot/Type ne 'Attended' and Robot/Environments/any(e:e/Id eq " + searchEnvironmentId + ") and Robot/Type ne 'Attended'&$top=10000&$expand=Robot&$orderby=HostMachineName asc";
		
		
		ResponseEntity<Map> response = restApi.get(url, map);
		Map<String, Object> returnMap = response.getBody();
		
		logger.debug("PackageApi searchRobots End!!!!!!!!!!!!!");
		
		return returnMap;
	}

	public Map<String, Object> triggerUrInsertInstantStart(Map<String, Object> map) throws Exception{
		logger.debug("TriggerUrApi triggerUrInsertInstantStart Start!!!!!!!!!!!!!");
		String url = "/odata/Jobs/UiPath.Server.Configuration.OData.StartJobs";
		ResponseEntity<Map> response = restApi.post2(url, map);
		Map<String, Object> returnMap = response.getBody();
		logger.debug("PackageApi triggerUrInsertInstantStart End!!!!!!!!!!!!!");
		return returnMap;
	}
	
	public Map<String, Object> getProcessSchedules(Map<String, Object> map) throws Exception{
		logger.debug("TriggerUrApi getProcessSchedules Start!!!!!!!!!!!!!");
		String url = "/odata/ProcessSchedules("+ map.get("schduleId").toString() +")";
		ResponseEntity<Map> response = restApi.get(url, map);
		Map<String, Object> returnMap = response.getBody();
		logger.debug("PackageApi getProcessSchedules End!!!!!!!!!!!!!");
		return returnMap;
	}
	
	
	public Map<String, Object> getRobotIdsForProcessSchedules(Map<String, Object> map) throws Exception{
		logger.debug("TriggerUrApi getRobotIdsForProcessSchedules Start!!!!!!!!!!!!!");
		String url = "/odata/ProcessSchedules/UiPath.Server.Configuration.OData.GetRobotIdsForSchedule(key="+ map.get("schduleId").toString() + ")";
		ResponseEntity<Map> response = restApi.get(url, map);
		Map<String, Object> returnMap = response.getBody();
		logger.debug("PackageApi getRobotIdsForProcessSchedules End!!!!!!!!!!!!!");
		return returnMap;
	}
	
	public Map<String, Object> updateProcessSchedules(Map<String, Object> map) throws Exception{
		logger.debug("TriggerUrApi updateProcessSchedules Start!!!!!!!!!!!!!");
		
		String url = "/odata/ProcessSchedules("+ map.get("Id").toString() +")";
		
		ResponseEntity<Map> response = restApi.put2(url, map);
		Map<String, Object> returnMap = response.getBody();
		
		logger.debug("PackageApi updateProcessSchedules End!!!!!!!!!!!!!");
		
		return returnMap;
	}
	
}
