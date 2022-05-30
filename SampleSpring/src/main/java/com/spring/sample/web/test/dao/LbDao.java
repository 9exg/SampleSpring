package com.spring.sample.web.test.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LbDao implements ILbDao{
	
	@Autowired
	public SqlSession sqlSession;

	public List<HashMap<String, String>> getLbList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("lb.getLbList",params);
	}

	@Override
	public HashMap<String, String> getLb(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("lb.getLb", params);	
	}

	@Override
	public int getCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("lb.getCnt",params);
	}

	@Override
	public void lbWrite(HashMap<String, String> params) throws Throwable {
		sqlSession.insert("lb.lbWrite", params);
	}

	@Override
	public int lbUpdate(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("lb.lbUpdate", params);
	}

	@Override
	public int lbDelete(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("lb.lbDelete", params);
	}

}
