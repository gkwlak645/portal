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
	 * ???????????? ?????????
	 */
	@Resource(name="taskPaymentService")
	private TaskPaymentService taskPaymentService;
	
	/**
	 * ?????? ???????????? ??????
	 */
	@Value("${file.tmpdownload.path}")
	private String downloadPath;
	
	/**
	 * ???????????? ????????????
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/taskDevelopMain")
	public ModelAndView taskDevelopMain() throws Exception {
		return new ModelAndView("/task/develop/taskDevelopMain");
	}
	
	/**
	 * ???????????????????????? ????????? ??????
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectTaskDevelopList")
	@ResponseBody
	public ResponseVO selectTaskDevelopList(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		logger.debug("TaskDevelopController.selectTaskDevelopList start!!");
		AuthorVO oAuthorVO = portalCommonService.getScreenAuthor(req);
		//?????? ????????? ????????? ??????
		if(!oAuthorVO.getRedngAuthor().equals("Y")) {
			return new ResponseVO("E202", "????????? ???????????????.");
		}
		else if(!oAuthorVO.getUntenantAuthor().equals("Y") && ((String)params.get("searchCmpnyCd")).equals("")) {
			return new ResponseVO("E202", "????????? ???????????????.");
		}
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		//???????????? > ??????: ????????? ????????? ??????
		int totalRecordCount = taskDevelopService.selectTaskDevelopListCount(params);
		
		//????????? ?????? ??????
		PaginationInfo paginationInfo = PaginationUtil.getPaginationInfo(params, totalRecordCount);
		
		//??????????????? ????????? ?????? ??????
		params.put("paginationInfo", PaginationUtil.getPaginationInfo(params, totalRecordCount));

		//???????????? > ??????: ?????????  ??????
		List<Map<String, Object>> resultList = taskDevelopService.selectTaskDevelopList(params);

		//????????? ??????
		returnMap.put("resultList", resultList);
		returnMap.put("paginationInfo", paginationInfo);
		logger.debug("TaskDevelopController.selectTaskDevelopList end!!");
		return new ResponseVO(returnMap);
	}
	
	
	/**
	 * ???????????? ?????? ?????? ????????????
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/outExportTaskDevelopList")
	@ResponseBody
	public ResponseVO outExportTaskDevelopList(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		logger.debug("TaskDevelopController.outExportTaskDevelopList start!!");
		
		AuthorVO oAuthorVO = portalCommonService.getScreenAuthor(req);
		//?????? ????????? ????????? ??????
		if(!oAuthorVO.getRedngAuthor().equals("Y")) {
			return new ResponseVO("E202", "????????? ???????????????.");
		}
		else if(!oAuthorVO.getUntenantAuthor().equals("Y") && ((String)params.get("searchCmpnyCd")).equals("")) {
			return new ResponseVO("E202", "????????? ???????????????.");
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

		Workbook wb = new SXSSFWorkbook(100); // 100 row?????? ????????? flush
		
		CellStyle cellStyle = wb.createCellStyle();
		cellStyle.setBorderRight(BorderStyle.THIN);
		cellStyle.setBorderLeft(BorderStyle.THIN);
		cellStyle.setBorderTop(BorderStyle.THIN);
		cellStyle.setBorderBottom(BorderStyle.THIN);

		Sheet processSh 	= wb.createSheet("??????????????????");
		Sheet chargerSh  	= wb.createSheet("????????? ??????");
		Sheet redcnTmSh  	= wb.createSheet("????????? ????????????");
		Sheet contributeSh  = wb.createSheet("????????? ?????????");
		Sheet cntcSysSh  	= wb.createSheet("???????????????");
		
		//????????????
		String[] processColumns    = new String[] {"??????", "????????????", "?????????", "????????????", "??????", "????????????", "??????????????????", "???????????????", "????????????(??????)", "??????", "??????", "??????????????????"
													, "???????????????", "BOT" ,"????????????" ,"??????" ,"????????????" ,"?????????????????????" ,"??????????????????(??? X 33,000???)" ,"????????????" ,"????????????" ,"???????????????"   
													,"??????????????????(??? X 8.5Hr X 33,000???)" ,"????????????" ,"RTO" ,"ROI??????(??? X 10 ??? ???)" ,"????????????" ,"??????????????????" ,"??????????????????", "???????????????"};
		//?????????
		String[] chargerColumns    = new String[] {"??????", "????????????", "?????????",  "??????????????????", "???????????????", "??????", "??????"};
		//????????? ????????????
		String[] redcnTmColumns    = new String[] {"??????", "????????????", "?????????",  "??????????????????", "???????????????", "??????", "??????", "????????????(hour)"};
		//????????? ?????????
		String[] contributeColumns = new String[] {"??????", "????????????", "?????????",  "??????????????????", "???????????????", "??????", "??????", "?????????(%)"};
		//???????????????
		String[] cntcSysColumns    = new String[] {"??????", "????????????", "?????????",  "??????????????????", "???????????????", "??????", "??????", "???????????????", "????????????"};
		
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
		
		//???????????? > ??????: ?????????  ??????
		List<Map<String, Object>> resultList = taskDevelopService.selectTaskDevelopList(params);
		
		Map<String, Object> map = null;
		
		int resultListSize = resultList.size();
		
		for (int i = 0; i < resultListSize; i++) {
			
			map = resultList.get(i);
			
			if(map.get("processCd") != null && !"".equals(map.get("processCd"))) {
				
			//?????????????????? 
			int cellIdx = 0;
			Row row = processSh.createRow(taskCellIdx);	
				
			Map<String, Object> taskDetailData = taskDevelopService.getTaskDevelopProcessDetail2(map);
			Map<String, Object> taskDetailMap = null;
			
			//??????????????????
			//????????????----------------------------------------------------------------------------------
			//??????
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(taskCellIdx-1);
			bodyCell.setCellStyle(cellStyle);
			//????????????
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)taskDetailData.get("taskCd"));
			bodyCell.setCellStyle(cellStyle);
			//?????????
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)taskDetailData.get("taskNm"));
			bodyCell.setCellStyle(cellStyle);
			//????????????
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)taskDetailData.get("taskDc"));
			bodyCell.setCellStyle(cellStyle);
			//?????????
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)taskDetailData.get("cmpnyNm"));
			bodyCell.setCellStyle(cellStyle);
			//????????????
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)taskDetailData.get("clsNm"));
			bodyCell.setCellStyle(cellStyle);
			//??????????????????
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)taskDetailData.get("jobChrgDeptNm"));
			bodyCell.setCellStyle(cellStyle);
			//???????????????
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)taskDetailData.get("jobChargerNm"));
			bodyCell.setCellStyle(cellStyle);
			//????????????(??????)
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(String.valueOf(taskDetailData.get("jobTm")));
			bodyCell.setCellStyle(cellStyle);
			//??????
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(String.valueOf(taskDetailData.get("fqNm")) +" "+ String.valueOf(taskDetailData.get("executCnt")) + "???");
			bodyCell.setCellStyle(cellStyle);
			//??????????????????----------------------------------------------------------------------------------
			//??????
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)taskDetailData.get("sj"));
			bodyCell.setCellStyle(cellStyle);
			//??????????????????
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)taskDetailData.get("processCd"));
			bodyCell.setCellStyle(cellStyle);
			//???????????????
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)taskDetailData.get("processNm"));
			bodyCell.setCellStyle(cellStyle);
			//????????? or ?????????
			String bot = !taskDetailData.containsKey("BOT_SE") ? "NULL" : (String)taskDetailData.get("BOT_SE");
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(bot);
			bodyCell.setCellStyle(cellStyle);
			//????????????
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)taskDetailData.get("jobDc"));
			bodyCell.setCellStyle(cellStyle);
			//??????
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)taskDetailData.get("cmpnyNmReg"));
			bodyCell.setCellStyle(cellStyle);
			//????????????
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(String.valueOf(taskDetailData.get("processJobTm")));
			bodyCell.setCellStyle(cellStyle);
			//?????????????????????
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(String.valueOf(taskDetailData.get("redcnTm")));
			bodyCell.setCellStyle(cellStyle);
			//??????????????????(??? X 33,000???)
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(String.valueOf(taskDetailData.get("expectRedcnAmt")));
			bodyCell.setCellStyle(cellStyle);
			//????????????
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(String.valueOf(taskDetailData.get("fqNmReg")) +" "+ String.valueOf(taskDetailData.get("executCntReg")) + "???");
			bodyCell.setCellStyle(cellStyle);
			//????????????
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(String.valueOf(taskDetailData.get("executTm")));
			bodyCell.setCellStyle(cellStyle);
			//???????????????
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(String.valueOf(taskDetailData.get("devlopWdcnt")));
			bodyCell.setCellStyle(cellStyle);
			//??????????????????(??? X 8.5Hr X 33,000???)
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(String.valueOf(taskDetailData.get("expectDevlopCt")));
			bodyCell.setCellStyle(cellStyle);
			//????????????
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)taskDetailData.get("emrgncyCrspnd"));
			bodyCell.setCellStyle(cellStyle);
			//RTO
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(String.valueOf(taskDetailData.get("rto")));
			bodyCell.setCellStyle(cellStyle);
			//ROI??????(??? X 10 ??? ???)
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)taskDetailData.get("roiEvaluate"));
			bodyCell.setCellStyle(cellStyle);
			//????????????
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)taskDetailData.get("devlopResn"));
			bodyCell.setCellStyle(cellStyle);
			//??????????????????
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)taskDetailData.get("insideDevlopAtNm"));
			bodyCell.setCellStyle(cellStyle);
			//??????????????????
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)map.get("processSttusNm"));
			bodyCell.setCellStyle(cellStyle);
			
			// ?????? ????????? 
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)map.get("belongingDe"));
			bodyCell.setCellStyle(cellStyle);
			
			taskCellIdx++;	
				
			//?????????
			List<Map<String, Object>> chargerList = (List<Map<String, Object>>) taskDetailData.get("chargerList");
			int chargerListSize = chargerList.size();
				
				if(chargerList != null && chargerListSize > 0) {
					taskDetailMap = null;
					for (int j = 0; j < chargerListSize; j++) {
						int Idx = 0;
						taskDetailMap = chargerList.get(j);
						Row chargerRow = chargerSh.createRow(chargerCellIdx);
						
						//??????
						bodyCell = chargerRow.createCell(Idx++);
						bodyCell.setCellValue(chargerCellIdx-1);
						bodyCell.setCellStyle(cellStyle);
						
						//????????????
						bodyCell = chargerRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailData.get("taskCd"));
						bodyCell.setCellStyle(cellStyle);
						//?????????
						bodyCell = chargerRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailData.get("taskNm"));
						bodyCell.setCellStyle(cellStyle);
						
						//??????????????????
						bodyCell = chargerRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailData.get("processCd"));
						bodyCell.setCellStyle(cellStyle);
						//???????????????
						bodyCell = chargerRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailData.get("processNm"));
						bodyCell.setCellStyle(cellStyle);
						
						//??????
						bodyCell = chargerRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailMap.get("chrgDeptNm"));
						bodyCell.setCellStyle(cellStyle);
						//??????
						bodyCell = chargerRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailMap.get("chargerNm"));
						bodyCell.setCellStyle(cellStyle);
						
						chargerCellIdx++;
						
					}
				}
				
				//????????? ????????????
				List<Map<String, Object>> redcnTmList = (List<Map<String, Object>>) taskDetailData.get("redcnTmList");
				int redcnTmListSize = redcnTmList.size();
				
				if(redcnTmList != null && redcnTmListSize > 0) {
				
					taskDetailMap = null;
					for (int j = 0; j < redcnTmListSize; j++) {
						int Idx = 0;
						taskDetailMap = redcnTmList.get(j);
						Row redcnTmRow = redcnTmSh.createRow(redcnTmCellIdx);
						
						//??????
						bodyCell = redcnTmRow.createCell(Idx++);
						bodyCell.setCellValue(redcnTmCellIdx-1);
						bodyCell.setCellStyle(cellStyle);
						
						//????????????
						bodyCell = redcnTmRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailData.get("taskCd"));
						bodyCell.setCellStyle(cellStyle);
						//?????????
						bodyCell = redcnTmRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailData.get("taskNm"));
						bodyCell.setCellStyle(cellStyle);
						
						//??????????????????
						bodyCell = redcnTmRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailData.get("processCd"));
						bodyCell.setCellStyle(cellStyle);
						//???????????????
						bodyCell = redcnTmRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailData.get("processNm"));
						bodyCell.setCellStyle(cellStyle);
						
						//??????
						bodyCell = redcnTmRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailMap.get("deptNm"));
						bodyCell.setCellStyle(cellStyle);
						//??????
						bodyCell = redcnTmRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailMap.get("userNm"));
						bodyCell.setCellStyle(cellStyle);
						//????????????
						bodyCell = redcnTmRow.createCell(Idx++);
						bodyCell.setCellValue(String.valueOf(taskDetailMap.get("redcnTm")));
						bodyCell.setCellStyle(cellStyle);
						
						redcnTmCellIdx++;
						
					}
				}
				
				//????????? ?????????
				List<Map<String, Object>> contributeList = (List<Map<String, Object>>) taskDetailData.get("contributeList");
				int contributeListSize = contributeList.size();
				
				if(contributeList != null && contributeListSize > 0) {
					
					taskDetailMap = null;
					for (int j = 0; j < contributeListSize; j++) {
						int Idx = 0;
						taskDetailMap = contributeList.get(j);
						Row contributeRow = contributeSh.createRow(contributeCellIdx);
						
						//??????
						bodyCell = contributeRow.createCell(Idx++);
						bodyCell.setCellValue(contributeCellIdx-1);
						bodyCell.setCellStyle(cellStyle);
						
						//????????????
						bodyCell = contributeRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailData.get("taskCd"));
						bodyCell.setCellStyle(cellStyle);
						//?????????
						bodyCell = contributeRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailData.get("taskNm"));
						bodyCell.setCellStyle(cellStyle);
						
						//??????????????????
						bodyCell = contributeRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailData.get("processCd"));
						bodyCell.setCellStyle(cellStyle);
						//???????????????
						bodyCell = contributeRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailData.get("processNm"));
						bodyCell.setCellStyle(cellStyle);
						
						//??????
						bodyCell = contributeRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailMap.get("deptNm"));
						bodyCell.setCellStyle(cellStyle);
						//??????
						bodyCell = contributeRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailMap.get("userNm"));
						bodyCell.setCellStyle(cellStyle);
						//?????????
						bodyCell = contributeRow.createCell(Idx++);
						bodyCell.setCellValue(String.valueOf(taskDetailMap.get("contribute")));
						bodyCell.setCellStyle(cellStyle);
					
						contributeCellIdx++;
						
					}
				}
				
				
				
				//?????? ?????????
				List<Map<String, Object>> cntcSysList = (List<Map<String, Object>>) taskDetailData.get("cntcSysList");
				int cntcSysListSize = cntcSysList.size();
				
				if(cntcSysList != null && cntcSysListSize > 0) {
					
					taskDetailMap = null;
					for (int j = 0; j < cntcSysListSize; j++) {
						int Idx = 0;
						taskDetailMap = cntcSysList.get(j);
						Row cntcSysRow = cntcSysSh.createRow(cntcSysCellIdx);
						
						//??????
						bodyCell = cntcSysRow.createCell(Idx++);
						bodyCell.setCellValue(cntcSysCellIdx-1);
						bodyCell.setCellStyle(cellStyle);
						
						//????????????
						bodyCell = cntcSysRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailData.get("taskCd"));
						bodyCell.setCellStyle(cellStyle);
						//?????????
						bodyCell = cntcSysRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailData.get("taskNm"));
						bodyCell.setCellStyle(cellStyle);
						
						//??????????????????
						bodyCell = cntcSysRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailData.get("processCd"));
						bodyCell.setCellStyle(cellStyle);
						//???????????????
						bodyCell = cntcSysRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailData.get("processNm"));
						bodyCell.setCellStyle(cellStyle);
						
						//??????
						bodyCell = cntcSysRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailMap.get("cntcSysClsNm"));
						bodyCell.setCellStyle(cellStyle);
						//??????
						bodyCell = cntcSysRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailMap.get("cmpnyNm"));
						bodyCell.setCellStyle(cellStyle);
						//???????????????
						bodyCell = cntcSysRow.createCell(Idx++);
						bodyCell.setCellValue((String)taskDetailMap.get("cntcSysCd"));
						bodyCell.setCellStyle(cellStyle);
						//????????????
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
	 * ???????????? > ????????????
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/taskDevelopRegPop")
	public ModelAndView taskkDevelopRegPop() throws Exception {
		return new ModelAndView("/task/develop/taskDevelopRegPop");
	}
	
	
	
	/**
	 * ???????????? > ???????????? > ????????????
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/getTaskDevelopMaxTaskCd")
	@ResponseBody
	public ResponseVO getTaskDevelopMaxTaskCd(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		logger.debug("TaskDevelopController.getTaskDevelopMaxTaskCd start!!");

		AuthorVO oAuthorVO = portalCommonService.getScreenAuthor(req);
		//??????/?????? ????????? ?????? ??????
		if(!oAuthorVO.getWrtngAuthor().equals("Y")) {
			return new ResponseVO("E202", "????????? ???????????????.");
		}

		Map<String, Object> returnData = new HashMap<String, Object>();
		returnData.put("taskCd", taskDevelopService.getTaskDevelopMaxTaskCd(params));
		
		logger.debug("TaskDevelopController.getTaskDevelopMaxTaskCd end!!");
		return new ResponseVO(returnData);
	}
	
	
	/**
	 * ???????????? > ???????????? > ??????
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/insertTaskDevelop")
	@ResponseBody
	public ResponseVO insertTaskDevelop(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		logger.debug("TaskDevelopController.insertTaskDevelop start!!");

		AuthorVO oAuthorVO = portalCommonService.getScreenAuthor(req);
		//?????? ????????? ?????? ??????
		if(!oAuthorVO.getWrtngAuthor().equals("Y")) {
			return new ResponseVO("E202", "????????? ???????????????.");
		}
		
		//???????????? ????????????
		else if(taskDevelopService.chkTaskDevelopTaskCd(params) > 0){
			return new ResponseVO("E60000", "????????????????????? ?????????.");
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
		
		//?????? ????????? ?????? ??????
		AuthorVO oAuthorVO = portalCommonService.getScreenAuthor(req);
		if(oAuthorVO.getWrtngAuthor().equals("Y")) {
			mav.addObject("identityFlag", true); 
		}else {
			mav.addObject("identityFlag", false);
		}
		return mav;
	}
	
	/**
	 * ???????????? > ????????????: get Data
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getTaskDevelopDetail")
	@ResponseBody
	public ResponseVO getTaskDevelopDetail(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		logger.debug("TaskDevelopController.getTaskDevelopDetail start!!");

		AuthorVO oAuthorVO = portalCommonService.getScreenAuthor(req);
		//?????? ????????? ?????? ??????
		if(!oAuthorVO.getRedngAuthor().equals("Y")) {
			return new ResponseVO("E202", "????????? ???????????????.");
		}
		
		Map<String, Object> returnData = taskDevelopService.getTaskDevelopDetail(params);
		
		logger.debug("TaskDevelopController.getTaskDevelopDetail end!!");
		return new ResponseVO(returnData);
	}
	
	@RequestMapping(value = "/updateTaskDevelop")
	@ResponseBody
	public ResponseVO updateTaskDevelop(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		AuthorVO oAuthorVO = portalCommonService.getScreenAuthor(req);
		//??????/?????? ????????? ?????? ??????
		if(!oAuthorVO.getWrtngAuthor().equals("Y")) {
			return new ResponseVO("E202", "????????? ???????????????.");
		}
		
		Map<String, Object> returnData = taskDevelopService.getTaskDevelopDetail(params);
		
		//?????? ??????
		if(returnData == null) {
			return new ResponseVO("E60005", "?????? ????????? ?????????????????????.");
		}
		
		//update ??????
		String sTxUserId = MDC.get("txUserId");
		params.put("updusrId", sTxUserId);
		taskDevelopService.updateTaskDevelop(params);
		
		return new ResponseVO(new HashMap<String, Object>());
	}
	
	@RequestMapping(value = "/deleteTaskDevelop")
	@ResponseBody
	public ResponseVO deleteTaskDevelop(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		AuthorVO oAuthorVO = portalCommonService.getScreenAuthor(req);
		//??????/?????? ????????? ?????? ??????
		if(!oAuthorVO.getWrtngAuthor().equals("Y")) {
			return new ResponseVO("E202", "????????? ???????????????.");
		}
		
		Map<String, Object> returnData = taskDevelopService.getTaskDevelopDetail(params);
		
		//?????? ??????
		if(returnData == null) {
			return new ResponseVO("E60005", "?????? ????????? ?????????????????????.");
		}
		
		String sTxUserId = MDC.get("txUserId");
		//????????? ??????????????? ????????? ??????
		if(taskDevelopService.getTaskDevelopProcessCnt(params) > 0) {
			return new ResponseVO("E202", "????????? ???????????????.");
		}
			
		//?????? ??????
		params.put("updusrId", sTxUserId);
		taskDevelopService.deleteTaskDevelop(params);
		
		return new ResponseVO(new HashMap<String, Object>());
	}
	
	/**
	 * ???????????? > ???????????? ????????????
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/taskProcessRegPop")
	public ModelAndView taskProcessRegPop() throws Exception {
		return new ModelAndView("/task/develop/taskProcessRegPop");
	}
	
	/**
	 * ???????????? > ???????????? ?????? ????????? ??????, ????????? ??????
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
	 * ???????????? > ???????????? ???????????? > ??????
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/insertTaskDevelopProcess")
	@ResponseBody
	public ResponseVO insertTaskDevelopProcess(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		logger.debug("TaskDevelopController.insertTaskDevelopProcess start!!");

		AuthorVO oAuthorVO = portalCommonService.getScreenAuthor(req);
		//??????/?????? ????????? ?????? ??????
		if(!oAuthorVO.getWrtngAuthor().equals("Y")) {
			return new ResponseVO("E202", "????????? ???????????????.");
		}
		//
		
		if(taskDevelopService.chkOverlapProcessCd(params) > 0) {
			return new ResponseVO("E60007", "????????? ???????????????????????????.");
		};
		
		
		int iDevlopSn = Integer.parseInt(params.get("devlopSn").toString());
		//????????????SN ??????
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
		
		
		//??????????????? ?????? ????????? ?????? ??????
		Map<String, Object> responseMap = new HashMap<String, Object>();
		if(params.get("pTemporary") != null && params.get("pTemporary") != "" &&  (Boolean)params.get("pTemporary") == false) {
			//???????????? ??????
			responseMap = taskPaymentService.requestTaskPayment(params);
		}
		
		
		logger.debug("TaskDevelopController.insertTaskDevelopProcess end!!");
		return new ResponseVO(responseMap);
	}
	
	/**
	 * ??????????????????
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
	 * ???????????? > ???????????? ??????: getData
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
		
		//?????? ????????? ?????? ??????
		AuthorVO oAuthorVO = portalCommonService.getScreenAuthor(req);
		if(oAuthorVO.getWrtngAuthor().equals("Y")) {
			mav.addObject("identityFlag", true); 
		}else {
			mav.addObject("identityFlag", false);
		}
		
		//???????????? ?????? ?????? ?????? ??????
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
		//?????? ????????? ?????? ??????
		AuthorVO oAuthorVO = portalCommonService.getScreenAuthor(req);
		if(oAuthorVO.getWrtngAuthor().equals("Y")) {
			mav.addObject("identityFlag", true); 
		}else {
			mav.addObject("identityFlag", false);
		}
		
		//???????????? ?????? ?????? ?????? ??????
		int oRoleCdCnt = portalCommonService.selectDownloadBtnUserRoleCount(req);
		if(oRoleCdCnt > 0) {
			mav.addObject("isDownloadBtnRoleAtFlag", true); 
		}else {
			mav.addObject("isDownloadBtnRoleAtFlag", false); 
		}
		return mav;
	}
	
	/**
	 * ???????????? > ???????????? ?????? > ??????????????? ??????: Layout
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
		//???????????? > ??????: ????????? ????????? ??????
		int totalRecordCount = taskDevelopService.selectCntcSysListCount(params);
		
		//????????? ?????? ??????
		PaginationInfo paginationInfo = PaginationUtil.getPaginationInfo(params, totalRecordCount);
		
		//??????????????? ????????? ?????? ??????
		params.put("paginationInfo", PaginationUtil.getPaginationInfo(params, totalRecordCount));

		//???????????? > ??????: ?????????  ??????
		List<Map<String, Object>> resultList = taskDevelopService.selectCntcSysList(params);

		//????????? ??????
		returnMap.put("resultList", resultList);
		returnMap.put("paginationInfo", paginationInfo);
		logger.debug("TaskDevelopController.selectCntcSysList end!!");
		return new ResponseVO(returnMap);
	}
	
	/**
	 * ???????????? > ???????????? ??????: ??????
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateTaskDevelopProcess", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO updateTaskDevelopProcess(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		logger.debug("TaskDevelopController.updateTaskDevelopProcess start!!");

		AuthorVO oAuthorVO = portalCommonService.getScreenAuthor(req);
		//??????/?????? ????????? ?????? ??????
		if(!oAuthorVO.getWrtngAuthor().equals("Y")) {
			return new ResponseVO("E202", "????????? ???????????????.");
		}

		// ???????????? ????????????
		//???????????? ????????? ?????? ??????
		Map<String, Object> returnData = taskDevelopService.getTaskDevelopProcessDetail(params);
		String sTxUserId = MDC.get("txUserId");
		
		//?????? ?????? ?????? ?????? ??????
		if(taskDevelopService.chkOverlapProcessCdType2(params) > 1) {
			return new ResponseVO("E60007", "????????? ???????????????????????????.");
		};
		
		//update ??????
		//update
		params.put("registerId", sTxUserId);
		params.put("updusrId", sTxUserId);
		
		//???????????? ???????????? ??????
		int iProcessHistNo = taskDevelopService.getTaskProcessHistNo(params);
		params.put("processHistNo", iProcessHistNo);
		
		//???????????? ?????? ?????? ??????
		taskDevelopService.insertTaskProcessHist(params);
		
		//???????????? ?????? ?????? ??????
		taskDevelopService.insertTaskProcessChangeHist(params);

		//???????????? ?????? ????????????
		taskDevelopService.updateTaskProcess(params);
		
		int iDevlopSn = Integer.parseInt(params.get("devlopSn").toString());
		int iProcessNo = Integer.parseInt(params.get("processNo").toString());
		
		
		//????????? ?????? ?????? ??????
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
		
		
		//????????? ???????????? ?????? ??????
		taskDevelopService.insertTaskProcessRedcnTmHist(params);
		
		//????????? ???????????? ??????
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
		
		//????????? ????????? ?????? ??????
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
		
		//?????? ????????? ?????? ??????
		taskDevelopService.insertTaskDevlopProcessCntcSysHist(params);
		
		//?????? ????????? ??????
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
		//?????? ????????? ?????? ????????? ????????? ??????
		aTemp.put("cntcSysNo", iaCntcSysList);
		taskDevelopService.deleteTaskDevlopProcessCntcSys(aTemp);
		
		//??????????????? ?????? ????????? ?????? ??????
		Map<String, Object> responseMap = new HashMap<String, Object>();
		if(params.get("pTemporary") != null && params.get("pTemporary") != "" &&  (Boolean)params.get("pTemporary") == false) {
			//???????????? ??????
			responseMap = taskPaymentService.requestTaskPayment(params);
		}
		
		logger.debug("TaskDevelopController.updateTaskDevelopProcess end!!");
		return new ResponseVO(responseMap);
	}
	
	
}
