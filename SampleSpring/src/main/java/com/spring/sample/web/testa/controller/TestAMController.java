package com.spring.sample.web.testa.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.sample.util.Utils;
import com.spring.sample.web.test.service.IMService;

@Controller
public class TestAMController {

	@Autowired
	public IMService iMService;
	
	//////로그인
	@RequestMapping (value = "/amLogin")
	public ModelAndView amLogin(HttpSession session, ModelAndView mav) {
		if(session.getAttribute("sMNo") != null) {
			mav.setViewName("redirect:atbList");
		}else {
			mav.setViewName("testa/amLogin");
		}
		
		return mav;
	}
	
	//////
	@RequestMapping(value = "amLoginAjax", method = RequestMethod.POST,
				produces = "text/json;charset=UTF-8")
	@ResponseBody 
	public String amLoginAjax(@RequestParam HashMap<String, String> params,
							  HttpSession session) throws Throwable {
	ObjectMapper mapper = new ObjectMapper();
	
	Map<String, Object> modelMap = new HashMap<String, Object>();

	//구현 내용
	params.put("pw", Utils.encryptAES128(params.get("pw")));
	
	HashMap<String, String> data = iMService.getLogin(params);
	
	if(data != null) {		 
		session.setAttribute("sMNo", data.get("M_NO"));		
		session.setAttribute("sMNm", data.get("M_NM"));
		
		modelMap.put("res", "success");
	}else {		
		modelMap.put("res", "failed");
	}
	
	return mapper.writeValueAsString(modelMap);
	}
	
	@RequestMapping(value="/amLogout")
	public ModelAndView amLogout(HttpSession session, ModelAndView mav) {
		session.invalidate();
		
		mav.setViewName("redirect:amLogin");
		return mav;
	}
	
}
