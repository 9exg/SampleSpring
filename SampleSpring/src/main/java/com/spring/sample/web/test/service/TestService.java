package com.spring.sample.web.test.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.sample.web.test.dao.ITestDao;

@Service
public class TestService implements ITestService{
	@Autowired
	public ITestDao iTestDao;

	@Override
	public List<HashMap<String, String>> getTbList(HashMap<String, String> params) throws Throwable {
		return iTestDao.getTbList(params);
	}

	@Override
	public HashMap<String, String> getTb(HashMap<String, String> params) throws Throwable {
		return iTestDao.getTb(params);
	}

	@Override
	public int getTbCnt(HashMap<String, String> params) throws Throwable {
		return iTestDao.getTbCnt(params);
	}

	@Override
	public void tbWrite(HashMap<String, String> params) throws Throwable {
		iTestDao.tbWrite(params);
	}

	@Override
	public int tbUpdate(HashMap<String, String> params) throws Throwable {
		return iTestDao.tbUpdate(params);
	}

	@Override
	public int tbDelete(HashMap<String, String> params) throws Throwable {
		return iTestDao.tbDelete(params);
	}

	@Override
	public void updateTbHit(HashMap<String, String> params) throws Throwable {
		iTestDao.updateTbHit(params);
	}
}
