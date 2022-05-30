package com.spring.sample.web.test.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.sample.common.bean.PagingBean;
import com.spring.sample.common.service.IPagingService;
import com.spring.sample.web.test.service.IABService;

@Controller
public class ABController {
	@Autowired
	public IABService iabService;
	
	@Autowired
	public IPagingService iPagingService;

	
	@RequestMapping (value = "/abList")
	public ModelAndView getAbList (@RequestParam HashMap<String, String> params,
									HttpSession session,
									ModelAndView mav) throws Throwable {		
		
		if(session.getAttribute("sMNo") != null) {
			params.put("sMNo", String.valueOf(session.getAttribute("sMNo")));
			
			//검색 월 초기값 (현재 월)
			Date today = new Date();
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
			
			String searchMon = sdf.format(today);
			
			if(params.get("searchMon") == null || params.get("searchMon") == "") {
				params.put("searchMon", searchMon);
			}
			
			int page = 1;
			//넘어오는 페이지가 있는 경우 해당 값으로 지정
			if(params.get("page") != null && params.get("page") != "") {
				page = Integer.parseInt(params.get("page"));
			}
			//전체 글 개수
			int cnt = iabService.getAbCnt(params);
			
			PagingBean pb = iPagingService.getPagingBean(page, cnt, 3,5);
			
			params.put("startCount", Integer.toString(pb.getStartCount()));
			params.put("endCount", Integer.toString(pb.getEndCount()));
			
			
			// 데이터 받아오기
			List<HashMap<String, String>> list = iabService.getAbList(params);
			
			//통계데이터
			HashMap<String,String> analy = iabService.getAnaly(params);
			
			// 뷰에 보내기
			mav.addObject("list", list);
			mav.addObject("pb", pb);
			mav.addObject("page", page);
			mav.addObject("searchMon", params.get("searchMon"));
			mav.addObject("analy", analy);
			
			// test에 tbList 보낼 것이다
			mav.setViewName("test/abList");
			System.out.println(list);
		} else {
			mav.setViewName("redirect:mLogin");
		}
		
		return mav;
	}
	
	//////글쓰기
	@RequestMapping(value = "/abAdd")
	public ModelAndView abAdd (ModelAndView mav) {
		mav.setViewName("test/abAdd");
		return mav;
	}
	
	//////글쓰기
	@RequestMapping(value = "/abAdds")
	public ModelAndView abAdds (@RequestParam HashMap<String, String> params,
								ModelAndView mav) throws Throwable {
		try {
			iabService.abAdd(params);
			mav.setViewName("redirect:abList");
		}catch (Exception e) {
			e.printStackTrace();
			mav.setViewName("test/abAdds"); //성공 못하면 뒤로가기
		}
		return mav;
	}
	
	//////상세보기
	@RequestMapping (value = "/ab")
	public ModelAndView getAb (@RequestParam HashMap<String, String> params,
							ModelAndView mav) throws Throwable {
		
		HashMap<String, String> data = iabService.getAb(params);
		
		mav.addObject("data", data);
		mav.setViewName("test/ab");
		return mav;
	}
	
	//////수정
	@RequestMapping (value = "/abUpdate")
	public ModelAndView abUpdate (@RequestParam HashMap<String, String> params,
								  ModelAndView mav) throws Throwable{
		HashMap<String, String> data = iabService.getAb(params);
		
		mav.addObject("data",data);
		mav.setViewName("test/abUpdate");
		return mav;
	}
	
	//////수정
	@RequestMapping (value = "/abUpdates")
	public ModelAndView abUpdates (@RequestParam HashMap<String, String> params,
								  ModelAndView mav) throws Throwable {
		try {
			int cnt = iabService.abUpdate(params);
			System.out.println(cnt);
			if(cnt == 1) {
				mav.addObject("res","success");
			}else {
				mav.addObject("res","failed");
			}
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("res","error");
		}
		mav.setViewName("test/abUpdates");
		return mav;
	}
	
	//////삭제
	@RequestMapping(value="abDeletes")
	public ModelAndView abDeletes (@RequestParam HashMap<String, String> params,
			ModelAndView mav) throws Throwable {
		try {
			int cnt = iabService.abDelete(params);
			
			if(cnt == 1) {
				mav.addObject("res", "success");
			}else {
				mav.addObject("res", "failed");				
			}
		} catch(Exception e ) {
			e.printStackTrace();
			mav.addObject("res", "error");				
		}
		
		mav.setViewName("test/abDeletes"); 
		
		return mav;
	}
} //controller end
