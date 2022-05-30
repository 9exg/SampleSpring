package com.spring.sample.web.test.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ABDao implements IABDao {
	@Autowired
	public SqlSession sqlSession;

	@Override
	public int getAbCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("ab.getAbCnt",params);
	}

	@Override
	public List<HashMap<String, String>> getAbList(HashMap<String, String> params) throws Throwable {		
		return sqlSession.selectList("ab.getAbList",params);
	}

	@Override
	public void abAdd(HashMap<String, String> params) throws Throwable {
		sqlSession.insert("ab.abAdd",params);
		
	}

	@Override
	public HashMap<String, String> getAb(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("ab.getAb", params);
	}

	@Override
	public int abUpdate(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("ab.abUpdate", params);
	}

	@Override
	public int abDelete(HashMap<String, String> params) throws Throwable {
		return sqlSession.delete("ab.abDelete",params);
	}

	@Override
	public HashMap<String, String> getAnaly(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("ab.getAnaly", params);
	}

}
