package com.spring.sample.web.testa.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.sample.web.testa.dao.IASellDao;

@Service
public class ASellService implements IASellService {
	@Autowired
	public IASellDao iASellDao;

	@Override
	public int getTbCnt(HashMap<String, String> params) throws Throwable {
		return iASellDao.getTbCnt(params);
	}

	@Override
	public List<HashMap<String, String>> getTbList(HashMap<String, String> params) throws Throwable {
		return iASellDao.getTbList(params);
	}

	@Override
	public HashMap<String, String> aSell(HashMap<String, String> params) throws Throwable {
		return iASellDao.aSell(params);
	}

	@Override
	public void aSellAdd(HashMap<String, String> params) throws Throwable {
		iASellDao.aSellAdd(params);
		
	}

	@Override
	public void aSellUpdate(HashMap<String, String> params) throws Throwable {
		iASellDao.aSellUpdate(params);
	}

	@Override
	public void aSellDelete(HashMap<String, String> params) throws Throwable {
		iASellDao.aSellDelete(params);
	}

}
