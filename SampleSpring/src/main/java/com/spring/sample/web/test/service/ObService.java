package com.spring.sample.web.test.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.sample.web.test.dao.IObDao;

@Service
public class ObService implements IObService {
	@Autowired
	public IObDao iObDao;

	@Override
	public int getObCnt() throws Throwable {
		return iObDao.getObCnt();
	}

	@Override
	public List<HashMap<String, String>> getOb(HashMap<String, String> params) throws Throwable {
		return iObDao.getOb(params);
	}

	@Override
	public void obWrite(HashMap<String, String> params) throws Throwable {
		iObDao.obWrite(params);
	}

	@Override
	public void obUpdate(HashMap<String, String> params) throws Throwable {
		iObDao.obUpdate(params);
		
	}

	@Override
	public void obDelete(HashMap<String, String> params) throws Throwable {
		iObDao.obDelete(params);
	}

}
