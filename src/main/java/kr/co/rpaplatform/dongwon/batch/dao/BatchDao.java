package kr.co.rpaplatform.dongwon.batch.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;


@Repository
public class BatchDao {
	private final Logger logger = LoggerFactory.getLogger(BatchDao.class);
	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	@Resource(name="groupwareSession")
	private SqlSession groupwareSession;
	
	
	public List<Map<String, Object>> getDongwonDeptList() throws Exception{
		return groupwareSession.selectList("GwpwrDeptMapper.getDongwonDeptList");
	}
	
	
	public void syncDongwonDept(Map<String, Object> aParam) throws Exception{
		sqlSession.insert("BatchMapper.syncDongwonDept", aParam);
	}
	
	public List<Map<String, Object>> getDongwonUserList() throws Exception{
		return groupwareSession.selectList("GwpwrUserMapper.getDongwonUserList");
	}
	
	public void syncDongwonUserBas(Map<String, Object> aParam) throws Exception{
		sqlSession.insert("BatchMapper.syncDongwonUserBas", aParam);
	}
	
	public void syncDongwonUserDetail(Map<String, Object> aParam) throws Exception{
		sqlSession.insert("BatchMapper.syncDongwonUserDetail", aParam);
	}
	
	public void insertSyncExecutDscntcImg(Map<String, Object> aParam) throws Exception{
		sqlSession.insert("BatchMapper.insertSyncExecutDscntcImg", aParam);
	}
	
	public void syncArcLogs() throws Exception{
		sqlSession.insert("BatchMapper.syncArcLogs");
	}
}
