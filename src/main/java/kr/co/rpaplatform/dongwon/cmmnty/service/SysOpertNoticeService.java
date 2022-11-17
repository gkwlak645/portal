package kr.co.rpaplatform.dongwon.cmmnty.service;

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
import kr.co.rpaplatform.dongwon.cmmnty.dao.BbsAnswerDAO;
import kr.co.rpaplatform.dongwon.cmmnty.dao.NoticeDAO;
import kr.co.rpaplatform.dongwon.cmmnty.dao.SysOpertNoticeeDAO;
import kr.co.rpaplatform.dongwon.cmmnty.vo.BbsAnswerVO;
import kr.co.rpaplatform.dongwon.cmmnty.vo.BbsVO;
import kr.co.rpaplatform.dongwon.file.service.AtchFileService;
import kr.co.rpaplatform.dongwon.file.vo.AtchFileVO;

@Service
public class SysOpertNoticeService {

	private final Logger logger = LoggerFactory.getLogger(BbsMngService.class);
	
	@Resource(name="sysOpertNoticeeDAO")
	private SysOpertNoticeeDAO sysOpertNoticeeDAO;
	
	
	public int selectSysOpertNoticeListCount(Map<String, Object> map) throws Exception {
		return sysOpertNoticeeDAO.selectSysOpertNoticeListCount(map);
	}
	
	public List<Map<String, Object>> selectSysOpertNoticeList(Map<String, Object> map) throws Exception {
		return sysOpertNoticeeDAO.selectSysOpertNoticeList(map);
	}
	
	
	/*
	 * 저장 번호 가져오기
	 * */
	public int getSysOpertNoticeNextSn() throws Exception {
		return sysOpertNoticeeDAO.getSysOpertNoticeNextSn();
	}
	
	/**
	 * 시스템 작업공지 등록
	 * */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void insertSysOpertNotice(Map<String, Object> map) throws Exception{
		sysOpertNoticeeDAO.insertSysOpertNotice(map);
	}
	
	/**
	 * 시스템 작업공지 > 상세: getData
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public Map<String, Object> getSysOpertNoticeDetailPopGetData(Map<String, Object> map) throws Exception{
		return sysOpertNoticeeDAO.getSysOpertNoticeDetailPopGetData(map);
	}
	
	/**
	 * 시스템 작업공지 > 상세: 저장
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateSysOpertNotice(Map<String, Object> map) throws Exception{
		 sysOpertNoticeeDAO.updateSysOpertNotice(map);
	}
	
	/**
	 * 시스템 작업공지 > 상세: 삭제
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void deleteSysOpertNotice(Map<String, Object> map) throws Exception{
		 sysOpertNoticeeDAO.deleteSysOpertNotice(map);
	}
	
	/**
	 * 연관시시템 목록
	 * */
	public List<Map<String, Object>> selectSysOpertNoticeCntcSys(Map<String, Object> map) throws Exception{
		return sysOpertNoticeeDAO.selectSysOpertNoticeCntcSys(map);
	}
	
	/**
	 * 연관시시템 등록
	 * */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void insertSysOpertNoticeCntcSys(Map<String, Object> map) throws Exception{
		sysOpertNoticeeDAO.insertSysOpertNoticeCntcSys(map);
	}
	
	/**
	 * 연관시시템 삭제
	 * */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void deleteSysOpertNoticeCntcSys(Map<String, Object> map) throws Exception{
		 sysOpertNoticeeDAO.deleteSysOpertNoticeCntcSys(map);
	}
	
	public List<Map<String, Object>> selectSendTrgetList(Map<String, Object> map) throws Exception{
		return sysOpertNoticeeDAO.selectSendTrgetList(map);
	}
}
