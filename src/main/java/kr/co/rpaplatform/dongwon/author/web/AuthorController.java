package kr.co.rpaplatform.dongwon.author.web;

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
import org.springframework.web.servlet.ModelAndView;

import kr.co.rpaplatform.common.vo.ResponseVO;
import kr.co.rpaplatform.dongwon.author.service.AuthorService;
import kr.co.rpaplatform.dongwon.author.vo.AuthorVO;

/**
 * 권한 컨트롤러 클래스
 * @author jw.lee
 * 2020. 6. 2.
 */
@Controller
@RequestMapping("/author/authormng")
public class AuthorController {

	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(AuthorController.class);
	
	@Resource(name="authorService")
	private AuthorService authorService;
	
	/**
	 * 권한관리 페이지
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/authorRoleMain", method = RequestMethod.GET)
	public ModelAndView menuRoleMain() throws Exception {
		ModelAndView mav = new ModelAndView("/author/authormng/authorRoleMain");
		return mav;
	}
	
	/**
	 * 역할명 가져오기
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getSelectbox", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getSelectbox() throws Exception {
		logger.debug("AuthorController getSelectbox started !!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		resultData.put("selectbox",authorService.selectRole());
		logger.debug("AuthorController getSelectbox end !!!");
		
		return new ResponseVO(resultData);
	}
	
	/**
	 * 선택한 메뉴에대한 권한 가져오기
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectAuthorRole", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO selectMenuRole(@RequestBody AuthorVO vo) throws Exception {
		logger.debug("AuthorController selectAuthorRole started !!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		resultData.put("selectAuth",authorService.selectAuth(vo));
		
		logger.debug("AuthorController selectAuthorRole end !!!");
		
		return new ResponseVO(resultData);
	}
	
	/**
	 * 권한 수정 및 추가
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/authUpdate", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO menuAuthUpdate(@RequestBody AuthorVO vo) throws Exception {
		logger.debug("AuthorController AuthUpdate started !!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		authorService.updateAuth(vo);
		
		logger.debug("AuthorController AuthUpdate end !!!");
		
		return new ResponseVO(resultData);
	}

}
