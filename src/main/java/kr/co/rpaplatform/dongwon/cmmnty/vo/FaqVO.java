package kr.co.rpaplatform.dongwon.cmmnty.vo;

import com.fasterxml.jackson.annotation.JsonInclude;

import kr.co.rpaplatform.common.pagination.PaginationInfo;
import kr.co.rpaplatform.dongwon.common.vo.CmmnUserVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=true)
public class FaqVO extends CmmnUserVO{
	
	/**
	 * serialVersionUID 
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * 게시판 번호
	 */
	private String boardNo;
	
	/**
	 * FAQ게시글번호
	 */
	private int boardSn;
	
	/**
	 * FAQ제목
	 */
	private String boardSj;

	/**
	 * FAQ내용 
	 */
	private String boardCn;
	
	/**
	 * FAQ답변
	 */
	private String boardAnswerCn;

	/**
	 * 등록자
	 */
	private String registerId;
	
	/**
	 * 등록일자
	 */
	private String regDt;
	
	/**
	 * 파일 그룹번호
	 */
	private int fileGrpNo;
	
	/**
	 * 검색 조건 시작 날짜
	 */
	private String startDt;
	
	/**
	 * 검색 조건 마지막 날짜
	 */
	private String lastDt;
	
	
	@JsonInclude(JsonInclude.Include.NON_NULL)
    private PaginationInfo pageInfo;
}
