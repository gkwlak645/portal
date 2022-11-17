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

import kr.co.rpaplatform.common.exception.RpaException;
import kr.co.rpaplatform.dongwon.stdrinfo.dao.AssetDAO;
import kr.co.rpaplatform.rpaapi.uipath.api.AssetApi;

/**
 * Asset 서비스
 * @author LSH
 */
@Service
public class AssetService {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(AssetService.class);
	
	/**
	 * Asset DAO
	 */
	@Resource(name="assetDAO")
	private AssetDAO assetDAO;
	
	@Resource(name="assetApi")
	private AssetApi assetApi;
	
	/**
	 * Asset 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getAssetList(Map<String, Object> map) throws Exception {
		return assetDAO.selectAssetList(map);
	}
	
	/**
	 * Asset 리스트 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int getAssetCount(Map<String, Object> map) throws Exception {
		return assetDAO.selectAssetCount(map);
	}

	/**
	 * Asset 상세 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public Map<String, Object> getAssetDetail(Map<String, Object> map) throws Exception {
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("assetDetail", assetDAO.selectAsset(map));
		resultMap.put("assetRobotList", assetDAO.selectAssetRobtList(map));
		resultMap.put("robotList", assetDAO.selectRobtList(map));
		
		return resultMap;
	}

	
	/**
	 * Asset 상세 등록
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> registAsset(Map<String, Object> map) throws Exception {
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		//이름 중복 체크
		int chkOverAN = assetDAO.chkOverAssetName(map);
		
		if(chkOverAN > 0) {
			throw new RpaException("E00001", "이미 등록된 이름 입니다.");	 //이미 등록된 이름 입니다.
		}else {
			map.remove("txDeptCd");
			map.remove("txUserId");
			resultMap = assetApi.registerAsset(map);
		}
		
		return resultMap;
	}

	
	/**
	 * Asset 상세 수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> updateAsset(Map<String, Object> map) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		//이름 중복 체크
		int chkOverAN = assetDAO.updateChkOverAssetName(map);
		
		if(chkOverAN > 0) {
			throw new RpaException("E00001", "이미 등록된 이름 입니다.");	 //이미 등록된 이름 입니다.
		}else {
			map.remove("txDeptCd");
			map.remove("txUserId");
			map.remove("orgName");
			resultMap = assetApi.updateAsset(map);
		}
		
		return resultMap;
	}

	
	/**
	 * Asset 상세 삭제
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> deleteAsset(Map<String, Object> map) throws Exception {
		Map<String, Object> resultMap = assetApi.deleteAsset(map);
		return resultMap;
	}

	
	/**
	 * 로봇 조회
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getRobtList(Map<String, Object> map) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("robotList", assetDAO.selectRobtList(map));
		return resultMap;
	}

}
