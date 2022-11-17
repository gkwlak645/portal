package kr.co.rpaplatform.dongwon.hub.vo;

import java.util.Date;

import lombok.Data;

@Data
public class HubVO {

	
	/**
	 * serialVersionUID 
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * 자동화이름
	 */
	private String PIPELINE_NAME;
	
	/**
	 * 계층
	 */
	private String PIPELINE_HIERARCHY;

	/**
	 * 단계 
	 */
	private String PIPELINE_PHASE;

	/**
	 * 상태
	 */
	private String PIPELINE_STATUS;
	
	/**
	 * 자동화목표
	 */
	private String PIPELINE_GOAL;
	
	/**
	 * 점수
	 */
	private int PIPELINE_SCORE;
	
	/**
	 * 등록일
	 */
	
	private  Date   PIPELINE_REGDATE;
	
	/**
	 * 수정일
	 */

	private  Date   PIPELINE_UPDATE_DATE;
	
	/**
	 * 점수
	 */
	private  String  PIPELINE_ACTION;
	
	
}
