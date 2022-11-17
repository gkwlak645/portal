package kr.co.rpaplatform.dongwon.stdrinfo.vo;

import com.fasterxml.jackson.annotation.JsonInclude;

import kr.co.rpaplatform.common.pagination.PaginationInfo;
import kr.co.rpaplatform.dongwon.common.vo.CmmnUserVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=true)
public class TaskTmplatMngVO extends CmmnUserVO {

	
	/**
	 * serialVersionUID 
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * 일련번호
	 */
	private int sn;
	
	/**
	 * 템플릿 코드
	 */
	private String tmplatCd;
	
	/**
	 * 템플릿 이름
	 */
	private String tmplatNm;
	
	/**
	 * 프로세스 코드
	 */
	private String processCd;
	
	/**
	 * 프로세스 이름
	 */
	private String processNm;
	
	/**
	 * 파일 그룹 번호 
	 */
	private String fileGrpNo;

	/**
	 * 다운로드 URL
	 */ 
	private String dwldUrl;
	
	/**
	 * 등록한 ID
	 */
	private String registerId;
	
	/**
	 * 등록시간
	 */
	private String regDt;
	
	/**
	 * 수정한 ID
	 */
	private String updusrId;

	/**
	 * 수정시간
	 */ 
	private String updtDt;
	
	/**
	 * 검색 조건 시작 날짜
	 */
	private String startDt;
	
	/**
	 * 검색 조건 마지막 날짜
	 */
	private String lastDt;
	
	/**
	 * 파일 이름
	 */
	private String oriFileNm;
	
	
	/*
	 * 회사코드 
	 */
	private String cmpnyCd;
	
	/*
	 * 동일 사용자 여부 
	 */
	private String identityFlag;
	
	@JsonInclude(JsonInclude.Include.NON_NULL)
    private PaginationInfo pageInfo;
}
