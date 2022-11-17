package kr.co.rpaplatform.dongwon.cmmnty.vo;

import com.fasterxml.jackson.annotation.JsonInclude;

import kr.co.rpaplatform.common.pagination.PaginationInfo;
import kr.co.rpaplatform.dongwon.common.vo.CmmnUserVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=true)
public class BbsMngVO extends CmmnUserVO {

	/**
	 * serialVersionUID 
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * 게시판 번호
	 */
	private String boardNo;
	/**
	 * 게시판 코드
	 */
	private String boardCd;
	
	/**
	 * 게시판 이름
	 */
	private String boardNm;
	
	/**
	 * 게시판 타입
	 */
	private String boardTy;
	
	/**
	 * 게시판 url
	 */
	private String boardUrl;
	
	/**
	 * 게시판 설명
	 */
	private String boardDc;
	
	/**
	 * 등록자
	 */
	private String registerId;
	
	/**
	 * 등록일자
	 */
	private String regDt;
	
	/**
	 * 사용여부
	 */
	private String useAt;
	
	@JsonInclude(JsonInclude.Include.NON_NULL)
    private PaginationInfo pageInfo;
	
}
