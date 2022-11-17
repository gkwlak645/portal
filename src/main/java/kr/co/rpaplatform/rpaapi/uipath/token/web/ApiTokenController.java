package kr.co.rpaplatform.rpaapi.uipath.token.web;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.rpaplatform.rpaapi.uipath.token.TokenScheduler;

/**
 * @author LSH
 */
@Controller
@RequestMapping("/rpaapi/tkoen")
public class ApiTokenController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(ApiTokenController.class);
	
	
	@Resource(name="tokenScheduler")
	private TokenScheduler tokenScheduler;
	
	
	@RequestMapping(value = "/getProcessApiToken")
	@ResponseBody
	public void getProcessApiToken() throws Exception {
		tokenScheduler.processApiToken();
		
	}
	
	
	
}
