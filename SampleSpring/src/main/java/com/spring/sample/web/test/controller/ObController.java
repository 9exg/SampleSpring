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
import com.spring.sample.web.test.service.IObService;

@Controller
public class ObController {
	@Autowired
	public IObService iObService;
	
	@Autowired
	public IPagingService iPagingService;
	
	@RequestMapping(value = "/ob")
	public ModelAndView ob(@RequestParam HashMap<String, String> params,
							ModelAndView mav) throws Throwable {
		// 페이지 초기 세팅
		int page = 1;
		if(params.get("page") != null && params.get("page") != "") {
			page = Integer.parseInt(params.get("page"));
		}
		
		//총 게시글 수
		int cnt = iObService.getObCnt();
		
		//페이징 정보 취득
		PagingBean pb = iPagingService.getPagingBean(page, cnt, 10, 5);
		
		//데이터 시작 종료 할당
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));
		
		//목록 조회
		List<HashMap<String, String>> list = iObService.getOb(params);
		
		mav.addObject("list", list);
		mav.addObject("pb", pb);
		mav.addObject("page", page);
		
		mav.setViewName("test/ob");
		
		return mav;
	}
	
	@RequestMapping(value = "/obAction")
	public ModelAndView obAction (@RequestParam HashMap<String, String> params,
								 ModelAndView mav) throws Throwable {
		try {
			switch(params.get("gbn")) {
			case "i" :
				iObService.obWrite(params);
				break;
			case "u" :
				iObService.obUpdate(params);
				break;
			case "d" :
				iObService.obDelete(params);
				break;
			}
			mav.addObject("res","success");
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("res","error");
		}
		
		mav.setViewName("test/obAction");
		
		return mav;
	}

}
