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
import com.spring.sample.web.test.service.ICellService;

@Controller
public class CellController {
	
	@Autowired
	public ICellService iCellService;
	
	@Autowired
	public IPagingService iPagingService;
	
	//목록
	@RequestMapping (value = "/cellList")
	public ModelAndView cellList (@RequestParam HashMap<String, String> params,
								  ModelAndView mav) throws Throwable {
		
		//페이지
		int page = 1;
		if(params.get("page") != null && params.get("page") != "") {
			page = Integer.parseInt(params.get("page"));
		}
		
		//총 글 수
		int cnt = iCellService.getCnt(); 
		
		//페이징빈 사용하기
		PagingBean pb = iPagingService.getPagingBean(page, cnt);
		
		params.put("startCount", Integer.toString(pb.getStartCount()));
		params.put("endCount", Integer.toString(pb.getEndCount()));
		
		//리스트
		List<HashMap<String,String>> list = iCellService.getList(params);

		//뷰에 데이터 보내기
		mav.addObject("cnt", cnt);
		mav.addObject("pb", pb);
		mav.addObject("list", list);
		mav.addObject("page", page);
		
		mav.setViewName("test/cellList");
		return mav;
	}
	
	//추가하기
	@RequestMapping (value = "/cellAction")
	public ModelAndView cellAction (@RequestParam HashMap<String,String> params,
								   ModelAndView mav) throws Throwable {
		try {
			switch(params.get("gbn")) {
			case "i" :
				iCellService.cellAdd(params);
				break;
			case "u" :
				break;
			case "d" :
				break;
			}			
		}catch(Exception e){
			e.printStackTrace();
			mav.addObject("res", "error");
		}
		
		mav.setViewName("test/cellAction");
		return mav;
	}

}
