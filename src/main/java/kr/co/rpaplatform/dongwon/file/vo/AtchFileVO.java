package kr.co.rpaplatform.dongwon.file.vo;

import java.io.Serializable;

import lombok.Data;

/**
 * 첨부파일 VO
 * @author jw.lee
 *
 */
@Data
public class AtchFileVO  implements Serializable {
	
	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * 파일 그룹 번호
	 */
	private int fileGrpNo;
	
	/**
	 * 파일 번호
	 */
	private int fileNo;
	
	/**
	 * 원본 파일명
	 */
	private String oriFileNm;
	
	/**
	 * 저장 경로
	 */
	private String savePath;
	
	/**
	 * 파일 사이즈
	 */
	private int fileSz;
	
	/**
	 * 저장 파일명
	 */
	private String saveFileNm;
	
	/**
	 * 등록자
	 */
	private String creatUsr;
	
	/**
	 * 등록일시
	 */
	private String creatDt;

}
