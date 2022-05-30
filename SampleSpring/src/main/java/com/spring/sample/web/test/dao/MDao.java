package com.spring.sample.web.test.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MDao implements IMDao {
	
	@Autowired
	public SqlSession sqlSession;

	@Override
	public List<HashMap<String, String>> getList() throws Throwable {
		return sqlSession.selectList("m.getList");
	}

	@Override
	public void mAdds(HashMap<String, String> params) throws Throwable {
		sqlSession.insert("m.mAdds", params);
	}

	@Override
	public int checkId(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("m.checkId",params);
	}

	@Override
	public HashMap<String, String> getLogin(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("m.getLogin",params);
	}
	

}
