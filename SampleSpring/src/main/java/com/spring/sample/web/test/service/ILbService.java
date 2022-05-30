package com.spring.sample.web.test.service;

import java.util.HashMap;
import java.util.List;


public interface ILbService {
	
	// 리스트 받아오기
	public List<HashMap<String, String>> getLbList(HashMap<String, String> params) throws Throwable ;

	public HashMap<String, String> getLb(HashMap<String, String> params) throws Throwable;

	public int getCnt(HashMap<String, String> params) throws Throwable;

	public void lbWrite(HashMap<String, String> params) throws Throwable;

	public int lbUpdate(HashMap<String, String> params) throws Throwable;

	public int lbDelete(HashMap<String, String> params) throws Throwable;
	

}
