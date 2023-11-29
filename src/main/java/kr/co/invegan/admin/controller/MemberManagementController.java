package kr.co.invegan.admin.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.invegan.admin.service.MemberManagementService;
import kr.co.invegan.member.dto.MemberDTO;

@Controller
public class MemberManagementController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired MemberManagementService service;
	
  @RequestMapping(value="/admin/list") 
  public String memberList() { 
	  return"/admin/memberList"; 
  }	

	@RequestMapping(value="/admin/memberListCall")
	@ResponseBody
	public HashMap<String,Object> memberList(HttpSession session, @RequestParam HashMap<String, String> params){
		logger.info("params:"+params);
		MemberDTO loginInfo = (MemberDTO) session.getAttribute("loginInfo");
	
		logger.info(params.get("page"));
		return service.memberList(loginInfo, params);
	}
	

	@RequestMapping(value="/admin/detail")
	public String detail(Model model, HttpSession session, @RequestParam String id) {
		logger.info("상세보기 요청 : "+id);
		String page = "/admin/list";
		
		MemberDTO loginInfo = (MemberDTO) session.getAttribute("loginInfo");
		
		if(loginInfo != null && loginInfo.getIs_admin() != 0) { 
			MemberDTO dto = service.userInfo(id);
			model.addAttribute("dto",dto);
			logger.info("dto:"+dto);
			page = "/admin/detail";
			
		}else{
				page = "/admin/main";
		}
		return page;
	}
	
}
