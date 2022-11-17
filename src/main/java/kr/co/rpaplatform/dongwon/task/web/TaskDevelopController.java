package kr.co.rpaplatform.dongwon.task.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.MDC;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.ModelAndView;

import kr.co.rpaplatform.common.exception.RpaException;
import kr.co.rpaplatform.common.pagination.PaginationInfo;
import kr.co.rpaplatform.dongwon.author.service.AuthorService;
import kr.co.rpaplatform.dongwon.author.vo.AuthorVO;
import kr.co.rpaplatform.dongwon.common.service.PortalCommonService;
import kr.co.rpaplatform.dongwon.common.util.PaginationUtil;
import kr.co.rpaplatform.dongwon.common.vo.CmmnUserVO;
import kr.co.rpaplatform.dongwon.orgnzt.service.UserService;
import kr.co.rpaplatform.common.vo.ResponseVO;
import kr.co.rpaplatform.dongwon.task.service.TaskDevelopService;
import kr.co.rpaplatform.dongwon.task.service.TaskIdeaService;
import kr.co.rpaplatform.dongwon.task.service.TaskPaymentService;

/**
 * @author LSH
 */
@Controller
@RequestMapping("/task/develop")
public class TaskDevelopController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(TaskDevelopController.class);
	
	
	@Resource(name="userService")
	private UserService userService;
	
	@Resource(name="portalCommonService")
	private PortalCommonService portalCommonService;
	
	@Resource(name="taskDevelopService")
	private TaskDevelopService taskDevelopService;
	
	/**
	 * 과제운영 서비스
	 */
	@Resource(name="taskPaymentService")
	private TaskPaymentService taskPaymentService;
	
	/**
	 * 임시 다운로드 경로
	 */
	@Value("${file.tmpdownload.path}")
	private String downloadPath;
	
	/**
	 * 과제개발 메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/taskDevelopMain")
	public ModelAndView taskDevelopMain() throws Exception {
		return new ModelAndView("/task/develop/taskDevelopMain");
	}
	
	/**
	 * 과제아이디어등록 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectTaskDevelopList")
	@ResponseBody
	public ResponseVO selectTaskDevelopList(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		logger.debug("TaskDevelopController.selectTaskDevelopList start!!");
		AuthorVO oAuthorVO = portalCommonService.getScreenAuthor(req);
		//읽기 권한이 있는지 확인
		if(!oAuthorVO.getRedngAuthor().equals("Y")) {
			return new ResponseVO("E202", "비정상 접근입니다.");
		}
		else if(!oAuthorVO.getUntenantAuthor().equals("Y") && ((String)params.get("searchCmpnyCd")).equals("")) {
			return new ResponseVO("E202", "비정상 접근입니다.");
		}
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		//과제개발 > 메인: 리스트 카운트 조회
		int totalRecordCount = taskDevelopService.selectTaskDevelopListCount(params);
		
		//페이징 정보 조회
		PaginationInfo paginationInfo = PaginationUtil.getPaginationInfo(params, totalRecordCount);
		
		//조회조건에 페이징 정보 설정
		params.put("paginationInfo", PaginationUtil.getPaginationInfo(params, totalRecordCount));

		//과제개발 > 메인: 리스트  조회
		List<Map<String, Object>> resultList = taskDevelopService.selectTaskDevelopList(params);

		//결과값 설정
		returnMap.put("resultList", resultList);
		returnMap.put("paginationInfo", paginationInfo);
		logger.debug("TaskDevelopController.selectTaskDevelopList end!!");
		return new ResponseVO(returnMap);
	}
	
	
	/**
	 * 프로세스 개발 엑셀 다운로드
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/outExportTaskDevelopList")
	@ResponseBody
	public ResponseVO outExportTaskDevelopList(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		logger.debug("TaskDevelopController.outExportTaskDevelopList start!!");
		
		AuthorVO oAuthorVO = portalCommonService.getScreenAuthor(req);
		//읽기 권한이 있는지 확인
		if(!oAuthorVO.getRedngAuthor().equals("Y")) {
			return new ResponseVO("E202", "비정상 접근입니다.");
		}
		else if(!oAuthorVO.getUntenantAuthor().equals("Y") && ((String)params.get("searchCmpnyCd")).equals("")) {
			return new ResponseVO("E202", "비정상 접근입니다.");
		}
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
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

		Sheet processSh 	= wb.createSheet("프로세스개발");
		Sheet chargerSh  	= wb.createSheet("담당자 정보");
		Sheet redcnTmSh  	= wb.createSheet("개인별 절감시간");
		Sheet contributeSh  = wb.createSheet("개인별 기여도");
		Sheet cntcSysSh  	= wb.createSheet("연관시스템");
		
		//과제상세
		String[] processColumns    = new String[] {"순번", "과제코드", "과제명", "과제설명", "회사", "업무분류", "업무담당부서", "업무담당자", "업무시간(연간)", "빈도", "제목", "프로세스코드"
													, "프로세스명", "BOT" ,"업무설명" ,"회사" ,"업무시간" ,"예상절감시간①" ,"예상절감금액(① X 33,000원)" ,"실행주기" ,"실행시간" ,"개발공수②"   
													,"예상개발비용(② X 8.5Hr X 33,000원)" ,"긴급대응" ,"RTO" ,"ROI평가(② X 10 ≤ ①)" ,"개발사유" ,"내부개발여부" ,"프로세스상태", "개발귀속일"};
		//담당자
		String[] chargerColumns    = new String[] {"순번", "과제코드", "과제명",  "프로세스코드", "프로세스명", "부서", "성명"};
		//개인별 절감시간
		String[] redcnTmColumns    = new String[] {"순번", "과제코드", "과제명",  "프로세스코드", "프로세스명", "부서", "성명", "절감시간(hour)"};
		//개인별 기여도
		String[] contributeColumns = new String[] {"순번", "과제코드", "과제명",  "프로세스코드", "프로세스명", "부서", "성명", "기여도(%)"};
		//연관시스템
		String[] cntcSysColumns    = new String[] {"순번", "과제코드", "과제명",  "프로세스코드", "프로세스명", "분류", "회사", "시스템코드", "시스템명"};
		
		Row hd = processSh.createRow(1);
		for (int i = 0; i < processColumns.length; i++) {
			Cell cell = hd.createCell(i);
			cell.setCellValue(processColumns[i]);
			cell.setCellStyle(cellStyle);
			processSh.setColumnWidth(i, 13*256);
		}
		
		hd = chargerSh.createRow(1);
		for (int i = 0; i < chargerColumns.length; i++) {
			Cell cell = hd.createCell(i);
			cell.setCellValue(chargerColumns[i]);
			cell.setCellStyle(cellStyle);
			chargerSh.setColumnWidth(i, 13*256);
		}
		
		hd = redcnTmSh.createRow(1);
		for (int i = 0; i < redcnTmColumns.length; i++) {
			Cell cell = hd.createCell(i);
			cell.setCellValue(redcnTmColumns[i]);
			cell.setCellStyle(cellStyle);
			redcnTmSh.setColumnWidth(i, 13*256);
		}
		
		hd = contributeSh.createRow(1);
		for (int i = 0; i < contributeColumns.length; i++) {
			Cell cell = hd.createCell(i);
			cell.setCellValue(contributeColumns[i]);
			cell.setCellStyle(cellStyle);
			contributeSh.setColumnWidth(i, 13*256);
		}
		
		hd = cntcSysSh.createRow(1);
		for (int i = 0; i < cntcSysColumns.length; i++) {
			Cell cell = hd.createCell(i);
			cell.setCellValue(cntcSysColumns[i]);
			cell.setCellStyle(cellStyle);
			cntcSysSh.setColumnWidth(i, 13*256);
		}
		
		int taskCellIdx = 2;
		int chargerCellIdx = 2;
		int redcnTmCellIdx = 2;
		int contributeCellIdx = 2;
		int cntcSysCellIdx = 2;
		
		Cell bodyCell = null;
		
		//과제개발 > 메인: 리스트  조회
		List<Map<String, Object>> resultList = taskDevelopService.selectTaskDevelopList(params);
		
		Map<String, Object> map = null;
		
		int resultListSize = resultList.size();
		
		for (int i = 0; i < resultListSize; i++) {
			
			map = resultList.get(i);
			
			if(map.get("processCd") != null && !"".equals(map.get("processCd"))) {
				
			//프로세스개발 
			int cellIdx = 0;
			Row row = processSh.createRow(taskCellIdx);	
				
			Map<String, Object> taskDetailData = taskDevelopService.getTaskDevelopProcessDetail2(map);
			Map<String, Object> taskDetailMap = null;
			
			//프로세스개발
			//과제정보----------------------------------------------------------------------------------
			//순번
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(taskCellIdx-1);
			bodyCell.setCellStyle(cellStyle);
			//과제코드
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)taskDetailData.get("taskCd"));
			bodyCell.setCellStyle(cellStyle);
			//과제명
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)taskDetailData.get("taskNm"));
			bodyCell.setCellStyle(cellStyle);
			//과제설명
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)taskDetailData.get("taskDc"));
			bodyCell.setCellStyle(cellStyle);
			//회사명
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)taskDetailData.get("cmpnyNm"));
			bodyCell.setCellStyle(cellStyle);
			//업무분류
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)taskDetailData.get("clsNm"));
			bodyCell.setCellStyle(cellStyle);
			//업무담당부서
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)taskDetailData.get("jobChrgDeptNm"));
			bodyCell.setCellStyle(cellStyle);
			//업무담당자
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)taskDetailData.get("jobChargerNm"));
			bodyCell.setCellStyle(cellStyle);
			//업무시간(연간)
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(String.valueOf(taskDetailData.get("jobTm")));
			bodyCell.setCellStyle(cellStyle);
			//빈도
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(String.valueOf(taskDetailData.get("fqNm")) +" "+ String.valueOf(taskDetailData.get("executCnt")) + "회");
			bodyCell.setCellStyle(cellStyle);
			//프로세스정보----------------------------------------------------------------------------------
			//제목
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)taskDetailData.get("sj"));
			bodyCell.setCellStyle(cellStyle);
			//프로세스코드
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)taskDetailData.get("processCd"));
			bodyCell.setCellStyle(cellStyle);
			//프로세스명
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)taskDetailData.get("processNm"));
			bodyCell.setCellStyle(cellStyle);
			//개발봇 or 운영봇
			String bot = !taskDetailData.containsKey("BOT_SE") ? "NULL" : (String)taskDetailData.get("BOT_SE");
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(bot);
			bodyCell.setCellStyle(cellStyle);
			//업무설명
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)taskDetailData.get("jobDc"));
			bodyCell.setCellStyle(cellStyle);
			//회사
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)taskDetailData.get("cmpnyNmReg"));
			bodyCell.setCellStyle(cellStyle);
			//업무시간
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(String.valueOf(taskDetailData.get("processJobTm")));
			bodyCell.setCellStyle(cellStyle);
			//예상절감시간①
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(String.valueOf(taskDetailData.get("redcnTm")));
			bodyCell.setCellStyle(cellStyle);
			//예상절감금액(① X 33,000원)
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(String.valueOf(taskDetailData.get("expectRedcnAmt")));
			bodyCell.setCellStyle(cellStyle);
			//실행주기
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(String.valueOf(taskDetailData.get("fqNmReg")) +" "+ String.valueOf(taskDetailData.get("executCntReg")) + "회");
			bodyCell.setCellStyle(cellStyle);
			//실행시간
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(String.valueOf(taskDetailData.get("executTm")));
			bodyCell.setCellStyle(cellStyle);
			//개발공수②
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(String.valueOf(taskDetailData.get("devlopWdcnt")));
			bodyCell.setCellStyle(cellStyle);
			//예상개발비용(② X 8.5Hr X 33,000원)
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(String.valueOf(taskDetailData.get("expectDevlopCt")));
			bodyCell.setCellStyle(cellStyle);
			//긴급대응
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)taskDetailData.get("emrgncyCrspnd"));
			bodyCell.setCellStyle(cellStyle);
			//RTO
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(String.valueOf(taskDetailData.get("rto")));
			bodyCell.setCellStyle(cellStyle);
			//ROI평가(② X 10 ≤ ①)
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)taskDetailData.get("roiEvaluate"));
			bodyCell.setCellStyle(cellStyle);
			//개발사유
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)taskDetailData.get("devlopResn"));
			bodyCell.setCellStyle(cellStyle);
			//내부개발여부
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)taskDetailData.get("insideDevlopAtNm"));
			bodyCell.setCellStyle(cellStyle);
			//프로세스상태
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)map.get("processSttusNm"));
			bodyCell.setCellStyle(cellStyle);
			
			// 개발 귀속일 
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)map.get("belongingDe"));
			bodyCell.setCellStyle(cellStyle);
			
			taskCellIdx++;	
				
			//담당자
			List<Map<String, Object>> chargerList = (List<Map<String, Object>>) taskDetailData.get("chargerList");
			int chargerListSize = chargerList.size();
				
				if(chargerList != null && chargerListSize > 0) {
					taskDetailMap = null;
					for (int j = 0; j < chargerListSize; j++) {
						int Idx = 0;
						taskDetailMap = chargerList.get(j);
						Row chargerRow = chargerSh.createRow(chargerCellIdx);
						
						//순번
						bodyCell = chargerRow.createCell(Idx++);
						bodyCell.setCellValue(chargerCellIdx-1);
						bodyCell.setCellStyle(cellStyle);
						
						//과제코드
						bodyCell = chargerRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailData.get("taskCd"));
						bodyCell.setCellStyle(cellStyle);
						//과제명
						bodyCell = chargerRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailData.get("taskNm"));
						bodyCell.setCellStyle(cellStyle);
						
						//프로세스코드
						bodyCell = chargerRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailData.get("processCd"));
						bodyCell.setCellStyle(cellStyle);
						//프로세스명
						bodyCell = chargerRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailData.get("processNm"));
						bodyCell.setCellStyle(cellStyle);
						
						//부서
						bodyCell = chargerRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailMap.get("chrgDeptNm"));
						bodyCell.setCellStyle(cellStyle);
						//성명
						bodyCell = chargerRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailMap.get("chargerNm"));
						bodyCell.setCellStyle(cellStyle);
						
						chargerCellIdx++;
						
					}
				}
				
				//개인별 절감시간
				List<Map<String, Object>> redcnTmList = (List<Map<String, Object>>) taskDetailData.get("redcnTmList");
				int redcnTmListSize = redcnTmList.size();
				
				if(redcnTmList != null && redcnTmListSize > 0) {
				
					taskDetailMap = null;
					for (int j = 0; j < redcnTmListSize; j++) {
						int Idx = 0;
						taskDetailMap = redcnTmList.get(j);
						Row redcnTmRow = redcnTmSh.createRow(redcnTmCellIdx);
						
						//순번
						bodyCell = redcnTmRow.createCell(Idx++);
						bodyCell.setCellValue(redcnTmCellIdx-1);
						bodyCell.setCellStyle(cellStyle);
						
						//과제코드
						bodyCell = redcnTmRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailData.get("taskCd"));
						bodyCell.setCellStyle(cellStyle);
						//과제명
						bodyCell = redcnTmRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailData.get("taskNm"));
						bodyCell.setCellStyle(cellStyle);
						
						//프로세스코드
						bodyCell = redcnTmRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailData.get("processCd"));
						bodyCell.setCellStyle(cellStyle);
						//프로세스명
						bodyCell = redcnTmRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailData.get("processNm"));
						bodyCell.setCellStyle(cellStyle);
						
						//부서
						bodyCell = redcnTmRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailMap.get("deptNm"));
						bodyCell.setCellStyle(cellStyle);
						//성명
						bodyCell = redcnTmRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailMap.get("userNm"));
						bodyCell.setCellStyle(cellStyle);
						//절감시간
						bodyCell = redcnTmRow.createCell(Idx++);
						bodyCell.setCellValue(String.valueOf(taskDetailMap.get("redcnTm")));
						bodyCell.setCellStyle(cellStyle);
						
						redcnTmCellIdx++;
						
					}
				}
				
				//개인별 기여도
				List<Map<String, Object>> contributeList = (List<Map<String, Object>>) taskDetailData.get("contributeList");
				int contributeListSize = contributeList.size();
				
				if(contributeList != null && contributeListSize > 0) {
					
					taskDetailMap = null;
					for (int j = 0; j < contributeListSize; j++) {
						int Idx = 0;
						taskDetailMap = contributeList.get(j);
						Row contributeRow = contributeSh.createRow(contributeCellIdx);
						
						//순번
						bodyCell = contributeRow.createCell(Idx++);
						bodyCell.setCellValue(contributeCellIdx-1);
						bodyCell.setCellStyle(cellStyle);
						
						//과제코드
						bodyCell = contributeRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailData.get("taskCd"));
						bodyCell.setCellStyle(cellStyle);
						//과제명
						bodyCell = contributeRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailData.get("taskNm"));
						bodyCell.setCellStyle(cellStyle);
						
						//프로세스코드
						bodyCell = contributeRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailData.get("processCd"));
						bodyCell.setCellStyle(cellStyle);
						//프로세스명
						bodyCell = contributeRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailData.get("processNm"));
						bodyCell.setCellStyle(cellStyle);
						
						//부서
						bodyCell = contributeRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailMap.get("deptNm"));
						bodyCell.setCellStyle(cellStyle);
						//성명
						bodyCell = contributeRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailMap.get("userNm"));
						bodyCell.setCellStyle(cellStyle);
						//기여도
						bodyCell = contributeRow.createCell(Idx++);
						bodyCell.setCellValue(String.valueOf(taskDetailMap.get("contribute")));
						bodyCell.setCellStyle(cellStyle);
					
						contributeCellIdx++;
						
					}
				}
				
				
				
				//연관 시스템
				List<Map<String, Object>> cntcSysList = (List<Map<String, Object>>) taskDetailData.get("cntcSysList");
				int cntcSysListSize = cntcSysList.size();
				
				if(cntcSysList != null && cntcSysListSize > 0) {
					
					taskDetailMap = null;
					for (int j = 0; j < cntcSysListSize; j++) {
						int Idx = 0;
						taskDetailMap = cntcSysList.get(j);
						Row cntcSysRow = cntcSysSh.createRow(cntcSysCellIdx);
						
						//순번
						bodyCell = cntcSysRow.createCell(Idx++);
						bodyCell.setCellValue(cntcSysCellIdx-1);
						bodyCell.setCellStyle(cellStyle);
						
						//과제코드
						bodyCell = cntcSysRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailData.get("taskCd"));
						bodyCell.setCellStyle(cellStyle);
						//과제명
						bodyCell = cntcSysRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailData.get("taskNm"));
						bodyCell.setCellStyle(cellStyle);
						
						//프로세스코드
						bodyCell = cntcSysRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailData.get("processCd"));
						bodyCell.setCellStyle(cellStyle);
						//프로세스명
						bodyCell = cntcSysRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailData.get("processNm"));
						bodyCell.setCellStyle(cellStyle);
						
						//분류
						bodyCell = cntcSysRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailMap.get("cntcSysClsNm"));
						bodyCell.setCellStyle(cellStyle);
						//회사
						bodyCell = cntcSysRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailMap.get("cmpnyNm"));
						bodyCell.setCellStyle(cellStyle);
						//시스템코드
						bodyCell = cntcSysRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailMap.get("cntcSysCd"));
						bodyCell.setCellStyle(cellStyle);
						//시스템명
						bodyCell = cntcSysRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailMap.get("cntcSysNm"));
						bodyCell.setCellStyle(cellStyle);
						
						cntcSysCellIdx++;
						
					}
				}
			}
		}
				
		wb.write(os);
		os.close();

		((SXSSFWorkbook) wb).dispose();
		wb.close();
		
		returnMap.put("fileNo", fileNo);
		
		logger.debug("TaskDevelopController.outExportTaskDevelopList end!!");
		return new ResponseVO(returnMap);
	}
	
	
	
	/**
	 * 과제개발 > 등록화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/taskDevelopRegPop")
	public ModelAndView taskkDevelopRegPop() throws Exception {
		return new ModelAndView("/task/develop/taskDevelopRegPop");
	}
	
	
	
	/**
	 * 과제개발 > 등록화면 > 자동채번
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/getTaskDevelopMaxTaskCd")
	@ResponseBody
	public ResponseVO getTaskDevelopMaxTaskCd(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		logger.debug("TaskDevelopController.getTaskDevelopMaxTaskCd start!!");

		AuthorVO oAuthorVO = portalCommonService.getScreenAuthor(req);
		//쓰기/수정 권한자 인지 확인
		if(!oAuthorVO.getWrtngAuthor().equals("Y")) {
			return new ResponseVO("E202", "비정상 접근입니다.");
		}

		Map<String, Object> returnData = new HashMap<String, Object>();
		returnData.put("taskCd", taskDevelopService.getTaskDevelopMaxTaskCd(params));
		
		logger.debug("TaskDevelopController.getTaskDevelopMaxTaskCd end!!");
		return new ResponseVO(returnData);
	}
	
	
	/**
	 * 과제개발 > 등록화면 > 등록
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/insertTaskDevelop")
	@ResponseBody
	public ResponseVO insertTaskDevelop(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		logger.debug("TaskDevelopController.insertTaskDevelop start!!");

		AuthorVO oAuthorVO = portalCommonService.getScreenAuthor(req);
		//쓰기 권한자 인지 확인
		if(!oAuthorVO.getWrtngAuthor().equals("Y")) {
			return new ResponseVO("E202", "비정상 접근입니다.");
		}
		
		//과제코드 중복확인
		else if(taskDevelopService.chkTaskDevelopTaskCd(params) > 0){
			return new ResponseVO("E60000", "중복번과제코드 입니다.");
		}
		
		//insert
		params.put("registerId", MDC.get("txUserId"));
		taskDevelopService.insertTaskDevelop(params);
		
		logger.debug("TaskDevelopController.insertTaskDevelop end!!");
		return new ResponseVO(new HashMap<String, Object>());
	}
	
	
	@RequestMapping(value = "/taskDevelopDetailPop", method = RequestMethod.GET)
	public ModelAndView taskIdeaDetailPop(HttpServletRequest req, @RequestParam(value="registerId") String registerId) throws Exception {
		
		ModelAndView mav = new ModelAndView("/task/develop/taskDevelopDetailPop");
		
		//쓰기 권한자 인지 확인
		AuthorVO oAuthorVO = portalCommonService.getScreenAuthor(req);
		if(oAuthorVO.getWrtngAuthor().equals("Y")) {
			mav.addObject("identityFlag", true); 
		}else {
			mav.addObject("identityFlag", false);
		}
		return mav;
	}
	
	/**
	 * 과제개발 > 과제상세: get Data
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getTaskDevelopDetail")
	@ResponseBody
	public ResponseVO getTaskDevelopDetail(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		logger.debug("TaskDevelopController.getTaskDevelopDetail start!!");

		AuthorVO oAuthorVO = portalCommonService.getScreenAuthor(req);
		//읽기 권한자 인지 확인
		if(!oAuthorVO.getRedngAuthor().equals("Y")) {
			return new ResponseVO("E202", "비정상 접근입니다.");
		}
		
		Map<String, Object> returnData = taskDevelopService.getTaskDevelopDetail(params);
		
		logger.debug("TaskDevelopController.getTaskDevelopDetail end!!");
		return new ResponseVO(returnData);
	}
	
	@RequestMapping(value = "/updateTaskDevelop")
	@ResponseBody
	public ResponseVO updateTaskDevelop(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		AuthorVO oAuthorVO = portalCommonService.getScreenAuthor(req);
		//쓰기/수정 권한자 인지 확인
		if(!oAuthorVO.getWrtngAuthor().equals("Y")) {
			return new ResponseVO("E202", "비정상 접근입니다.");
		}
		
		Map<String, Object> returnData = taskDevelopService.getTaskDevelopDetail(params);
		
		//삭제 여부
		if(returnData == null) {
			return new ResponseVO("E60005", "이미 삭제된 과제개발입니다.");
		}
		
		//update 실행
		String sTxUserId = MDC.get("txUserId");
		params.put("updusrId", sTxUserId);
		taskDevelopService.updateTaskDevelop(params);
		
		return new ResponseVO(new HashMap<String, Object>());
	}
	
	@RequestMapping(value = "/deleteTaskDevelop")
	@ResponseBody
	public ResponseVO deleteTaskDevelop(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		AuthorVO oAuthorVO = portalCommonService.getScreenAuthor(req);
		//쓰기/수정 권한자 인지 확인
		if(!oAuthorVO.getWrtngAuthor().equals("Y")) {
			return new ResponseVO("E202", "비정상 접근입니다.");
		}
		
		Map<String, Object> returnData = taskDevelopService.getTaskDevelopDetail(params);
		
		//삭제 여부
		if(returnData == null) {
			return new ResponseVO("E60005", "이미 삭제된 과제개발입니다.");
		}
		
		String sTxUserId = MDC.get("txUserId");
		//등록된 프로세스가 있는지 확인
		if(taskDevelopService.getTaskDevelopProcessCnt(params) > 0) {
			return new ResponseVO("E202", "비정상 접근입니다.");
		}
			
		//삭제 실행
		params.put("updusrId", sTxUserId);
		taskDevelopService.deleteTaskDevelop(params);
		
		return new ResponseVO(new HashMap<String, Object>());
	}
	
	/**
	 * 과제개발 > 프로세스 등록화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/taskProcessRegPop")
	public ModelAndView taskProcessRegPop() throws Exception {
		return new ModelAndView("/task/develop/taskProcessRegPop");
	}
	
	/**
	 * 과제개발 > 프로세스 등록 사용자 번호, 이메일 조회
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getUserInfo")
	@ResponseBody
	public ResponseVO getUserInfo(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		logger.debug("TaskDevelopController.getUserInfo start!!");
		Map<String, Object> returnData = taskDevelopService.getUserInfo(params);
		
		logger.debug("TaskDevelopController.getUserInfo end!!");
		return new ResponseVO(returnData);
	}
	
	/**
	 * 과제개발 > 프로세스 등록화면 > 등록
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/insertTaskDevelopProcess")
	@ResponseBody
	public ResponseVO insertTaskDevelopProcess(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		logger.debug("TaskDevelopController.insertTaskDevelopProcess start!!");

		AuthorVO oAuthorVO = portalCommonService.getScreenAuthor(req);
		//쓰기/수정 권한자 인지 확인
		if(!oAuthorVO.getWrtngAuthor().equals("Y")) {
			return new ResponseVO("E202", "비정상 접근입니다.");
		}
		//
		
		if(taskDevelopService.chkOverlapProcessCd(params) > 0) {
			return new ResponseVO("E60007", "중복된 프로세스코드입니다.");
		};
		
		
		int iDevlopSn = Integer.parseInt(params.get("devlopSn").toString());
		//프로세스SN 채번
		Map<String, Object> aProcessNo = taskDevelopService.getMaxProcessNo(params);
		int iProcessNo = Integer.parseInt(aProcessNo.get("processNo").toString());
		params.put("processNo", iProcessNo);
		
		//insert
		params.put("registerId", MDC.get("txUserId"));
		taskDevelopService.insertTaskProcess(params);
		
		List<Map<String, Object>> aChargerList = (List<Map<String, Object>>)params.get("chargerList");
		int iaChargerList = aChargerList.size();
		
		for(int i = 0; i < iaChargerList; i++) {
			Map<String, Object> oaChargerList = aChargerList.get(i);
			oaChargerList.put("devlopSn", iDevlopSn); 
			oaChargerList.put("processNo", iProcessNo);
			oaChargerList.put("chargerNo", i+1);
			taskDevelopService.insertTaskProcessCharger(oaChargerList);
		}
		Map<String, Object> aTemp = new HashMap<String, Object>();
		//aTemp.put("devlopSn", iDevlopSn); 
		//aTemp.put("processNo", iProcessNo);
		//aTemp.put("chargerNo", iaChargerList);
		//taskDevelopService.deleteTaskProcessCharger(aTemp);
		
		
		List<Map<String, Object>> aRedcnTmList = (List<Map<String, Object>>)params.get("redcnTmList");
		int iaRedcnTmList = aRedcnTmList.size();
		for(int i = 0; i < iaRedcnTmList; i++) {
			Map<String, Object> oaRedcnTmList = aRedcnTmList.get(i);
			oaRedcnTmList.put("devlopSn", iDevlopSn); 
			oaRedcnTmList.put("processNo", iProcessNo);
			oaRedcnTmList.put("redcnNo", i+1);
			taskDevelopService.insertTaskProcessRedcnTm(oaRedcnTmList);
		}
		//aTemp.put("redcnNo", iaRedcnTmList);
		//taskDevelopService.deletTaskProcessRedcnTm(aTemp);
		
		List<Map<String, Object>> aContributeList = (List<Map<String, Object>>)params.get("contributeList");
		int iaContributeList = aContributeList.size();
		for(int i = 0; i < iaContributeList; i++) {
			Map<String, Object> oaContributeList = aContributeList.get(i);
			oaContributeList.put("devlopSn", iDevlopSn); 
			oaContributeList.put("processNo", iProcessNo);
			oaContributeList.put("contributeNo", i+1);
			taskDevelopService.insertTaskProcessContribute(oaContributeList); 
		}
		//aTemp.put("contributeNo", iaContributeList);
		//taskDevelopService.deleteTaskProcessContribute(aTemp);
		
		
		//임시저장이 아닐 경우만 결재 호출
		Map<String, Object> responseMap = new HashMap<String, Object>();
		if(params.get("pTemporary") != null && params.get("pTemporary") != "" &&  (Boolean)params.get("pTemporary") == false) {
			//과제결재 호출
			responseMap = taskPaymentService.requestTaskPayment(params);
		}
		
		
		logger.debug("TaskDevelopController.insertTaskDevelopProcess end!!");
		return new ResponseVO(responseMap);
	}
	
	/**
	 * 프로세스코드
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getTaskCdListByClsCd", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getTaskCdListByClsCd(@RequestBody Map<String, Object> map) throws Exception {
		
		List<Map<String, Object>> resultData = taskDevelopService.getTaskCdListByClsCd(map);
	
		return new ResponseVO(resultData);
	}

	/**
	 * 과제개발 > 프로세스 상세: getData
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getTaskDevelopProcessDetail", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getTaskDevelopProcessDetail(@RequestBody Map<String, Object> map) throws Exception {
		Map<String, Object> resultData = taskDevelopService.getTaskDevelopProcessDetail(map);
		return new ResponseVO(resultData);
	}
	
	
	@RequestMapping(value = "/taskProcessDetailPop", method = RequestMethod.GET)
	public ModelAndView taskProcessDetailPop(HttpServletRequest req, @RequestParam(value="registerId") String registerId) throws Exception {
		
		ModelAndView mav = new ModelAndView("/task/develop/taskProcessDetailPop");
		
		//쓰기 권한자 인지 확인
		AuthorVO oAuthorVO = portalCommonService.getScreenAuthor(req);
		if(oAuthorVO.getWrtngAuthor().equals("Y")) {
			mav.addObject("identityFlag", true); 
		}else {
			mav.addObject("identityFlag", false);
		}
		
		//다운로드 버튼 권한 여부 확인
		int oRoleCdCnt = portalCommonService.selectDownloadBtnUserRoleCount(req);
		if(oRoleCdCnt > 0) {
			mav.addObject("isDownloadBtnRoleAtFlag", true); 
		}else {
			mav.addObject("isDownloadBtnRoleAtFlag", false); 
		}
		
		return mav;
	}
	
	@RequestMapping(value = "/taskProcessTemporaryDetailPop", method = RequestMethod.GET)
	public ModelAndView taskProcessTemporaryDetailPop(HttpServletRequest req, @RequestParam(value="registerId") String registerId) throws Exception {
		ModelAndView mav = new ModelAndView("/task/develop/taskProcessTemporaryDetailPop");
		//쓰기 권한자 인지 확인
		AuthorVO oAuthorVO = portalCommonService.getScreenAuthor(req);
		if(oAuthorVO.getWrtngAuthor().equals("Y")) {
			mav.addObject("identityFlag", true); 
		}else {
			mav.addObject("identityFlag", false);
		}
		
		//다운로드 버튼 권한 여부 확인
		int oRoleCdCnt = portalCommonService.selectDownloadBtnUserRoleCount(req);
		if(oRoleCdCnt > 0) {
			mav.addObject("isDownloadBtnRoleAtFlag", true); 
		}else {
			mav.addObject("isDownloadBtnRoleAtFlag", false); 
		}
		return mav;
	}
	
	/**
	 * 과제개발 > 프로세스 상세 > 연관시스템 검색: Layout
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/searchCntcSysPopup")
	public ModelAndView selectCntcSys() throws Exception {
		return new ModelAndView("/task/develop/searchCntcSysPopup");
	}
	
	@RequestMapping(value = "/selectCntcSysList")
	@ResponseBody
	public ResponseVO selectCntcSysList(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		logger.debug("TaskDevelopController.selectCntcSysList start!!");
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		//과제개발 > 메인: 리스트 카운트 조회
		int totalRecordCount = taskDevelopService.selectCntcSysListCount(params);
		
		//페이징 정보 조회
		PaginationInfo paginationInfo = PaginationUtil.getPaginationInfo(params, totalRecordCount);
		
		//조회조건에 페이징 정보 설정
		params.put("paginationInfo", PaginationUtil.getPaginationInfo(params, totalRecordCount));

		//과제개발 > 메인: 리스트  조회
		List<Map<String, Object>> resultList = taskDevelopService.selectCntcSysList(params);

		//결과값 설정
		returnMap.put("resultList", resultList);
		returnMap.put("paginationInfo", paginationInfo);
		logger.debug("TaskDevelopController.selectCntcSysList end!!");
		return new ResponseVO(returnMap);
	}
	
	/**
	 * 과제개발 > 프로세스 상세: 저장
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateTaskDevelopProcess", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO updateTaskDevelopProcess(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		logger.debug("TaskDevelopController.updateTaskDevelopProcess start!!");

		AuthorVO oAuthorVO = portalCommonService.getScreenAuthor(req);
		//쓰기/수정 권한자 인지 확인
		if(!oAuthorVO.getWrtngAuthor().equals("Y")) {
			return new ResponseVO("E202", "비정상 접근입니다.");
		}

		// 프로세스 이력번호
		//등록자와 동일인 인지 확인
		Map<String, Object> returnData = taskDevelopService.getTaskDevelopProcessDetail(params);
		String sTxUserId = MDC.get("txUserId");
		
		//자신 빼고 코드 중복 확인
		if(taskDevelopService.chkOverlapProcessCdType2(params) > 1) {
			return new ResponseVO("E60007", "중복된 프로세스코드입니다.");
		};
		
		//update 실행
		//update
		params.put("registerId", sTxUserId);
		params.put("updusrId", sTxUserId);
		
		//프로세스 이력번호 생성
		int iProcessHistNo = taskDevelopService.getTaskProcessHistNo(params);
		params.put("processHistNo", iProcessHistNo);
		
		//프로세스 과거 이력 저장
		taskDevelopService.insertTaskProcessHist(params);
		
		//프로세스 변경 이력 저장
		taskDevelopService.insertTaskProcessChangeHist(params);

		//프로세스 정보 업데이트
		taskDevelopService.updateTaskProcess(params);
		
		int iDevlopSn = Integer.parseInt(params.get("devlopSn").toString());
		int iProcessNo = Integer.parseInt(params.get("processNo").toString());
		
		
		//담당자 정보 이력 저장
		taskDevelopService.insertTaskProcessChargerHist(params);
		
		List<Map<String, Object>> aChargerList = (List<Map<String, Object>>)params.get("chargerList");
		int iaChargerList = aChargerList.size();
		
		for(int i = 0; i < iaChargerList; i++) {
			Map<String, Object> oaChargerList = aChargerList.get(i);
			oaChargerList.put("devlopSn", iDevlopSn); 
			oaChargerList.put("processNo", iProcessNo);
			oaChargerList.put("chargerNo", i+1);
			taskDevelopService.insertTaskProcessCharger(oaChargerList);
		}
		Map<String, Object> aTemp = new HashMap<String, Object>();
		aTemp.put("devlopSn", iDevlopSn); 
		aTemp.put("processNo", iProcessNo);
		aTemp.put("chargerNo", iaChargerList);
		taskDevelopService.deleteTaskProcessCharger(aTemp);
		
		
		//개인별 절감시간 이력 저장
		taskDevelopService.insertTaskProcessRedcnTmHist(params);
		
		//개인별 절감시간 저장
		List<Map<String, Object>> aRedcnTmList = (List<Map<String, Object>>)params.get("redcnTmList");
		int iaRedcnTmList = 0;
		if(aRedcnTmList != null) {
			iaRedcnTmList = aRedcnTmList.size();
		}
				
		for(int i = 0; i < iaRedcnTmList; i++) {
			Map<String, Object> oaRedcnTmList = aRedcnTmList.get(i);
			oaRedcnTmList.put("devlopSn", iDevlopSn); 
			oaRedcnTmList.put("processNo", iProcessNo);
			oaRedcnTmList.put("redcnNo", i+1);
			taskDevelopService.insertTaskProcessRedcnTm(oaRedcnTmList);
		}
		aTemp.put("redcnNo", iaRedcnTmList);
		taskDevelopService.deletTaskProcessRedcnTm(aTemp);
		
		//개인별 기여도 이력 저장
		taskDevelopService.insertTaskProcessContributeHist(params);
				
		List<Map<String, Object>> aContributeList = (List<Map<String, Object>>)params.get("contributeList");
		int iaContributeList = aContributeList.size();
		for(int i = 0; i < iaContributeList; i++) {
			Map<String, Object> oaContributeList = aContributeList.get(i);
			oaContributeList.put("devlopSn", iDevlopSn); 
			oaContributeList.put("processNo", iProcessNo);
			oaContributeList.put("contributeNo", i+1);
			taskDevelopService.insertTaskProcessContribute(oaContributeList); 
		}
		aTemp.put("contributeNo", iaContributeList);
		taskDevelopService.deleteTaskProcessContribute(aTemp);
		
		//연관 시스템 이력 저장
		taskDevelopService.insertTaskDevlopProcessCntcSysHist(params);
		
		//연관 시스템 저장
		List<Map<String, Object>> aCntcSysList = (List<Map<String, Object>>)params.get("cntcSysList");
		int iaCntcSysList = 0;
		if(aCntcSysList != null) {
			iaCntcSysList = aCntcSysList.size();
		}
			
		for(int i = 0; i < iaCntcSysList; i++) {
			Map<String, Object> oaCntcSysList = aCntcSysList.get(i);
			oaCntcSysList.put("devlopSn", iDevlopSn); 
			oaCntcSysList.put("processNo", iProcessNo);
			oaCntcSysList.put("cntcSysNo", i+1);
			taskDevelopService.insertTaskDevlopProcessCntcSys(oaCntcSysList); 
		}
		//연관 시스템 저장 정보외 나머지 삭제
		aTemp.put("cntcSysNo", iaCntcSysList);
		taskDevelopService.deleteTaskDevlopProcessCntcSys(aTemp);
		
		//임시저장이 아닐 경우만 결재 호출
		Map<String, Object> responseMap = new HashMap<String, Object>();
		if(params.get("pTemporary") != null && params.get("pTemporary") != "" &&  (Boolean)params.get("pTemporary") == false) {
			//과제결재 호출
			responseMap = taskPaymentService.requestTaskPayment(params);
		}
		
		logger.debug("TaskDevelopController.updateTaskDevelopProcess end!!");
		return new ResponseVO(responseMap);
	}
	
	
}
