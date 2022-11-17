package kr.co.rpaplatform.dongwon.file.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.co.rpaplatform.dongwon.file.vo.AtchFileVO;


/**
 * 첨부파일 DAO
 * @author jw.lee
 *
 */
@Repository
public class AtchFileDAO {

	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	/**
	 * 첨부파일 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public AtchFileVO selectAtchmnfl(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("selectAtchmnfl", map);
	}
	
	/**
	 * 첨부파일 목록 조회
	 * @param fileGrpNo
	 * @return
	 * @throws Exception
	 */
	public List<AtchFileVO> selectAtchmnflList(int fileGrpNo) throws Exception {
		return sqlSession.selectList("selectAtchmnflList", fileGrpNo);
	}
	
	
	/**
	 * 파일그룹번호 채번
	 * @return
	 * @throws Exception
	 */
	public int selectNextFileGrpNo() throws Exception {
		return sqlSession.selectOne("selectNextFileGrpNo");
	}
	
	/**
	 * 삭제 파일 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<AtchFileVO> selectDeleteFile(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("selectDeleteFile", map);
	}
	
	/**
	 * 첨부파일 삭제
	 * @param map
	 * @throws Exception
	 */
	public void deleteAtchmnfl(Map<String, Object> map) throws Exception {
		sqlSession.delete("deleteAtchmnfl", map);
	}
	
	/**
	 * 파일번호 채번
	 * @param fileGrpNo
	 * @return
	 * @throws Exception
	 */
	public int selectNextFileNo(int fileGrpNo) throws Exception {
		return sqlSession.selectOne("selectNextFileNo", fileGrpNo);
	}

	/**
	 * 파일 등록
	 * @param atchUploadFileVO
	 * @throws Exception
	 */
	public void insertAtchmnfl(AtchFileVO atchUploadFileVO) throws Exception {
		sqlSession.insert("insertAtchmnfl", atchUploadFileVO);
	}
	
	public int templateUploadChk(int fileGrpNo) throws Exception {
		return sqlSession.selectOne("templateUploadChk", fileGrpNo);
	}
	
	/**
	 * 업데이트 날짜 업데이트
	 * @param map
	 * @throws Exception
	 */
	public void updateDtAtchmnfl(Map<String, Object> map) throws Exception {
		sqlSession.update("updateDtAtchmnfl", map);
	}
}
