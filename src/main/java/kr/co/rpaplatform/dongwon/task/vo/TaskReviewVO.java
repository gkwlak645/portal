/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 7. 15.         LSH        최초 작성
 */
package kr.co.rpaplatform.dongwon.task.vo;

import kr.co.rpaplatform.dongwon.common.vo.CmmnUserVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 과제검토 VO
 * @author LSH
 */
@Data
@EqualsAndHashCode(callSuper=true)
public class TaskReviewVO extends CmmnUserVO {
	
	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * 과제코드
	 */
	private String taskNo;
	
	/**
	 * 과제검토번호
	 */
	private String taskReviewNo;
	
	/**
	 * 진행단계코드
	 */
	private String prgrStpCd;
	
	/**
	 * 상태코드
	 */
	private String sttusCd;
	
	/**
	 * 상태명
	 */
	private String sttusNm;
	
	/**
	 * 검토의견
	 */
	private String reviewOpin;

}
