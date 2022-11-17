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

import kr.co.rpaplatform.dongwon.cmmnty.dao.CntrbtRankDAO;

@Service
public class CntrbtRankService {

	private final Logger logger = LoggerFactory.getLogger(BbsMngService.class);
	
	@Resource(name="cntrbtRankDAO")
	private CntrbtRankDAO cntrbtRankDAO;
	
	
	public int selectCntrbtRankListCount(Map<String, Object> map) throws Exception {
		return cntrbtRankDAO.selectCntrbtRankListCount(map);
	}
	
	public List<Map<String, Object>> selectCntrbtRankList(Map<String, Object> map) throws Exception {
		return cntrbtRankDAO.selectCntrbtRankList(map);
	}
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public Map<String, Object> getCntrbtRankDetailPopGetData(Map<String, Object> map) throws Exception{
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("cntrbtRankDetail", cntrbtRankDAO.getCntrbtRankDetailPopGetData(map));
		resultMap.put("cntrbtInfoList", cntrbtRankDAO.getCntrbtRankDetailPopGetData2(map));
		
		return resultMap;
	}
	
}
