package kr.co.invegan.member.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.invegan.member.dto.MemberDTO;
import kr.co.invegan.member.service.MemberService;

@Controller
public class MemberController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired MemberService service;
	
	@RequestMapping(value="/member/login.go")
	public String loginPage() {
		return "member/login";
	}	
	
	//로그인
	@RequestMapping(value={"*/member/login", "member/login"}, method = RequestMethod.POST)
	public String login(HttpSession session, RedirectAttributes redirectAttributes ,@RequestParam String id, @RequestParam String pw){
		logger.info("로그인 요청 || id = "+id+" / pw = "+pw);
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("pw", pw);
		MemberDTO loginInfo = service.login(params);
		logger.info("loginInfo : "+ loginInfo);		
		if(loginInfo == null) {
			logger.info("아이디 / 비밀번호 불일치");
			redirectAttributes.addFlashAttribute("msg", "아이디 또는 비밀번호를 확인 하세요");
		}else {
			if(loginInfo.getProfile_img() == null) {
				loginInfo.setProfile_img("profile.jpg");
			}
			session.setAttribute("loginInfo", loginInfo);
			logger.info("로그인 id :"+loginInfo.getId()+" 관리자 여부 : "+loginInfo.getIs_admin());
		}
		return "redirect:/";	
	}
	
	
	@RequestMapping(value = "/member/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("loginInfo");
		return "redirect:/";
	}

	//아이디 비밀번호 찾기
		@RequestMapping(value = { "/member/find" }, method = RequestMethod.GET)
		public String find() {

			return "member/find";
		}
	
	//아이디 찾기
	@RequestMapping(value = { "/member/findId" }, method = RequestMethod.GET)
	public String findId() {

		return "member/findId";
	}

	@RequestMapping(value = {"/member/findId2"}, method = RequestMethod.POST)
	public String findId(HttpServletResponse response, 
			@RequestParam String email, 
			Model model) throws Exception {
		logger.info("email : "+email);
		model.addAttribute("id", service.findId(response, email));
		
		return "member/findId";
	}
	

	//비밀번호 찾기
	@RequestMapping(value = { "/member/findPw" }, method = RequestMethod.GET)
	public String findPw() {

		return "member/findPw";
	}
	
	@RequestMapping(value = {"/member/findPw2"}, method = RequestMethod.POST)
	public String findPw(HttpServletResponse response, 
	        @RequestParam String id, @RequestParam String email, 
	        Model model) throws Exception {
	    logger.info("id : " + id);
	    logger.info("email : " + email);
	    
	    String pw = service.findPw(response, id, email);
	    logger.info("service.findPw(id, email)을 실행해서 pw변수에 담음");
	    if (pw != null) {
	        model.addAttribute("pw", pw);
	    }
	    
	    return "member/findPw"; 
	}
	
	//회원가입 go
	@RequestMapping(value = { "/member/signup.go" }, method = RequestMethod.GET)
	public String signupGo() {
		logger.info("회원가입 go");
		return "member/signup";
	}
	
	// 회원가입 do
	@RequestMapping(value = "/member/signup.do", method = RequestMethod.POST)
	public String signupDo(Model model, @RequestParam HashMap<String, Object> params, @RequestParam String[] interests) {
		logger.info("params"+params);
		String page = "/member/signup";
		
		// 파라미터 값 check
		String paramsChk = service.paramsChk(params);
		
		int row = 0;
		if(paramsChk.equals("complete")) {
			
			// "interests" 배열을 쉼표로 구분된 하나의 문자열로 결합
			String combinedInterests = String.join(",", interests);
			logger.info("Combined interests: " + combinedInterests);
			//HashMap에서 값을 집어 넣을 때 put 사용
			//combinedInterests 값을 interests라는 이름으로 집어넣음
			params.put("interests", combinedInterests);
			logger.info("params : "+params);
			
			row = service.signup(params);
			if(row > 0 ) {
				page = "redirect:/";
				model.addAttribute("msg", "환영합니다. "+params.get("id")+" 님\n로그인 해주세요");
			}else {
				model.addAttribute("msg", "회원가입실패");
			}
		}else {
			model.addAttribute("msg", paramsChk);
		}
		
		return page;
	}
	
	// 아이디 중복 검사
	@RequestMapping(value = "/member/validateId")
	@ResponseBody
	public HashMap<String, Object> validateId(@RequestParam String validateId) {
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		logger.info("id 값 : "+validateId);
		int row = service.validateId(validateId);
		logger.info("row =="+ row);
		
		if(row > 0) {	
			// 이미 사용중인 아이디 일때 
			 result.put("success", row);
		}else {		
			// 사용 가능한 아이디 일때		// row = 0
			 result.put("success", row);
		}
		return result;
	}
		
	
}
