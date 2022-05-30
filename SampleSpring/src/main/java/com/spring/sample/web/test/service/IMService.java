package com.spring.sample.web.test.service;

import java.util.HashMap;
import java.util.List;

public interface IMService  {

	public List<HashMap<String, String>> getList() throws Throwable ;

	public void mAdds(HashMap<String, String> params)throws Throwable;

	public int checkId(HashMap<String, String> params)throws Throwable;

	public HashMap<String, String> getLogin(HashMap<String, String> params)throws Throwable;

}
