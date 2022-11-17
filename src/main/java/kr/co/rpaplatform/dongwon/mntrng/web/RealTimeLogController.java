package kr.co.rpaplatform.dongwon.mntrng.web;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
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
import kr.co.rpaplatform.dongwon.mntrng.service.RealTimeLogService;

/**
 * 작업 컨트롤러
 * @author LSH
 *
 */
@Controller
@RequestMapping("/mntrng/realtimelog")
public class RealTimeLogController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(RealTimeLogController.class);
	
	@Resource(name="portalCommonService")
	private PortalCommonService portalCommonService;
	
	/**
	 * 실시간 로그 메인 화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/realTimeLogMain")
	public ModelAndView realTimeLogMain(HttpServletRequest req) throws Exception {
		ModelAndView mav = new ModelAndView("/mntrng/realtimelog/realTimeLogMain");
		mav.addObject("tokenRealTimeNow", "Y");
		mav.addObject("paramJobKey", req.getParameter("jobKey"));
		return mav;
	}
	
	/**
	 * 실시간 로그 팝업창
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/realTimeLogDetailPop")
	public ModelAndView realTimeLogDetailPop() throws Exception {
		return new ModelAndView("/mntrng/realtimelog/realTimeLogDetailPop");
	}
	
	/**
	 * Bot 동작현황 서비스
	 */
	@Resource(name="botMntrngService")
	private BotMntrngService botMntrngService;
	
	/**
	 * Bot 동작현황 서비스
	 */
	@Resource(name="realTimeLogService")
	private RealTimeLogService realTimeLogService;
	
	/**
	 * 임시 다운로드 경로
	 */
	@Value("${file.tmpdownload.path}")
	private String downloadPath;
	
	/**
	 * 실시간 로그 리스트 가져오기
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getRealTimeLogList")
	@ResponseBody
	public ResponseVO getRealTimeLogList(@RequestBody Map<String, Object> map) throws Exception { 
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		if(!MDC.get("txCmpnyCd").equals("") && MDC.get("txCmpnyCd") != null) {
			map.put("cmpnycd", (String)MDC.get("txCmpnyCd"));
		}	
				
		// 리스트 카운트 조회
		int totalRecordCount = realTimeLogService.selectRealTimeLogCount(map);
		
		if(totalRecordCount > 10000) {
			totalRecordCount = 10000;
		}
		
		// 해당 회사에 맞는 로봇 리스트 조회
		List<Map<String, Object>> robotList = botMntrngService.selectBotList(map); 				
		returnMap.put("robotList", robotList);

		if (totalRecordCount > 0) {
			
			//페이징 정보 조회
			PaginationInfo paginationInfo = PaginationUtil.getPaginationInfo(map, totalRecordCount);
			
			int currentPageNo = Integer.parseInt((String.valueOf(map.get("currentPageNo"))));
			int recordCountPerPage = Integer.parseInt((String.valueOf(map.get("recordCountPerPage"))));
			int showCanCountPerPage = 0;
			
			if((currentPageNo * recordCountPerPage) > totalRecordCount) {
				showCanCountPerPage = totalRecordCount % recordCountPerPage;
				map.put("recordCountPerPage", showCanCountPerPage);
			}
		
			//조회조건에 페이징 정보 설정
			map.put("paginationInfo", PaginationUtil.getPaginationInfo(map, totalRecordCount));

			//디바이스 리스트 조회
			List<Map<String, Object>> resultList = realTimeLogService.selectRealTimeLogList(map); 
	
			//결과 설정
			returnMap.put("resultList", resultList);
			returnMap.put("paginationInfo", paginationInfo);		
		} 
		else 
		{	
			//결과 설정
			returnMap.put("resultList", null);
			returnMap.put("paginationInfo", PaginationUtil.getPaginationInfo(map, 0));			
		}
		
		return new ResponseVO(returnMap);
	}
	
	
	/**
	 * realTimeLog 엑셀 다운로드
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/outExportRealTimeLog")
	@ResponseBody
	public ResponseVO outExportRealTimeLog(@RequestBody Map<String, Object> params) throws Exception {

		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();
		
		if(!MDC.get("txCmpnyCd").equals("") && MDC.get("txCmpnyCd") != null) {
			params.put("cmpnycd", (String)MDC.get("txCmpnyCd"));
		}	
		
		/*int totalRecordCount = realTimeLogService.selectRealTimeLogCount(params);

        if(totalRecordCount > 10000) {
        	returnMap.put("isDownload", false);
    		return new ResponseVO(returnMap);     	
        }*/
		
        //{"로봇명", "프로세스명", "발생시간", "LEVEL", "Message"}
        List<String> columns = new ArrayList<String>();
        List<String> columnsStd = new ArrayList<String>();
        columns.add("로봇명");
        columns.add("프로세스명");
        columns.add("발생시간");
        columns.add("LEVEL");
        columns.add("Message");

        //디바이스 리스트 조회
		resultList = realTimeLogService.selectRealTimeLogList(params); 
   
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
        
		Sheet sh = wb.createSheet("실시간 로그");
		
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
			
			// 로봇명
			String compNm = (String)map.get("robotname");
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(compNm);
			bodyCell.setCellStyle(cellStyle);
					
			// 프로세스명 
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)map.get("processNm"));
			bodyCell.setCellStyle(cellStyle);
			
			// 발생시간
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)map.get("occrrncDt"));
			bodyCell.setCellStyle(cellStyle);
			
			// LEVEL
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)map.get("levelNm"));
			bodyCell.setCellStyle(cellStyle);
			
			// Message
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)map.get("message"));
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