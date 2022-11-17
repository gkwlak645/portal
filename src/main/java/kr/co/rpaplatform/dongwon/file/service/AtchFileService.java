package kr.co.rpaplatform.dongwon.file.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.MDC;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import kr.co.rpaplatform.dongwon.file.dao.AtchFileDAO;
import kr.co.rpaplatform.dongwon.file.vo.AtchFileVO;
import kr.co.rpaplatform.dongwon.stdrinfo.service.TaskTmplatMngService;


/**
 * 첨부파일 서비스
 * @author jw.lee
 *
 */
@Service
public class AtchFileService {
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(AtchFileService.class);
	
	/**
	 * 첨부파일 DAO
	 */
	@Resource(name="atchFileDAO")
	private AtchFileDAO atchFileDAO;
	
	/**
	 * 첨부파일 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public AtchFileVO getAtchmnfl(Map<String, Object> map) throws Exception {
		return atchFileDAO.selectAtchmnfl(map);
	}
	
	/**
	 * 첨부파일목록조회
	 * @param fileGrpNo
	 * @return
	 * @throws Exception
	 */
	public List<AtchFileVO> getAtchmnflList(int fileGrpNo) throws Exception {
		return atchFileDAO.selectAtchmnflList(fileGrpNo);
	}
	
	/**
	 * 첨부파일업로드 처리
	 * @param fileGrpNo
	 * @param fileNoArray
	 * @param uploadFileList
	 * @return
	 * @throws Exception
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public Map<String, Object> processUpload(Integer fileGrpNo, Integer[] fileNoArray, List<AtchFileVO> uploadFileList) throws Exception {
		
		List<AtchFileVO> deleteFileList = null;	//삭제 파일 목록
		
		if (fileGrpNo == 0) {	//최초등록인 경우
			
			//파일그룹번호 채번
			fileGrpNo = atchFileDAO.selectNextFileGrpNo();
		} else {	//수정인 경우
			Map<String, Object> inputMap = new HashMap<String, Object>();
			inputMap.put("fileGrpNo", fileGrpNo);
			inputMap.put("fileNoArray", fileNoArray);
			
			//삭제 파일정보 조회 
			deleteFileList = atchFileDAO.selectDeleteFile(inputMap);
			
			//삭제 파일번호 데이터 삭제
			atchFileDAO.deleteAtchmnfl(inputMap);
			
		}
		
		//업로드 데이터 등록
		if (uploadFileList != null && uploadFileList.size() > 0) {
			
			int fileNo = atchFileDAO.selectNextFileNo(fileGrpNo);
			
			for (AtchFileVO atchUploadFileVO : uploadFileList) {
				
				atchUploadFileVO.setFileGrpNo(fileGrpNo);
				atchUploadFileVO.setFileNo(fileNo);
				atchUploadFileVO.setCreatUsr(MDC.get("txUserId"));
				
				atchFileDAO.insertAtchmnfl(atchUploadFileVO);
				
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("fileGrpNo", fileGrpNo.toString());
				atchFileDAO.updateDtAtchmnfl(map);
			
				fileNo = fileNo + 1;
			}
		}
		
		//전체 업로드 데이터 조회
		List<AtchFileVO> atchmnflList = atchFileDAO.selectAtchmnflList(fileGrpNo);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("atchmnflList", atchmnflList);
		resultMap.put("deletedFileList", deleteFileList);
		
		return resultMap;
	}
	
	
	/**
	 * 파일그룹번호 채번
	 * @return
	 * @throws Exception
	 */
	public int getNextFileGrpNo() throws Exception {
		return atchFileDAO.selectNextFileGrpNo();
	}
	
	/**
	 * 해당 파일그룹의 파일 삭제
	 * @param fileGrpNo
	 * @return
	 * @throws Exception
	 */
	public List<AtchFileVO> deleteFile(int fileGrpNo) throws Exception {
		List<AtchFileVO> deleteFileList = null;	//삭제 파일 목록 
		
		Map<String, Object> inputMap = new HashMap<String, Object>();
		inputMap.put("fileGrpNo", fileGrpNo);
		inputMap.put("fileNoArray", null);
		
		//삭제 파일정보 조회 
		deleteFileList = atchFileDAO.selectDeleteFile(inputMap);
		
		//삭제 파일번호 데이터 삭제
		atchFileDAO.deleteAtchmnfl(inputMap);
		
		return deleteFileList;
	}
	
	public int templateUploadChk(int iFileGrpNo) throws Exception {
		return atchFileDAO.templateUploadChk(iFileGrpNo);
	}
}
