package com.spring.sample.web.test.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.sample.web.test.dao.IMDao;

@Service
public class MService implements IMService {
	
	@Autowired
	public IMDao iMDao;

	@Override
	public List<HashMap<String, String>> getList() throws Throwable {
		return iMDao.getList();
	}

	@Override
	public void mAdds(HashMap<String, String> params) throws Throwable {
		iMDao.mAdds(params);	
	}

	@Override
	public int checkId(HashMap<String, String> params) throws Throwable {
		return iMDao.checkId(params);
	}

	@Override
	public HashMap<String, String> getLogin(HashMap<String, String> params) throws Throwable {
		return iMDao.getLogin(params);
	}

}
