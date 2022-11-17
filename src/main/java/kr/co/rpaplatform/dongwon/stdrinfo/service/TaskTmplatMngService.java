package kr.co.rpaplatform.dongwon.stdrinfo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import kr.co.rpaplatform.common.pagination.PaginationInfo;
import kr.co.rpaplatform.dongwon.file.service.AtchFileService;
import kr.co.rpaplatform.dongwon.file.vo.AtchFileVO;
import kr.co.rpaplatform.dongwon.stdrinfo.dao.TaskTmplatMngDAO;
import kr.co.rpaplatform.dongwon.stdrinfo.service.TaskTmplatMngService;
import kr.co.rpaplatform.dongwon.stdrinfo.vo.TaskTmplatMngVO;


@Service
public class TaskTmplatMngService {

	private final Logger logger = LoggerFactory.getLogger(TaskTmplatMngService.class);
	
	@Resource(name="taskTmplatMngDAO")
	private TaskTmplatMngDAO taskTmplatMngDAO;
	
	@Resource(name="atchFileService")
	private AtchFileService atchFileService;
	
	/**
	 * 과제템플릿 게시글 List
	 **/
	public Map<String,Object> getTaskTmplatMng(TaskTmplatMngVO vo) throws Exception {

		PaginationInfo pageInfo = vo.getPageInfo();
		pageInfo.setTotalRecordCount(taskTmplatMngDAO.selectTotalTaskTmplatMngListCount(vo));
		Map<String,Object> result = new HashMap<>();		
		result.put("items", taskTmplatMngDAO.selectTaskTmplatMngList(vo));
		result.put("pageInfo", pageInfo);
		
		return result;
	}
	
	/**
	 * 파일 FILE_GRP_NO 최대값 구하기
	 **/
	public TaskTmplatMngVO getMaxFileGrpNo(TaskTmplatMngVO vo) throws Exception {
		return taskTmplatMngDAO.getMaxFileGrpNo(vo);		
	}
	
	/**
	 * 과제템플릿 게시글 중복체크
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public TaskTmplatMngVO insertCheck(TaskTmplatMngVO vo) throws Exception {
		return taskTmplatMngDAO.insertCheck(vo);
	}
	
	/**
	 * 과제템플릿 게시글 등록
	 * */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void insertTaskTmplatMng(TaskTmplatMngVO vo) throws Exception{
		logger.debug("TaskTmplatMngService insertTaskTmplatMng started !!!");
		
		taskTmplatMngDAO.insertTaskTmplatMng(vo); 
		
		logger.debug("TaskTmplatMngService insertTaskTmplatMng end !!!");
	}
	
	/**
	 * 과제템플릿 상세화면 정보 조회
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public TaskTmplatMngVO getTaskTmplatDetail(TaskTmplatMngVO vo) throws Exception {
		return taskTmplatMngDAO.getTaskTmplatDetail(vo);
	}
	
	/**
	 * 과제템플릿 게시글 수정
	 * */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateTaskTmplatMng(TaskTmplatMngVO vo) throws Exception{
		taskTmplatMngDAO.updateTaskTmplatMng(vo); 
	}
	
	/**
	 * 과제템플릿 게시글 삭제
	 * */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void deleteTaskTmplatMng(TaskTmplatMngVO vo) throws Exception{
		taskTmplatMngDAO.deleteTaskTmplatMng(vo); 
	}
}