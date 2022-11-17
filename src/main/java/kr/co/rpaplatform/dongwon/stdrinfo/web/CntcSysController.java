package kr.co.rpaplatform.dongwon.stdrinfo.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.rpaplatform.common.pagination.PaginationInfo;
import kr.co.rpaplatform.common.vo.ResponseVO;
import kr.co.rpaplatform.dongwon.author.vo.AuthorVO;
import kr.co.rpaplatform.dongwon.common.service.PortalCommonService;
import kr.co.rpaplatform.dongwon.common.util.PaginationUtil;
import kr.co.rpaplatform.dongwon.stdrinfo.service.CntcSysService;
import kr.co.rpaplatform.dongwon.stdrinfo.vo.CntcSysVO;




/**
 * @author jyj
 */

@Controller
@RequestMapping("/stdrinfo/cntcsys")
public class CntcSysController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(AssetController.class);
	
	@Resource(name="portalCommonService")
	private PortalCommonService portalCommonService;
	
	
	/**
	 * cntc 서비스
	 */
	@Resource(name="cntcSysService")
	private CntcSysService cntcSysService;
	
	/**
	 * cntc 관리 메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/cntcSysMain")
	public ModelAndView cntcSysMain() throws Exception {
		ModelAndView mav = new ModelAndView("/stdrinfo/cntcsys/cntcSysMain");
		return mav;
	}
	
	/**
	 * cntc  등록화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/cntcSysRegister")
	public ModelAndView cntcSysRegister() throws Exception {
		ModelAndView mav = new ModelAndView("/stdrinfo/cntcsys/cntcSysRegister");
		return mav;
	}
    
	
	/**
	 * cntc  등록
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/cntcRegister")
	@ResponseBody
	public ResponseVO cntcRegister(HttpServletRequest req, @RequestBody Map<String, Object> map) throws Exception{
    	this.logger.debug("CntcSysController cntcRegister start!!!! "); 
    	//쓰기/수정 권한자 인지 확인
    			AuthorVO oAuthorVO = portalCommonService.getScreenAuthor(req);
    			if(!oAuthorVO.getWrtngAuthor().equals("Y")) {
    				return new ResponseVO("E202", "비정상 접근입니다.");
    			}
    			
    	return cntcSysService.cntcRegister(map);    	   	
    	
    }
	/**
	 * cntc  수정
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/cntcSysUpdate")
	@ResponseBody
	public ResponseVO  cntcSysUpdate(@RequestBody Map<String, Object> map) throws Exception{
        this.logger.debug("CntcSysController cntcRegister start!!!! ");
        this.logger.debug("CntcSysController cntcSysUpdate map 넘어오는 값!!!! " + map);
        cntcSysService.cntcSysUpdate(map);
        this.logger.debug("CntcSysController cntcRegister end!!!! ");
		return new ResponseVO();
	}
	
	/**
	 * cntc  삭제
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/cntcSysDelete")
	@ResponseBody
	public ResponseVO cntcSysDelete(@RequestBody Map<String, Object> map) throws Exception{
		    this.logger.debug("CntcSysController cntcSysDelete start!!!! ");
	        this.logger.debug("CntcSysController cntcSysDelete map 넘어오는 값!!!! " + map);
	        cntcSysService.cntcSysDelete(map);
	        this.logger.debug("CntcSysController cntcSysDelete end!!!! ");
		
		
		return new ResponseVO();
	}
	
	
	
	
	/**
	 * cntc  조회
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getCntcSysList")
	@ResponseBody
	public ResponseVO getCntcSysList(@RequestBody Map<String, Object> map) throws Exception{
		this.logger.debug("CntcSysController getCntcSysList start!!!! ");
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		//연계시스템 리스트 카운트 조회
		int totalRecordCount = cntcSysService.getCntcCount(map);
		
		//페이징 정보 조회
		PaginationInfo paginationInfo = PaginationUtil.getPaginationInfo(map, totalRecordCount);
		
		//조회조건에 페이징 정보 설정
		map.put("paginationInfo", PaginationUtil.getPaginationInfo(map, totalRecordCount));
		
		
		//연계시스템 리스트 조회
		List<Map<String, Object>> resultList = cntcSysService.getCntcSysList(map);
		
		//결과값 설정
		returnMap.put("resultList", resultList);
		returnMap.put("paginationInfo", paginationInfo);
				
		
		this.logger.debug("CntcSysController getCntcSysList end!!!! ");
		return new ResponseVO(returnMap);
	}
	
	/**
	 * cntc 상세 조회 화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/cntcDetailPagePop")
	public ModelAndView cntcDetailPagePop() throws Exception{
		return new ModelAndView("/stdrinfo/cntcsys/cntcDetailPagePop");
	}
	
	/**
	 * cntc 상세 조회 화면 내역
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/getCntcDetail")
	@ResponseBody
	public ResponseVO getCntcDetail(@RequestBody CntcSysVO vo) throws Exception {
		
		this.logger.debug("vo값은????????" + vo);
		CntcSysVO result = cntcSysService.cntcDetailSelectPage(vo);
		
		
		this.logger.debug("result값은????????" + result);
		
		return new ResponseVO(result);
	}
	
	/**
	 * cntc 자동채번
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/autoNumSelect")
	@ResponseBody
		public ResponseVO autoNumSelect(@RequestBody Map<String, Object> map) throws Exception{
		
		this.logger.debug("map값은????????" + map);
		Map<String, Object> resultMap  = cntcSysService.autoNumSelect(map);
		this.logger.debug("resultMap값은????????" + resultMap);
		
		return new ResponseVO(resultMap);
	}
	
	
	
}
















