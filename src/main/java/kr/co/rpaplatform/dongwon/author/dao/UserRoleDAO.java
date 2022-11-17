package kr.co.rpaplatform.dongwon.author.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.co.rpaplatform.dongwon.author.vo.RoleMngVO;
import kr.co.rpaplatform.dongwon.author.vo.UserRoleVO;

@Repository
public class UserRoleDAO {

	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	/**
	 * 사용자별역할 변경
	 * @return
	 * @throws Exception
	 */
	public void updateUserRole(UserRoleVO vo) throws Exception{
		sqlSession.update("updateUserRole", vo);
	}
	
	/**
	 * 사용자별역할 등록
	 * @return
	 * @throws Exception
	 */
	public void insertUserRole(UserRoleVO vo) throws Exception{
		sqlSession.update("insertUserRole", vo);
	}
	
	/**
	 * 사용자별역할 유무 확인
	 * @return
	 * @throws Exception
	 */
	/*public List<UserRoleVO> getUserRole(UserRoleVO vo) throws Exception{*/
	public UserRoleVO getUserRole(UserRoleVO vo) throws Exception{
		/*return sqlSession.selectList("selectUserRole", vo);*/
		return sqlSession.selectOne("selectUserRole", vo);
	}
	
	/**
	 * 역할 삭제 시 사용자별 역할 삭제
	 * @return
	 * @throws Exception
	 */
	public void deleteUserRole(UserRoleVO vo) {
		sqlSession.delete("deleteUserRole", vo);
	}

	/**
	 * 역할 수정 추가 및 업데이트를 위한 역할  유무 확인
	 * @return
	 * @throws Exception
	 */
	public int selectCountUserRole(UserRoleVO vo) {
		return sqlSession.selectOne("selectCountUserRole", vo);
	}
	
	
	/**
	 * 권한에 따른 파일 다운로드 버튼 활성화 권한 체크
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectDownloadBtnUserRoleCount(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("selectDownloadBtnUserRoleCount",map);
	}
}
