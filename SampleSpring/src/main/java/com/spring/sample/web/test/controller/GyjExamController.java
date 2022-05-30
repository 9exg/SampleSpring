package com.spring.sample.web.test.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.sample.common.bean.PagingBean;
import com.spring.sample.common.service.IPagingService;
import com.spring.sample.web.test.service.ILbService;

@Controller
public class GyjExamController {
	
	@Autowired 
	public ILbService iLbService;
	
	@Autowired
	public IPagingService iPagingService;
	
	//////목록
	@RequestMapping(value = "/lbList")
	public ModelAndView lbList (@RequestParam HashMap<String, String> params,
								ModelAndView mav) throws Throwable {
		
		//페이징 초기값 1, 넘어오는 숫자 있으면 해당 값
		int page = 1;
		if(params.get("page") != null && params.get("page") != "") {
			page = Integer.parseInt(params.get("page"));
		}
		
		//전체 글 개수	
		int cnt = iLbService.getCnt(params);
		
		//PagingBean 사용하기
		PagingBean pb = iPagingService.getPagingBean(page, cnt);
		
		params.put("startCount", Integer.toString(pb.getStartCount()));
		params.put("endCount", Integer.toString(pb.getEndCount()));
	
		//리스트 데이터 받아오기
		List<HashMap<String,String>> list = iLbService.getLbList(params);
		
		//데이터 보내기
		mav.addObject("list", list);
		mav.addObject("pb", pb);
		mav.addObject("page", page);
		
		mav.setViewName("test/lbList");
		return mav;
	}
	
	//////상세보기
	@RequestMapping(value = "/lb")
	public ModelAndView lb (@RequestParam HashMap<String, String> params,
							ModelAndView mav) throws Throwable {
		
		HashMap<String, String> data = iLbService.getLb(params);
		
		mav.addObject("data", data);
	
		mav.setViewName("test/lb");
		return mav;
	}
	
	//////글쓰기
	@RequestMapping(value = "/lbWrite")
	public ModelAndView lbWrite (ModelAndView mav) throws Throwable{
		
		mav.setViewName("test/lbWrite");
		return mav;
	}
	
	//////글쓰기
	@RequestMapping(value = "/lbWrites")
	public ModelAndView lbWrites (@RequestParam HashMap<String, String> params,
									ModelAndView mav) throws Throwable{
		try {
			iLbService.lbWrite(params);
			mav.setViewName("redirect:lbList");
			
		}catch (Exception e) {
			e.printStackTrace();
			mav.setViewName("test/lbWrites"); 
		}
		
		return mav;	
	}
	
	//////수정
	@RequestMapping(value = "/lbUpdate")
	public ModelAndView lbUpdate (@RequestParam HashMap<String, String> params,
			ModelAndView mav) throws Throwable{ 
		HashMap<String, String> data = iLbService.getLb(params);
		
		mav.addObject("data", data);
		mav.setViewName("test/lbUpdate");
		return mav;
	}
	
	//////수정
	@RequestMapping(value = "/lbUpdates")
	public ModelAndView lbUpdates (@RequestParam HashMap<String, String> params,
									ModelAndView mav) throws Throwable{ 
		try {
			int cnt = iLbService.lbUpdate(params);
			if(cnt == 1) {
				mav.addObject("res", "success");
			}else {
				mav.addObject("res", "failed");				
			}
			
		} catch(Exception e) {
			e.printStackTrace();
			mav.addObject("res", "error");
		}
		mav.setViewName("test/lbUpdates");
		
		return mav;	
	}
	
	//////삭제
	@RequestMapping (value = "/lbDeletes") 
	public ModelAndView lbDeletes (@RequestParam HashMap<String, String> params,
			ModelAndView mav) throws Throwable {
		try {
			int cnt = iLbService.lbDelete(params);
			
			if(cnt == 1) {
				mav.addObject("res", "success");
			}else {
				mav.addObject("res", "failed");				
			}
		} catch(Exception e ) {
			e.printStackTrace();
			mav.addObject("res", "error");				
		}
		
		mav.setViewName("test/lbDeletes"); 
		
		return mav;
	}
}
