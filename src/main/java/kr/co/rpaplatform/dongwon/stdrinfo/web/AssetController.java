package kr.co.rpaplatform.dongwon.stdrinfo.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.rpaplatform.common.pagination.PaginationInfo;
import kr.co.rpaplatform.common.vo.ResponseVO;
import kr.co.rpaplatform.dongwon.common.util.PaginationUtil;
import kr.co.rpaplatform.dongwon.stdrinfo.service.AssetService;

/**
 * @author LSH
 */
@Controller
@RequestMapping("/stdrinfo/asset")
public class AssetController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(AssetController.class);
	
	/**
	 * Asset 서비스
	 */
	@Resource(name="assetService")
	private AssetService assetService;
	
	/**
	 * Asset 관리 메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/assetMngMain")
	public ModelAndView assetMngMain() throws Exception {
		ModelAndView mav = new ModelAndView("/stdrinfo/asset/assetMngMain");
		return mav;
	}
	
	/**
	 * Asset 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/getAssetList")
	@ResponseBody
	public ResponseVO getAssetList(@RequestBody Map<String, Object> map) throws Exception {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();

		//Asset 리스트 카운트 조회
		int totalRecordCount = assetService.getAssetCount(map);
		
		if (totalRecordCount > 0) {
		
			//페이징 정보 조회
			PaginationInfo paginationInfo = PaginationUtil.getPaginationInfo(map, totalRecordCount);
			
			//조회조건에 페이징 정보 설정
			map.put("paginationInfo", PaginationUtil.getPaginationInfo(map, totalRecordCount));
	
			//디바이스 리스트 조회
			List<Map<String, Object>> resultList = assetService.getAssetList(map);
	
			//결과값 설정
			returnMap.put("resultList", resultList);
			returnMap.put("paginationInfo", paginationInfo);
			
		} else {
			
			//결과값 설정
			returnMap.put("resultList", null);
			returnMap.put("paginationInfo", PaginationUtil.getPaginationInfo(map, 0));
			
		}
		
		return new ResponseVO(returnMap);
	}
	
	
	/**
	 * Asset 등록 페이지
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/assetRegistPop")
	public ModelAndView assetRegistPop() throws Exception {
		return new ModelAndView("/stdrinfo/asset/assetRegistPop");
	}

	/**
	 * Asset 조회
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/getAssetDetail")
	@ResponseBody
	public ResponseVO getAsset(@RequestBody Map<String, Object> map) throws Exception {
		logger.debug("AssetController getAssetDetail started !!!");
		
		Map<String, Object> resultMap = assetService.getAssetDetail(map);

		logger.debug("AssetController getAssetDetail end !!!");
		
		return new ResponseVO(resultMap);
		
	}
	
	
	/**
	 * Asset 등록
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/registAsset")
	@ResponseBody
	public ResponseVO registAsset(@RequestBody Map<String, Object> map) throws Exception {
		logger.debug("AssetController registAsset started !!!");
		
		Map<String, Object> resultMap = assetService.registAsset(map);

		logger.debug("AssetController registAsset end !!!");
		
		return new ResponseVO(resultMap);
		
	}
	
	/**
	 * Asset 수정
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/updateAsset")
	@ResponseBody
	public ResponseVO updateAsset(@RequestBody Map<String, Object> map) throws Exception {
		logger.debug("AssetController updateAsset started !!!");
		
		Map<String, Object> resultMap = assetService.updateAsset(map);

		logger.debug("AssetController updateAsset end !!!");
		
		return new ResponseVO(resultMap);
		
	}
	
	/**
	 * Asset 삭제
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAsset")
	@ResponseBody
	public ResponseVO deleteAsset(@RequestBody Map<String, Object> map) throws Exception {
		logger.debug("AssetController deleteAsset started !!!");
		
		Map<String, Object> resultMap = assetService.deleteAsset(map);

		logger.debug("AssetController deleteAsset end !!!");
		
		return new ResponseVO(resultMap);
		
	}
	
	
	/**
	 * 로봇 조회
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/getRobtList")
	@ResponseBody
	public ResponseVO getRobtList(@RequestBody Map<String, Object> map) throws Exception {
		logger.debug("AssetController getRobtList started !!!");
		
		Map<String, Object> resultMap = assetService.getRobtList(map);

		logger.debug("AssetController getRobtList end !!!");
		
		return new ResponseVO(resultMap);
		
	}
	

}
