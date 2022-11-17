/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 6. 1.         LSH
 */
package kr.co.rpaplatform.dongwon.resrce.web;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import kr.co.rpaplatform.common.pagination.PaginationInfo;
import kr.co.rpaplatform.common.vo.ResponseVO;
import kr.co.rpaplatform.dongwon.common.util.PaginationUtil;
import kr.co.rpaplatform.dongwon.common.vo.CmmnUserVO;
import kr.co.rpaplatform.dongwon.file.vo.AtchFileVO;
import kr.co.rpaplatform.dongwon.orgnzt.vo.UserVO;
import kr.co.rpaplatform.dongwon.resrce.service.PackageService;
import kr.co.rpaplatform.dongwon.resrce.vo.PackageVO;
import kr.co.rpaplatform.dongwon.task.service.TaskService;


/**
 * @author LSH
 * 2020. 6. 1.
 */
@Controller
@RequestMapping("/resrce/package")
public class PackageController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(PackageController.class);
	
	/**
	 * 패키지 서비스
	 */
	@Resource(name="packageService")
	private PackageService packageService;
	
	/**
	 * 페키지메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/packageInfoMain", method = RequestMethod.GET)
	public ModelAndView packageInfoMain() throws Exception {
		ModelAndView mav = new ModelAndView("/resrce/package/packageInfoMain");
		return mav;
	}
	
	/**
	 * 패키지 요청 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getPackageLibraryList")
	@ResponseBody
	public ResponseVO getPackageLibraryList(@RequestBody Map<String, Object> map) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();

		int totalRecordCount = packageService.getPackageLibraryRequstCount(map);
		
		PaginationInfo paginationInfo = PaginationUtil.getPaginationInfo(map, totalRecordCount);
		
		map.put("paginationInfo", PaginationUtil.getPaginationInfo(map, totalRecordCount));

		List<Map<String, Object>> resultList = packageService.getPackageLibraryList(map);

		returnMap.put("resultList", resultList);
		returnMap.put("paginationInfo", paginationInfo);
		
		return new ResponseVO(returnMap);
	}
	
	/**
	 * 패키지 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/getPackageList")
	@ResponseBody
	public ResponseVO getPackageList(@RequestBody Map<String, Object> map) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		String cmpnyCd = map.get("cmpnyCd").toString();
		int skip = Integer.parseInt(map.get("skip").toString());
		int cnt = 0;
		List<Map<String, Object>> lastList = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();
		
		if(cmpnyCd == "" || cmpnyCd == null) {
			
			List<Map<String, Object>> tokenList =  packageService.selectCmpnyCdAll();
			
			if(tokenList != null && tokenList.size() > 0) {

				for(Map<String, Object> tokenResult: tokenList) {
					
					Map<String, Object> responseMap = new HashMap<String, Object>();
					
//					responseMap.put("skip", map.get("skip"));
					responseMap.put("searchKwrd", map.get("searchKwrd"));
					responseMap.put("cmpnyCd", tokenResult.get("cmpnyCd"));
					
					//패키지 가져오기
					Map<String, Object> tempMap = packageService.getPackageAllList(responseMap);
					
					List<Map<String, Object>> packageList = (List<Map<String, Object>>)tempMap.get("value");
					cnt += Integer.parseInt(tempMap.get("@odata.count").toString());		   	
					if(packageList != null && packageList.size() > 0) {

						for(Map<String, Object> result: packageList) {						
							result.put("cmpnyCd", tokenResult.get("cmpnyCd"));
							result.put("cmpnyNm", tokenResult.get("cmpnyNm"));
							lastList.add(result);;
						}
					}				
				}
				
				//마지막페이지 구분 처리
				if(cnt - skip > 10 || cnt - skip == 0) {
					for(int i=skip ; i < skip+10 ; i++) {
						resultList.add(lastList.get(i));
					}
				} else {
					for(int i=skip ; i < cnt ; i++) {
						resultList.add(lastList.get(i));
					}
				}
				
			}
			
		} else {
			List<Map<String, Object>> tokenList =  packageService.selectCmpnyCd(map);
			
			if(tokenList != null && tokenList.size() > 0) {
				Map<String, Object> tempMap = packageService.getPackageList(map);
				
				List<Map<String, Object>> packageList = (List<Map<String, Object>>)tempMap.get("value");
				cnt = Integer.parseInt(tempMap.get("@odata.count").toString());
				
				for(Map<String, Object> result: packageList) {						
					result.put("cmpnyCd", tokenList.get(0).get("cmpnyCd"));
					result.put("cmpnyNm", tokenList.get(0).get("cmpnyNm"));
					resultList.add(result);;
				}
			}
		}
		
		PaginationInfo paginationInfo = PaginationUtil.getPaginationInfo(map, cnt);
		
		map.put("paginationInfo", PaginationUtil.getPaginationInfo(map, cnt));
		
		returnMap.put("resultList", resultList);
		returnMap.put("paginationInfo", paginationInfo);
		
		return new ResponseVO(returnMap);
	}
	
	/**
	 * 라이브러리 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getLibraryList")
	@ResponseBody
	public ResponseVO getLibraryList(@RequestBody Map<String, Object> map, HttpServletRequest request) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		CmmnUserVO cmmnUserVO = (CmmnUserVO)request.getSession().getAttribute("sessionUserInfo");
		
		String cmpnyCd = cmmnUserVO.getTxCmpnyCd();
		map.put("cmpnyCd", cmpnyCd);
		
//		List<Map<String, Object>> resultList = packageService.getPackageList(map);
		Map<String, Object> tempMap = packageService.getLibraryList(map);
		
		List<Map<String, Object>> resultList = (List<Map<String, Object>>)tempMap.get("value");
		int cnt = Integer.parseInt(tempMap.get("@odata.count").toString());
		
		PaginationInfo paginationInfo = PaginationUtil.getPaginationInfo(map, cnt);
		
		map.put("paginationInfo", PaginationUtil.getPaginationInfo(map, cnt));
		
		returnMap.put("resultList", resultList);
		returnMap.put("paginationInfo", paginationInfo);
		
		return new ResponseVO(returnMap);
	}
	
	/**
	 * 패키지버전관리 페이지
	 */
	@RequestMapping(value="/packageVerMng",  method = RequestMethod.GET)
	public ModelAndView packageVerMng() throws Exception{
		ModelAndView mav = new ModelAndView("/resrce/package/packageVerMng");
		return mav;
	}
	
	/**
	 * 패키지이력보기 페이지
	 */
	@RequestMapping(value="/packageHistInqire",  method = RequestMethod.GET)
	public ModelAndView packageHistInqire() throws Exception{
		ModelAndView mav = new ModelAndView("/resrce/package/packageHistInqire");
		return mav;
	}
	
	/**
	 * 패키지 버전정보조회 
	 */
	@RequestMapping(value="/packageVersionInfoList")
	@ResponseBody
	public ResponseVO packageVerList(@RequestParam("processId") String processId, @RequestParam("cmpnyCd") String cmpnyCd) throws Exception{
		logger.debug("PackageController packageVerList started !!!");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("processId", processId);
		map.put("cmpnyCd", cmpnyCd);
		
		List<Map<String, Object>> resultList = packageService.packageVerList(map);
		
		return new ResponseVO(resultList);
	}

	/**
	 * 라이브러리 버전정보조회 
	 */
	@ResponseBody
	@RequestMapping(value="/libraryVersionInfoList")
	public ResponseVO libraryVerList(@RequestParam("packageId") String packageId, HttpServletRequest request) throws Exception{
		logger.debug("PackageController libraryVerList started !!!");
		
		Map<String, Object> map = new HashMap<String, Object>();
		CmmnUserVO cmmnUserVO = (CmmnUserVO)request.getSession().getAttribute("sessionUserInfo");
		
		String cmpnyCd = cmmnUserVO.getTxCmpnyCd();
		map.remove("cmpnyCd");
		map.put("packageId", packageId);
		map.put("cmpnyCd", cmpnyCd);
		
		List<Map<String, Object>> resultList = packageService.libraryVerList(map);
		
		return new ResponseVO(resultList);
	}
	
	/**
	 * 패키지, 라이브러리 이력조회 
	 */
//	@ResponseBody
//	@RequestMapping(value="/packageLibraryHistInqireList", method = RequestMethod.POST)
//	public ResponseVO packageHistList(@RequestBody Map<String, Object> map) throws Exception{
//		logger.debug("PackageController packageLibraryHistInqireList started !!!");
//		
//		Map<String, Object> returnMap = new HashMap<String, Object>();
//		
//		List<PackageVO> resultList = packageService.packageLibraryHistInqireList(map);
//		
//		returnMap.put("resultList", resultList);
//		return new ResponseVO(returnMap);
//	}
	
	public void writeToFile(String filename, byte[] pData)
	{
	    if(pData == null){
	        return;
	    }

	    int lByteArraySize = pData.length;

	    try{

	        File lOutFile = new File("C:\\Users\\dw\\Desktop\\"+filename);
	        FileOutputStream lFileOutputStream = new FileOutputStream(lOutFile);
	        lFileOutputStream.write(pData);
	        lFileOutputStream.close();
	    }catch(Throwable e){
	        e.printStackTrace(System.out);
	    }
	}

	/**
	 * 패키지 다운로드
	 */
	@RequestMapping(value="/packageDownload", method = RequestMethod.GET)
	public ResponseEntity<byte[]> packageDownload(@RequestParam("processKey") String processKey, @RequestParam("version") String version, HttpServletRequest request) throws Exception{
		logger.debug("PackageController packageDownload started !!!");
		
		CmmnUserVO cmmnUserVO = (CmmnUserVO)request.getSession().getAttribute("sessionUserInfo");
		String cmpnyCd = cmmnUserVO.getTxCmpnyCd();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("processKey", processKey);
		map.put("version", version);
		map.put("cmpnyCd", cmpnyCd);
		ResponseEntity<byte[]> response = packageService.packageDownload(map);
		
		HttpHeaders responseHeaders = new HttpHeaders();

		responseHeaders.set("Content-Type", "application/octet-stream");
		responseHeaders.set("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
		responseHeaders.set("Pragma", "no-cache");
		responseHeaders.set("Expires", "-1");	
		responseHeaders.set("Content-Transfer-Encoding", "binary");
		responseHeaders.set("Content-Disposition", "attachment");
		//responseHeaders.set("charset", "ANSI");	
		// 지우지 말 것(개발 진행시 테스트 용)
		//writeToFile("test.nupkg", response.getBody());

		ResponseEntity<byte[]> res = new ResponseEntity(response.getBody(), responseHeaders, HttpStatus.OK);
		
		return res;
	}
 	
	/**
	 * 패키지 등록 페이지
	 */
	@RequestMapping(value="/packageRegPop",  method = RequestMethod.GET)
	public ModelAndView packageRegPop() throws Exception{
		ModelAndView mav = new ModelAndView("/resrce/package/packageRegPop");
		return mav;
	}
	
	/**
	 * 패키지 등록
	 * @param map
	 * @throws Exception
	 */
	@RequestMapping(value="/registerPackage",  method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO registerPackage(@RequestParam("file") MultipartFile multipartFile, @RequestParam("cmpnyCd") String cmpnyCd) throws Exception {
		
		this.logger.debug("PackageController registerPackage start!!");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cmpnyCd", cmpnyCd);
		
		List<Map<String, Object>> response = packageService.registerPackage(multipartFile, map);
		this.logger.debug("PackageController registerPackage end!!");
		
		return new ResponseVO(response);
	}	
	
	/**
	 * 패키지 삭제
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/deletePackage")
	@ResponseBody
	public ResponseVO deletePackage(@RequestBody Map<String, Object> map) throws Exception {
		
		this.logger.debug("PackageController deletePackage start!!");
		
		Map<String, Object> response = packageService.deletePackage(map);
		

		
		this.logger.debug("PackageController deletePackage end!!");
		
		return new ResponseVO(response);
	}
	

	
	/**
	 * 라이브러리 등록
	 *  * @param map
	 * @throws Exception
	 */
	@RequestMapping(value="/registerLibrary",  method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO registerLibrary(@RequestParam("file") MultipartFile multipartFile, HttpServletRequest request) throws Exception {
		
		this.logger.debug("PackageController registerLibrary start!!");

		Map<String, Object> map = new HashMap<String, Object>();
		CmmnUserVO cmmnUserVO = (CmmnUserVO)request.getSession().getAttribute("sessionUserInfo");
		
		String cmpnyCd = cmmnUserVO.getTxCmpnyCd();
		map.remove("cmpnyCd");
		map.put("cmpnyCd", cmpnyCd);
		
		List<Map<String, Object>> response = packageService.registerLibrary(multipartFile, map);
		this.logger.debug("PackageController registerLibrary end!!");
		
		return new ResponseVO();
	}	
	
	/**
	 * 패키지 업그레이드 페이지
	 */
	@RequestMapping(value="/packageUpgradePop",  method = RequestMethod.GET)
	public ModelAndView packageUpgradePop() throws Exception{
		ModelAndView mav = new ModelAndView("/resrce/package/packageUpgradePop");
		return mav;
	}
	
	/**
	 * 패키지 업그레이드 프로세스 조회
	 */
	@ResponseBody
	@RequestMapping(value="/processUpdateList")
	public ResponseVO processUpdateList(@RequestParam("id") String id, @RequestParam("cmpnyCd") String cmpnyCd) throws Exception{
		logger.debug("PackageController processUpdateList started !!!");
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("cmpnyCd", cmpnyCd);
		
		List<Map<String, Object>> resultList = packageService.processUpdateList(map);
		
		returnMap.put("resultList", resultList);
		return new ResponseVO(returnMap);
	}
	
	/**
	 * 패키지 버전 업데이트
	 * @param map
	 * @throws Exception
	 */
	@RequestMapping(value="/updatePackageLatest",  method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO updatePackageLatest(@RequestBody Map<String, Object> map) throws Exception {
		
		this.logger.debug("PackageController updatePackageLatest start!!");
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		Map<String, Object> result = packageService.updatePackageLatest(map);
		returnMap.put("result", result);
		
		this.logger.debug("PackageController updatePackageLatest end!!");
		
		return new ResponseVO(returnMap);
	}
}
