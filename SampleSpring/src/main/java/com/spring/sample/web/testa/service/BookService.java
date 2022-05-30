package com.spring.sample.web.testa.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.sample.web.testa.dao.IBookDao;

@Service
public class BookService implements IBookService{
	
	@Autowired 
	public IBookDao iBookDao;

	@Override
	public List<HashMap<String, String>> getBookList(HashMap<String, String> params) throws Throwable {
		return iBookDao.getBookList(params);
	}

	@Override
	public HashMap<String, String> getBook(HashMap<String, String> params) throws Throwable {
		return iBookDao.getBook(params);
	}

	@Override
	public int getCnt(HashMap<String, String> params) throws Throwable {
		return iBookDao.getCnt(params);
	}

	@Override
	public void bookWrite(HashMap<String, String> params) throws Throwable {
		iBookDao.bookWrite(params);
	}

	@Override
	public int bookUpdate(HashMap<String, String> params) throws Throwable {
		return iBookDao.bookUpdate(params);
	}

	@Override
	public void bookDelete(HashMap<String, String> params) throws Throwable {
		iBookDao.bookDelete(params);
		
	}
	
	

}
