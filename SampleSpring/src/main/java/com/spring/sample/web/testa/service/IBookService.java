package com.spring.sample.web.testa.service;

import java.util.HashMap;
import java.util.List;


public interface IBookService {
	
	// 리스트 받아오기
	public List<HashMap<String, String>> getBookList(HashMap<String, String> params) throws Throwable ;

	public HashMap<String, String> getBook(HashMap<String, String> params) throws Throwable;

	public int getCnt(HashMap<String, String> params) throws Throwable;

	public void bookWrite(HashMap<String, String> params) throws Throwable;

	public int bookUpdate(HashMap<String, String> params) throws Throwable;

	public void bookDelete(HashMap<String, String> params) throws Throwable;
	

}
