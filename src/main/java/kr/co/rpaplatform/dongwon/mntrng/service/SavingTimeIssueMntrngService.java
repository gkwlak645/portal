package kr.co.rpaplatform.dongwon.mntrng.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import kr.co.rpaplatform.dongwon.mntrng.dao.DevBotMntrngDAO;
import kr.co.rpaplatform.dongwon.mntrng.dao.SavingTimeIssueMntrngDAO;

/**
 * 작업 서비스
 * @author LSH
 *
 */
@Service
public class SavingTimeIssueMntrngService {
	
	private final Logger logger = LoggerFactory.getLogger(SavingTimeIssueMntrngService.class);
	
	/**
	 * 작업 DAO
	 */
	@Resource(name="savingTimeIssueMntrngDAO")
	private SavingTimeIssueMntrngDAO savingTimeIssueMntrngDAO;
	
	/**
	 * 절감시간 이슈관리 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSavingTimeIssueList(Map<String, Object> map) throws Exception {
		return savingTimeIssueMntrngDAO.selectSavingTimeIssueList(map);
	}
	
	/**
	 * 절감시간 이슈관리  카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectSavingTimeIssueListCount(Map<String, Object> map) throws Exception {
		return savingTimeIssueMntrngDAO.selectSavingTimeIssueListCount(map);
	}
	
	
	/**
	 * 절감시간 이슈관리  사유 등록
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void insertSavingTimeIssueResn(Map<String, Object> map) throws Exception {
		savingTimeIssueMntrngDAO.insertSavingTimeIssueResn(map);	
	}
	
	/**
	 * 절감시간 이슈관리  사유 수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void updateSavingTimeIssueResn(Map<String, Object> map) throws Exception {
		savingTimeIssueMntrngDAO.updateSavingTimeIssueResn(map);	
	}
	
	/**
	 * 절감시간 이슈관리  정상여부 수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void updateSavingTimeIssueNormalAt(Map<String, Object> map) throws Exception {
		savingTimeIssueMntrngDAO.updateSavingTimeIssueNormalAt(map);	
	}
	
	
}
