package kr.co.rpaplatform.dongwon.author.web;

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

import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.quartz.CronExpression;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.MDC;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.rpaplatform.common.pagination.PaginationInfo;
import kr.co.rpaplatform.common.vo.ResponseVO;
import kr.co.rpaplatform.dongwon.author.service.AuthorService;
import kr.co.rpaplatform.dongwon.author.service.LoginListService;
import kr.co.rpaplatform.dongwon.author.vo.AuthorVO;
import kr.co.rpaplatform.dongwon.common.util.PaginationUtil;

/**
 * 권한 컨트롤러 클래스
 * @author jw.lee
 * 2020. 6. 2.
 */
@Controller
@RequestMapping("/author/loginlistmntrng")
public class LoginListController {

	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(LoginListController.class);
	
	@Resource(name="loginListService")
	private LoginListService loginListService;
	
	/**
	 * 임시 다운로드 경로
	 */
	@Value("${file.tmpdownload.path}")
	private String downloadPath;
	
	/**
	 * 접속가능명단 메인페이지
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/loginListMntrngMain", method = RequestMethod.GET)
	public ModelAndView menuRoleMain() throws Exception {
		ModelAndView mav = new ModelAndView("/author/loginlistmntrng/loginListMntrngMain");
		return mav;
	}
	
	/**
	 * 접속가능명단 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/searchPortalLoginList")
	@ResponseBody
	public ResponseVO searchPortalLoginList(@RequestBody Map<String, Object> map) throws Exception {		
		// 반환 Map
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		// 로그인 가능 리스트 카운트 조회(메인)
		int totalRecordCount = loginListService.searchPortalLoginListCount(map);	
		
		if (totalRecordCount > 0) {
			//페이징 정보 조회
			PaginationInfo paginationInfo = PaginationUtil.getPaginationInfo(map, totalRecordCount);
			
			//조회조건에 페이징 정보 설정
			map.put("paginationInfo", PaginationUtil.getPaginationInfo(map, totalRecordCount));
			
			// 접속 가능 리스트 조회
			List<Map<String, Object>> resultList = loginListService.searchPortalLoginList(map); 
	
			//결과값 설정
			returnMap.put("resultList", resultList);
			returnMap.put("paginationInfo", paginationInfo);	
		} 
		else {
			
			//결과값 설정
			returnMap.put("resultList", null);
			returnMap.put("paginationInfo", PaginationUtil.getPaginationInfo(map, 0));		
		}
		
		// 회사별로 젒속 가능 명단 조회
		List<Map<String, Object>> loginCountPerCmpList = loginListService.loginCountPerCmpList(map); 
		if(loginCountPerCmpList.size() > 0) returnMap.put("loginCountPerCmpList", loginCountPerCmpList);
		else returnMap.put("loginCountPerCmpList", null);
		
		// 역할별 인원수
		List<Map<String, Object>> loginCountPerRoleList = loginListService.loginCountPerRoleList(map); 
		if(loginCountPerRoleList.size() > 0) returnMap.put("loginCountPerRoleList", loginCountPerRoleList);
		else returnMap.put("loginCountPerRoleList", null);
		
		// 역할 리스트
		List<Map<String, Object>> roleList = loginListService.searchRoleList(map); 
		if(roleList.size() > 0) returnMap.put("roleList", roleList);
		else returnMap.put("roleList", null);
				
		return new ResponseVO(returnMap);
	}
	
	
	
	/**
	 * realTimeLog 엑셀 다운로드
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/outExportLoginList")
	@ResponseBody
	public ResponseVO outExportRealTimeLog(@RequestBody Map<String, Object> params) throws Exception {

		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();
        
        List<String> columns = new ArrayList<String>();
        List<String> columnsStd = new ArrayList<String>();
        
        columns.add("");
        columns.add("회사");
        columns.add("이름");
        columns.add("ID");
        columns.add("권한");

        //디바이스 리스트 조회
		resultList = loginListService.searchPortalLoginList(params); 
   
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
        
		Sheet sh = wb.createSheet("Portal_접속가능명단");
		
		Row hd = sh.createRow(1);
		for (int i = 1; i < columns.size(); i++) {
			Cell cell = hd.createCell(i);
			cell.setCellValue(columns.get(i));
			cell.setCellStyle(cellStyle);
			sh.setColumnWidth(i, 13*256);
		}
		
		Cell bodyCell = null;
		Map<String, Object> map = null;
		for (int i = 0; i < resultList.size(); i++) {
			
			map = resultList.get(i);
			
			int cellIdx = 1; // 위에서  columns.add(""); 했으므로, 1 증가(열을 한 칸 오른쪽으로 이동)
			Row row = sh.createRow(i+2);
			
			// 회사
			String compNm = (String)map.get("cmpNm");
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue(compNm);
			bodyCell.setCellStyle(cellStyle);
					
			// 이름 
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)map.get("name"));
			bodyCell.setCellStyle(cellStyle);
			
			// ID
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)map.get("id"));
			bodyCell.setCellStyle(cellStyle);
			
			// 권한
			bodyCell = row.createCell(cellIdx++);
			bodyCell.setCellValue((String)map.get("roleNm"));
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
