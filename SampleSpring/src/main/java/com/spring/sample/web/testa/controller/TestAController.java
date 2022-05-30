package com.spring.sample.web.testa.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class TestAController {

	@RequestMapping( value = "/testa1")
	public ModelAndView test1(ModelAndView mav) {
		mav.setViewName("testa/testa1");
		
		return mav;
	}

	//RequestMapping의 method : 접근 방법 제한
	//RequestMapping의 produces : 반환 형태 지정
	@RequestMapping(value = "testa1Ajax", method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
	@ResponseBody //View로 인식시킴
	public String testa1Ajax(@RequestParam HashMap<String, String> params) throws Throwable {
		//{키:값, 키:값}
		//ObjectMapper : 객체 문자열로 변환(json)
		ObjectMapper mapper = new ObjectMapper();
		
		//데이터를 담을 객체
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		System.out.println(params); //넘어오는 데이터 확인
		
		modelMap.put ("res", "성공");
		modelMap.put ("msg", params.get("msg") + "받았음");
		
		//writeValueAsString : 객체를 문자열로 변환
		//변환시 문제가 발생할 수 있기 때문에 예외처리 필요
		System.out.println(mapper.writeValueAsString(modelMap));
		return mapper.writeValueAsString(modelMap);
	}
	
}
