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
import kr.co.rpaplatform.dongwon.mntrng.service.JobErrorService;

/**
 * 작업 컨트롤러
 * @author LSH
 *
 */
@Controller
@RequestMapping("/mntrng/joberror")
public class JobErrorController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(JobErrorController.class);
	
	@Resource(name="portalCommonService")
	private PortalCommonService portalCommonService;
	
	/**
	 * 작업 서비스
	 */
	@Resource(name="jobErrorService")
	private JobErrorService jobErrorService;
	
	
	/**
	 * 작업모니터링 메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/jobErrorMain")
	public ModelAndView jobMntrngMngMain() throws Exception {
		return new ModelAndView("/mntrng/joberror/jobErrorMain");
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
		List<Map<String, Object>> robotList = jobErrorService.selectBotList(map); 				
		returnMap.put("robotList", robotList);
				
		return new ResponseVO(returnMap);
	}
	
	/**
	 * 작업 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getJobErrorList")
	@ResponseBody
	public ResponseVO getJobErrorList(@RequestBody Map<String, Object> map) throws Exception {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		// 리스트 카운트 조회
		int totalRecordCount = jobErrorService.getJobErrorCount(map);
		
		
		if (totalRecordCount > 0) {
			
			//페이징 정보 조회
			PaginationInfo paginationInfo = PaginationUtil.getPaginationInfo(map, totalRecordCount);
			
			//조회조건에 페이징 정보 설정
			map.put("paginationInfo", PaginationUtil.getPaginationInfo(map, totalRecordCount));
			
			//디바이스 리스트 조회
			List<Map<String, Object>> resultList = jobErrorService.selectJobErrorList(map); 
	
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
	 * joberror 엑셀 다운로드
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/outExportJobErrorList")
	@ResponseBody
	public ResponseVO outExportJobErrorList(@RequestBody Map<String, Object> params) throws Exception {

		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();
        
        //{"회사", "로봇", "발생일시", "프로세스코드", "프로세스명", "State", "실행구분", "오류내용", "조치상태"}
        List<String> columns = new ArrayList<String>();
        List<String> columnsStd = new ArrayList<String>();
        columns.add("회사");
        columns.add("로봇");
        columns.add("발생일시");
        columns.add("프로세스코드");
        columns.add("프로세스명");
        columns.add("State");
        columns.add("실행구분");
        columns.add("오류내용");
        columns.add("조치상태");
        columns.add("개발귀속일");
        
        //디바이스 리스트 조회
		resultList = jobErrorService.selectJobErrorList(params); 
        
        
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
        
		Sheet sh = wb.createSheet("JOB오류관리");
		
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
			String compNm = (String)map.get("cmpnyNm");
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(compNm);
			bodyCell.setCellStyle(cellStyle);
			
			//로봇
			String robotName = (String)map.get("robotName");
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(robotName);
			bodyCell.setCellStyle(cellStyle);
			
			// 발생일시 
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)map.get("occrrncDt"));
			bodyCell.setCellStyle(cellStyle);
			
			//프로세스코드
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)map.get("processCd"));
			bodyCell.setCellStyle(cellStyle);
			
			//프로세스명
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)map.get("processNm"));
			bodyCell.setCellStyle(cellStyle);
			
			//State
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)map.get("stateNm"));
			bodyCell.setCellStyle(cellStyle);
			
			//실행구분
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)map.get("sourceNm"));
			bodyCell.setCellStyle(cellStyle);
			
			//오류내용
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)map.get("info"));
			bodyCell.setCellStyle(cellStyle);
			
			//조치상태
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)map.get("sttusNm"));
			bodyCell.setCellStyle(cellStyle);
			
			//개발귀속일
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)map.get("belongingDe"));
			bodyCell.setCellStyle(cellStyle);
		}
		
		wb.write(os);
		os.close();

		((SXSSFWorkbook) wb).dispose();
		wb.close();
		
		returnMap.put("fileNo", fileNo);
		return new ResponseVO(returnMap);
	}
	
	
	
	
	
	
	/**
	 * 작업 상세 화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/jobErrorDetailPop")
	public ModelAndView jobErrorDetailPop() throws Exception {
		return new ModelAndView("/mntrng/joberror/jobErrorDetailPop");
	}
	
	/**
	 * 작업 상세 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getJobErrorDetail")
	@ResponseBody
	public ResponseVO getJobErrorDetail(@RequestBody Map<String, Object> map) throws Exception {
		Map<String, Object> resultMap = jobErrorService.getJobErrorDetail(map);
		return new ResponseVO(resultMap);
	}
	
	
	/**
	 * 조치 내역 저장 
	 * @param map
	 * @return 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateDetailData")
	@ResponseBody
	public ResponseVO updateDetailData(HttpServletRequest req, @RequestBody Map<String, Object> map) throws Exception {
		AuthorVO oAuthorVO = portalCommonService.getScreenAuthor(req);
		//쓰기/수정 권한자 인지 확인
		if(!oAuthorVO.getWrtngAuthor().equals("Y")) {
			return new ResponseVO("E202", "비정상 접근입니다.");
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		jobErrorService.updateJobError(map);
		return new ResponseVO(resultMap);
	}
	
	
	
	
	
	
	
	
	

}
