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

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.sl.usermodel.VerticalAlignment;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
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

import kr.co.rpaplatform.common.pagination.PaginationInfo;
import kr.co.rpaplatform.common.vo.ResponseVO;
import kr.co.rpaplatform.dongwon.common.util.PaginationUtil;
import kr.co.rpaplatform.dongwon.stats.service.ExecutStatsService;
import kr.co.rpaplatform.dongwon.stats.service.ExpectRealProcessService;
import kr.co.rpaplatform.dongwon.stats.service.GroupRpaOperService;

/**
 * 그룹RPA운영실적  Controller
 */
@Controller
@RequestMapping("/stats/expectRealProcess")
public class ExpectRealProcessController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(ExpectRealProcessController.class);
	
	@Resource(name="expectRealProcessService")
	private ExpectRealProcessService expectRealProcessService;
	
	/**
	 * 임시 다운로드 경로
	 */
	@Value("${file.tmpdownload.path}")
	private String downloadPath;
			
	/**
	 * 예상실적비교 메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/expectRealProcessMain")
	public ModelAndView precessExecutStatusMain() throws Exception {
		return new ModelAndView("/stats/expectRealProcess/expectRealProcessMain");
	}
	
	/**
	 * 예상실적비교 로봇 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getRobotList")
	@ResponseBody
	public ResponseVO getRobotList(@RequestBody Map<String, Object> map) throws Exception {		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		// 해당 회사에 맞는 로봇 리스트 조회
		List<Map<String, Object>> robotList = expectRealProcessService.selectBotListForExpectRealRobot(map); 				
		returnMap.put("robotList", robotList);
				
		return new ResponseVO(returnMap);
	}
	
	/**
	 * 예상실제비교 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getExpectRealProcessList")
	@ResponseBody
	public ResponseVO getExpectRealProcessList(@RequestBody Map<String, Object> params) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();

		// 리스트 카운트 조회
		int totalRecordCount = expectRealProcessService.getExpectRealProcessListCount(params);
				
		if (totalRecordCount > 0) {
			
			//페이징 정보 조회
			PaginationInfo paginationInfo = PaginationUtil.getPaginationInfo(params, totalRecordCount);
			
			//조회조건에 페이징 정보 설정
			params.put("paginationInfo", paginationInfo);
			
			List<Map<String, Object>> expectRealProcessList = expectRealProcessService.getExpectRealProcessList(params);

			//결과값 설정
			returnMap.put("resultList", expectRealProcessList);
			returnMap.put("paginationInfo", paginationInfo);
			
		} else {
			
			//결과값 설정
			returnMap.put("resultList", null);
			returnMap.put("paginationInfo", PaginationUtil.getPaginationInfo(params, 0));
			
		}
		
		return new ResponseVO(returnMap);
	}
	
	
	/**
	 * 예상실제비교_프로세스 엑셀 다운로드
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/outExportExpectRealProcessList")
	@ResponseBody
	public ResponseVO outExportJobMngList(@RequestBody Map<String, Object> params) throws Exception {
		
		boolean isAllCmpny = params.get("searchCmpnyCd").toString().equals("");
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();

        List<String> columns = new ArrayList<String>();
        List<String> columnsStd = new ArrayList<String>();
        columns.add("회사");
        columns.add("프로세스 코드");
        columns.add("프로세스 명");
        
        columns.add("프로세스 상태");
        columns.add("개발 귀속일");
        columns.add("실행주기");
        columns.add("(예상)절감시간(건당)");
        
        columns.add("(예상)성공횟수");
        columns.add("(예상)절감시간");
        columns.add("(실제)성공횟수");
        columns.add("(실제)절감시간");
        
        columns.add("실행성공률");
        columns.add("BOT");


        //디바이스 리스트 조회
		resultList = expectRealProcessService.getExpectRealProcessList(params); 
              
		//디바이스 리스트 조회
		              
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
		
		CellStyle headerCellStyle = wb.createCellStyle();
		headerCellStyle.setBorderRight(BorderStyle.THIN);
		headerCellStyle.setBorderLeft(BorderStyle.THIN);
		headerCellStyle.setBorderTop(BorderStyle.THIN);
		headerCellStyle.setBorderBottom(BorderStyle.THIN);
		headerCellStyle.setAlignment(HorizontalAlignment.CENTER);
		headerCellStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
		headerCellStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		
		Font toBold = wb.createFont();
		toBold.setBold(true);
		headerCellStyle.setFont(toBold);
		
		CellStyle cellStyle = wb.createCellStyle();
		cellStyle.setBorderRight(BorderStyle.THIN);
		cellStyle.setBorderLeft(BorderStyle.THIN);
		cellStyle.setBorderTop(BorderStyle.THIN);
		cellStyle.setBorderBottom(BorderStyle.THIN);
        
		Sheet sh = wb.createSheet("에상실제비교");
		
		Row hd = sh.createRow(1);
		
		int columnsSize = columns.size();
		for (int i = 0; i < columnsSize; i++) {
			Cell cell = hd.createCell(i);
			cell.setCellValue(columns.get(i));
			cell.setCellStyle(headerCellStyle);
			
			sh.setColumnWidth(i, 13*256);
		}
		
		Cell bodyCell = null;
		Map<String, Object> map = null;
		
		int resultListSize = resultList.size();
		
		for (int i = 0; i < resultListSize; i++) {
			
			map = resultList.get(i);
			
			int cellIdx = 0;
			Row row = sh.createRow(i+2);	
			
			// 회사명
			String cmpnyNm = !map.containsKey("cmpnyNm") ? "NULL" : (String)map.get("cmpnyNm");
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(cmpnyNm);
			bodyCell.setCellStyle(cellStyle);
			
			// 프로세스코드
			String processCd = !map.containsKey("processCd") ? "NULL" : (String)map.get("processCd");
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(processCd);
			bodyCell.setCellStyle(cellStyle);
			
			
			// 프로세스명
			String processNm = !map.containsKey("processNm") ? "NULL" : (String)map.get("processNm");
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(processNm);
			bodyCell.setCellStyle(cellStyle);
			
		    
			// 프로세스 상태
			String processStatus = !map.containsKey("processStatus") ? "NULL" : (String)map.get("processStatus");
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(processStatus);
			bodyCell.setCellStyle(cellStyle);
			
		
			// 개발 귀속일
			String belongingDate = !map.containsKey("belongingDate") ? "NULL" : (String)map.get("belongingDate");
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(belongingDate);
			bodyCell.setCellStyle(cellStyle);
			
			
			// 실행주기
			String expectFreq = !map.containsKey("expectFreq") ? "NULL" : (String)map.get("expectFreq");
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(expectFreq);
			bodyCell.setCellStyle(cellStyle);
			
			
			// (예상)절감시간(건당)
			Double oneRedcnTm = !map.containsKey("oneRedcnTm") ? 0.00 : Double.parseDouble(String.valueOf(map.get("oneRedcnTm")));
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(oneRedcnTm);
			bodyCell.setCellStyle(cellStyle);
			
			
			// (예상)성공횟수
			Double expectSuccessCount = !map.containsKey("expectSuccessCount") ? 0.00 : Double.parseDouble(String.valueOf(map.get("expectSuccessCount")));
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(expectSuccessCount);
			bodyCell.setCellStyle(cellStyle);
			
			
			// (예상)절감시간
			Double expectRedcnTm = !map.containsKey("expectRedcnTm") ? 0.00 : Double.parseDouble(String.valueOf(map.get("expectRedcnTm")));
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(expectRedcnTm);
			bodyCell.setCellStyle(cellStyle);
			
			
			// (실제)성공횟수
			int realSuccessCount = !map.containsKey("realSuccessCount") ? 0 : Integer.parseInt(String.valueOf(map.get("realSuccessCount")));
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(realSuccessCount);
			bodyCell.setCellStyle(cellStyle);

			// (실제)절감시간
			Double realRedcnTm = !map.containsKey("realRedcnTm") ? 0.00 : Double.parseDouble(String.valueOf(map.get("realRedcnTm")));
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(realRedcnTm);
			bodyCell.setCellStyle(cellStyle);
			
			
			// 실행성공률
			Double successRate = !map.containsKey("successRate") ? 0.00 : Double.parseDouble(String.valueOf(map.get("successRate")));
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(successRate);
			bodyCell.setCellStyle(cellStyle);
					
			// BOT
			String bot = !map.containsKey("bot") ? "NULL" : (String)map.get("bot");
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(bot);
			bodyCell.setCellStyle(cellStyle);	
		}
		
		wb.write(os);
		os.close();

		((SXSSFWorkbook) wb).dispose();
		wb.close();
		
		returnMap.put("fileNo", fileNo);
		return new ResponseVO(returnMap);
	}
}
