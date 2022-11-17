package kr.co.rpaplatform.dongwon.cmmnty.vo;

import kr.co.rpaplatform.dongwon.common.vo.CmmnUserVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=true)
public class BbsAnswerVO extends CmmnUserVO {
	
	/**
	 * serialVersionUID 
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * 게시판 코드
	 */
	private String boardNo;
	
	/**
	 * 번호
	 */
	private int boardSn;
	
	/**
	 * 댓글번호
	 */
	private int answerSn;
	
	/**
	 * 댓글내용
	 */
	private String answerCn;
	
	/**
	 * 상위댓글번호
	 */
	private int upAnswerSn;
	
	/**
	 * 댓글등록자
	 */
	private String registerId;
	
	/**
	 * 댓글등록일자
	 */
	private String regDt;

}
