package com.spring.sample.web.test.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

// @Repository : 저장소 접근 객체
@Repository
public class TestDao implements ITestDao{
	@Autowired
	public SqlSession sqlSession;

	@Override
	public List<HashMap<String, String>> getTbList(HashMap<String, String> params) throws Throwable {
		// 목록을 받을 때 .selectList 사용
		// selectList(SQL위치) : 위치에 있는 SQL을 조회하여 목록을 취득하겠다.
		// SQL 위치 : namespace.id
		return sqlSession.selectList("test.getTbList", params);
		//쿼리로 해쉬맵을 보낸다?
	}
	
	@Override
	public HashMap<String, String> getTb(HashMap<String, String> params) throws Throwable {
		// selectOne(쿼리위치) : 쿼리를 조회하여 한건을 취득
		// selectOne(쿼리위치, 값) : 쿼리 조회시 값을 전달하고 한건을 취득
		return sqlSession.selectOne("test.getTb", params);
	}

	@Override
	public int getTbCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("test.getTbCnt", params);
	}
	
	@Override
	public void tbWrite(HashMap<String, String> params) throws Throwable {
		// insert(~~) : 등록 쿼리 실행
		sqlSession.insert("test.tbWrite", params);
	}

	@Override
	public int tbUpdate(HashMap<String, String> params) throws Throwable {
		// update(~~) : 수정 쿼리 실행
		return sqlSession.update("test.tbUpdate",params);
	}

	@Override
	public int tbDelete(HashMap<String, String> params) throws Throwable {
		// delete(~~) : 삭제 쿼리 실행
		return sqlSession.delete("test.tbDelete", params);
	}

	@Override
	public void updateTbHit(HashMap<String, String> params)throws Throwable {	
		sqlSession.update("test.updateTbHit",params);
	}
}