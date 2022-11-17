package kr.co.rpaplatform.dongwon.stdrinfo.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import kr.co.rpaplatform.dongwon.stdrinfo.vo.TaskTmplatMngVO;

@Repository
public class TaskTmplatMngDAO {

	private final Logger logger = LoggerFactory.getLogger(TaskTmplatMngDAO.class);
	
	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	public int selectTotalTaskTmplatMngListCount(TaskTmplatMngVO vo) throws Exception{
		return sqlSession.selectOne("selectTotalTaskTmplatMngListCount", vo);
	}
	
	public List<Map<String, Object>> selectTaskTmplatMngList(TaskTmplatMngVO vo) throws Exception{
		return sqlSession.selectList("selectTaskTmplatMngList", vo);
	}
	
	public TaskTmplatMngVO getMaxFileGrpNo(TaskTmplatMngVO vo) throws Exception {
		return  sqlSession.selectOne("getMaxFileGrpNo", vo);	
	}
	
	/**
	 * 과제템플릿 등록 중복체크
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public TaskTmplatMngVO insertCheck(TaskTmplatMngVO vo) throws Exception {
		return  sqlSession.selectOne("insertCheck", vo);	
	}
	
	
	public void insertTaskTmplatMng(TaskTmplatMngVO vo) throws Exception {
		sqlSession.insert("insertTaskTmplatMng", vo);
	}
	
	/**
	 * 과제템플릿 상세화면 내용 조회
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public TaskTmplatMngVO getTaskTmplatDetail(TaskTmplatMngVO vo) throws Exception {
		return  sqlSession.selectOne("getTaskTmplatDetail", vo);	
	}
	
	public void updateTaskTmplatMng(TaskTmplatMngVO vo) throws Exception {
		sqlSession.update("updateTaskTmplatMng", vo);
	}
	
	public void deleteTaskTmplatMng(TaskTmplatMngVO vo) throws Exception {
		sqlSession.delete("deleteTaskTmplatMng", vo);
	}
	
}
