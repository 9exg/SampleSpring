package com.spring.sample.web.test.service;

import java.util.HashMap;
import java.util.List;

public interface ICellService {

	public int getCnt() throws Throwable;

	public List<HashMap<String, String>> getList(HashMap<String, String> params)throws Throwable;

	public void cellAdd(HashMap<String, String> params)throws Throwable;

}
