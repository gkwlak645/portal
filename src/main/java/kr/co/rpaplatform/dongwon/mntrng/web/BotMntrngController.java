package kr.co.rpaplatform.dongwon.mntrng.web;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.MDC;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.support.CronSequenceGenerator;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.rpaplatform.common.pagination.PaginationInfo;
import kr.co.rpaplatform.common.vo.ResponseVO;
import kr.co.rpaplatform.dongwon.author.vo.AuthorVO;
import kr.co.rpaplatform.dongwon.common.service.PortalCommonService;
import kr.co.rpaplatform.dongwon.common.util.PaginationUtil;
import kr.co.rpaplatform.dongwon.mntrng.service.BotMntrngService;
import kr.co.rpaplatform.dongwon.mntrng.service.JobErrorService;

import org.quartz.*;

/**
 * 작업 컨트롤러
 * @author LSH
 *
 */
@Controller
@RequestMapping("/mntrng/botmntrng")
public class BotMntrngController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(BotMntrngController.class);
	
	@Resource(name="portalCommonService")
	private PortalCommonService portalCommonService;
	
	/**
	 * Bot 동작현황 서비스
	 */
	@Resource(name="botMntrngService")
	private BotMntrngService botMntrngService;
	
	/**
	 * Bot별 동작현황 메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/botMntrngMain")
	public ModelAndView botMntrngMain() throws Exception {
		return new ModelAndView("/mntrng/botmntrng/taskBotMain");
	}
	
	/**
	 * Bot별 동작현황 해당 시간대 프로세스 상세 화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/taskBotProcess")
	public ModelAndView taskBotProcess() throws Exception {
		return new ModelAndView("/mntrng/botmntrng/taskBotProcess");
	}
	
	/**
	 * Bot별 동작현황 리스트 및 로봇 리스트 조회(오늘 날짜만 가져옴)
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getBotMntrngList")
	@ResponseBody
	public ResponseVO getBotMntrngList(@RequestBody Map<String, Object> map) throws Exception {	
		/* Cron 표현식을 DateTime으로 변경 예제 */
		/*CronExpression ce = new CronExpression("0 50 23 ? * MON,TUE,WED,THU,FRI *");
		Date now = new Date();
		Date tomorrow = new Date();
		Calendar tempCalendar = Calendar.getInstance(); 
		tempCalendar.setTime(tomorrow); 
		tempCalendar.add(Calendar.DATE, 1);
		tempCalendar.set(Calendar.MILLISECOND, 0);
		tempCalendar.set(Calendar.SECOND, 0);
		tempCalendar.set(Calendar.MINUTE, 0);
		tempCalendar.set(Calendar.HOUR_OF_DAY, 0);
		
		tomorrow = tempCalendar.getTime();
		
		while(now.compareTo(tomorrow) < 0) {
			now = ce.getTimeAfter(now);
			String dateTimeTemp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(now);
			System.out.println(dateTimeTemp);
		}*/
		
		// 반환 Map
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		/*// 회사 코드 설정
		if(!MDC.get("txCmpnyCd").equals("") && MDC.get("txCmpnyCd") != null) {
			map.put("cmpnycd", (String)MDC.get("txCmpnyCd"));
		}		
		else {
			map.put("cmpnycd", null);
		}*/
	
		/*// Portal에 등록한 회사인지 여부
		int countCmpny = botMntrngService.selectCountLoginCmpny(map); 
		
		if(countCmpny != 1) {
			returnMap.put("countCmpny", false);
			return new ResponseVO(returnMap);
		}*/
		
		// 해당 회사에 맞는 로봇 리스트 조회
		List<Map<String, Object>> robotList = botMntrngService.selectBotList(map); 
		if(robotList.size() > 0) returnMap.put("robotList", robotList);
		else returnMap.put("robotList", null);

		// UR에 해당하는 프로세스의 다음 스케줄 시간대만 가져온다.
		List<Map<String, Object>> tempProcessSchedulesList = botMntrngService.selectTriggerUrScheduleList(map);	
		List<Map<String, Object>> processSchedulesList = new ArrayList<Map<String,Object>>();	

		// 아래 set 순서 지켜야 한다.
		SimpleDateFormat beforeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date endTime = beforeFormat.parse(map.get("searchYMD").toString());
		Calendar tempCalendar = Calendar.getInstance(); 
		tempCalendar.setTime(endTime); 
		tempCalendar.set(Calendar.MILLISECOND, 999);
		tempCalendar.set(Calendar.SECOND, 59);
		tempCalendar.set(Calendar.MINUTE, 59);
		tempCalendar.set(Calendar.HOUR_OF_DAY, 23);
		endTime = tempCalendar.getTime();

		for(Map<String, Object> tempMap : tempProcessSchedulesList) {

			CronExpression ce = new CronExpression(tempMap.get("cronExpression").toString());

			Date now = beforeFormat.parse(tempMap.get("startDt").toString());
						
			Calendar cal = Calendar.getInstance();
			cal.setTime(now);
			//cal.add(Calendar.MINUTE, 2);
			now = cal.getTime();

			while(true) {
				now = ce.getTimeAfter(now);
				if(now.compareTo(endTime) >= 0) break;		

				String nextProcessSchd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(now);

				Map<String, Object> tm = new HashMap<String, Object>();
				tm.putAll(tempMap);
				tm.put("startDt", nextProcessSchd);
				
				Calendar calendar = Calendar.getInstance(); // creates a new calendar instance
				calendar.setTime(now);   // assigns calendar to given date 
				int hour = calendar.get(Calendar.HOUR_OF_DAY); // gets hour in 24h format
				int minute = calendar.get(Calendar.MINUTE);			
				int Lc = minute >= 30 ? 2 * hour + 2 : 2 * hour + 1;
				
				tm.put("startLc", Lc);
				tm.put("endLc", Lc);

				processSchedulesList.add(tm);
			}
		}

		if(processSchedulesList.size() > 0) returnMap.put("processSchedulesList", processSchedulesList);	
		else returnMap.put("processSchedulesList", null);
		
		List<Map<String, Object>> selectTriggerArScheduleList = botMntrngService.selectTriggerArScheduleList(map); 
		if(selectTriggerArScheduleList.size() > 0) returnMap.put("selectTriggerArScheduleList", selectTriggerArScheduleList);	
		else returnMap.put("selectTriggerArScheduleList", null);

		// 오늘 날짜 기준 프로세스 동작 리스트 조회
		List<Map<String, Object>> resultList = botMntrngService.selectBotMntrngList(map); 
		if(resultList.size() > 0) returnMap.put("resultList", resultList);	
		else returnMap.put("resultList", null);			

		return new ResponseVO(returnMap);
	}
}
