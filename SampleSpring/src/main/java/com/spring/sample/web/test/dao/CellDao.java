package com.spring.sample.web.test.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CellDao implements ICellDao {
	
	@Autowired
	public SqlSession sqlSession;

	@Override
	public int getCnt() throws Throwable {
		return sqlSession.selectOne("cell.getCnt");
	}

	@Override
	public List<HashMap<String, String>> getList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("cell.getList", params);
	}

	@Override
	public void cellAdd(HashMap<String, String> params) throws Throwable {
		sqlSession.insert("cell.cellAdd", params);
	}

}
