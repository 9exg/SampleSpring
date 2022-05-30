package com.spring.sample.web.test.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.sample.util.Utils;
import com.spring.sample.web.test.service.IMService;

@Controller
public class MController {
	
	@Autowired
	public IMService iMService;
	
	//목록조회
	@RequestMapping (value = "/mList")
	public ModelAndView mList (ModelAndView mav) throws Throwable {
		
	List<HashMap<String,String>> list = iMService.getList();
		
		mav.addObject("list", list);
		
		mav.setViewName("test/mList");
		return mav;
	}
	
	//등록
	@RequestMapping (value = "/mAdd")
	public ModelAndView mAdd (ModelAndView mav) {
		mav.setViewName("test/mAdd");
		return mav;
	}
	
	//등록
	@RequestMapping (value = "/mAdds")
	public ModelAndView mAdds(@RequestParam HashMap<String, String> params,
							  ModelAndView mav) throws Throwable {
		//중복된 아이디가 있는지 체크
		int cnt = iMService.checkId(params);
		
		if(cnt == 0) {							//중복된 아이디가 없는 경우
			try {
				System.out.println(params.get("pw"));
				
				//암호화
				params.put("pw", Utils.encryptAES128(params.get("pw")));
				System.out.println(params.get("pw"));
				
				//복호화 확인
				System.out.println(Utils.decryptAES128(params.get("pw")));
				
				iMService.mAdds(params);
				mav.setViewName("redirect:mList");
				
			}catch (Exception e) {
				e.printStackTrace();
				mav.setViewName("test/mAdds"); 	//성공 못하면 뒤로가기
			}
		}else {									//중복된 아이디가 있는 경우
			mav.addObject("check","false");
			mav.setViewName("test/mAdds");
		}
		return mav;
	}
	
	@RequestMapping (value = "/mLogin")
	public ModelAndView mLogin(HttpSession session, ModelAndView mav) {
		if(session.getAttribute("sMNo") != null) {
			mav.setViewName("redirect:abList");
		}else {
			mav.setViewName("test/mLogin");
		}
		return mav;
	}
	
	//로그인
	@RequestMapping (value = "/mLogins")
	public ModelAndView mLogins(@RequestParam HashMap<String, String> params,
								//HttpServletRequest req,							// Session  취득방법 1: 리퀘스트 취득
								HttpSession session, 								// Session  취득방법 2: Spring에게 Session 요청
							    ModelAndView mav) throws Throwable {
		// Session 취득 방법 1 : request 이용
		//HttpSession Session = req.getSession();
		
		
		//비밀번호 암호화
		params.put("pw", Utils.encryptAES128(params.get("pw")));
		
		//사용자 정보 취득
		HashMap<String, String> data = iMService.getLogin(params);
		
		//정보취득 유무
		if(data != null) {		//값이 있다
			
			//session에 정보 추가
			//setAttribute(키,값) : session에 정보 추가
			session.setAttribute("sMNo", data.get("M_NO"));		//s 소문자 앞에 달리면, 세션에 들어가 있을 가능성이 높당
			session.setAttribute("sMNm", data.get("M_NM"));
			System.out.println(session.getAttribute("sMNm"));
			
			mav.setViewName("redirect:abList");
			
		}else {					//로그인 실패 (값이 없다)
			mav.setViewName("test/mLogins");
		}
		return mav;
	}
	
	//로그아웃
	@RequestMapping (value = "/mLogout")
	public ModelAndView mLogout(HttpSession session,
								ModelAndView mav) {
		// invalidate() : 세션 초기화. 데이터 날림.
		session.invalidate();
		
		mav.setViewName("redirect:mLogin");
		
		return mav;
	}

}
