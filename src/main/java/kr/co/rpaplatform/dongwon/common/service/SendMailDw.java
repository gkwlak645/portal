/**
 * 
 */
package kr.co.rpaplatform.dongwon.common.service;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Part;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;


@Service
public class SendMailDw {
	private final Logger logger = LoggerFactory.getLogger(SendMailDw.class);
	
	protected String IP = "172.20.18.13"; // 메일 서버 IP 수정(20181220 by Guk).
	protected String PORT = "25";
	protected String USER = "";
	protected String PW = "";
	
	/**
	 * Multi 수신자, Multi 참조자, 단일 파일 첨부
	 * @param to - ;이나 :로 연결된 메일주소 ===> 사번이 아닌 메일주소가 들어가야 한다.
	 * @param from - (주의) 첨부파일이 있고 외부로 발송시 from 이 반드시 있어야 한다.(결재)  ==> 사번 or EMAIL 주소 모두 가능
	 * @param cc - ;이나 :로 연결된 메일주소 ===> 사번이 아닌 메일주소가 들어가야 한다.
	 * @param title
	 * @param contents - HTML 형식
	 * @param processId - PROCESS ID
	 * @param appendId - (주의) FILE_COMMON 에 있는 APPEND_ID 로 뒤진다.
	 */
	public void sendMail(String to, String title, String contents){
		
		Properties props = new Properties();
		props.setProperty("mail.smtp.host", IP);
		props.put("mail.smtp.port", PORT);
		
		
		
		//props.setProperty("mail.smtp.connectiontimeout", "25000");
		props.setProperty("mail.smtp.connectiontimeout", "30000");
		//props.setProperty("mail.smtp.timeout", "25000");
		props.setProperty("mail.smtp.timeout", "30000");
        props.put("mail.smtp.auth", "false");
        props.put("mail.smtp.user", USER);
        props.put("mail.smtp.password", PW);
        
     // id와 password를 설정하고 session을 생성합니다.
        Session session = Session.getInstance(props, new Authenticator() {
        	protected PasswordAuthentication getPasswordAuthentication() {
        		return new PasswordAuthentication(USER, PW);
        	}
        });
		 
		try {
			// 메일 메시지를 만들기 위한 클래스를 생성합니다.
			MimeMessage message = new MimeMessage(session);
			// 송신자 설정
			message.setFrom(getAddress("rpatest@dongwon.com"));
			// 수신자 설정			
			message.addRecipients(Message.RecipientType.TO, getAddresses(to));
			
			// 참조 수신자 설정
			//message.addRecipients(Message.RecipientType.CC, getAddresses(""));
			// 숨은 참조 수신자 설정
			//message.addRecipients(Message.RecipientType.BCC, getAddresses(""));
			// 메일 제목을 설정합니다.
			message.setSubject(title);
			// 메일 내용을 설정을 위한 클래스를 설정합니다.		
			message.setContent(new MimeMultipart());
			// 메일 내용을 위한 Multipart클래스를 받아온다. (위 new MimeMultipart()로 넣은 클래스입니다.)
			Multipart mp = (Multipart) message.getContent();
			// html 형식으로 본문을 작성해서 바운더리에 넣습니다.			
			mp.addBodyPart(getContents(contents));
			// 첨부 파일을 추가합니다.
			//mp.addBodyPart(getFileAttachment("test.xlsx"));
			// 이미지 파일을 추가해서 contextId를 설정합니다. contextId는 위 본문 내용의 cid로 링크가 설정 가능합니다.
			//mp.addBodyPart(getImage("capture.png", "image"));
			// 메일을 보냅니다.

			

			Transport.send(message);
			System.out.println("★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★");
			
		} catch (Exception e) {
		    //예외를 던지지 않는다.
			logger.info("Mail Error : " + e.getMessage());
			//메일은 발송되나 SMTP (Read time out) 에러가 무조건 발생하여 예외찍지 않는다.
			
			/*
			if(!"dev".equals(Config.DEFAULT_SERVICE_TYPE)){	//개발에선 안보낸다.
				
				StringBuffer sb = new StringBuffer();
				sb.append("PROCESS_ID : " + processId + "<br>메일발송 실패<br><br>");
				sb.append("TO : " + to + "<br>");
				sb.append("CC : " + cc + "<br>");
				sb.append("TITLE : " + title + "<br>");
				sb.append(e.getMessage());
				try{
					CommonUtil.sendMailMulti("[BPM Noti.]BPM 메일발송 실패", sb.toString(), "", "jaehyun.kim@seoulsemicon.com;303630@seoulsemicon.com;", "");				
				}catch(Exception ex){
				}
			}
			*/
		}
	}
	
	// String으로 된 복수의 메일 주소를 콤마(,)의 구분으로 Address array형태로 변환
	private Address[] getAddresses(String addresses) throws AddressException {
		String[] array = addresses.split(",");
		Address[] ret = new Address[array.length];
		for (int i = 0; i < ret.length; i++) {
			ret[i] = getAddress(array[i]);
		}
		return ret;
	}

	// String으로 된 메일 주소를 Address 클래스로 변환
	private Address getAddress(String address) throws AddressException {
		return new InternetAddress(address);
	}


	// 메일의 본문 내용 설정
	private BodyPart getContents(String html) throws MessagingException {
		BodyPart mbp = new MimeBodyPart();
		// setText를 이용할 경우 일반 텍스트 내용으로 설정된다.
		// mbp.setText(html);
		// html 형식으로 설정
		mbp.setContent(html, "text/html; charset=utf-8");
		return mbp;
	}

	// 이미지를 로컬로 부터 읽어와서 BodyPart 클래스로 만든다. (바운더리 변환)
	private BodyPart getImage(String filename, String contextId) throws MessagingException {
		// 파일을 읽어와서 BodyPart 클래스로 받는다.
		BodyPart mbp = getFileAttachment(filename);
		if (contextId != null) {
			// ContextId 설정
			mbp.setHeader("Content-ID", "<" + contextId + ">");
		}
		return mbp;
	}
	
	// 파일을 로컬로 부터 읽어와서 BodyPart 클래스로 만든다. (바운더리 변환)
	private BodyPart getFileAttachment(String filename) throws MessagingException {
		// BodyPart 생성
		BodyPart mbp = new MimeBodyPart();
		// 파일 읽어서 BodyPart에 설정(바운더리 변환)
		File file = new File(filename);
		DataSource source = new FileDataSource(file);
		mbp.setDataHandler(new DataHandler(source));
		mbp.setDisposition(Part.ATTACHMENT);
		mbp.setFileName(file.getName());
		return mbp;
	}


		
//public void sendMail(String to, String from, String cc, String title, String contents, String processId, String appendId){
//		
//		Properties props = new Properties();
//		
//		props.setProperty("mail.smtp.host", IP);
//		props.put("mail.smtp.port", PORT);
//		//props.setProperty("mail.smtp.connectiontimeout", "25000");
//		props.setProperty("mail.smtp.connectiontimeout", "3000");
//		//props.setProperty("mail.smtp.timeout", "25000");
//		props.setProperty("mail.smtp.timeout", "3000");
//        props.put("mail.smtp.auth", "false");
//        props.put("mail.smtp.user", USER);
//        props.put("mail.smtp.password", PW);
//        
//		Session session = Session.getDefaultInstance(props, null);
//		//session.setDebug(true);
//		
//		MimeMessage msg = new MimeMessage(session);
//		
//		String fromName = "BPM";
//		 
//		try {
//		    //validation
//			if(to == null || "".equals(to)){
//				throw new Exception("Parameter is null : TO_MAIL");
//			}
//			if(from == null || "".equals(from)){
//				from = "sscbpm@seoulsemicon.com";
//
//				if("dev".equals(Config.DEFAULT_SERVICE_TYPE)){		//개발일 경우 sscbpmtest 처리
//					from = "sscbpmtest@seoulsemicon.com";
//				}
//				//from = "304694@seoulsemicon.com";
//			}else{
//				if(from.indexOf("@") < 0){
//					//사번으로 넘어왔다고 판단하고 메일주소 검색
//					
//					Map<String, Object> paramMap = new HashMap<String, Object>();
//			    	paramMap.put("EMP_NO", from);
//
//			    	List<Map<String, Object>> fileList = CommonUtil.getList(SqlSessionUtil.DEFAULT, "COMMON.SELECT_EMAIL_OF_EMP_NO", paramMap);
//			    	
//			    	from = StringUtil.print(fileList.get(0).get("EMAIL"));
//			    	fromName = StringUtil.print(fileList.get(0).get("EMP_NAME"));
//				} else if("sskv@seoulsemicon.com".equals(from)) {
//					fromName = "SSKV";
//				}
//			}
//			
//			String[] toEmpArr = to.split(";");
//			String[] ccEmpArr = cc.split(";");
//			
//			// 발신자, 수신자, 참조자, 제목, 본문 내용 등을 설정한다
//		    msg.setFrom(new InternetAddress(from, fromName));
//		    
//		    //20171025 304694 : 사번으로만 왔을 경우 메일주소 찾아서 처리
//		    if(to.indexOf("@") < 0){
//		    	
//		    	Map<String, Object> paramMap_forMail = new HashMap<String, Object>(); 
//		    	ArrayList<String> toList = new ArrayList(Arrays.asList(toEmpArr)); 
//		    	
//				paramMap_forMail.put("EMP_NO_LIST", toList);
//				
//				List<Map<String, Object>> toMailList = CommonUtil.getList(SqlSessionUtil.DEFAULT, "COMMON.SELECT_EMAIL_OF_EMP_NO_LIST", paramMap_forMail);
//				
//				if(toMailList != null){
//					toEmpArr = new String[toMailList.size()];
//					
//					for(int i = 0; i < toMailList.size(); i++){
//						Map<String, Object> m = toMailList.get(i);
//						toEmpArr[i] = StringUtil.print(m.get("EMAIL"));
//					}
//				}
//		    }
//		    
//		    if(cc.indexOf("@") < 0){
//		    	
//		    	Map<String, Object> paramMap_forMail = new HashMap<String, Object>(); 
//		    	ArrayList<String> ccList = new ArrayList(Arrays.asList(ccEmpArr)); 
//		    	
//				paramMap_forMail.put("EMP_NO_LIST", ccList);
//				
//				List<Map<String, Object>> ccMailList = CommonUtil.getList(SqlSessionUtil.DEFAULT, "COMMON.SELECT_EMAIL_OF_EMP_NO_LIST", paramMap_forMail);
//				
//				if(ccMailList != null){
//					ccEmpArr = new String[ccMailList.size()];
//					
//					for(int i = 0; i < ccMailList.size(); i++){
//						Map<String, Object> m = ccMailList.get(i);
//						ccEmpArr[i] = StringUtil.print(m.get("EMAIL"));
//					}
//				}
//		    }
//		    
//		    for(int i = 0; i < toEmpArr.length; i++){
//		    	if(!toEmpArr[i].equals("")){
//		    		msg.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmpArr[i], toEmpArr[i].split("@")[0]));		    		
//		    	}
//		    }
//		    
//		    for(int i = 0; i < ccEmpArr.length; i++){
//		    	if(!ccEmpArr[i].equals("")){
//		    		msg.addRecipient(Message.RecipientType.CC, new InternetAddress(ccEmpArr[i], ccEmpArr[i].split("@")[0]));		    		
//		    	}
//		    }
//		    
//		    msg.setSubject(title);
//		    
//		    MimeMultipart multipart = new MimeMultipart();
//		    
//		    MimeBodyPart part = new MimeBodyPart();
//		    part.setContent(contents, "text/html; charset=utf-8");
//		    multipart.addBodyPart(part);
//		    
//		    //파일 처리
//		    if(appendId != null && !appendId.equals("")){
//		    	Map<String, Object> paramMap = new HashMap<String, Object>();
//		    	paramMap.put("PROCESS_ID", processId);
//		    	paramMap.put("FILE_ID", appendId);
//
//		    	List<Map<String, Object>> fileList = CommonUtil.getList(SqlSessionUtil.DEFAULT, "COMMON.SELECT_FILE_COMMON", paramMap);
//
//		    	if(fileList != null && !fileList.isEmpty()){
//		    		//FILE_PATH, FILE_NAME, FILE_SAVE_NAME
//		    		for(int i = 0; i < fileList.size(); i++){
//		    			Map<String, Object> map = fileList.get(i);
//		    			
//		    			String path = StringUtil.print(map.get("FILE_PATH"));
//		    			String saveName = StringUtil.print(map.get("FILE_SAVE_NAME"));
//		    			
//		    			part = new MimeBodyPart();
//		    			
//		    		    FileDataSource fds = new FileDataSource(path + "/" + saveName);
//		    		    logger.info("file path : " + path + "/" + saveName);
//		    		    
//		    		    part.setDataHandler(new DataHandler(fds));
//		    		    part.setFileName(MimeUtility.encodeText(fds.getName(), "UTF-8", "B"));
//		    		    
//		    		    multipart.addBodyPart(part);
//		    		}
//		    	}
//		    }
//		    
//		    msg.setContent(multipart);
//		    
//		    // 메일을 발신한다
//		    Transport.send(msg);
//		    
//		} catch (Exception e) {
//		    //예외를 던지지 않는다.
//			logger.info("Mail Error : " + e.getMessage());
//			//메일은 발송되나 SMTP (Read time out) 에러가 무조건 발생하여 예외찍지 않는다.
//			
//			/*
//			if(!"dev".equals(Config.DEFAULT_SERVICE_TYPE)){	//개발에선 안보낸다.
//				
//				StringBuffer sb = new StringBuffer();
//				sb.append("PROCESS_ID : " + processId + "<br>메일발송 실패<br><br>");
//				sb.append("TO : " + to + "<br>");
//				sb.append("CC : " + cc + "<br>");
//				sb.append("TITLE : " + title + "<br>");
//				sb.append(e.getMessage());
//				try{
//					CommonUtil.sendMailMulti("[BPM Noti.]BPM 메일발송 실패", sb.toString(), "", "jaehyun.kim@seoulsemicon.com;303630@seoulsemicon.com;", "");				
//				}catch(Exception ex){
//				}
//			}
//			*/
//		}
//	}
}
