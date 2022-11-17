package kr.co.rpaplatform.dongwon.mntrng.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import kr.co.rpaplatform.dongwon.mntrng.dao.ExcResHistDAO;

/**
 * 작업 서비스
 * @author LSH
 *
 */
@Service
public class ExcResHistService {
	
	private final Logger logger = LoggerFactory.getLogger(ExcResHistService.class);
	
	/**
	 * 작업 DAO
	 */
	@Resource(name="excResHistDAO")
	private ExcResHistDAO excResHistDAO;
	
	/**
	 * 작업 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getExcResList(Map<String, Object> map) throws Exception {
		return excResHistDAO.selectExcResList(map);
	}
	
	/**
	 * 작업 리스트 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int getExcResCount(Map<String, Object> map) throws Exception {
		return excResHistDAO.selectExcResCount(map);
	}
	
	/**
	 * 재실행 정보 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectReExcInfo(Map<String, Object> map) throws Exception {
		return excResHistDAO.selectReExcInfo(map);
	}
	
	/**
	 * 프로세스 운영 Attended 입력
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void insertTaskAttendedReserve(Map<String, Object> params) throws Exception {
		excResHistDAO.insertTaskAttendedReserve(params);
	}
	
	/**
	 * 프로세스 JOB SEND History 입력
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void insertTaskSendHistory(Map<String, Object> params) throws Exception {
		excResHistDAO.insertTaskSendHistory(params);
	}
	
	/**
	 * 프로세스 운영 Attended 입력
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void insertReExcInfo(Map<String, Object> params) throws Exception {
		excResHistDAO.insertReExcInfo(params);
	}
	
	/**
	 * UR 원본정보 변경
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void updateOriginalAt(Map<String, Object> map) throws Exception {
		excResHistDAO.updateOriginalAt(map);
	}
	
	/**
	 * 작업 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectResHistList(Map<String, Object> map) throws Exception {
		return excResHistDAO.selectResHistList(map);
	}
	
	/**
	 * 작업 리스트 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectResHistCount(Map<String, Object> map) throws Exception {
		return excResHistDAO.selectResHistCount(map);
	}
	
	/**
	 * 재실행 대상 여부 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectTrgetAt(Map<String, Object> map) throws Exception {
		return excResHistDAO.selectTrgetAt(map);
	}
	
	/**
	 * UR 과제 실행중 여부 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectURJobExcAt(Map<String, Object> map) throws Exception {
		return excResHistDAO.selectURJobExcAt(map);
	}
	
	/**
	 * AR 과제 실행중 여부 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectARJobExcAt(Map<String, Object> map) throws Exception {
		return excResHistDAO.selectARJobExcAt(map);
	}
}
