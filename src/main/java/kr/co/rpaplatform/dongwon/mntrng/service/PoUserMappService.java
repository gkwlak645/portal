package kr.co.rpaplatform.dongwon.mntrng.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import kr.co.rpaplatform.dongwon.mntrng.dao.PoUserMappDAO;

/**
 * 작업 서비스
 * @author LSH
 *
 */
@Service
public class PoUserMappService {
	
	private final Logger logger = LoggerFactory.getLogger(PoUserMappService.class);
	
	/**
	 * 작업 DAO
	 */
	@Resource(name="poUserMappDAO")
	private PoUserMappDAO poUserMappDAO;
	
	/**
	 * 작업 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getPoUserMappList(Map<String, Object> map) throws Exception {
		return poUserMappDAO.getPoUserMappList(map);
	}
	
	/**
	 * 작업 리스트 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int getPoUserMappCount(Map<String, Object> map) throws Exception {
		return poUserMappDAO.getPoUserMappCount(map);
	}
	
	/**
	 * ORC 릴리즈데이터 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getOrcReleaseList(Map<String, Object> map) throws Exception {
		return poUserMappDAO.getOrcReleaseList(map);
	}
	
	/**
	 * ORC 릴리즈데이터 조회 For 개발 서버
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getOrcReleaseListForDevServer(Map<String, Object> map) throws Exception {
		return poUserMappDAO.getOrcReleaseListForDevServer(map);
	}
	
	
	
	/**
	 * 파워유저 프로세스 매핑정보 등록
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void insertMappInfo(Map<String, Object> map) throws Exception {
		poUserMappDAO.insertMappInfo(map);
	}
	
	/**
	 * 파워유저 프로세스 매핑정보 등록 For 개발 서버
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void insertMappInfoForDevServer(Map<String, Object> map) throws Exception {
		poUserMappDAO.insertMappInfoForDevServer(map);
	}
	
	
	
	/**
	 * 파워유저 프로세스 매핑정보 삭제
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void deleteMappInfo(Map<String, Object> map) throws Exception {
		poUserMappDAO.deleteMappInfo(map);
	}
	
	/**
	 * 매핑 데이터 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getDevMapperList(Map<String, Object> map) throws Exception {
		return poUserMappDAO.getDevMapperList(map);
	}
	
	/**
	 * 매핑 데이터 조회 For 개발 서버
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getDevMapperListForDevServer(Map<String, Object> map) throws Exception {
		return poUserMappDAO.getDevMapperListForDevServer(map);
	}
	
}
