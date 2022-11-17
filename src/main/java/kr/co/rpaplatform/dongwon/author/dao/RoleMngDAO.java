package kr.co.rpaplatform.dongwon.author.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.co.rpaplatform.dongwon.author.vo.RoleMngVO;

@Repository
public class RoleMngDAO {
		/**
		 * sqlSession
		 */
		@Resource(name="sqlSession")
		private SqlSession sqlSession;
		
		/**
		 * 역할코드 리스트 조회
		 * @return
		 * @throws Exception
		 */
		public List<RoleMngVO> selectRoleMngList(RoleMngVO vo) throws Exception {
			return sqlSession.selectList("selectRoleMngList", vo);
		}
		
		/**
		 * 역할 코드 업데이트
		 * @return
		 * @throws Exception
		 */
		public void updateRoleMng(RoleMngVO vo) throws Exception{
			sqlSession.update("updateRoleMng", vo);
		}
		
		/**
		 * 역할 코드 추가 
		 * @return
		 * @throws Exception
		 */
		public void insertRoleMng(RoleMngVO vo) throws Exception{
			sqlSession.insert("insertRoleMng", vo);
		}
		/**
		 * 역할 코드 제거
		 * @return
		 * @throws Exception
		 */
		public void deleteRoleMng(RoleMngVO vo) throws Exception{
			sqlSession.update("deleteRoleMng", vo);
		}
		
		/**
		 * 역할 코드 추가 및 업데이트를 위한 역할  유무 확인
		 * @return
		 * @throws Exception
		 */
		public int selectCountRoleMngList(RoleMngVO vo) throws Exception{
			return sqlSession.selectOne("selectCountRoleMngList", vo);
		}
}
