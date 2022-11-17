package kr.co.rpaplatform.dongwon.mntrng.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import kr.co.rpaplatform.common.exception.RpaException;
import kr.co.rpaplatform.dongwon.mntrng.dao.ResveArDAO;


/**
 * 작업 서비스
 * @author LSH
 *
 */
@Service
public class ResveArService {
	
	private final Logger logger = LoggerFactory.getLogger(ResveArService.class);
	
	/**
	 * 작업 DAO
	 */
	@Resource(name="resveArDAO")
	private ResveArDAO resveArDAO;
	
	/**
	 * 작업 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getResveArList(Map<String, Object> map) throws Exception {
		return resveArDAO.selectResveArList(map);
	}
	
	/**
	 * 작업 리스트 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int getResveArCount(Map<String, Object> map) throws Exception {
		return resveArDAO.selectResveArCount(map);
	}
	
	/**
	 * 작업 리스트 삭제
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void delResveAr(Map<String, Object> map) throws Exception {
		
		//현재 전송여부 체크
		String nowSttus = resveArDAO.selectResveArSttus(map);
		
		// 전송여부가 Y 일경우 작업 중지
		if("N".equals(nowSttus)) {
			 resveArDAO.delResveAr(map);
		}else {
		//그 외 오류 처리
			throw new RpaException("E60014", "전송된 예약은 삭제할 수 없습니다.");	 
		}
	}

}
