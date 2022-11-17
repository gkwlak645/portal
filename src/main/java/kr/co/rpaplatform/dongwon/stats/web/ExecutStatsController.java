/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 6. 10.         LSH
 */
package kr.co.rpaplatform.dongwon.stats.web;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

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
import org.springframework.stereotype.Controller;
import org.springframework.validation.DefaultMessageCodesResolver.Format;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.rpaplatform.common.vo.ResponseVO;
import kr.co.rpaplatform.dongwon.stats.service.ExecutStatsService;

/**
 * 실행통계  Controller
 * @author LSH
 * 2020. 6. 10.
 */
@Controller
@RequestMapping("/stats")
public class ExecutStatsController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(ExecutStatsController.class);
	
	
	
	@Resource(name="executStatsService")
	private ExecutStatsService executStatsService;
	
	/**
	 * 임시 다운로드 경로
	 */
	@Value("${file.tmpdownload.path}")
	private String downloadPath;
	
	
	
	/**
	 * 프로세스별실행현황 메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/processExecutStatus/processExecutStatusMain")
	public ModelAndView precessExecutStatusMain() throws Exception {
		return new ModelAndView("/stats/processExecutStatus/processExecutStatusMain");
	}
	
	/**
	 * 프로세스별실행현황 메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/processExecutStatus/processExecutStatusV2Main")
	public ModelAndView precessExecutStatusV2Main() throws Exception {
		return new ModelAndView("/stats/processExecutStatus/processExecutStatusV2Main");
	}
	
	/**
	 * 프로세스별실행현황 월별 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/processExecutStatus/processExecutStatusYearList")
	@ResponseBody
	public ResponseVO getYearList(@RequestBody Map<String, Object> params) throws Exception {

		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
        Calendar c1 = Calendar.getInstance();
        String year = sdf.format(c1.getTime());
        String stYear = (String) params.get("searchYear");
        
        if(stYear == null || stYear == "") {
        	params.put("year", year);
        }else {
        	params.put("year", stYear);
        }
        List<Map<String, Object>> resultList = executStatsService.selectProcessRunStsList(params);
		returnMap.put("resultList", resultList);
		return new ResponseVO(returnMap);
	}
	
	/**
	 * 프로세스별실행현황 일별 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/processExecutStatus/processExecutStatusMonthList")
	@ResponseBody
	public ResponseVO getMonthList(@RequestBody Map<String, Object> params) throws Exception {

		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		String year = (String) params.get("searchYear");
		String month = (String) params.get("searchMonth");
		if(month.length() == 1) {
			month = "0"+month;
		}
		params.put("year", year);
		params.put("month", month);
		
		int monthCnt = executStatsService.selectMonthPerDayCount(params);
		List<Map<String, Object>> resultList= executStatsService.selectProcessMonthList(params);
		//결과값 설정
		returnMap.put("monthCnt", monthCnt);
		returnMap.put("resultList", resultList);
		
		return new ResponseVO(returnMap);
	}
	
	
	/**
	 * 프로세스별실행현황 리스트 엑셀 다운로드
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/processExecutStatus/outExportProcessExecutStatusList")
	@ResponseBody
	public ResponseVO processExecutStatusList(@RequestBody Map<String, Object> params) throws Exception {

		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();
		
		int 	 monthCnt  	= 0;
        String   yearSe 	= (String) params.get("yearSe");
        
        //{"회사명", "프로세스코드", "프로세스명",  "합계/평균", "구분"}
        List<String> columns = new ArrayList<String>();
        List<String> columnsStd = new ArrayList<String>();
        columns.add("회사명");
        columns.add("프로세스코드");
        columns.add("프로세스명");
        columns.add("합계/평균");
        columns.add("구분");
        
        if("Y".equals(yearSe)) {
        	SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
            Calendar c1   = Calendar.getInstance();
            String year   = sdf.format(c1.getTime());
            String stYear = (String) params.get("searchYear");
            
            if(stYear == null || stYear == "") {
            	params.put("year", year);
            }else {
            	params.put("year", stYear);
            }
            
            for(int i=0; i<12; i++) {
            	String month = String.valueOf(i+1);
            	if(month.length() == 1) {
            		month = "0"+month;
        		}
            	columns.add(month);
            	columnsStd.add("m"+month);
            }
            
            resultList = executStatsService.selectProcessRunStsListV2(params);
        }else {
        	String year  = (String) params.get("searchYear");
    		String month = (String) params.get("searchMonth");
    		if(month.length() == 1) {
    			month = "0"+month;
    		}
    		params.put("year", year);
    		params.put("month", month);
    		
    		monthCnt = executStatsService.selectMonthPerDayCount(params);
    		
    		for(int i=0; i<monthCnt; i++) {
            	String day = String.valueOf(i+1);
            	if(day.length() == 1) {
            		day = "0"+day;
        		}
            	columns.add(day);
            	columnsStd.add("d"+day);
            }
    		
    		resultList= executStatsService.selectProcessMonthListV2(params);
        }
        
        
        File dir = new File(downloadPath);
		
		if (!dir.exists()) {
			dir.mkdirs();
		}
		
		SimpleDateFormat dfm = new SimpleDateFormat ("yyyyMMddhhmmss");
		Calendar cal = Calendar.getInstance();
		String today = "";
		today = dfm.format(cal.getTime());
		
		String fileNo = MDC.get("txUserId") + today;
		
		OutputStream os = new FileOutputStream(downloadPath + File.separator + fileNo+".xlsx");

		Workbook wb = new SXSSFWorkbook(100); // 100 row마다 파일로 flush
		
		CellStyle cellStyle = wb.createCellStyle();
		cellStyle.setBorderRight(BorderStyle.THIN);
		cellStyle.setBorderLeft(BorderStyle.THIN);
		cellStyle.setBorderTop(BorderStyle.THIN);
		cellStyle.setBorderBottom(BorderStyle.THIN);
        
		Sheet sh = wb.createSheet("프로세스별실행현황");
		
		Row hd = sh.createRow(1);
		int columnSize = columns.size();
		for (int i = 0; i < columnSize; i++) {
			Cell cell = hd.createCell(i);
			cell.setCellValue(columns.get(i));
			cell.setCellStyle(cellStyle);
			sh.setColumnWidth(i, 13*256);
		}
		
		Cell bodyCell = null;
		Map<String, Object> map = null;
		int resultListSize = resultList.size();
		for (int i = 0; i < resultListSize; i++) {
			
			map = resultList.get(i);
			
			int cellIdx = 0;
			Row row = sh.createRow(i+2);	
			
			//회사명
			String compNm = "ZZ".equals((String)map.get("compNm")) ? "전체 합계/평균" : (String)map.get("compNm");
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(compNm);
			bodyCell.setCellStyle(cellStyle);
			
			//프로세스코드
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)map.get("processCd"));
			bodyCell.setCellStyle(cellStyle);
			
			//프로세스명
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)map.get("processNm"));
			bodyCell.setCellStyle(cellStyle);
			
			//합계/평균
			bodyCell = row.createCell(cellIdx++);
			if(map.containsKey("monTot")) {
				bodyCell.setCellValue(Integer.parseInt(String.valueOf(Math.round((double) map.get("monTot"))))); 
			}
			else {
				bodyCell.setCellValue(0); 
			}
			
			bodyCell.setCellStyle(cellStyle);
			
			//구분
			String gbn = "";
			if("A".equals((String)map.get("gbn")) || "TA".equals((String)map.get("gbn"))) {
				gbn = "성공";
			}else if("B".equals((String)map.get("gbn")) || "TB".equals((String)map.get("gbn"))) {
				gbn = "실패";
			}else if("C".equals((String)map.get("gbn")) || "TC".equals((String)map.get("gbn"))) {
				gbn = "성공률";
			}else if("D".equals((String)map.get("gbn")) || "TD".equals((String)map.get("gbn"))) {
				gbn = "평균실행시간";
			}else if("E".equals((String)map.get("gbn")) || "TE".equals((String)map.get("gbn"))) {
				gbn = "절감시간";
			}else if("F".equals((String)map.get("gbn")) || "TF".equals((String)map.get("gbn"))) {
				gbn = "절감률";
			}else if("G".equals((String)map.get("gbn")) || "TG".equals((String)map.get("gbn"))) {
				gbn = "가동시간";
			}else if("H".equals((String)map.get("gbn")) || "TH".equals((String)map.get("gbn"))) {
				gbn = "가동률";
				
				if("TH".equals((String)map.get("gbn"))) {
					sh.addMergedRegion(new CellRangeAddress(i-5, i+2, 0, 2));
				}else {
					sh.addMergedRegion(new CellRangeAddress(i-5, i+2, 0, 0));
					sh.addMergedRegion(new CellRangeAddress(i-5, i+2, 1, 1));
					sh.addMergedRegion(new CellRangeAddress(i-5, i+2, 2, 2));
				}
			}else {}
			
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(gbn);
			bodyCell.setCellStyle(cellStyle);
			
			//월/일 값 map.get(columnsStd.get(j))
			int columnsStdSize = columnsStd.size();
			for(int j=0; j<columnsStdSize; j++) {
				bodyCell = row.createCell(cellIdx++);
				bodyCell.setCellValue(Integer.parseInt(String.valueOf(Math.round((double) map.get(columnsStd.get(j)))))); 
				bodyCell.setCellStyle(cellStyle);
			}
		}
		
		wb.write(os);
		os.close();

		((SXSSFWorkbook) wb).dispose();
		wb.close();
		
		returnMap.put("fileNo", fileNo);
		return new ResponseVO(returnMap);
	}
	
	
	/**
	 * 로봇별실행현황 메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/robotExecutStatus/robotExecutStatusMain")
	public ModelAndView robotExecutStatusMain() throws Exception {
		return new ModelAndView("/stats/robotExecutStatus/robotExecutStatusMain");
	}
	
	/**
	 * 로봇별실행현황 메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/robotExecutStatus/robotExecutStatusV2Main")
	public ModelAndView robotExecutStatusV2Main() throws Exception {
		return new ModelAndView("/stats/robotExecutStatus/robotExecutStatusV2Main");
	}
	
	/**
	 * 과제별실행현황 메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/taskExecutStatus/taskExecutStatusV2Main")
	public ModelAndView taskExecutStatusV2Main() throws Exception {
		return new ModelAndView("/stats/taskExecutStatus/taskExecutStatusV2Main");
	}
	
	/**
	 * 로봇별실행현황 월별 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/robotExecutStatus/robotExecutStatusYearList")
	@ResponseBody
	public ResponseVO getRobotYearList(@RequestBody Map<String, Object> params) throws Exception {

		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
        Calendar c1 = Calendar.getInstance();
        String year = sdf.format(c1.getTime());
        String stYear = (String) params.get("searchYear");
        
        if(stYear == null || stYear == "") {
        	params.put("year", year);
        }else {
        	params.put("year", stYear);
        }
        List<Map<String, Object>> resultList = executStatsService.selectRobotRunYearStsList(params);
		returnMap.put("resultList", resultList);
		return new ResponseVO(returnMap);
	}
	
	/**
	 * 로봇별실행현황 일별 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/robotExecutStatus/robotExecutStatusMonthList")
	@ResponseBody
	public ResponseVO getRobotMonthList(@RequestBody Map<String, Object> params) throws Exception {

		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		String year = (String) params.get("searchYear");
		String month = (String) params.get("searchMonth");
		if(month.length() == 1) {
			month = "0"+month;
		}
		params.put("year", year);
		params.put("month", month);
		
		int monthCnt = executStatsService.selectMonthPerDayCount(params);
		List<Map<String, Object>> resultList= executStatsService.selectRobotRunMonthStsList(params);
		//결과값 설정
		returnMap.put("monthCnt", monthCnt);
		returnMap.put("resultList", resultList);
		
		return new ResponseVO(returnMap);
	}
	
	
	
	/**
	 * 로봇별실행현황 리스트 엑셀 다운로드
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/robotExecutStatus/outExportrobotExecutStatusList")
	@ResponseBody
	public ResponseVO outExportrobotExecutStatusList(@RequestBody Map<String, Object> params) throws Exception {

		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();
		
		int 	 monthCnt  	= 0;
        String   yearSe 	= (String) params.get("yearSe");
        
        //{"회사명", "로봇명",  "합계/평균", "구분"}
        List<String> columns = new ArrayList<String>();
        List<String> columnsStd = new ArrayList<String>();
        columns.add("회사명");
        columns.add("로봇명");
        columns.add("합계/평균");
        columns.add("구분");
        
        if("Y".equals(yearSe)) {
        	SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
            Calendar c1   = Calendar.getInstance();
            String year   = sdf.format(c1.getTime());
            String stYear = (String) params.get("searchYear");
            
            if(stYear == null || stYear == "") {
            	params.put("year", year);
            }else {
            	params.put("year", stYear);
            }
            
            for(int i=0; i<12; i++) {
            	String month = String.valueOf(i+1);
            	if(month.length() == 1) {
            		month = "0"+month;
        		}
            	columns.add(month);
            	columnsStd.add("m"+month);
            }
            
            resultList = executStatsService.selectRobotRunYearStsListV2(params);
        }else {
        	String year  = (String) params.get("searchYear");
    		String month = (String) params.get("searchMonth");
    		if(month.length() == 1) {
    			month = "0"+month;
    		}
    		params.put("year", year);
    		params.put("month", month);
    		
    		monthCnt = executStatsService.selectMonthPerDayCount(params);
    		
    		for(int i=0; i<monthCnt; i++) {
            	String day = String.valueOf(i+1);
            	if(day.length() == 1) {
            		day = "0"+day;
        		}
            	columns.add(day);
            	columnsStd.add("d"+day);
            }
    		
    		resultList= executStatsService.selectRobotRunMonthStsListV2(params);
        }
        
        
        File dir = new File(downloadPath);
		
		if (!dir.exists()) {
			dir.mkdirs();
		}
		
		SimpleDateFormat dfm = new SimpleDateFormat ("yyyyMMddhhmmss");
		Calendar cal = Calendar.getInstance();
		String today = "";
		today = dfm.format(cal.getTime());
		
		String fileNo = MDC.get("txUserId") + today;
		
		OutputStream os = new FileOutputStream(downloadPath + File.separator + fileNo+".xlsx");

		Workbook wb = new SXSSFWorkbook(100); // 100 row마다 파일로 flush
		
		CellStyle cellStyle = wb.createCellStyle();
		cellStyle.setBorderRight(BorderStyle.THIN);
		cellStyle.setBorderLeft(BorderStyle.THIN);
		cellStyle.setBorderTop(BorderStyle.THIN);
		cellStyle.setBorderBottom(BorderStyle.THIN);
        
		Sheet sh = wb.createSheet("로봇별실행현황");
		
		Row hd = sh.createRow(1);
		for (int i = 0; i < columns.size(); i++) {
			Cell cell = hd.createCell(i);
			cell.setCellValue(columns.get(i));
			cell.setCellStyle(cellStyle);
			sh.setColumnWidth(i, 13*256);
		}
		
		Cell bodyCell = null;
		Map<String, Object> map = null;
		for (int i = 0; i < resultList.size(); i++) {
			
			map = resultList.get(i);
			
			int cellIdx = 0;
			Row row = sh.createRow(i+2);	
			
			//회사명
			String compNm = "ZZ".equals((String)map.get("compNm")) ? "전체 합계/평균" : (String)map.get("compNm");
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(compNm);
			bodyCell.setCellStyle(cellStyle);
			
			//로봇명
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)map.get("botNm"));
			bodyCell.setCellStyle(cellStyle);
			
			//합계/평균
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(Integer.parseInt(String.valueOf(Math.round((double) map.get("monTot"))))); 
			bodyCell.setCellStyle(cellStyle);
			
			//구분
			String gbn = "";
			if("A".equals((String)map.get("gbn")) || "TA".equals((String)map.get("gbn"))) {
				gbn = "성공";
			}else if("B".equals((String)map.get("gbn")) || "TB".equals((String)map.get("gbn"))) {
				gbn = "실패";
			}else if("C".equals((String)map.get("gbn")) || "TC".equals((String)map.get("gbn"))) {
				gbn = "성공률";
			}else if("D".equals((String)map.get("gbn")) || "TD".equals((String)map.get("gbn"))) {
				gbn = "평균실행시간";
			}else if("E".equals((String)map.get("gbn")) || "TE".equals((String)map.get("gbn"))) {
				gbn = "절감시간";
			}else if("F".equals((String)map.get("gbn")) || "TF".equals((String)map.get("gbn"))) {
				gbn = "절감률";
			}else if("G".equals((String)map.get("gbn")) || "TG".equals((String)map.get("gbn"))) {
				gbn = "가동시간";
			}else if("H".equals((String)map.get("gbn")) || "TH".equals((String)map.get("gbn"))) {
				gbn = "가동률";
				
				if("TH".equals((String)map.get("gbn"))) {
					sh.addMergedRegion(new CellRangeAddress(i-5, i+2, 0, 1));
				}else {
					sh.addMergedRegion(new CellRangeAddress(i-5, i+2, 0, 0));
					sh.addMergedRegion(new CellRangeAddress(i-5, i+2, 1, 1));
				}
			}else {}
			
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(gbn);
			bodyCell.setCellStyle(cellStyle);
			
			//월/일 값 map.get(columnsStd.get(j))
			for(int j=0; j<columnsStd.size(); j++) {
				bodyCell = row.createCell(cellIdx++);
				bodyCell.setCellValue(Integer.parseInt(String.valueOf(Math.round((double) map.get(columnsStd.get(j)))))); 
				bodyCell.setCellStyle(cellStyle);
			}
		}
		
		/*for (int i = 0; i < columns.size(); i++) {
			sh.autoSizeColumn(i);;
		}*/
		
		wb.write(os);
		os.close();

		((SXSSFWorkbook) wb).dispose(); 
		wb.close();
		
		returnMap.put("fileNo", fileNo);
		return new ResponseVO(returnMap);
	}
	
	/**
	 * 인원 및 봇수 현황 메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/npRobotStatus/npRobotStatusMain")
	public ModelAndView npRobotStatusMain() throws Exception {
		return new ModelAndView("/stats/npRobotStatus/npRobotStatusMain");
	}

	/**
	 * 인원 및 봇수 현황 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/npRobotStatus/npRobotStatusList")
	@ResponseBody
	public ResponseVO getnpRobotStatusList(@RequestBody Map<String, Object> params) throws Exception {

		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		int roleCnt = executStatsService.selectRoleCdCount(params);
		
        List<Map<String, Object>> resultList = executStatsService.selectNpRobotStatusList(params);
        
		returnMap.put("roleCnt", roleCnt);
		returnMap.put("resultList", resultList);
		return new ResponseVO(returnMap);
	}
	
	/**
	 * 계획대비실적 현황 메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/planAgainstPerforStatus/planAgainstPerforStatusMain")
	public ModelAndView planAgainstPerforStatusMain() throws Exception {
		return new ModelAndView("/stats/planAgainstPerforStatus/planAgainstPerforStatusMain");
	}
	
	/**
	 * 계획대비실적 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/planAgainstPerforStatus/getPlanAgainstPerforStatusList")
	@ResponseBody
	public ResponseVO getPlanAgainstPerforStatusList(@RequestBody Map<String, Object> params) throws Exception {

		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		String month = (String) params.get("searchMonth");
		String searchGbn = params.get("radioVal").toString();
		if(month.length() == 1) {
			month = "0"+month;
			params.put("searchMonth", month);
		}
		
		List<Map<String, Object>> resultList = null;
		if("Y".equals(searchGbn)) {
			resultList = executStatsService.selectPlanAgainstPerforStatusList(params);
		}else {
			resultList = executStatsService.selectPlanAgainstPerforStatusTwoList(params);
		}
		returnMap.put("resultList", resultList);
		return new ResponseVO(returnMap);
	}
	
	/**
	 * 프로세스 운영 현황 메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/preocessOperStatus/preocessOperStatusMain")
	public ModelAndView preocessOperStatusMain() throws Exception {
		return new ModelAndView("/stats/preocessOperStatus/preocessOperStatusMain");
	}
	
	/**
	 * 프로세스별 운영 현황 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/preocessOperStatus/preocessOperStatusList")
	@ResponseBody
	public ResponseVO preocessOperStatusList(@RequestBody Map<String, Object> params) throws Exception {

		Map<String, Object> returnMap = new HashMap<String, Object>();
        List<Map<String, Object>> resultList = executStatsService.selectPreocessOperStatusList(params);
        returnMap.put("resultList", resultList);
        
        List<Map<String, Object>> totList = executStatsService.selectPreocessOperStatusTotList(params);
        returnMap.put("totList", totList);
        
        List<Map<String, Object>> chartList = executStatsService.selectPreocessOperStatusChart(params);
		returnMap.put("chartList", chartList);
		
		logger.debug("ar====: "+totList);
		logger.debug("ar====: "+chartList);
		
		return new ResponseVO(returnMap);
	}
	
	/**
	 * 프로세스별실행현황 월별 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/processExecutStatus/processExecutStatusYearListV2")
	@ResponseBody
	public ResponseVO getYearListV2(@RequestBody Map<String, Object> params) throws Exception {

		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
        Calendar c1 = Calendar.getInstance();
        String year = sdf.format(c1.getTime());
        String stYear = (String) params.get("searchYear");
        
        if(stYear == null || stYear == "") {
        	params.put("year", year);
        }else {
        	params.put("year", stYear);
        }
        List<Map<String, Object>> resultList = executStatsService.selectProcessRunStsListV2(params);
		returnMap.put("resultList", resultList);
		return new ResponseVO(returnMap);
	}
	
	/**
	 * 프로세스별실행현황 일별 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/processExecutStatus/processExecutStatusMonthListV2")
	@ResponseBody
	public ResponseVO getMonthListV2(@RequestBody Map<String, Object> params) throws Exception {

		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		String year = (String) params.get("searchYear");
		String month = (String) params.get("searchMonth");
		if(month.length() == 1) {
			month = "0"+month;
		}
		params.put("year", year);
		params.put("month", month);
		
		int monthCnt = executStatsService.selectMonthPerDayCount(params);
		List<Map<String, Object>> resultList= executStatsService.selectProcessMonthListV2(params);
		//결과값 설정
		returnMap.put("monthCnt", monthCnt);
		returnMap.put("resultList", resultList);
		
		return new ResponseVO(returnMap);
	}
	
	/**
	 * 로봇별실행현황 월별 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/robotExecutStatus/robotExecutStatusYearListV2")
	@ResponseBody
	public ResponseVO getRobotYearListV2(@RequestBody Map<String, Object> params) throws Exception {

		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
        Calendar c1 = Calendar.getInstance();
        String year = sdf.format(c1.getTime());
        String stYear = (String) params.get("searchYear");
        
        if(stYear == null || stYear == "") {
        	params.put("year", year);
        }else {
        	params.put("year", stYear);
        }
        List<Map<String, Object>> resultList = executStatsService.selectRobotRunYearStsListV2(params);
		returnMap.put("resultList", resultList);
		return new ResponseVO(returnMap);
	}
	
	/**
	 * 로봇별실행현황 일별 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/robotExecutStatus/robotExecutStatusMonthListV2")
	@ResponseBody
	public ResponseVO getRobotMonthListV2(@RequestBody Map<String, Object> params) throws Exception {

		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		String year = (String) params.get("searchYear");
		String month = (String) params.get("searchMonth");
		if(month.length() == 1) {
			month = "0"+month;
		}
		params.put("year", year);
		params.put("month", month);
		
		int monthCnt = executStatsService.selectMonthPerDayCount(params);
		List<Map<String, Object>> resultList= executStatsService.selectRobotRunMonthStsListV2(params);
		//결과값 설정
		returnMap.put("monthCnt", monthCnt);
		returnMap.put("resultList", resultList);
		
		return new ResponseVO(returnMap);
	}
	
	/**
	 * 과제별실행현황 월별 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/taskExecutStatus/taskExecutStatusYearListV2")
	@ResponseBody
	public ResponseVO getTaskYearListV2(@RequestBody Map<String, Object> params) throws Exception {

		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
        Calendar c1 = Calendar.getInstance();
        String year = sdf.format(c1.getTime());
        String stYear = (String) params.get("searchYear");
        
        if(stYear == null || stYear == "") {
        	params.put("year", year);
        }else {
        	params.put("year", stYear);
        }
        List<Map<String, Object>> resultList = executStatsService.selectTaskRunYearStsListV2(params);
		returnMap.put("resultList", resultList);
		return new ResponseVO(returnMap);
	}
	
	/**
	 * 과제별실행현황 일별 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/taskExecutStatus/taskExecutStatusMonthListV2")
	@ResponseBody
	public ResponseVO getTaskMonthListV2(@RequestBody Map<String, Object> params) throws Exception {

		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		String year = (String) params.get("searchYear");
		String month = (String) params.get("searchMonth");
		if(month.length() == 1) {
			month = "0"+month;
		}
		params.put("year", year);
		params.put("month", month);
		
		int monthCnt = executStatsService.selectMonthPerDayCount(params);
		List<Map<String, Object>> resultList= executStatsService.selectTaskRunMonthStsListV2(params);
		//결과값 설정
		returnMap.put("monthCnt", monthCnt);
		returnMap.put("resultList", resultList);
		
		return new ResponseVO(returnMap);
	}
	
	/**
	 * 과제별실행현황 리스트 엑셀 다운로드
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/taskExecutStatus/outExporttaskExecutStatusList")
	@ResponseBody
	public ResponseVO outExporttaskExecutStatusList(@RequestBody Map<String, Object> params) throws Exception {

		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();
		
		int 	 monthCnt  	= 0;
        String   yearSe 	= (String) params.get("yearSe");
        
        //{"회사명", "과제코드", "과제명",  "합계/평균", "구분"}
        List<String> columns = new ArrayList<String>();
        List<String> columnsStd = new ArrayList<String>();
        columns.add("회사명");
        columns.add("과제코드");
        columns.add("과제명");
        columns.add("합계/평균");
        columns.add("구분");
        
        if("Y".equals(yearSe)) {
        	SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
            Calendar c1   = Calendar.getInstance();
            String year   = sdf.format(c1.getTime());
            String stYear = (String) params.get("searchYear");
            
            if(stYear == null || stYear == "") {
            	params.put("year", year);
            }else {
            	params.put("year", stYear);
            }
            
            for(int i=0; i<12; i++) {
            	String month = String.valueOf(i+1);
            	if(month.length() == 1) {
            		month = "0"+month;
        		}
            	columns.add(month);
            	columnsStd.add("m"+month);
            }
            
            resultList = executStatsService.selectTaskRunYearStsListV2(params);
        }else {
        	String year  = (String) params.get("searchYear");
    		String month = (String) params.get("searchMonth");
    		if(month.length() == 1) {
    			month = "0"+month;
    		}
    		params.put("year", year);
    		params.put("month", month);
    		
    		monthCnt = executStatsService.selectMonthPerDayCount(params);
    		
    		for(int i=0; i<monthCnt; i++) {
            	String day = String.valueOf(i+1);
            	if(day.length() == 1) {
            		day = "0"+day;
        		}
            	columns.add(day);
            	columnsStd.add("d"+day);
            }
    		
    		resultList= executStatsService.selectTaskRunMonthStsListV2(params);
        }
        
        
        File dir = new File(downloadPath);
		
		if (!dir.exists()) {
			dir.mkdirs();
		}
		
		SimpleDateFormat dfm = new SimpleDateFormat ("yyyyMMddhhmmss");
		Calendar cal = Calendar.getInstance();
		String today = "";
		today = dfm.format(cal.getTime());
		
		String fileNo = MDC.get("txUserId") + today;
		
		OutputStream os = new FileOutputStream(downloadPath + File.separator + fileNo+".xlsx");

		Workbook wb = new SXSSFWorkbook(100); // 100 row마다 파일로 flush
		
		CellStyle cellStyle = wb.createCellStyle();
		cellStyle.setBorderRight(BorderStyle.THIN);
		cellStyle.setBorderLeft(BorderStyle.THIN);
		cellStyle.setBorderTop(BorderStyle.THIN);
		cellStyle.setBorderBottom(BorderStyle.THIN);
        
		Sheet sh = wb.createSheet("과제별실행현황");
		
		Row hd = sh.createRow(1);
		for (int i = 0; i < columns.size(); i++) {
			Cell cell = hd.createCell(i);
			cell.setCellValue(columns.get(i));
			cell.setCellStyle(cellStyle);
			sh.setColumnWidth(i, 13*256);
		}
		
		Cell bodyCell = null;
		Map<String, Object> map = null;
		for (int i = 0; i < resultList.size(); i++) {
			
			map = resultList.get(i);
			
			int cellIdx = 0;
			Row row = sh.createRow(i+2);	
			
			//회사명
			String compNm = "ZZ".equals((String)map.get("compNm")) ? "전체 합계/평균" : (String)map.get("compNm");
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(compNm);
			bodyCell.setCellStyle(cellStyle);
			
			//과제코드
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)map.get("taskCd"));
			bodyCell.setCellStyle(cellStyle);
			
			//과제명
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)map.get("taskNm"));
			bodyCell.setCellStyle(cellStyle);
			
			//합계/평균
			bodyCell = row.createCell(cellIdx++);
			//bodyCell.setCellValue(Integer.parseInt(String.valueOf(Math.round((double) map.get("monTot")))));
			if(map.containsKey("monTot")) {
				bodyCell.setCellValue(Integer.parseInt(String.valueOf(Math.round((double) map.get("monTot"))))); 
			}
			else {
				bodyCell.setCellValue(0); 
			}
			bodyCell.setCellStyle(cellStyle);
			
			//구분
			String gbn = "";
			if("A".equals((String)map.get("gbn")) || "TA".equals((String)map.get("gbn"))) {
				gbn = "성공";
			}else if("B".equals((String)map.get("gbn")) || "TB".equals((String)map.get("gbn"))) {
				gbn = "실패";
			}else if("C".equals((String)map.get("gbn")) || "TC".equals((String)map.get("gbn"))) {
				gbn = "성공률";
			}else if("D".equals((String)map.get("gbn")) || "TD".equals((String)map.get("gbn"))) {
				gbn = "평균실행시간";
			}else if("E".equals((String)map.get("gbn")) || "TE".equals((String)map.get("gbn"))) {
				gbn = "절감시간";
			}else if("F".equals((String)map.get("gbn")) || "TF".equals((String)map.get("gbn"))) {
				gbn = "절감률";
			}else if("G".equals((String)map.get("gbn")) || "TG".equals((String)map.get("gbn"))) {
				gbn = "가동시간";
			}else if("H".equals((String)map.get("gbn")) || "TH".equals((String)map.get("gbn"))) {
				gbn = "가동률";
				
				if("TH".equals((String)map.get("gbn"))) {
					sh.addMergedRegion(new CellRangeAddress(i-5, i+2, 0, 2));
				}else {
					sh.addMergedRegion(new CellRangeAddress(i-5, i+2, 0, 0));
					sh.addMergedRegion(new CellRangeAddress(i-5, i+2, 1, 1));
					sh.addMergedRegion(new CellRangeAddress(i-5, i+2, 2, 2));
				}
			}else {}
			
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(gbn);
			bodyCell.setCellStyle(cellStyle);
			
			//월/일 값 map.get(columnsStd.get(j))
			for(int j=0; j<columnsStd.size(); j++) {
				bodyCell = row.createCell(cellIdx++);
				bodyCell.setCellValue(Integer.parseInt(String.valueOf(Math.round((double) map.get(columnsStd.get(j)))))); 
				bodyCell.setCellStyle(cellStyle);
			}
		}
		
		wb.write(os);
		os.close();

		((SXSSFWorkbook) wb).dispose();
		wb.close();
		
		returnMap.put("fileNo", fileNo);
		return new ResponseVO(returnMap);
	}
}
