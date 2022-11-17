package kr.co.rpaplatform.dongwon.stdrinfo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import kr.co.rpaplatform.common.vo.ResponseVO;
import kr.co.rpaplatform.dongwon.resrce.service.RobotService;
import kr.co.rpaplatform.dongwon.stdrinfo.dao.CntcSysDAO;
import kr.co.rpaplatform.dongwon.stdrinfo.vo.CntcSysVO;

/**
 * 연계시스템 서비스
 * @author JYJ
 * 2020. 9. 9.
 */

@Service
public class CntcSysService {

	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(RobotService.class);

	
	
	@Resource(name="cntcSysDAO")
	private CntcSysDAO cntcSysDAO;
	
	/**
	 * 연계시스템 등록
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public ResponseVO cntcRegister(Map<String, Object> map) throws Exception{
		logger.debug("CntcSysService cntcRegister start!!");
		logger.debug("CntcSysService cntcRegister map 넘어 오는 값!!" + map);
		
		//코드 중복 체크
		if(cntcSysDAO.chkCntcSysCd(map) > 0) {
			return new ResponseVO("E200", "중복된 시스템코드입니다.");
		}
		
		
		//insert
		cntcSysDAO.insertCntc(map);
		
		logger.debug("CntcSysService cntcRegister start!!");
		return new ResponseVO(new HashMap<String, Object>());
	}
	
	/**
	 * 연계시스템 수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void cntcSysUpdate(Map<String, Object> map) throws Exception{
		logger.debug("CntcSysService cntcSysUpdate start!!");
		logger.debug("CntcSysService cntcSysUpdate map 넘어 오는 값!!" + map);		
		cntcSysDAO.updateCntc(map);		
		logger.debug("CntcSysService cntcSysUpdate end!!");
		
	}
	
	/**
	 * 연계시스템 삭제
	 * @param map
	 * @return
	 * @throws Exception
	 */
    public void cntcSysDelete(Map<String, Object> map) throws Exception{
    	//[삭제]버튼 제외함
		logger.debug("CntcSysService cntcSysDelete start!!");
				
		//연계 시스템 사용하는 과제가 있는지 확인
		
		//없으면 삭제
		cntcSysDAO.cntcDelete(map);		
		logger.debug("CntcSysService cntcSysDelete end!!");
		
	}

	/**
	 * 연계시스템 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getCntcSysList(Map<String, Object> map) throws Exception {
		
		
		return cntcSysDAO.getCntcSysList(map);
	}

	/**
	 * 연계시스템 리스트 카운트
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int getCntcCount(Map<String, Object> map) throws Exception{		
		return cntcSysDAO.selectCntcCount(map);
	}

	/**
	 * 연계시스템 상세화면 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public CntcSysVO cntcDetailSelectPage(CntcSysVO vo) throws Exception {	
		logger.debug("CntcSysService cntcDetailSelectPage start!!!!!!");		
		logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ service에 vo 넘어온 값 : " + vo);
		logger.debug("CntcSysService cntcDetailSelectPage end!!!!!!");
		
		return cntcSysDAO.cntcDetailSelectPage(vo);
	}

	/**
	 * 연계시스템 자동채번
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> autoNumSelect(Map<String, Object> map)throws Exception {
		
		return cntcSysDAO.autoNumSelect(map);
	}

	


	
	
	
	
	
	
	
}
