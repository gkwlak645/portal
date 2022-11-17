/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 7. 14.         LSH        최초 작성
 */
package kr.co.rpaplatform.dongwon.task.vo;

import java.util.List;

import kr.co.rpaplatform.dongwon.common.vo.CmmnUserVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 과제 VO
 * @author LSH
 */
@Data
@EqualsAndHashCode(callSuper=true)
public class TaskVO extends CmmnUserVO {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * 과제코드
	 */
	private String taskNo;
	
	/**
	 * 과제명
	 */
	private String taskNm;
	
	/**
	 * 담당부서코드
	 */
	private String chrgDeptCd;
	
	/**
	 * 담당자사용자아이디
	 */
	private String chargerUserId;
	
	/**
	 * 과제빈도코드
	 */
	private String taskFqCd;
	
	/**
	 * 과제빈도건수
	 */
	private int taskFqCnt = 0;
	
	/**
	 * 건별처리시간
	 */
	private int csbyProcessTm = 0;
	
	/**
	 * 처리시간단위
	 */
	private String processTmUnit;
	
	/**
	 * 처리인원
	 */
	private int processNp = 0;
	
	/**
	 * 과제설명
	 */
	private String taskDc;
	
	/**
	 * 요청일
	 */
	private String requstDe;
	
	/**
	 * 설계자사용자아이디 
	 */
	private String dsgnrUserId;
	
	/**
	 * 설계자사용자명
	 */
	private String dsgnrUserNm;
	
	/**
	 * 파일그룹번호
	 */
	private int fileGrpNo = 0;
	
	/**
	 * 과제활용시스템 리스트
	 */
	private List<TaskPrcuseSysVO> taskPrcuseSysList;

}
