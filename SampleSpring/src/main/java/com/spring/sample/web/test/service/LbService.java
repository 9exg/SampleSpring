package com.spring.sample.web.test.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.sample.web.test.dao.ILbDao;

@Service
public class LbService implements ILbService{
	
	@Autowired 
	public ILbDao iLbDao;

	@Override
	public List<HashMap<String, String>> getLbList(HashMap<String, String> params) throws Throwable {
		return iLbDao.getLbList(params);
	}

	@Override
	public HashMap<String, String> getLb(HashMap<String, String> params) throws Throwable {
		return iLbDao.getLb(params);
	}

	@Override
	public int getCnt(HashMap<String, String> params) throws Throwable {
		return iLbDao.getCnt(params);
	}

	@Override
	public void lbWrite(HashMap<String, String> params) throws Throwable {
		iLbDao.lbWrite(params);
	}

	@Override
	public int lbUpdate(HashMap<String, String> params) throws Throwable {
		return iLbDao.lbUpdate(params);
	}

	@Override
	public int lbDelete(HashMap<String, String> params) throws Throwable {
		return iLbDao.lbDelete(params);
	}
	
	

}
