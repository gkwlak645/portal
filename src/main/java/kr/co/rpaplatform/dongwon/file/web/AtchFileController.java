package kr.co.rpaplatform.dongwon.file.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import kr.co.rpaplatform.common.exception.RpaException;
import kr.co.rpaplatform.common.util.DateUtil;
import kr.co.rpaplatform.common.vo.ResponseVO;
import kr.co.rpaplatform.dongwon.file.service.AtchFileService;
import kr.co.rpaplatform.dongwon.file.vo.AtchFileVO;


/**
 * 첨무파일 컨트롤러
 * @author jw.lee
 *
 */
@Controller
@RequestMapping(value="/file")
public class AtchFileController {

	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(AtchFileController.class);
	
	/**
	 * 업로드 한 파일당 최대 사이즈
	 */
	@Value("${file.upload.maxfilesize}")
	private long maxFileSize;
	
	/**
	 * 업로드 한 전체 파일 최대 사이즈
	 */
	@Value("${file.totalupload.maxfilesize}")
	private long maxTotalFileSize;

	/**
	 * 업로드 경로
	 */
	@Value("${file.upload.path}")
	private String uploadPath;
	
	/**
	 * 로봇이미지 경로
	 */
	@Value("${robot.image.path}")
	private String robotImagePath;
	
	/**
	 * 임시 다운로드 경로
	 */
	@Value("${file.tmpdownload.path}")
	private String downloadPath;
	
	/**
	 * 첨부파일 서비스
	 */
	@Resource(name="atchFileService")
	private AtchFileService atchFileService;
	
	
	
	/**
	 * 첨부파일 목록 조회  
	 * @param fileGrpNo
	 * @return
	 * @throws Exception
	 * uploadAtchmnfl와 리턴 형이 달라 file-upload에서 오류가 나타나 수정
	 */
	@RequestMapping(value="/getAtchmnflList")
	@ResponseBody
	public ResponseVO getAtchmnflList(@RequestBody Map<String, Object> params) throws Exception {
		logger.debug("AtchFileController getAtchmnflList started !!!");
		
		int fileGrpNo = 0;
		if (params != null && params.get("fileGrpNo") != null) {
			fileGrpNo = (Integer)params.get("fileGrpNo");
		}
		
		List<AtchFileVO> atchFileList = null;
		atchFileList = atchFileService.getAtchmnflList(fileGrpNo);
		logger.debug("AtchFileController getAtchmnflList end !!!");
		
		return new ResponseVO(atchFileList);
	}
	
	/**
	 * 첨부파일 업로드
	 * @param request
	 * @param multipartRequest
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/uploadAtchmnfl", method=RequestMethod.POST)
	@ResponseBody
	public ResponseVO uploadAtchmnfl(HttpServletRequest request, MultipartHttpServletRequest multipartRequest) throws Exception {
		logger.debug("AtchFileController uploadAtchmnfl started !!!");
		List<MultipartFile> multipartFileList = multipartRequest.getFiles("file");
		
		//파일 업로드
		List<AtchFileVO> uploadFileList = (List<AtchFileVO>)storeUploadFileList(multipartFileList);
		
		int fileGrpNo = 0;	//파일그룹번호
		if (request.getParameter("fileGrpNo") != null && !"".equals(request.getParameter("fileGrpNo"))) {	//수정인 경우
			fileGrpNo = Integer.parseInt(request.getParameter("fileGrpNo"));
		}
		
		Integer[] fileNoArray = null;
		String[] fileNos = request.getParameterValues("fileNo");
		
		if (fileNos != null && fileNos.length > 0) {
			fileNoArray = new Integer[fileNos.length];
			
			for (int i = 0; i <= fileNos.length - 1; i++) { /*"="파일 2개 이상 지울시 지워지지 않아 추가*/

					fileNoArray[i] = Integer.parseInt(fileNos[i]);

			}
		}
		
		//업로드 정보 저장 및 전체 업로드 정보 조회
		Map<String, Object> resultMap = atchFileService.processUpload(fileGrpNo, fileNoArray, uploadFileList);
		
		List<AtchFileVO> atchmnflList = null;
		
		if (resultMap != null && !resultMap.isEmpty()) {
			
			//삭제된 파일이 있는 경우 실제 파일 삭제 처리
			deleteUploadFileList((List<AtchFileVO>)resultMap.get("deletedFileList"));
			
			//파일 정보
			atchmnflList = (List<AtchFileVO>)resultMap.get("atchmnflList");
		}
		logger.debug("AtchFileController uploadAtchmnfl end !!!");
		return new ResponseVO(atchmnflList);
	}
	
	
	/**
	 * 첨부파일 다운로드
	 * @param request
	 * @param multipartRequest
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/downloadAtchmnfl", method=RequestMethod.POST)
	public ModelAndView downloadAtchmnfl(@RequestParam("fileGrpNo") String fileGrpNo, @RequestParam("fileNo") String fileNo) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("fileGrpNo", fileGrpNo);
		map.put("fileNo", fileNo);
		
		AtchFileVO atchUploadFileVO = atchFileService.getAtchmnfl(map);

		String filePath = atchUploadFileVO.getSavePath() + File.separator + atchUploadFileVO.getSaveFileNm();
		File downloadFile = new File(filePath);
		
		if (!downloadFile.exists()) {
			throw new RpaException("E104");
		}
		
		ModelAndView mav = new ModelAndView("downloadView");
		mav.addObject("downloadFile", downloadFile);
		mav.addObject("oriFileNm", atchUploadFileVO.getOriFileNm());
		
		return mav;
	}
	
	@RequestMapping(value="/downloadUrlAtchmnfl", method=RequestMethod.GET)
	public ModelAndView downloadUrlAtchmnfl(@RequestParam("fileGrpNo") String fileGrpNo, @RequestParam("fileNo") String fileNo) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("fileGrpNo", fileGrpNo);
		map.put("fileNo", fileNo);
		
		AtchFileVO atchUploadFileVO = atchFileService.getAtchmnfl(map);

		String filePath = atchUploadFileVO.getSavePath() + File.separator + atchUploadFileVO.getSaveFileNm();
		File downloadFile = new File(filePath);
		
		if (!downloadFile.exists()) {
			throw new RpaException("E104");
		}
		
		ModelAndView mav = new ModelAndView("downloadView");
		mav.addObject("downloadFile", downloadFile);
		mav.addObject("oriFileNm", atchUploadFileVO.getOriFileNm());
		
		return mav;
	}
	
	/**
	 * 파일리스트 삭제
	 * @param deletedFileList
	 * @return
	 * @throws Exception
	 */
	private void deleteUploadFileList(List<AtchFileVO> deletedFileList) throws Exception {
		
		if (deletedFileList != null && deletedFileList.size() > 0) {
			for (AtchFileVO atchUploadFileVO : deletedFileList) {
				String path = atchUploadFileVO.getSavePath() + File.separator + atchUploadFileVO.getSaveFileNm();
				File file = new File(path);
				if (file.exists()) {
					file.delete();
				}
			}
		}
	}
	
	/**
	 * 파일리스트 저장
	 * @param multipartFileList
	 * @return
	 * @throws Exception
	 */
	private List<AtchFileVO> storeUploadFileList(List<MultipartFile> multipartFileList) throws Exception {
		
		List<AtchFileVO> uploadFileList = new ArrayList<AtchFileVO>();
		
		if (multipartFileList != null && multipartFileList.size() > 0) {
			
			//전체 파일 사이즈 체크
			checkTotalFileSize(multipartFileList);
			
			for (MultipartFile multipartFile : multipartFileList) {
				AtchFileVO atchUploadFileVO = saveFile(multipartFile);
				uploadFileList.add(atchUploadFileVO);
			}
		}
		
		return uploadFileList;
	}
	
	/**
	 * 
	 * @param multipartFile
	 * @throws Exception
	 */
	private AtchFileVO saveFile(MultipartFile multipartFile) throws Exception {
		
		//파일 사이즈 체크
		checkFileSize(multipartFile.getSize());
		
		//저장 파일명 생성
		String saveFileNm = UUID.randomUUID().toString();
		logger.debug("saveFileNm : {}", saveFileNm);
		
		//파일저장 경로 생성
		String savePath = uploadPath + File.separator + DateUtil.getCurrentDe();
		
		//디렉토리 미존재시 생성
		File directory = new File(savePath);
		if (!directory.exists()) {
			directory.mkdirs();
		}

		//파일 정보 설정
		AtchFileVO atchUploadFileVO = new AtchFileVO();
		atchUploadFileVO.setSaveFileNm(saveFileNm);
		atchUploadFileVO.setOriFileNm(multipartFile.getOriginalFilename());
		atchUploadFileVO.setSavePath(savePath);
		atchUploadFileVO.setFileSz((int)multipartFile.getSize());
		
		logger.debug("파일저장 정보 : {}", atchUploadFileVO.toString());

		/*
		 * 파일 저장 
		 */
		File file = new File(savePath + File.separator + saveFileNm);
		
		multipartFile.transferTo(file);
		
		return atchUploadFileVO;
	}
	
	/**
	 * 파일 사이즈 체크
	 * @param size
	 */
	private void checkFileSize(long size) throws Exception {
		
		logger.debug("size : {}", size);
		logger.debug("maxFileSize : {}", maxFileSize);
		if (size > maxFileSize) {
			throw new RpaException("err.401",  new String[] {""+maxFileSize});
		}
	}
	
	/**
	 * 전체 파일 사이즈 체크
	 * @param multipartFileList
	 * @throws Exception
	 */
	private void checkTotalFileSize(List<MultipartFile> multipartFileList) throws Exception {
		
		long totalFileSize = 0;
		
		if (multipartFileList != null && multipartFileList.size() > 0) {
			
			for (MultipartFile multipartFile : multipartFileList) {
				
				totalFileSize += multipartFile.getSize();
			}
		}
		
		if (totalFileSize > maxTotalFileSize) {
			throw new RpaException("err.402", new String[] {""+maxTotalFileSize});
		}

	}
	
	/**
	 * 로봇중단이미지 조회
	 * @param response
	 * @param fileName
	 * @throws Exception
	 */
	@RequestMapping(value = "/getRobotImage", method=RequestMethod.GET)
	public void getStudentPhoto(HttpServletResponse response, @RequestParam("filePath") String filePath, @RequestParam("fileName") String fileName) throws Exception {
		
	    String filePathName = robotImagePath + File.separator + filePath+  File.separator + fileName;
	    logger.debug("filePathName : {}", filePathName);

		InputStream inputStream = new FileInputStream(filePathName);
		
		response.setContentType("image/jpeg");
		IOUtils.copy(inputStream, response.getOutputStream());
	}
	
	/**
	 * 템플릿 덮어쓰기
	 * @param request
	 * @param multipartRequest
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/templateUploadAtchmnfl", method=RequestMethod.POST)
	@ResponseBody
	public ResponseVO templateUploadAtchmnfl(HttpServletRequest request, MultipartHttpServletRequest multipartRequest) throws Exception {
		logger.debug("AtchFileController uploadAtchmnfl started !!!");
		List<MultipartFile> multipartFileList = multipartRequest.getFiles("file");
		
		//파일 업로드
		List<AtchFileVO> uploadFileList = (List<AtchFileVO>)storeUploadFileList(multipartFileList);
		
		int fileGrpNo = 0;	//파일그룹번호
		if (request.getParameter("fileGrpNo") != null && !"".equals(request.getParameter("fileGrpNo"))) {	//수정인 경우
			fileGrpNo = Integer.parseInt(request.getParameter("fileGrpNo"));
			if(atchFileService.templateUploadChk(fileGrpNo) < 1) {
				return new ResponseVO("E200", "등록되지 않은 템플릿 파일입니다.");
			}
		}
		
		if(fileGrpNo == 0) {
			return new ResponseVO("E200", "등록되지 않은 템플릿 파일입니다.");
		}
		
		Integer[] fileNoArray = null;
		String[] fileNos = request.getParameterValues("fileNo");
		
		if (fileNos != null && fileNos.length > 0) {
			fileNoArray = new Integer[fileNos.length];
			
			for (int i = 0; i <= fileNos.length - 1; i++) { /*"="파일 2개 이상 지울시 지워지지 않아 추가*/

					fileNoArray[i] = Integer.parseInt(fileNos[i]);

			}
		}
		
		//업로드 정보 저장 및 전체 업로드 정보 조회
		Map<String, Object> resultMap = atchFileService.processUpload(fileGrpNo, fileNoArray, uploadFileList);
		
		List<AtchFileVO> atchmnflList = null;
		
		if (resultMap != null && !resultMap.isEmpty()) {
			
			//삭제된 파일이 있는 경우 실제 파일 삭제 처리
			deleteUploadFileList((List<AtchFileVO>)resultMap.get("deletedFileList"));
			
			//파일 정보
			atchmnflList = (List<AtchFileVO>)resultMap.get("atchmnflList");
		}
		logger.debug("AtchFileController uploadAtchmnfl end !!!");
		return new ResponseVO();
	}
	
	/**
	 * 템플릿 파일 다운로드
	 * @param request
	 * @param multipartRequest
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/templateDownloadAtchmnfl", method=RequestMethod.GET)
	public ModelAndView downloadUrlTemplate(@RequestParam("fileGrpNo") String fileGrpNo, @RequestParam("fileNo") String fileNo) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("fileGrpNo", fileGrpNo);
		map.put("fileNo", fileNo);
		
		AtchFileVO atchUploadFileVO = atchFileService.getAtchmnfl(map);

		String filePath = atchUploadFileVO.getSavePath() + File.separator + atchUploadFileVO.getSaveFileNm();
		File downloadFile = new File(filePath);
		
		if (!downloadFile.exists()) {
			throw new RpaException("E104");
		}
		
		ModelAndView mav = new ModelAndView("downloadView");
		mav.addObject("downloadFile", downloadFile);
		mav.addObject("oriFileNm", atchUploadFileVO.getOriFileNm());
		
		return mav;
	}
	
	
	
	/**
	 * 임시 경로 파일 다운로드
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/downloadExport", method=RequestMethod.POST)
	public void downloadExport(HttpServletRequest request, HttpServletResponse response, @RequestParam("fileNo") String fileNo, @RequestParam("fileNm") String fileNm) throws Exception {
		logger.debug("/file/downloadExport");
		
		String filePath = downloadPath + File.separator +fileNo+".xlsx";
		File downloadFile = new File(filePath);
		
		String header = request.getHeader("User-Agent");
		fileNm = fileNm+".xlsx";
		
		if (header.contains("MSIE") || header.contains("Trident")) {
			fileNm = URLEncoder.encode(fileNm,"UTF-8").replaceAll("\\+", "%20");
        } else {
        	fileNm = new String(fileNm.getBytes("UTF-8"), "ISO-8859-1");
        }
		
		if (downloadFile.exists() && downloadFile.isFile()) {
	        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileNm + "\";");
	        response.setHeader("Content-Transter-Encoding", "binary");
	 
	        OutputStream out = response.getOutputStream();
	        FileInputStream fis = null;
	 
	        try {
	            fis = new FileInputStream(downloadFile);
	            FileCopyUtils.copy(fis, out);
	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            if (fis != null) {
	                try {
	                    fis.close();
	                } catch (IOException ioe) {
	                    ioe.printStackTrace();
	                }
	            }
	            out.flush();
	            
				if (downloadFile.exists()) {
					downloadFile.delete();
				}
	        }
		}
	}
}
