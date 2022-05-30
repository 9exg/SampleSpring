package com.spring.sample.web.test.dao;

import java.util.HashMap;
import java.util.List;

public interface IObDao {

	public int getObCnt() throws Throwable;

	public List<HashMap<String, String>> getOb(HashMap<String, String> params)throws Throwable;

	public void obWrite(HashMap<String, String> params)throws Throwable;

	public void obUpdate(HashMap<String, String> params)throws Throwable;

	public void obDelete(HashMap<String, String> params)throws Throwable;;

	

}
