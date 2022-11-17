package kr.co.rpaplatform.dongwon.login.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.co.rpaplatform.common.util.MessageDigestUtil;
import kr.co.rpaplatform.dongwon.common.vo.CmmnUserVO;
import kr.co.rpaplatform.dongwon.login.dao.LoginDAO;
import kr.co.rpaplatform.dongwon.orgnzt.vo.UserVO;

@Service
public class LoginService {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(LoginService.class);
	
	/**
	 * 로그인 DAO
	 */
	@Resource(name="loginDAO")
	private LoginDAO loginDAO;
	
	
	@Value("${sso.login.check.url}")
	private String ssoLoginCheckUrl;
	
	/**
	 * 아이디 비밀번호 체크, 로그인
	 * @return
	 * @throws Exception
	 */
	public CmmnUserVO loginCheck(UserVO vo) throws Exception{
		logger.debug("LoginService loginCheck started !!!");

		String Key = vo.getPassword(); //사용자가 쓴 비번 
		String encKey = "";
		
		CmmnUserVO voEncKey = loginDAO.LoginCheck(vo);
		
		if(voEncKey == null) {
			encKey ="";
		}else{
			encKey = loginDAO.LoginCheck(vo).getPassword();
		}
		
		boolean result = MessageDigestUtil.isSameMessage(Key, encKey);
		
		CmmnUserVO sVo = null;
		
		if(result) {
			sVo = selectUser(vo);
		}
		
		logger.debug("LoginService loginCheck end !!!");
		
		return sVo;
	}
	
	public boolean loginSsoCheck(UserVO vo) throws Exception{
		boolean bReturn = false;
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		String sUrlPath = ssoLoginCheckUrl + vo.getUserId() +":" + URLEncoder.encode(vo.getPassword(), "UTF-8");
		logger.debug("sUrlPath: " + sUrlPath);
		try {
			
			URL url = new URL(sUrlPath);
			
			ObjectMapper mapper = new ObjectMapper();
			StringBuilder postData = new StringBuilder();
			/*
				        for(Map.Entry<String,Object> param : params.entrySet()) {
				            if(postData.length() != 0) postData.append('&');
				            postData.append(URLEncoder.encode(param.getKey(), "UTF-8"));
				            postData.append('=');
				            postData.append(URLEncoder.encode(String.valueOf(param.getValue()), "UTF-8"));
				        }
			*/	        
	        byte[] postDataBytes = postData.toString().getBytes("UTF-8");
	 
	        HttpURLConnection conn = (HttpURLConnection)url.openConnection();
	        conn.setRequestMethod("GET");
	        conn.setRequestProperty("Content-Type", "text/plain");
	        conn.setRequestProperty("Content-Length", String.valueOf(postDataBytes.length));
	        conn.setDoOutput(true);
	        conn.getOutputStream().write(postDataBytes); // POST 호출
	 
	        int responseCode = conn.getResponseCode();
	        
	        BufferedReader in; 
	        if(responseCode == 200) { // 정상 호출
	            in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        }else {  // 에러 발생
	            in = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
	        }

	        String inputLine;
	        StringBuffer response = new StringBuffer();
	        while ((inputLine = in.readLine()) != null) {
	            response.append(inputLine);
	        }
	        in.close();
	        result.put("responseCode", responseCode);
	         
	        //String sResponseText = "( [{	             \"SABUN\": \"E20150023\",	             \"NAME\": \"함두완\",	             \"UNIT_CODE\": \"E7136\",	             \"UNIT_NAME\": \"다이렉트HR파트\",	             \"JOBPOSITION\": \"과장\",	             \"JOBTITLE\": \"파트장\",	             \"OFFICE_TEL\": \"02-589-4248\",	             \"MOBILE_TEL\": \"010-2374-1975\",	             \"EMAIL\": \"hamdw@dongwon.com\",	             \"ENT_CODE\": \"E\",	             \"ERR_CODE\": \"\",	             \"ERR_MSG\": \"\"	           }	         ])";
	        String sResponseText = response.toString();
	        int iPosition = sResponseText.indexOf("[");
	        sResponseText = sResponseText.substring(iPosition + 1);
	        iPosition = sResponseText.lastIndexOf("]");
	        sResponseText = sResponseText.substring(0, iPosition);
	        
	        //result.put("result", mapper.readValue(response.toString(), Map.class));
	        //result.put("result", mapper.readValue(sResponseText, Map.class));
	        
	        logger.debug("loginSsoCheck:: sResponseText: " + sResponseText);
	        
	        Map<String, Object> aResponse = (Map<String, Object>)mapper.readValue(sResponseText, Map.class);
	        if(((String)aResponse.get("ERR_CODE")).equals("0")) {
	        	bReturn = true;
	        }
	        
		} catch (Exception e) {
			// TODO Auto-generated catch block
			logger.debug("loginSsoCheck:: ERROR " );
			result.put("responseCode", (int)500);
			e.printStackTrace();
		}
		
		return bReturn;
		
	}
	
	
	/**
	 * 로그인시 유저 정보 SELECT
	 * @return
	 * @throws Exception
	 */
	/*public UserVO selectUser(UserVO vo) throws Exception{
		logger.debug("LoginService selectUser started !!!");
		
		logger.debug("LoginService selectUser end !!!");
		return loginDAO.selectUser(vo);
	}*/
	
	/**
	 * 로그인시 유저 정보 SELECT
	 * @return
	 * @throws Exception
	 */
	public CmmnUserVO selectUser(UserVO vo) throws Exception{
		logger.debug("LoginService selectUser started !!!");
		
		logger.debug("LoginService selectUser end !!!");
		return loginDAO.selectUser(vo);
	}
	
	/**
	 * 비밀번호 업데이트
	 * @return
	 * @throws Exception
	 */
	public void updatePwd(UserVO vo) throws Exception{
		logger.debug("LoginService updatePwd started !!!");
		
		loginDAO.updatePwd(vo); 
		
		logger.debug("LoginService updatePwd end !!!");
	}
	
	/**
	 * 이메일 통하여 등록된 유저 체크
	 * @return
	 * @throws Exception
	 */
	public int selectCountEmail(UserVO vo) throws Exception{
		logger.debug("LoginService selectCountEmail started !!!");
		
		logger.debug("LoginService selectCountEmail end !!!");
		
		return loginDAO.selectCountEmail(vo);
	}
	
	/**
	 * 이메일을 통한 아이디 찾기
	 * @return
	 * @throws Exception
	 */
	public UserVO selectFindId(UserVO vo) throws Exception{
		logger.debug("LoginService selectFindId started !!!");
		int checkEmail = loginDAO.selectCountEmail(vo);
		UserVO sVo = new UserVO();
		if(checkEmail > 0) {
			sVo = loginDAO.selectFindId(vo);
		}else {
			sVo=vo;
		}
		logger.debug("LoginService selectFindId end !!!");
		
		return sVo;
		}
}
