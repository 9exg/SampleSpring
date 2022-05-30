package com.spring.sample.web.test.service;

import java.util.HashMap;
import java.util.List;

public interface ITestService {

	public List<HashMap<String, String>> getTbList(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getTb(HashMap<String, String> params) throws Throwable;

	public int getTbCnt(HashMap<String, String> params) throws Throwable;

	public void tbWrite(HashMap<String, String> params) throws Throwable;

	public int tbUpdate(HashMap<String, String> params)throws Throwable;

	public int tbDelete(HashMap<String, String> params)throws Throwable;

	public void updateTbHit(HashMap<String, String> params)throws Throwable;

}
