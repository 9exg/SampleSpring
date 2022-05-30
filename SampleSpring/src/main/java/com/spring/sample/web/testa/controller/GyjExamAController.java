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
import com.spring.sample.web.testa.service.IBookService;

@Controller
public class GyjExamAController {
	
	@Autowired 
	public IBookService iBookService;
	
	@Autowired
	public IPagingService iPagingService;
	
	
	//////목록 뷰
	@RequestMapping(value = "/aBookList")
	public ModelAndView aBookList (@RequestParam HashMap<String, String> params,
								   ModelAndView mav) throws Throwable {
		
		if(params.get("page") == null || params.get("page") == "") {
			params.put("page", "1");
		}
		
		mav.addObject("page", params.get("page"));
		mav.setViewName("testa/aBookList");
		
		return mav;
	}
	
	
	//////목록 Ajax
	@RequestMapping(value = "aBookListAjax", method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String aBookListAjax(@RequestParam HashMap<String,String> params) throws Throwable {
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		//전체 글 개수	
		int cnt = iBookService.getCnt(params);
		
		//PagingBean 사용하기
		PagingBean pb 
		= iPagingService.getPagingBean(Integer.parseInt(params.get("page")), cnt, 3, 5);
		
		params.put("startCount", Integer.toString(pb.getStartCount())); 
		params.put("endCount", Integer.toString(pb.getEndCount()));
	
		//리스트 데이터 받아오기
		List<HashMap<String,String>> list = iBookService.getBookList(params);
		
		//데이터 보내기
		modelMap.put("list", list);
		modelMap.put("pb", pb);
		
		return mapper.writeValueAsString(modelMap);
	}
	
	
	//////상세보기
	@RequestMapping(value = "/aBook")
	public ModelAndView aBook (@RequestParam HashMap<String, String> params,
						       ModelAndView mav) throws Throwable {
		
		HashMap<String, String> data = iBookService.getBook(params);
		
		mav.addObject("data", data);
	
		mav.setViewName("testa/aBook");
		return mav;
	}
	
	//////글쓰기 뷰
	@RequestMapping(value = "/aBookWrite")
	public ModelAndView aBookWrite (ModelAndView mav) throws Throwable{
		
		mav.setViewName("testa/aBookWrite");
		return mav;
	}
	
	
	//////수정 뷰
	@RequestMapping(value = "/aBookUpdate")
	public ModelAndView aBookUpdate (@RequestParam HashMap<String, String> params,
									 ModelAndView mav) throws Throwable{ 
		HashMap<String, String> data = iBookService.getBook(params);
		
		mav.addObject("data", data);
		mav.setViewName("testa/aBookUpdate");
		return mav;
	}
	
	//////작성 수정 삭제 Ajax
	@RequestMapping(value = "/aBookAction/{gbn}", method = RequestMethod.POST,
			        produces = "text/json;charset=UTF-8")
	@ResponseBody 
	public String aBookAction(@RequestParam HashMap<String, String> params,
							  @PathVariable String gbn) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			switch(gbn) {
			case "insert" :
				iBookService.bookWrite(params);
				break;
			case "update" :
				iBookService.bookUpdate(params);
				break;
			case "delete" :
				iBookService.bookDelete(params);
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
