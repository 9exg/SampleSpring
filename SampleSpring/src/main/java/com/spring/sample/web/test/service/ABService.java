package com.spring.sample.web.test.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.sample.web.test.dao.IABDao;

@Service
public class ABService implements IABService {
	@Autowired
	public IABDao iabDao;

	@Override
	public int getAbCnt(HashMap<String, String> params) throws Throwable {
		return iabDao.getAbCnt(params);
	}

	@Override
	public List<HashMap<String, String>> getAbList(HashMap<String, String> params) throws Throwable {
		return iabDao.getAbList(params);
	}

	@Override
	public void abAdd(HashMap<String, String> params) throws Throwable {
		iabDao.abAdd(params);
	}

	@Override
	public HashMap<String, String> getAb(HashMap<String, String> params) throws Throwable {
		return iabDao.getAb(params);
	}

	@Override
	public int abUpdate(HashMap<String, String> params) throws Throwable {
		return iabDao.abUpdate(params);
	}

	@Override
	public int abDelete(HashMap<String, String> params) throws Throwable {
		return iabDao.abDelete(params);
	}

	@Override
	public HashMap<String, String> getAnaly(HashMap<String, String> params) throws Throwable {
		return iabDao.getAnaly(params);
	}


	
}
