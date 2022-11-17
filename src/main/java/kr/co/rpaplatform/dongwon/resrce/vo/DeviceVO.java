/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 6. 5.         LSH
 */
package kr.co.rpaplatform.dongwon.resrce.vo;

import java.io.Serializable;

import lombok.Data;

/**
 * 디바이스  VO
 * @author LSH
 * 2020. 6. 5.
 */
@Data
public class DeviceVO implements Serializable {
	
	/**
	 * serialVersionUID 
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * 아이디
	 */
	private int id = 0;
	
	/**
	 * 라이선스키
	 */
	private String licenseKey;
	
	/**
	 * 디바이스명
	 */
	private String name;
	
	/**
	 * 디바이스유형
	 */
	private int type = 0;
	
	/**
	 * 비운영슬롯
	 */
	private int nonProductionSlots = 0;
	
	/**
	 * unattended 슬롯
	 */
	private int unattendedSlots = 0;
	
	/**
	 * headless 슬롯
	 */
	private int headlessSlots = 0;
	
	/**
	 * 테스트 자동화 슬롯
	 */
	private int testAutomationSlots = 0;
	
	
	private String description; 
	
	/**
	 * 회사코드
	 */
	private String cmpnyCd;

}
