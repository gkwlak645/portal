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

import kr.co.rpaplatform.common.vo.ResponseVO;
import kr.co.rpaplatform.dongwon.stats.service.ExecutStatsService;
import kr.co.rpaplatform.dongwon.stats.service.GroupRpaOperService;

/**
 * 그룹RPA운영실적  Controller
 */
@Controller
@RequestMapping("/stats/groupRpaOper")
public class GroupRpaOperController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(GroupRpaOperController.class);
	
	@Resource(name="groupRpaOperService")
	private GroupRpaOperService groupRpaOperService;
	
	/**
	 * 임시 다운로드 경로
	 */
	@Value("${file.tmpdownload.path}")
	private String downloadPath;
			
	/**
	 * 그룹RPA운영실적 메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/groupRpaOperMain")
	public ModelAndView precessExecutStatusMain() throws Exception {
		return new ModelAndView("/stats/groupRpaOper/groupRpaOperMain");
	}
	
	/**
	 * 그룹RPA운영실적 로봇 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getRobotList")
	@ResponseBody
	public ResponseVO getRobotList(@RequestBody Map<String, Object> map) throws Exception {		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		// 해당 회사에 맞는 로봇 리스트 조회
		List<Map<String, Object>> robotList = groupRpaOperService.selectBotListForGroupRpaOper(map); 				
		returnMap.put("robotList", robotList);
				
		return new ResponseVO(returnMap);
	}
	
	/**
	 * 그룹RPA운영실적 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getGroupRpaOperList")
	@ResponseBody
	public ResponseVO getYearList(@RequestBody Map<String, Object> params) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();

		// 그룹RPA운영실적  리스트 조회
		List<Map<String, Object>> groupRpaOperList = groupRpaOperService.getGroupRpaOperList(params); 
		if(groupRpaOperList.isEmpty()) returnMap.put("groupRpaOperList", null);
		else returnMap.put("groupRpaOperList", groupRpaOperList);
		
		// (주간 실적) 그룹RPA운영실적  리스트 조회
		List<Map<String, Object>> groupRpaOperWeekList = groupRpaOperService.getGroupRpaOperWeekList(params); 
		if(groupRpaOperWeekList.isEmpty()) returnMap.put("groupRpaOperWeekList", null);
		else returnMap.put("groupRpaOperWeekList", groupRpaOperWeekList);
		
		return new ResponseVO(returnMap);
	}
	
	
	/**
	 * 위의 표 그룹RPA운영실적 엑셀 다운로드
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/outExportGroupRpaOperList")
	@ResponseBody
	public ResponseVO outExportJobMngList(@RequestBody Map<String, Object> params) throws Exception {
		
		boolean isAllCmpny = params.get("searchCmpnyCd").toString().equals("");
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();
        
        //{"회사", "실행 프로세스(건)", "실행 JOB(건)",  "조치 전 성공 JOB(건)", "조치 전 성공률(%)", "조치 전 실패 JOB(건)", "조치 전 실패율(%)", 
		// "조치 후 성공 JOB(건)", "조치 후 성공률(%)", "조치 후 실패 JOB(건)", "조치 후 실패율(%)"}
		
        List<String> columns = new ArrayList<String>();
        List<String> columnsStd = new ArrayList<String>();
        columns.add("회사");
        columns.add("실행 프로세스(건)");
        columns.add("실행 JOB(건)");
        
        columns.add("성공 JOB(건)");
        columns.add("성공률(%)");
        columns.add("실패 JOB(건)");
        columns.add("실패율(%)");
        
        columns.add("성공 JOB(건)");
        columns.add("성공률(%)");
        columns.add("실패 JOB(건)");
        columns.add("실패율(%)");

        //디바이스 리스트 조회
		resultList = groupRpaOperService.getGroupRpaOperList(params); 
              
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
		headerCellStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER); //높이 가운데 정렬
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
		cellStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0"));
		
		CellStyle cellStyleForRate = wb.createCellStyle();
		cellStyleForRate.setBorderRight(BorderStyle.THIN);
		cellStyleForRate.setBorderLeft(BorderStyle.THIN);
		cellStyleForRate.setBorderTop(BorderStyle.THIN);
		cellStyleForRate.setBorderBottom(BorderStyle.THIN);	
		cellStyleForRate.setDataFormat(wb.createDataFormat().getFormat("0.00"));
      
		Sheet sh = wb.createSheet("그룹RPA운영실적");
		Row twoRow = sh.createRow(1); // '회사' 셀 칸(병합 및 위치 조정)을 위한 Row
		Row threeRow = sh.createRow(2);
		
		// sheet.addMergedRegion(new CellRangeAddress(첫행, 마지막행, 첫열, 마지막열));
		
		// 한 칸 한 칸 씩 모두 setCellStyle을 적용해야 함.
		// 회사, 실행 프로세스(건), 실행 JOB(건) 엑셀 cell 칸 세팅
		for(int i=0; i<3; i++) {
			// '실행 JOB(건)' 셀칸 작성(병합)
			sh.addMergedRegion(new CellRangeAddress(1, 2, i, i));
			Cell tempCell = twoRow.createCell(i);
			tempCell.setCellValue(columns.get(i).toString()); // 실행 JOB(건)
			tempCell.setCellStyle(headerCellStyle);	

			threeRow.createCell(i).setCellStyle(headerCellStyle);
			
			sh.setColumnWidth(i, 15*256);
		}
		
		
		// 한 칸 한 칸 씩 모두 setCellStyle을 적용해야 함.
		// 조치 전, 조치 후  엑셀 cell 칸 세팅
		for(int i=0, j=0; i<2; i++, j+=4) {
			// '실행 JOB(건)' 셀칸 작성(병합)
			sh.addMergedRegion(new CellRangeAddress(1, 1, 3 + j, 6 + j)); // (1, 1) ~ (3 + j, 6 + j) 
			Cell tempCell = twoRow.createCell(3 + j);
			
			if(i==0) {
				tempCell.setCellValue("조치 전");
			}
			else {
				tempCell.setCellValue("조치 후");
			}
			
			tempCell.setCellStyle(headerCellStyle);	
	
			tempCell = twoRow.createCell(3 + j + 1);
			tempCell.setCellStyle(headerCellStyle);	
			
			tempCell = twoRow.createCell(3 + j + 2);
			tempCell.setCellStyle(headerCellStyle);	
			
			tempCell = twoRow.createCell(3 + j + 3);
			tempCell.setCellStyle(headerCellStyle);	
			
			sh.setColumnWidth(3 + j, 15*256);
		}

		int columnsSize = columns.size();
		for (int i = 3; i < columnsSize; i++) {
			Cell cell = threeRow.createCell(i);
			cell.setCellValue(columns.get(i));
			cell.setCellStyle(headerCellStyle);	
			sh.setColumnWidth(i, 13*256);
		}
		
		Cell bodyCell = null;
		Map<String, Object> map = null;
		
		int resultListSize = resultList.size();
		int rowNumber = 1;
		
		for (int i = 0; i < resultListSize; i++) {
			
			if(!isAllCmpny && i == 0) {
				continue;
			}

			map = resultList.get(i);
			
			int cellIdx = 0;
			Row row = sh.createRow((rowNumber++)+2);	

			// 회사
			String cmpnyNm = (String)map.get("cmpnyNm");	
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(cmpnyNm);
			bodyCell.setCellStyle(cellStyle);
			
			// 실행 프로세스(건)
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((Integer)map.get("processCount"));
			bodyCell.setCellStyle(cellStyle);
			
			// 실행 JOB(건)
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((Integer)map.get("jobTotalCount"));
			bodyCell.setCellStyle(cellStyle);
			
			// 조치 전 성공 JOB(건)
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((Integer)map.get("jobSuccessCountBefore"));
			bodyCell.setCellStyle(cellStyle);
						
			// 조치 전 성공률(%)
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(Double.parseDouble(String.valueOf(map.get("successRateBefore"))));
			bodyCell.setCellStyle(cellStyleForRate);
						
			// 조치 전 실패 JOB(건)
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((Integer)map.get("jobFailCountBefore"));
			bodyCell.setCellStyle(cellStyle);
						
			// 조치 전 실패율(%)
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(Double.parseDouble(String.valueOf(map.get("failRateBefore"))));
			bodyCell.setCellStyle(cellStyleForRate);
			
			// 조치 후 성공 JOB(건)
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((Integer)map.get("jobSuccessCount"));
			bodyCell.setCellStyle(cellStyle);
			
			// 조치 후 성공률(%)
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(Double.parseDouble(String.valueOf(map.get("successRate"))));
			bodyCell.setCellStyle(cellStyleForRate);
			
			// 조치 후 실패 JOB(건)
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((Integer)map.get("jobFailCount"));
			bodyCell.setCellStyle(cellStyle);
			
			// 조치 후 실패율(%)
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(Double.parseDouble(String.valueOf(map.get("failRate"))));
			bodyCell.setCellStyle(cellStyleForRate);
		}
		
		wb.write(os);
		os.close();

		((SXSSFWorkbook) wb).dispose();
		wb.close();
		
		returnMap.put("fileNo", fileNo);
		return new ResponseVO(returnMap);
	}
	
	
	
	
	
	
	
	/**
	 * 아래 표 그룹RPA운영실적 엑셀 다운로드
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/outExportGroupRpaOperWeekList")
	@ResponseBody
	public ResponseVO outExportGroupRpaOperWeekList(@RequestBody Map<String, Object> params) throws Exception {
				
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();

        List<String> columns = new ArrayList<String>();
        List<String> columnsStd = new ArrayList<String>();
        
        columns.add("회사");
        
        columns.add("성공률(%)");
        columns.add("실행 JOB(건)");
        columns.add("성공 JOB(건)");
        
        columns.add("성공률(%)");
        columns.add("실행 JOB(건)");
        columns.add("성공 JOB(건)");
        
        columns.add("성공률(%)");
        columns.add("실행 JOB(건)");
        columns.add("성공 JOB(건)");
        
        columns.add("성공률(%)");
        columns.add("실행 JOB(건)");
        columns.add("성공 JOB(건)");
        
        // 연도별 텍스트 배열을 params에서 얻어오기
        List<String> dateText = new ArrayList<String>();
        dateText = (List<String>)params.get("dateTextArray");

        //디바이스 리스트 조회
		resultList = groupRpaOperService.getGroupRpaOperWeekList(params);
		     
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
		headerCellStyle.setAlignment(CellStyle.ALIGN_CENTER); // 가운데 정렬
		headerCellStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER); //높이 가운데 정렬
		
		Font toBold = wb.createFont();
		toBold.setBold(true);
		headerCellStyle.setFont(toBold);
		
		CellStyle cellStyle = wb.createCellStyle();
		cellStyle.setBorderRight(BorderStyle.THIN);
		cellStyle.setBorderLeft(BorderStyle.THIN);
		cellStyle.setBorderTop(BorderStyle.THIN);
		cellStyle.setBorderBottom(BorderStyle.THIN);
		cellStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0"));
		
		CellStyle cellStyleForRate = wb.createCellStyle();
		cellStyleForRate.setBorderRight(BorderStyle.THIN);
		cellStyleForRate.setBorderLeft(BorderStyle.THIN);
		cellStyleForRate.setBorderTop(BorderStyle.THIN);
		cellStyleForRate.setBorderBottom(BorderStyle.THIN);	
		cellStyleForRate.setDataFormat(wb.createDataFormat().getFormat("0.00"));
		
		Sheet sh = wb.createSheet("성공률추이");
		
		Row twoRow = sh.createRow(1); // '회사' 셀 칸(병합 및 위치 조정)을 위한 Row
		Row threeRow = sh.createRow(2);
		
		// '회사' 셀칸 작성(병합)
		sh.addMergedRegion(new CellRangeAddress(1, 2, 0, 0));
		Cell tempCell = twoRow.createCell(0);
		tempCell.setCellValue(columns.get(0));
		tempCell.setCellStyle(headerCellStyle);	
		sh.setColumnWidth(0, 13*256);
		
		// 연도 TEXT 4개(병합)
		int dateTextSize = dateText.size();
		for(int i=0, j=0; i<dateTextSize; i++, j+=3) {
			sh.addMergedRegion(new CellRangeAddress(1, 1, j+1, j+3));

			// 연도 기간 표시 텍스트의 셀은 총 3칸 이므로, 각 셀 한 칸 씩에 스타일을 부여해야 한다.
			tempCell = twoRow.createCell(j + 1);
			tempCell.setCellValue(dateText.get(i));
			tempCell.setCellStyle(headerCellStyle);
			
			tempCell = twoRow.createCell(j + 2);
			tempCell.setCellStyle(headerCellStyle);
			
			tempCell = twoRow.createCell(j + 3);
			tempCell.setCellStyle(headerCellStyle);
			
			sh.setColumnWidth(j + 1, 13*256);
		}
		
		// 나머지 회사 이름과 실행 JOB건 등
		int columnsSize = columns.size();
		for (int i = 1; i < columnsSize; i++) {
			Cell cell = threeRow.createCell(i);
			cell.setCellValue(columns.get(i));
			cell.setCellStyle(headerCellStyle);		
			sh.setColumnWidth(i, 13*256);
		}
		
		Cell bodyCell = null;
		Map<String, Object> map = null;
		
		int resultListSize = resultList.size();
		int rowNumber = 1;
		
		for (int i = 0; i < resultListSize; i++) {		
			map = resultList.get(i);
			
			int cellIdx = 0;
			Row row = sh.createRow((rowNumber++)+2);			
			
			// 회사
			String cmpnyNm = (String)map.get("cmpnyNm");	
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(cmpnyNm);
			bodyCell.setCellStyle(cellStyle);
					
			// D 성공률(%)
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(Double.parseDouble(String.valueOf(map.get("DSuccessRate"))));
			bodyCell.setCellStyle(cellStyle);
						
			// D 실행 JOB(건)
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((Integer)map.get("DJobTotalCount"));
			bodyCell.setCellStyle(cellStyle);
						
			// D 성공 JOB(건)
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((Integer)map.get("DJobSuccessCount"));
			bodyCell.setCellStyle(cellStyle);
			
			// C 성공률(%)
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(Double.parseDouble(String.valueOf(map.get("CSuccessRate"))));
			bodyCell.setCellStyle(cellStyle);
						
			// C 실행 JOB(건)
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((Integer)map.get("CJobTotalCount"));
			bodyCell.setCellStyle(cellStyle);
						
			// C 성공 JOB(건)
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((Integer)map.get("CJobSuccessCount"));
			bodyCell.setCellStyle(cellStyle);
			
			// B 성공률(%)
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(Double.parseDouble(String.valueOf(map.get("BSuccessRate"))));
			bodyCell.setCellStyle(cellStyle);
									
			// B 실행 JOB(건)
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((Integer)map.get("BJobTotalCount"));
			bodyCell.setCellStyle(cellStyle);
									
			// B 성공 JOB(건)
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((Integer)map.get("BJobSuccessCount"));
			bodyCell.setCellStyle(cellStyle);
			
			// A 성공률(%)
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(Double.parseDouble(String.valueOf(map.get("ASuccessRate"))));
			bodyCell.setCellStyle(cellStyle);
			
			// A 실행 JOB(건)
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((Integer)map.get("AJobTotalCount"));
			bodyCell.setCellStyle(cellStyle);
			
			// A 성공 JOB(건)
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((Integer)map.get("AJobSuccessCount"));
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
