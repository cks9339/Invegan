package kr.co.invegan.mypage.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

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
import org.springframework.web.multipart.MultipartFile;

import kr.co.invegan.member.dto.MemberDTO;
import kr.co.invegan.mypage.dto.MyPageDTO;
import kr.co.invegan.mypage.service.MyPageService;

@Controller
public class MyPageController {

	Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	MyPageService service;

	MyPageDTO dto = new MyPageDTO();

	@RequestMapping(value = "/myPage/info.go")
	public String infoGo(Model model, HttpSession session) {

		int user_no = ((MemberDTO) session.getAttribute("loginInfo")).getUser_no();
		
		if (user_no != 0) {
			MyPageDTO dto = service.userInfo(user_no);
			model.addAttribute("dto", dto);
			logger.info("dto:" + dto);
			logger.info(dto.getProfile_image());
			
			return "myPage/mypage";
		} else {
			return "redirect:/login";
		}
	}

	@RequestMapping(value = "/myPage/feedListCall")
	@ResponseBody
	public HashMap<String, Object> feedListCall(@RequestParam String tabType, @RequestParam Integer user_no) {

		HashMap<String, Object> result = new HashMap<String, Object>();
		ArrayList<MyPageDTO> list = null;
		// String page = params.get("page");
		
		logger.info(tabType+"/"+user_no);
		
		/*switch (boardType) {
		case "요청":
			if ("작성한 글 모아보기".equals(tabType)) {
				list = service.requestBoardList(user_no);
			}
			break;
		
		case "레시피": 
			if ("작성한 글 모아보기".equals(tabType)) { 
				list = service.recipeBoardList(user_no); 
			}else if ("댓글 모아보기".equals(tabType)){ 
				list = service.recipeComments(user_no); 
			}else if("나의 스크랩".equals(tabType)) { 
				list = service.recipeFavorite(user_no); 
			}
			break;
		
	
		case "자유게시판": if ("작성한 글 모아보기".equals(tabType)) { 
				list = service.freeBoardList(user_no); 
			} else if ("댓글 모아보기".equals(tabType)) { 
				list = service.freeComments(user_no); } 
			break; */
		if(tabType.equals("작성한 피드 모아보기")) { 
			list = service.feedList(user_no); 
		} 
		/*
		else if("댓글 모아보기".equals(tabType)) { 
				list = service.feedComments(user_no); } 
			break;
		case "식당": if ("댓글 모아보기".equals(tabType)) { 
				list =service.restaurantComments(user_no); } else if ("나의 스크랩".equals(tabType)) {
				list = service.restaurantFavorite(user_no); } 
			break;
		 
		default:

			break;
		}*/
		result.put("user_no", user_no);
		logger.info("user_no:" + user_no);
		result.put("list", list);
		// result.put("page", page);
		// logger.info("보여줄 페이지 : " + page);

		return result;
	}
	
	@RequestMapping(value = "/myPage/feedCmListCall")
	@ResponseBody
	public HashMap<String, Object> feedCmListCall(@RequestParam String tabType, @RequestParam Integer user_no) {

		HashMap<String, Object> result = new HashMap<String, Object>();
		ArrayList<MyPageDTO> fcmList = null;


		logger.info(tabType+"/"+user_no);
	
		if(tabType.equals("댓글 모아보기")) { 
			fcmList = service.feedComments(user_no); } 
	
		result.put("user_no", user_no);
		logger.info("user_no:" + user_no);
		result.put("fcmList", fcmList);
		// result.put("page", page);
		// logger.info("보여줄 페이지 : " + page);

		return result;
	}
	
	/*
	 * @RequestMapping(value = "/myPage/rtCmListCall")
	 * 
	 * @ResponseBody public HashMap<String, Object> rtCmListCall(@RequestParam
	 * String boardType, @RequestParam Integer user_no) {
	 * 
	 * HashMap<String, Object> result = new HashMap<String, Object>();
	 * ArrayList<MyPageDTO> rtCmList = null;
	 * 
	 * 
	 * logger.info(boardType+"/"+user_no);
	 * 
	 * if(boardType.equals("식당")) { rtCmList = service.restaurantComments(user_no);
	 * }
	 * 
	 * result.put("user_no", user_no); logger.info("user_no:" + user_no);
	 * result.put("rtCmList", rtCmList); // result.put("page", page); //
	 * logger.info("보여줄 페이지 : " + page);
	 * 
	 * return result; }
	 */

	@RequestMapping(value = "/myPage/favoriteListCall")
	@ResponseBody
	public HashMap<String, Object> favoriteListCall(@RequestParam String tabType, @RequestParam Integer user_no) {

		HashMap<String, Object> result = new HashMap<String, Object>();
		ArrayList<MyPageDTO> favList = null;
		
		logger.info(tabType+"/"+user_no);
		
		if (tabType.equals("나의 스크랩")) { 
			favList = service.restaurantFavorite(user_no); 
		} 
		
		result.put("user_no", user_no);
		logger.info("user_no:" + user_no);
		result.put("favList", favList);
		// result.put("page", page);
		// logger.info("보여줄 페이지 : " + page);

		return result;
	}
	
	
	
	@RequestMapping(value = "/myPage/delUser")
	public String deleteInfo(@RequestParam int user_no, HttpSession session) {
		service.delUser(user_no);
		session.invalidate();

		logger.info("user_no:" + user_no);
		return "redirect:/";
	}

	@RequestMapping(value = "/myPage/overlay")
	@ResponseBody
	public HashMap<String, Object> overlay(@RequestParam String nickname) {
		boolean use = service.overlay(nickname);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("use", use);
		return map;
	}

	@RequestMapping(value = "/myPage/updateNickname")
	@ResponseBody
	public HashMap<String, Object> updateNickname(HttpSession session, Model model, @RequestParam String nickname, @RequestParam Integer user_no) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		logger.info(nickname + "/" + user_no);
		
		int cnt = service.updateNickname(nickname, user_no);
	   
	    if (cnt > 0) {
	        
	        MemberDTO loginInfo = (MemberDTO) session.getAttribute("loginInfo");
	        loginInfo.setNickname(nickname);
	        session.setAttribute("loginInfo", loginInfo);
	        
	        logger.info("닉네임 변경 완료");
	    }
	    
	    map.put("cnt", cnt);
	    return map;
	}

	@RequestMapping(value = "/myPage/pwConfirm")
	@ResponseBody
	public HashMap<String, Object> pwConfirm(@RequestParam String pw, @RequestParam Integer user_no) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		logger.info(pw + "/" + user_no);

		String crPw = service.pwConfirm(pw, user_no);
		logger.info(crPw);
		map.put("crPw", crPw);

		return map;

	}

	@RequestMapping(value = "/myPage/completePw")
	@ResponseBody
	public HashMap<String, Object> completePw(@RequestParam Map<String, Object> params) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		logger.info(params.get("user_no") + "/" + params.get("pw") + "/" + params.get("updatePw") + "/"
				+ params.get("updatePwConfirm"));

		if (params.get("updatePw").equals(params.get("updatePwConfirm"))) {
			int completePw = service.completePw(params);
			logger.info("수정여부:" + completePw);
			map.put("completePw", completePw);
		}
		return map;
	}

	@RequestMapping(value = "/myPage/save")
	@ResponseBody
	public HashMap<String, Object> save(@RequestParam Map<String, Object> params) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		logger.info(params.get("user_no") + "/" + params.get("interests") + "/" + params.get("vegan_type") + "/"
				+ params.get("vegan_purpose"));
		int cnt = service.save(params);
		logger.info("수정 여부:" + cnt);
		map.put("cnt", cnt);

		return map;
	}
		// 프로필 이미지 등록
		@RequestMapping(value="/myPage/imgUpload",method=RequestMethod.POST)
		@ResponseBody 
		public String imgUpload(HttpSession session, @RequestParam MultipartFile photo, @RequestParam Integer user_no) throws IOException {
		logger.info(photo.getOriginalFilename()+"/user_no : "+user_no);
		
		
		  service.imgUpload(session,photo,user_no);

		  return "update 성공"; 
		}
		
		// 프로필 이미지 수정
		@RequestMapping(value="/myPage/imgModify",method=RequestMethod.POST)
		@ResponseBody 
		public String imgModify(HttpSession session, @RequestParam("photo") MultipartFile photo, @RequestParam Integer user_no) throws IOException {
		logger.info("file :"+photo.getOriginalFilename()+"/user_no : "+user_no);
		
		
		 service.imgModify(session,photo,user_no);
		 

		  return "update 성공"; 
		}
		  
	 
}
