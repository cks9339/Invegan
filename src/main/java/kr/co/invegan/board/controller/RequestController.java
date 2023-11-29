package kr.co.invegan.board.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.invegan.board.service.RequestService;
import kr.co.invegan.member.dto.MemberDTO;

@Controller
public class RequestController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired RequestService service;
	
	MemberDTO loginInfo = null;
	
	// 요청 게시판 이동
	@RequestMapping(value="request/requestList")
	public String requestgo(HttpSession session, RedirectAttributes reAttr) {
		logger.info("요청 게시판 이동");
		String page = "redirect:member/login.go";
		loginInfo = (MemberDTO) session.getAttribute("loginInfo");
		
		if (loginInfo != null) {
			logger.info("User_no : " + loginInfo.getUser_no());
			page = "request/requestList";
		} else {
			logger.info("로그인 x");
			reAttr.addFlashAttribute("msg", "로그인 후 이용 가능한 서비스입니다.");
		}
		
		return page;
	}
	/*
	// 요청게시판 리스트 출력
	@RequestMapping(value="request/requestList.do")
	@ResponseBody
	public HashMap<String, Object> requestdo(HttpSession session) {

		loginInfo = (MemberDTO) session.getAttribute("loginInfo");
		logger.info("요청 게시판 리스트 출력");

		HashMap<String, Object> result = new HashMap<String, Object>();
		ArrayList<HashMap<String, Object>> requestdo = service.requestdo();
		
		logger.info("result : "+requestdo);
		
		result.put("requestdo", requestdo);
		result.put("admin", loginInfo.getIs_admin());
		
		return result;
	}*/
	
	@RequestMapping(value="request/requestList.do")
	@ResponseBody
	public Map<String, Object> requestdo(HttpSession session, 
			@RequestParam String pagePerNum, @RequestParam String page) {
		loginInfo = (MemberDTO) session.getAttribute("loginInfo");
		int admin = loginInfo.getIs_admin();
		
		logger.info("게시글 수 : "+pagePerNum);
		logger.info("보여주는 페이지 : "+page);	
		logger.info("관리자 유무 : "+admin);
		
		return service.requestdo(pagePerNum, page, admin);
	}
}
