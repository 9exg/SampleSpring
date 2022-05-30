package com.spring.sample.web.testa.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BookDao implements IBookDao {
	
	@Autowired
	public SqlSession sqlSession;

	public List<HashMap<String, String>> getBookList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("book.getBookList", params);
	}

	@Override
	public HashMap<String, String> getBook(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("book.getBook", params);	
	}

	@Override
	public int getCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("book.getCnt",params);
	}

	@Override
	public void bookWrite(HashMap<String, String> params) throws Throwable {
		sqlSession.insert("book.bookWrite", params);
	}

	@Override
	public int bookUpdate(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("book.bookUpdate", params);
	}

	@Override
	public void bookDelete(HashMap<String, String> params) throws Throwable {
		sqlSession.delete("book.bookDelete", params);
	}

	

}
