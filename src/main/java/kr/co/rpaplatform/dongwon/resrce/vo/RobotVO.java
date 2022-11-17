package kr.co.rpaplatform.dongwon.resrce.vo;

import lombok.Data;

@Data
public class RobotVO {

	/**
	 * serialVersionUID 
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * 디바이스 아이디
	 */
	private int deviceId = 0;

	/**
	 * 디바이스 아이디
	 */
	private String deviceName;

	/**
	 * 로봇 아이디
	 */
	private String robotId;
	/**
	 * 로봇명
	 */
	private String name;
	
	/**
	 * 로봇 설명
	 */
	private String robotDescription;
	
	/**
	 * 로봇 타입
	 */
	private int type;
	/**
	 * 로봇 타입
	 */
	private String typeName;
	
	/**
	 * 유저이름
	 */
	private String userName;
	
	/**
	 * 패스워드
	 */
	private String passWord;
	/**
	 * 아이피
	 */
	private String robotIp;
	
	
	
	/////////////////////////////////////////////////////////////
	
	//private Integer id;

	
	private String tenantId;
	
	
	private String robotPassword;
	
	
	/**
	 * 회사코드
	 */
	private String cmpnyCd;

}
