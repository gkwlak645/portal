/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 6. 3.         LSH
 */
package kr.co.rpaplatform.dongwon.menu.vo;

import java.util.Date;

import kr.co.rpaplatform.dongwon.common.vo.CmmnUserVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 메뉴 VO
 * @author LSH
 * 2020. 6. 3.
 */
@Data
@EqualsAndHashCode(callSuper=true)
public class MenuVO extends CmmnUserVO {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * 메뉴코드
	 */
	private String menuCd;
	
	/**
	 * 메뉴명
	 */
	private String menuNm;
	
	/**
	 * 메뉴URL
	 */
	private String menuUrl;
	
	/**
	 * 상위메뉴코드
	 */
	private String upMenuCd;
	
	/**
	 * 메뉴순서
	 */
	private int menuOrdr;
	
	/**
	 * 메뉴아이콘경로
	 */
	private String menuIconCours;
	
	/**
	 * 메뉴설명
	 */
	private String menuDc;
	
	/**
	 * 사용여부
	 */
	private String useAt;
	
	/**
	 * 등록자아이디
	 */
	private String registerId;
	
	/**
	 * 등록일시
	 */
	private Date regDt;
	
	/**
	 * 수정자아이디
	 */
	private String updusrId;
	
	/**
	 * 수정일시
	 */
	private Date updtDt;

}
