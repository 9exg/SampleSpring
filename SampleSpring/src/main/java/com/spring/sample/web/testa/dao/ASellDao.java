package com.spring.sample.web.testa.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ASellDao implements IASellDao {
	
	@Autowired 
	public SqlSession sqlsession;

	@Override
	public int getTbCnt(HashMap<String, String> params) throws Throwable {
		return sqlsession.selectOne("asell.getTbCnt", params) ;
	}

	@Override
	public List<HashMap<String, String>> getTbList(HashMap<String, String> params) throws Throwable {
		return sqlsession.selectList("asell.getTbList", params);
	}

	@Override
	public HashMap<String, String> aSell(HashMap<String, String> params) throws Throwable {
		return sqlsession.selectOne("asell.aSell", params);
	}

	@Override
	public void aSellAdd(HashMap<String, String> params) throws Throwable {
		sqlsession.insert("asell.aSellAdd", params);
	}

	@Override
	public void aSellUpdate(HashMap<String, String> params) throws Throwable {
		sqlsession.update("asell.aSellUpdate", params);
	}

	@Override
	public void aSellDelete(HashMap<String, String> params) throws Throwable {
		sqlsession.delete("asell.aSellDelete", params);
	}

}
