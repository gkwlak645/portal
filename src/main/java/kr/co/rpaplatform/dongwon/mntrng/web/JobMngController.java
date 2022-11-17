package kr.co.rpaplatform.dongwon.mntrng.web;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow; //열
import org.apache.poi.hssf.usermodel.HSSFSheet;  //시트
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.rpaplatform.common.pagination.PaginationInfo;
import kr.co.rpaplatform.common.vo.ResponseVO;
import kr.co.rpaplatform.dongwon.author.vo.AuthorVO;
import kr.co.rpaplatform.dongwon.common.service.PortalCommonService;
import kr.co.rpaplatform.dongwon.common.util.PaginationUtil;
import kr.co.rpaplatform.dongwon.mntrng.service.JobErrorService;
import kr.co.rpaplatform.dongwon.mntrng.service.JobMngService;

/**
 * 작업 컨트롤러
 * @author LSH
 *
 */
@Controller
@RequestMapping("/mntrng/jobmng")
public class JobMngController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(JobMngController.class);
	
	@Resource(name="portalCommonService")
	private PortalCommonService portalCommonService;
	
	/**
	 * 작업 서비스
	 */
	@Resource(name="jobMngService")
	private JobMngService jobMngService;
	
	
	/**
	 * JOB이력관리 메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/jobMngMain")
	public ModelAndView jobMntrngMngMain() throws Exception {
		return new ModelAndView("/mntrng/jobmng/jobMngMain");
	}
	
	/**
	 * 임시 다운로드 경로
	 */
	@Value("${file.tmpdownload.path}")
	private String downloadPath;
	
	/**
	 * 작업 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getRobotList")
	@ResponseBody
	public ResponseVO getArRobotList(@RequestBody Map<String, Object> map) throws Exception {		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		// 해당 회사에 맞는 로봇 리스트 조회
		List<Map<String, Object>> robotList = jobMngService.selectBotList(map); 				
		returnMap.put("robotList", robotList);
				
		return new ResponseVO(returnMap);
	}
	
	/**
	 * 작업 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getJobMngList")
	@ResponseBody
	public ResponseVO getJobErrorList(@RequestBody Map<String, Object> map) throws Exception {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		// 리스트 카운트 조회
		int totalRecordCount = jobMngService.getJobMngCount(map);
		
		if (totalRecordCount > 0) {
			
			//페이징 정보 조회
			PaginationInfo paginationInfo = PaginationUtil.getPaginationInfo(map, totalRecordCount);
			
			//조회조건에 페이징 정보 설정
			map.put("paginationInfo", paginationInfo);

			//디바이스 리스트 조회
			List<Map<String, Object>> resultList = jobMngService.selectJobMngList(map); 
	
			//결과값 설정
			returnMap.put("resultList", resultList);
			returnMap.put("paginationInfo", paginationInfo);
			
		} else {
			
			//결과값 설정
			returnMap.put("resultList", null);
			returnMap.put("paginationInfo", PaginationUtil.getPaginationInfo(map, 0));
			
		}
		
		return new ResponseVO(returnMap);
	}
	
	/**
	 * JOB이력관리  상세 화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/jobMngDetailPop")
	public ModelAndView jobErrorDetailPop() throws Exception {
		return new ModelAndView("/mntrng/jobmng/jobMngDetailPop");
	}
	
	/**
	 * JOB이력관리 사유 등록 및 수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateJobMngResn")
	@ResponseBody
	public ResponseVO updateJobMngResn(@RequestBody Map<String, Object> map) throws Exception {		
		// 반환 Map
		Map<String, Object> returnMap = new HashMap<String, Object>();		
		jobMngService.updateJobMngResn(map);
		
		return new ResponseVO(returnMap);
	}
	
	/**
	 * jobmng 엑셀 다운로드
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/outExportJobMngList")
	@ResponseBody
	public ResponseVO outExportJobMngList(@RequestBody Map<String, Object> params) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();

		// 리스트 카운트 조회
		int totalRowCount = jobMngService.getJobMngCount(params);
		
		if(totalRowCount > 10000) {
			returnMap.put("totalCount", totalRowCount);
			return new ResponseVO(returnMap);
		}
		
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();
        
        //{"회사", "로봇", "JOB ID", "프로세스코드", "프로세스명", "시작 시간", "종료 시간", "JOB 상태", "사유"}
        List<String> columns = new ArrayList<String>();
        List<String> columnsStd = new ArrayList<String>();
        columns.add("회사");
        columns.add("로봇");
        columns.add("JOB ID");
        columns.add("프로세스코드");
        columns.add("프로세스명");
        columns.add("시작 시간");
        columns.add("종료 시간");
        columns.add("JOB 상태");
        columns.add("사유");
        
        //디바이스 리스트 조회
		resultList = jobMngService.selectJobMngList(params); 
              
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
        
		Sheet sh = wb.createSheet("JOB이력관리");
		
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
			String compNm = (String)map.get("cmpnyNm");
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(compNm);
			bodyCell.setCellStyle(cellStyle);
			
			// 로봇
			String robotName = (String)map.get("robotNm");
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(robotName);
			bodyCell.setCellStyle(cellStyle);
			
			// JOB ID 
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(map.get("jobId").toString());
			bodyCell.setCellStyle(cellStyle);
			
			// 프로세스코드
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)map.get("processCd"));
			bodyCell.setCellStyle(cellStyle);
			
			// 프로세스명
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)map.get("processNm"));
			bodyCell.setCellStyle(cellStyle);
			
			// 시작 시간
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)map.get("startTimeAdd"));
			bodyCell.setCellStyle(cellStyle);
			
			// 종료 시간
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)map.get("endTimeAdd"));
			bodyCell.setCellStyle(cellStyle);
			
			// JOB 상태
			bodyCell = row.createCell(cellIdx++);
			int getSuccessAt = Integer.parseInt(map.get("successAt").toString());
			if(getSuccessAt == 0) {
				bodyCell.setCellValue("실패");
			}
			else {
				bodyCell.setCellValue("성공");
			}			
			// bodyCell.setCellValue((String)map.get("successAtNm"));
			bodyCell.setCellStyle(cellStyle);
			
			// 사유
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)map.get("resnNm"));
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