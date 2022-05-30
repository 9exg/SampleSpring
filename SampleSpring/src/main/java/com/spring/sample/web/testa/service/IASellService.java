package com.spring.sample.web.testa.service;

import java.util.HashMap;
import java.util.List;

public interface IASellService {

	public int getTbCnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getTbList(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> aSell(HashMap<String, String> params)throws Throwable;

	public void aSellAdd(HashMap<String, String> params)throws Throwable;

	public void aSellUpdate(HashMap<String, String> params)throws Throwable;

	public void aSellDelete(HashMap<String, String> params)throws Throwable;
}
