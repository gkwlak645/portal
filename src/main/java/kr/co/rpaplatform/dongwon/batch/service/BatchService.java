package kr.co.rpaplatform.dongwon.batch.service;

import java.io.File;
import java.io.FileFilter;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import kr.co.rpaplatform.dongwon.batch.dao.BatchDao;
import kr.co.rpaplatform.dongwon.stdrinfo.dao.CmmnCdDAO;

@Service
public class BatchService {
	private final Logger logger = LoggerFactory.getLogger(BatchService.class);
	
	/**
	 * 메뉴 DAO
	 */
	@Resource(name="cmmnCdDAO")
	private CmmnCdDAO cmmnCdDAO;
	
	
	
	@Resource(name="batchDao")
	private BatchDao batchDao;
	
	@Value("${executDscntcImg.basic.path}")
	private String executDscntcImgBasicPath;
	
	@Value("${executDscntcImg.move.path}")
	private String executDscntcImgMovePath;
	
			
	
	/*
	 * 동원 부서 동기화
	 */
	public void syncDongwonDept() throws Exception {
		//동원 부서정보 가져오기
		List<Map<String, Object>> aReturnDept = batchDao.getDongwonDeptList();
		
		//PORTAL에 부서정보 입력
		int iaReturnDept = aReturnDept.size();
		for(int i = 0; i < iaReturnDept; i++) {
			batchDao.syncDongwonDept(aReturnDept.get(i));
		}
	}
	
	
	/*
	 * 동원 사용자 동기화
	 */
	public void syncDongwonUser() throws Exception {
		//동원 부서정보 가져오기
		List<Map<String, Object>> aReturnDept = batchDao.getDongwonUserList();
		
		//PORTAL에 부서정보 입력
		int iaReturnDept = aReturnDept.size();
		for(int i = 0; i < iaReturnDept; i++) {
			batchDao.syncDongwonUserBas(aReturnDept.get(i));
			batchDao.syncDongwonUserDetail(aReturnDept.get(i));
		}
	}
	
	/*
	 * 커뮤니티 > 실행 중단 이미지
	 */
	public void syncExecutDscntcImg(){
		File dir = new File(executDscntcImgBasicPath);
		
		String moveBasicPath = executDscntcImgMovePath;
		
		if (!dir.exists()) {
			dir.mkdirs();
		}
		
		//파일만
		FileFilter filter = new FileFilter() {
		    public boolean accept(File f) {
		        return !f.isDirectory();
		    }
		};

		File files[] = dir.listFiles(filter);
		
		
		//I00101_robot1_20200908_130301.jpg
		//String sTestFileName = "I00101_robot1_20200908_130301.jpg";
		//String sA = sTestFileName.substring(0, sTestFileName.lastIndexOf('.'));
		//int iB = sA.lastIndexOf('_');
		//String sF = sA.substring(0, 1);				//회사코드
		//String sE = sA.substring(0, 6);				//프로세스코드
		//String sG = sA.substring(7, iB - 9);		//로봇명
		//String sD = sA.substring(iB - 8, iB );		//년월일
		//String sC = sA.substring(iB + 1, iB + 7);	//시간
		
		

		for (int i = 0; i < files.length; i++) {
			File file = files[i];
			
			//파일 이름 분석
			String sFileName = file.getName();
			String sA = sFileName.substring(0, sFileName.lastIndexOf('.'));
			int iB = sA.lastIndexOf('_');
			String sF = sA.substring(0, 1);				//회사코드
			String sE = sA.substring(0, 6);				//프로세스코드
			String sG = sA.substring(7, iB - 9);		//로봇명
			String sD = sA.substring(iB - 8, iB);		//년월일
			String sC = sA.substring(iB + 1, iB + 7);	//시간
			
			//디렉토리 미존재시 생성
			File movePath = new File(moveBasicPath + File.separator  + sD.substring(0, 4) + File.separator  + sD.substring(4, 8) );
			if (!movePath.exists()) {
				movePath.mkdirs();
			}
			
			//파일 이동
			String sFileCours = File.separator  + sD.substring(0, 4) + File.separator  + sD.substring(4, 8)  +  File.separator + System.currentTimeMillis() + "." + sFileName.substring(sFileName.lastIndexOf('.') + 1);
			File fileToMove = FileUtils.getFile(moveBasicPath +  sFileCours);
			try {
				//로봇 아이디 검색
				Map<String, Object> params = new HashMap<String, Object>();
				params.put("cmpnyCd", sF);
				params.put("cmpnyexecutDscntcDt", sD + " " + sC.substring(0, 2) + ":" + sC.substring(2, 4) + ":" + sC.substring(4, 6));
				params.put("processCd", sE);
				params.put("robotNm", sG);
				params.put("fileCours", sFileCours);
				params.put("fileNm", sFileName);
				
				//정보 저장
				batchDao.insertSyncExecutDscntcImg(params);
				
				//파일 이동
				FileUtils.moveFile(file, fileToMove);
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	    }
	}
	
	public void syncArcLogs() throws Exception {
		//동원 부서정보 가져오기
		batchDao.syncArcLogs();
	}
}
