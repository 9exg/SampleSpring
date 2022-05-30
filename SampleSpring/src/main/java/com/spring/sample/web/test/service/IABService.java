package com.spring.sample.web.test.service;

import java.util.HashMap;
import java.util.List;

public interface IABService {

	public int getAbCnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getAbList(HashMap<String, String> params) throws Throwable;

	public void abAdd(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getAb(HashMap<String, String> params) throws Throwable;

	public int abUpdate(HashMap<String, String> params) throws Throwable;

	public int abDelete(HashMap<String, String> params)throws Throwable;

	public HashMap<String, String> getAnaly(HashMap<String, String> params) throws Throwable;

}
