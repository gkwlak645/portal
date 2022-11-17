/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 6. 2.         LSH
 */
package kr.co.rpaplatform.dongwon.author.vo;


import kr.co.rpaplatform.dongwon.common.vo.CmmnUserVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author LSH
 * 2020. 6. 2.
 */
@Data
@EqualsAndHashCode(callSuper=true)
public class AuthorVO extends CmmnUserVO {
	
	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * 역할코드
	 */
	private String roleCd;
	
	/**
	 * 메뉴코드
	 */
	private String menuCd;
	
	/**
	 * 조회권한
	 */
	private String redngAuthor;
	
	/**
	 * 등록 및 수정 권한
	 */
	private String wrtngAuthor;
	
	/**
	 * 전체 테넌트 보기
	 */
	private String untenantAuthor;
	
	/**
	 * 예약권한2
	 */
	private String resveAuthor2;
	
	/**
	 * 예약권한3
	 */
	private String resveAuthor3;
	
	/**
	 * 예약권한4
	 */
	private String resveAuthor4;
	
	/**
	 * 예약권한5
	 */
	private String resveAuthor5;
	
	/**
	 * 예약권한1이름
	 * */
	private String resveAuthorNm1;
	
	/**
	 * 예약권한2이름
	 * */
	private String resveAuthorNm2;
	
	/**
	 * 예약권한3이름
	 * */
	private String resveAuthorNm3;
	
	/**
	 * 예약권한4이름
	 * */
	private String resveAuthorNm4;
	
	/**
	 * 예약권한5이름
	 * */
	private String resveAuthorNm5;


}