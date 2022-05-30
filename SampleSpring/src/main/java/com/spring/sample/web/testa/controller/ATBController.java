package com.spring.sample.web.testa.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.sample.common.bean.PagingBean;
import com.spring.sample.common.service.IPagingService;
import com.spring.sample.web.test.service.ITestService;

@Controller
public class ATBController {

		@Autowired
		public ITestService iTestService;
		
		@Autowired 
		public IPagingService iPagingService;
		
		
		//////atbList view
		@RequestMapping(value = "/atbList")
		public ModelAndView atbList(@RequestParam HashMap<String,String> params, ModelAndView mav) {
			
			if(params.get("page") == null || params.get("page") == "") {
				params.put("page", "1");
			}
			
			mav.addObject("page", params.get("page"));
			mav.setViewName("testa/atbList");
		
			return mav;
		}
		
		
		//////atbListAjax
		@RequestMapping(value = "atbListAjax", method = RequestMethod.POST,
				produces = "text/json;charset=UTF-8")
		@ResponseBody 
		public String atbListAjax(@RequestParam HashMap<String, String> params) throws Throwable {
			ObjectMapper mapper = new ObjectMapper();
			
			Map<String, Object> modelMap = new HashMap<String, Object>();
			
			// 총 게시글 수
			int cnt = iTestService.getTbCnt(params);
			
			PagingBean pb 
			= iPagingService.getPagingBean(Integer.parseInt(params.get("page")), cnt, 3, 5);
			
			params.put("startCount", Integer.toString(pb.getStartCount()));
			params.put("endCount", Integer.toString(pb.getEndCount()));
			
			List<HashMap<String,String>> list = iTestService.getTbList(params);
			
			modelMap.put("list", list);
			modelMap.put("pb", pb);
			
			return mapper.writeValueAsString(modelMap);
	}
		
		//작성
		@RequestMapping (value = "/atbWrite")
		public ModelAndView atbWrite(ModelAndView mav) {
			
			mav.setViewName("testa/atbWrite");
			return mav;
		}
		
		
		//@PathVariable : 주소의 {키} 부분을 변수로 취득
		@RequestMapping(value = "/atbAction/{gbn}", method = RequestMethod.POST,
				produces = "text/json;charset=UTF-8")
		@ResponseBody 
		public String atbAction(@RequestParam HashMap<String, String> params,
								@PathVariable String gbn) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			switch(gbn) {
			case "insert" :
				iTestService.tbWrite(params);
				break;
			case "update" :
				iTestService.tbUpdate(params);
				break;
			case "delete" :
				iTestService.tbDelete(params);
				break;
			}
			modelMap.put("res", "success");
		}catch (Throwable e) {
			e.printStackTrace();
			modelMap.put("res", "failed");
		}
		
		return mapper.writeValueAsString(modelMap);
	}
		
		//////상세보기
		@RequestMapping(value="/atb")
		public ModelAndView atb(@RequestParam HashMap<String, String> params,
								ModelAndView mav) throws Throwable {
			//조회수 증가
			iTestService.updateTbHit(params);
			
			HashMap<String, String> data = iTestService.getTb(params);
			
			mav.addObject("data", data);
			
			mav.setViewName("testa/atb");
			
			return mav;
		}
		
		//////수정
		@RequestMapping(value="/atbUpdate")
		public ModelAndView atbUpdate(@RequestParam HashMap<String, String> params,
				ModelAndView mav) throws Throwable {
			HashMap<String, String> data = iTestService.getTb(params);
			
			mav.addObject("data", data);
			
			mav.setViewName("testa/atbUpdate");
			
			return mav;
		}
		
}
