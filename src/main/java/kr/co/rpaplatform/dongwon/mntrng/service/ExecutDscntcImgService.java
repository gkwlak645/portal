package kr.co.rpaplatform.dongwon.mntrng.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import kr.co.rpaplatform.common.pagination.PaginationInfo;
import kr.co.rpaplatform.dongwon.mntrng.dao.ExecutDscntcImgDAO;
import kr.co.rpaplatform.dongwon.mntrng.vo.ExecutDscntcImgVO;

/**
 * 작업 서비스
 * @author LSH
 *
 */
@Service
public class ExecutDscntcImgService {
	
	private final Logger logger = LoggerFactory.getLogger(ExecutDscntcImgService.class);
	
	/**
	 * 작업 DAO
	 */
	@Resource(name="executDscntcImgDAO")
	private ExecutDscntcImgDAO executDscntcImgDAO;
	
	/**
	 * 로봇 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getSelectRobotList(Map<String, Object> map) throws Exception {
		return executDscntcImgDAO.getSelectRobotList(map);
	}
	
	/**
	 * 실행중단 이미지 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getExecutDscntcImgList(ExecutDscntcImgVO vo) throws Exception {
		PaginationInfo pageInfo = vo.getPageInfo();
		pageInfo.setTotalRecordCount(executDscntcImgDAO.selectExecutDscntcImgCount(vo));
		Map<String,Object> result = new HashMap<>();		
		result.put("items", executDscntcImgDAO.selectExecutDscntcImgList(vo));
		result.put("pageInfo", pageInfo);
		
		return result;
//		return executDscntcImgDAO.selectExecutDscntcImgList(map);
	}
	
	/**
	 * 실행중단 이미지  리스트 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int getExecutDscntcImgCount(ExecutDscntcImgVO vo) throws Exception {
		return executDscntcImgDAO.selectExecutDscntcImgCount(vo);
	}
	
	/**
	 * 작업 상세 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public ExecutDscntcImgVO getExecutDscntcImgDetail(ExecutDscntcImgVO vo) throws Exception {
		return executDscntcImgDAO.getExecutDscntcImgDetail(vo);
	}

}
