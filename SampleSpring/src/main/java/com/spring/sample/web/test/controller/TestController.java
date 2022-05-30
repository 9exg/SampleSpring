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
import com.spring.sample.web.test.service.ITestService;

@Controller
public class TestController {
	@Autowired
	public ITestService iTestService;
	
	@Autowired
	public IPagingService iPagingService;
	
	//////글쓰기
	@RequestMapping(value = "/tbWrite")
	public ModelAndView tbWrite (ModelAndView mav) {
		mav.setViewName("test/tbWrite");
		return mav;
	}
	
	//////글쓰기
	@RequestMapping(value = "/tbWrites")
	public ModelAndView tbWrites (@RequestParam HashMap<String, String> params,
								ModelAndView mav) throws Throwable {
		try {
			iTestService.tbWrite(params);
			
			//setViewName("redirect:주소") : 해당 주소로 이동. 단, get방식밖에 지원 안됨.
			//								controller -> controller
			mav.setViewName("redirect:tbList");
			
		}catch (Exception e) {
			e.printStackTrace();
			mav.setViewName("test/tbWrites"); //성공 못하면 뒤로가기
		}
		return mav;
	}
	
	//////수정
	@RequestMapping(value = "/tbUpdate")
	public ModelAndView tbUpdate (@RequestParam HashMap<String, String> params,
								  ModelAndView mav) throws Throwable {
		HashMap<String, String> data = iTestService.getTb(params);
	
		mav.addObject("data", data);
		mav.setViewName("test/tbUpdate");
		
		return mav;
	}
	
	////////수정
	@RequestMapping(value="/tbUpdates")
	public ModelAndView tbUpdates (@RequestParam HashMap<String, String> params,
							ModelAndView mav) throws Throwable {
		try {
			int cnt = iTestService.tbUpdate(params);
			
			if(cnt == 1) {
				mav.addObject("res", "success");
			}else {
				mav.addObject("res", "failed");				
			}
		} catch(Exception e ) {
			e.printStackTrace();
			mav.addObject("res", "error");				
		}
		
		mav.setViewName("test/tbUpdates"); 
		
		return mav;
	}
	
	//////삭제
	@RequestMapping(value="tbDeletes")
	public ModelAndView tbDeletes (@RequestParam HashMap<String, String> params,
			ModelAndView mav) throws Throwable {
		try {
			int cnt = iTestService.tbDelete(params);
			
			if(cnt == 1) {
				mav.addObject("res", "success");
			}else {
				mav.addObject("res", "failed");				
			}
		} catch(Exception e ) {
			e.printStackTrace();
			mav.addObject("res", "error");				
		}
		
		mav.setViewName("test/tbDeletes"); 
		
		return mav;
	}
	
	//목록
	@RequestMapping(value = "/tbList") 
	public ModelAndView tbList( @RequestParam HashMap<String, String> params,
								ModelAndView mav) throws Throwable { // DB 사용 시 예외처리 필수
		
		int page = 1;
		//넘어오는 페이지가 있는 경우 해당 값으로 지정
		if(params.get("page") != null && params.get("page") != "") {
			page = Integer.parseInt(params.get("page"));
		}
		//전체 글 개수
		int cnt = iTestService.getTbCnt(params);
		
		PagingBean pb = iPagingService.getPagingBean(page, cnt, 3, 10);
		
		params.put("startCount", Integer.toString(pb.getStartCount()));
		params.put("endCount", Integer.toString(pb.getEndCount()));
		
		// 데이터 받아오기
		List<HashMap<String, String>> list = iTestService.getTbList(params);

		// 뷰에 보내기
		mav.addObject("list", list);
		mav.addObject("pb", pb);
		mav.addObject("page", page);

		// test에 tbList 보낼 것이다
		mav.setViewName("test/tbList");

		return mav;
	}
	
	//////상세보기
	@RequestMapping(value="/tb")
	public ModelAndView tb(@RequestParam HashMap<String, String> params,
							ModelAndView mav) throws Throwable {
		//조회수 증가
		iTestService.updateTbHit(params);
		
		HashMap<String, String> data = iTestService.getTb(params);
		
		mav.addObject("data", data);
		
		mav.setViewName("test/tb");
		
		return mav;
	}
}
