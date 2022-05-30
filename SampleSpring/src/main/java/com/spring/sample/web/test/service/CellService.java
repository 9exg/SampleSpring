package com.spring.sample.web.test.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.sample.web.test.dao.ICellDao;

@Service
public class CellService implements ICellService{
	@Autowired
	public ICellDao iCellDao;

	@Override
	public int getCnt() throws Throwable {
		return iCellDao.getCnt();
	}

	@Override
	public List<HashMap<String, String>> getList(HashMap<String, String> params) throws Throwable {
		return iCellDao.getList(params);
	}

	@Override
	public void cellAdd(HashMap<String, String> params) throws Throwable {
		iCellDao.cellAdd(params);
	}

}
