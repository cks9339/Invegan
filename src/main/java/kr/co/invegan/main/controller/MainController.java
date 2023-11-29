package kr.co.invegan.main.controller;

import java.util.ArrayList;
import java.util.HashMap;

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

import kr.co.invegan.board.dto.FeedListDTO;
import kr.co.invegan.board.dto.restaurantFilterListDTO;
import kr.co.invegan.main.service.MainService;
import kr.co.invegan.member.dto.MemberDTO;

@Controller
public class MainController {

	@Autowired
	MainService service;

	Logger logger = LoggerFactory.getLogger(getClass());

	@RequestMapping(value = { "/", "/main" })
	public String main(HttpSession session) {
		return "main";
	}
	
	// 개인 맞춤 필터 리스트 제공
	@RequestMapping(value = "/main/FL", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> FL(HttpSession session, @RequestParam HashMap<String, String> param) {
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		double userLat = Double.parseDouble(param.get("lat")); // 위도
		double userLng = Double.parseDouble(param.get("lng")); // 경도
		session.setAttribute("userLat", userLat);
		session.setAttribute("userLng", userLng);
		logger.info("latlng: " + userLat + " " + userLng);
		
		ArrayList<restaurantFilterListDTO> RFL = service.restaurantFilterList(session, userLat, userLng); // 레스토랑 필터 리스트
		ArrayList<FeedListDTO> FFL = service.feedFilterList(session); // 피드 필터 리스트
		result.put("RFL", RFL);
		result.put("FFL", FFL);
		return result;
	}

	@RequestMapping(value = "/main/header")
	public String mainHeader(Model model, HttpSession session) {
		MemberDTO loginInfo = (MemberDTO) session.getAttribute("loginInfo");
		if (loginInfo != null) {
			logger.info("loginId: " + loginInfo.getId() + " / user_no: " + loginInfo.getUser_no() + " / admin: "
					+ loginInfo.getIs_admin());
		} else {
			logger.info("비회원");
		}
		return "main/header";
	}

	
	
	
	/*
	@RequestMapping(value = "/main/footer")
	public String mainFooter(Model model) {
		return "main/footer";
	}
	*/
}




