/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 7. 14.         LSH        최초 작성
 */
package kr.co.rpaplatform.dongwon.resrce.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.co.rpaplatform.common.exception.RpaException;
import kr.co.rpaplatform.dongwon.common.cont.Const;
import kr.co.rpaplatform.dongwon.resrce.dao.PackageDAO;
import kr.co.rpaplatform.dongwon.resrce.vo.PackageVO;
import kr.co.rpaplatform.dongwon.task.vo.TaskPrcuseSysVO;
import kr.co.rpaplatform.dongwon.task.vo.TaskReviewVO;
import kr.co.rpaplatform.dongwon.task.vo.TaskVO;
import kr.co.rpaplatform.rpaapi.uipath.api.LibrariesApi;
import kr.co.rpaplatform.rpaapi.uipath.api.PackageApi;
import kr.co.rpaplatform.rpaapi.uipath.api.ReleasesApi;

/**
 * 과제 서비스
 * @author LSH
 */
@Service
public class PackageService {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(PackageService.class);

	/**
	 * 패키지 DAO
	 */
	@Resource(name="packageDAO")
	private PackageDAO packageDAO;
	
	/**
	 * 패키지 API
	 */
	@Resource(name="packageApi")
	private PackageApi packageApi;
	
	/**
	 * 라이브러리 API
	 */
	@Resource(name="librariesApi")
	private LibrariesApi librariesApi;

	/**
	 * 릴리즈 API
	 */
	@Resource(name="releasesApi")
	private ReleasesApi releasesApi;
	
	/**
	 * cmpnyCd 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCmpnyCdAll() throws Exception {
		return packageDAO.selectCmpnyCdAll();
	}
	
	/**
	 * cmpnyCd 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCmpnyCd(Map<String, Object> map) throws Exception {
		return packageDAO.selectCmpnyCd(map);
	}
	
	/**
	 * 패키지, 라이브러리 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getPackageLibraryList(Map<String, Object> map) throws Exception {
		return packageDAO.selectPackageLibraryList(map);
	}
	
	/**
	 * 패키지, 라이브러리 리스트 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int getPackageLibraryRequstCount(Map<String, Object> map) throws Exception {
		return packageDAO.selectPackageLibraryRequstCount(map);
	}
	
	/**
	 * 패키지 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getPackageAllList(Map<String, Object> map) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		returnMap = packageApi.getPackageAllList(map);
		
		return returnMap;
	}
	
	/**
	 * 패키지 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getPackageList(Map<String, Object> map) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		returnMap = packageApi.getPackageList(map);
		
		return returnMap;
	}
	
	/**
	 * 라이브러리 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getLibraryList(Map<String, Object> map) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		returnMap = librariesApi.getLibraryList(map);
		
		return returnMap;
	}
	
	
	/**
	 * 패키지 버전정보조회
	 * @param taskNo
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> packageVerList(Map<String, Object> map) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		returnMap = packageApi.selectProcessVersionAPIList(map);
		
		return (List<Map<String, Object>>)returnMap.get("value");
	}
	
	/**
	 * 라이브러리 버전정보조회
	 * @param taskNo
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> libraryVerList(Map<String, Object> map) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		returnMap = librariesApi.selectLibraryVersionAPIList(map);
		
		return (List<Map<String, Object>>)returnMap.get("value");
	}
	
	/**
	 * 패키지, 라이브러리 이력조회
	 * @param taskNo
	 * @return
	 * @throws Exception
	 */
//	public List<PackageVO> packageLibraryHistInqireList(Map<String, Object> map) throws Exception {
//		return packageDAO.packageLibraryHistInqireList(map);
//	}
	
	/**
	 * 패키지 다운로드
	 */
	public ResponseEntity<byte[]> packageDownload(Map<String, Object> map) throws Exception {
		ResponseEntity<byte[]> response = packageApi.packageDownload(map);
		return response;
	}
	
	/**
	 * 패키지 등록
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> registerPackage(MultipartFile multipartFile, Map<String, Object> map) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		String fullName = multipartFile.getOriginalFilename().toString();
		fullName = fullName.substring(0, fullName.length()-6);
		String[] subName = fullName.split("\\.");
		String name = subName[0];
		String version = "";
		for(int i = 1 ; i < subName.length ; i++) {
			version += subName[i];
			if(i != subName.length-1) {
				version += ".";
			}
		}
		
		Map<String, Object> requestMap = new HashMap<String, Object>();
		requestMap.put("identifier", name);
		requestMap.put("version", version);
		
		Map<String, Object> checkForExistPack = new HashMap<String, Object>();
		checkForExistPack.put("identifier", name);
		checkForExistPack.put("version", version);
		checkForExistPack.put("cmpnyCd", map.get("cmpnyCd").toString());

		
		Map<String, Object> packageMap = packageApi.isExistPackageProcessVersion(checkForExistPack);
		
		int chkProcess = Integer.parseInt(packageMap.get("@odata.count").toString());
		
		//int chkProcess = packageDAO.chkProcess(requestMap);
		
		if(chkProcess > 0) {
			//이미 등록된 패키지 입니다.
			throw new RpaException("E00004", "이미 등록된 패키지 입니다.");
		} else {
			returnMap = packageApi.registerPackage(multipartFile, map);
		}
		
		return (List<Map<String, Object>>) returnMap.get("value");
	}
	
	/**
	 * 패키지 삭제
	 * @param map
	 * @throws Exception
	 */
	public Map<String, Object> deletePackage(Map<String, Object> map) throws Exception {	
		Map<String, Object> returnMap = new HashMap<String, Object>();
		returnMap = packageApi.deletePackage(map);
		return returnMap;
	}

	/**
	 * 라이브러리 등록
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> registerLibrary(MultipartFile multipartFile, Map<String, Object> map) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		String fullName = multipartFile.getOriginalFilename().toString();
		fullName = fullName.substring(0, fullName.length()-6);
		String[] subName = fullName.split("\\.");
		String name = subName[0];
		String version = "";
		for(int i = 1 ; i < subName.length ; i++) {
			version += subName[i];
			if(i != subName.length-1) {
				version += ".";
			}
		}
		
		Map<String, Object> requestMap = new HashMap<String, Object>();
		requestMap.put("identifier", name);
		requestMap.put("version", version);
		
		int chkLibrary = packageDAO.chkProcess(requestMap);
		
		if(0 < chkLibrary) {
			//이미 등록된 라이브러리 입니다.
			throw new RpaException("E00005", "이미 등록된 라이브러리입니다.");
		}
		
		returnMap = librariesApi.registerLibrary(multipartFile, map);
		return (List<Map<String, Object>>) returnMap.get("value");
	}
	
	/**
	 * 패키지 업그레이드 프로세스 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> processUpdateList(Map<String, Object> map) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		returnMap = releasesApi.getUpgradeReleases(map);
		return (List<Map<String, Object>>) returnMap.get("value");
	}
	
	/**
	 * 패키지 버전 업데이트
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> updatePackageLatest(Map<String, Object> map) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		returnMap = releasesApi.updatePackageLatest(map);
		return returnMap;
	}
}
