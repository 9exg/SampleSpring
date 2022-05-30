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
import com.spring.sample.web.testa.service.IASellService;

@Controller
public class ASellController {
	
	//////오버라이딩
	@Autowired
	public IASellService iSellService;
	
	@Autowired
	public IPagingService iPagingService;
	
	
	//////목록 View
	@RequestMapping (value = "/aSellList")
	public ModelAndView aSellList (@RequestParam HashMap<String, String> params,
								  ModelAndView mav)  {
		
		if(params.get("page") == null || params.get("page") == "") {
			params.put("page", "1");
		}
		
		mav.addObject("page", params.get("page"));
		
		mav.setViewName("testa/aSellList");
		return mav;
	}
	
	//////목록 Ajax
	@RequestMapping(value = "aSellListAjax", method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String aSellListAjax(@RequestParam HashMap<String,String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		int cnt = iSellService.getTbCnt(params);
		
		PagingBean pb 
		= iPagingService.getPagingBean(Integer.parseInt(params.get("page")), cnt, 3, 5);
		
		params.put("startCount", Integer.toString(pb.getStartCount()));
		params.put("endCount", Integer.toString(pb.getEndCount()));
		
		List<HashMap<String,String>> list = iSellService.getTbList(params);
		
		modelMap.put("list", list);
		modelMap.put("pb", pb);
		
		return mapper.writeValueAsString(modelMap);
	}
	
		//////상세보기
		@RequestMapping(value="/aSell")
		public ModelAndView aSell(@RequestParam HashMap<String, String> params,
								ModelAndView mav) throws Throwable {
			
			HashMap<String, String> data = iSellService.aSell(params);
			
			mav.addObject("data", data);
			
			mav.setViewName("testa/aSell");
			
			return mav;
		}
		
		//////작성
		@RequestMapping (value = "/aSellAdd")
		public ModelAndView aSellAdd(ModelAndView mav) {
			
			mav.setViewName("testa/aSellAdd");
			return mav;
		}
		
		//////수정
		@RequestMapping(value="/aSellUpdate")
		public ModelAndView aSellUpdate(@RequestParam HashMap<String, String> params,
				ModelAndView mav) throws Throwable {
			HashMap<String, String> data = iSellService.aSell(params);
			
			mav.addObject("data", data);
			
			mav.setViewName("testa/aSellUpdate");
			
			return mav;
		}
		
		//////작성 수정 삭제
		@RequestMapping(value = "/aSellAction/{gbn}", method = RequestMethod.POST,
				produces = "text/json;charset=UTF-8")
		@ResponseBody 
		public String aSellAction(@RequestParam HashMap<String, String> params,
								@PathVariable String gbn) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			switch(gbn) {
			case "insert" :
				iSellService.aSellAdd(params);
				break;
			case "update" :
				iSellService.aSellUpdate(params);
				break;
			case "delete" :
				iSellService.aSellDelete(params);
				break;
			}
			modelMap.put("res", "success");
		}catch (Throwable e) {
			e.printStackTrace();
			modelMap.put("res", "failed");
		}
		
		return mapper.writeValueAsString(modelMap);
	}

}
