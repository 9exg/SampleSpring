package com.spring.sample.web.test.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ObDao implements IObDao {
	@Autowired
	public SqlSession sqlSession;

	@Override
	public int getObCnt() throws Throwable {	
		return sqlSession.selectOne("ob.getObCnt");
	}

	@Override
	public List<HashMap<String, String>> getOb(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("ob.getOb", params);
	}

	@Override
	public void obWrite(HashMap<String, String> params) throws Throwable {
		sqlSession.insert("ob.obWrite", params);
	}

	@Override
	public void obUpdate(HashMap<String, String> params) throws Throwable {
		sqlSession.update("ob.obUpdate", params);
	}

	@Override
	public void obDelete(HashMap<String, String> params) throws Throwable {
		sqlSession.update("ob.obDelete", params);	
	}

}
