package kr.co.rpaplatform.dongwon.stdrinfo.web;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.rpaplatform.common.vo.ResponseVO;
import kr.co.rpaplatform.dongwon.stdrinfo.service.PymhrUpdtService;
import kr.co.rpaplatform.dongwon.stdrinfo.vo.PymhrUpdtVO;

@Controller
@RequestMapping("/stdrinfo/pymhr")
public class PymhrUpdtController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(PymhrUpdtController.class);
	
	/**
	 * 임율관리 서비스
	 */
	@Resource(name="pymhrUpdtService")
	private PymhrUpdtService pymhrUpdtService;
	
	/**
	 * 임율관리 메인 화면
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/pymhrUpdtMain", method = RequestMethod.GET)
	public String deptModify() throws Exception{
		return "/stdrinfo/pymhr/pymhrUpdtMain";
	}
	
	@RequestMapping(value="/getPymhrList")
	@ResponseBody
	public ResponseVO getRateList() throws Exception{
		
		logger.debug("PymhrUpdtController getPymhrList started !!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		resultData.put("rateUpdt", pymhrUpdtService.getPymhrList());

		logger.debug("PymhrUpdtController getPymhrList end !!!");
		
		return new ResponseVO(resultData);
	}
	
	@RequestMapping(value="/updtPymhrList", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO updtPymhrList(@RequestBody PymhrUpdtVO vo) throws Exception{
		logger.debug("PymhrUpdtController updtPymhrList started !!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		pymhrUpdtService.updtPymhrList(vo);
		
		logger.debug("PymhrUpdtController updtPymhrList end !!!");
		
		return new ResponseVO(resultData);
	}
	
	
	@RequestMapping(value="/deletePymhr", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO deletePymhr(@RequestBody PymhrUpdtVO vo) throws Exception{
		logger.debug("PymhrUpdtController deletePymhr started !!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		pymhrUpdtService.deletePymhr(vo);
		
		logger.debug("PymhrUpdtController deletePymhr end !!!");
		
		return new ResponseVO(resultData);
	}

}
