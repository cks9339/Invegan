package kr.co.invegan.diet.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;


import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.invegan.diet.dto.DailyNutriDTO;
import kr.co.invegan.diet.dto.DietDTO;
import kr.co.invegan.diet.dto.FoodDataDTO;
import kr.co.invegan.diet.dto.GetMonthKcalDTO;
import kr.co.invegan.diet.service.DietService;
import kr.co.invegan.member.dto.MemberDTO;

@Controller
public class DietController {

	@Autowired
	DietService dietService;

	Logger logger = LoggerFactory.getLogger(getClass());

	MemberDTO loginInfo = null;

	// 캘린더 페이지로 이동
	@RequestMapping(value = "diet/dietCalander")
	public String tempCalander(HttpSession session, RedirectAttributes reAttr) {
		logger.info("식단 캘린더 페이지 이동 요청");
		String page = "redirect:/";

		loginInfo = (MemberDTO) session.getAttribute("loginInfo");
		if (loginInfo != null) {
			logger.info("로그인된 회원번호 : " +
		loginInfo.getUser_no());
			page = "diet/dietCalander";
		} else {
			logger.info("로그인 되어있지 않음");
			reAttr.addFlashAttribute("msg", "로그인 후 이용 가능한 서비스입니다.");
		}
		return page;
	}
	
	// 칼로리 섭취량 가져오기
	@RequestMapping(value = "diet/getMonthKcal")
	@ResponseBody
	public HashMap<String, Object> getMonthKcal(HttpSession session ,@RequestParam String yearMonth){
		logger.info("캘린더 :: 칼로리 가져오기 :: yearMonth ="+yearMonth);
		loginInfo = (MemberDTO) session.getAttribute("loginInfo");
		int loginUser_no = loginInfo.getUser_no();
		HashMap<String, Object> result = new HashMap<String, Object>();
		Map<String, Object> params = Map.of(
			"loginUser_no",loginUser_no,
			"yearMonth",yearMonth
		);
				
		ArrayList<GetMonthKcalDTO> getMonthKcal = dietService.getMonthKcal(params);
		
		if(getMonthKcal.size() > 0) {
			result.put("getKcal", getMonthKcal);
		}else {
			
		}
		return result;
	}

	// 식단관리 페이지로 이동
	@RequestMapping(value = "diet/dietMgmt")
	public String dietMgmt(HttpSession session, @RequestParam String date, Model model) {
		logger.info("식단관리 페이지 이동 요청");
		logger.info("parameter chk : "+ date);
		loginInfo = (MemberDTO) session.getAttribute("loginInfo");
		String page = "redirect:/member/login.go";
		if (loginInfo == null) {
			logger.info("로그인 되어있지 않음");
			model.addAttribute("msg", "로그인 후 이용 가능한 서비스입니다.");
		} else {
			page = "diet/dietMgmt";
			// 로그인 정보 체크
			logger.info("로그인된 회원번호 : " + loginInfo.getUser_no());
			logger.info("로그인된 아이디 : " + loginInfo.getId());
			ArrayList<DietDTO> dietList = dietService.getDietList(date, loginInfo.getUser_no());

			model.addAttribute("date", date);
			logger.info("date : "+date);
			model.addAttribute("dietList", dietList);
			model.addAttribute("dietListSize", dietList.size());
			logger.info("리스트 개수 : " + dietList.size());
		}
		return page;
	}

	// 영양소 합계 불러오기
	@RequestMapping(value = "diet/getNutri")
	@ResponseBody
	public HashMap<String, Object> getNutri(HttpSession session, @RequestParam String selectDate,
			@RequestParam String dietCate) {
		logger.info("영양소 정보 불러오기 요청");

		loginInfo = (MemberDTO) session.getAttribute("loginInfo");
		int loginUser_no = loginInfo.getUser_no();

		// 회원이 섭취한 영양소 합 가져오기
		FoodDataDTO nutriInfo = dietService.getNutri(loginUser_no, selectDate, dietCate);
		// 회원별 권장 섭취량 가져오기
		DailyNutriDTO getDailyNutri = dietService.getDailyNutri(loginUser_no);
		logger.info("dailyNutri chk : "+getDailyNutri);
		logger.info("dailyNutri result check member's age : "+ getDailyNutri.getAge());
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		result.put("nutr", nutriInfo);
		logger.info("result - nutriInfo : " + nutriInfo.getKcal() );	

		result.put("daily", getDailyNutri);
		session.setAttribute("nutriInfo", nutriInfo);
		
		return result;
	}

		
	
	// 메뉴 추가 페이지 이동
	@RequestMapping(value = "diet/addMenu.go")
	public String addMenuGo(HttpSession session, Model model, 
			@RequestParam String date) {
		logger.info("메뉴 추가 페이지 요청 || date : " + date);
		model.addAttribute("date", date);
		return "diet/addMenu";
	}

	// 메뉴 추가 페이지에 기본메뉴 탭 페이지
	@RequestMapping(value = "diet/defaultMenu.go")
	public String defaultMenuGo() {
		logger.info("기본메뉴 페이지 요청 || ");
		return "diet/defaultMenu";
	}

	// 메뉴추가 하기
	@RequestMapping(value = "diet/addMenu.do")
	@ResponseBody
	public HashMap<String, Object> addMenuDo(HttpSession session, @RequestParam HashMap<String, Object> params) {
		logger.info("메뉴 추가 / 수정 요청 ");
		logger.info(" |||||| params : " + params);
		String upsertSort = (String) session.getAttribute("upsertSort");
		loginInfo = (MemberDTO) session.getAttribute("loginInfo");
		HashMap<String, Object> result = new HashMap<String, Object>();

		DietDTO dietDTO = new DietDTO();
		dietDTO.setUser_no(loginInfo.getId());
		dietDTO.setDate((String) params.get("select_date"));
		dietDTO.setFood_id(Integer.parseInt(params.get("food_id").toString()));
		dietDTO.setDiet_category((String) params.get("diet_category"));
		dietDTO.setCategory((String) params.get("menu_category"));
		dietDTO.setRecipe_name((String) params.get("recipe_name"));
		dietDTO.setGrams(Integer.parseInt(params.get("gram").toString()));

		String successMsg = dietService.addMenuDo(upsertSort, dietDTO);
		logger.info(successMsg);
		return result;
	}

	// 메뉴추가 페이지에서 식품 검색
	@RequestMapping(value = "diet/searchFood")
	@ResponseBody
	public HashMap<String, Object> searchFood(String keyword) {
		logger.info("식품 검색 기능 요청  || keyword : " + keyword);
		HashMap<String, Object> result = new HashMap<String, Object>();
		ArrayList<FoodDataDTO> searchFoodResult = dietService.findFoodList(keyword);
		if (searchFoodResult.size() == 0) {
			result.put("success", 0);
			result.put("msg", "검색 결과가 없습니다.");
		} else {
			result.put("success", 1);
			logger.info("findFoodList size : " + searchFoodResult.size());
			result.put("findFoodList", searchFoodResult);
			result.put("findFoodListSize", searchFoodResult.size());
		}

		return result;
	}

	// 검색한 식품 영양소 보기
	@RequestMapping(value = "diet/showNutri")
	@ResponseBody
	public HashMap<String, Object> showNutri(int foodId) {
		logger.info("식품 영양상세보기 요청 || foodId : " + foodId);
		HashMap<String, Object> result = new HashMap<String, Object>();
		FoodDataDTO showNutri = dietService.showNutri(foodId);
		result.put("showNutri", showNutri);
		return result;
	}
	
	// 메뉴 삭제하기
	@RequestMapping(value = "diet/deleteMenu")
	@ResponseBody
	public HashMap<String, Object> deleteMenu(HttpSession session, @RequestParam HashMap<String, Object> params){
		logger.info("메뉴 삭제 요청");
		logger.info("삭제요청 params check : " + params);
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		// 회원 검사(비회원 접근 제한 / 로그인한 회원번호와 식단의 회원번호 비교 )
		loginInfo = (MemberDTO) session.getAttribute("loginInfo");
		int getUserNo = dietService.getUserNo(params);
		if(loginInfo != null) {	// 비회원 접근 제한
			if(loginInfo.getUser_no() == getUserNo) { // 로그인한 회원번호 , 식단 회원번호 비교
				logger.info("회원번호 일치");
				// 일반 메뉴 , 나만의 레시피 메뉴 구분
				if(params.get("category").equals("기본메뉴")) {
					logger.info("메뉴삭제 :: 기본메뉴");
					int row = dietService.delMenu(params);
					if(row == 4) {
						logger.info("기본메뉴 삭제 정상동작");
						result.put("success", "success");
					}else {
						logger.info("기본메뉴 삭제 실패 row값 : "+ row);
						result.put("error", "삭제 실패 :: 관리자에게 문의해주세요");
					}
					
				}else if(params.get("category").equals("나만의레시피")) {
					logger.info("메뉴삭제 :: 나만의 레시피메뉴");
					int row = dietService.delMyRecipeMenu(params);
					if(row == 2) {
						logger.info("기본메뉴 삭제 정상동작");
						result.put("success", "success");
					}else {
						logger.info("기본메뉴 삭제 실패 row값 : "+ row);
						result.put("error", "삭제 실패 :: 관리자에게 문의해주세요");
					}
				}else {
					logger.info("VALLUE ERROR :: params value = "+params.get("category")+" :: DB or SOURCE CODE CHECK");
					
				}
			}else{
				logger.info("회원번호 불일치");
				result.put("msg", "잘못된 접근입니다.");
			}
		}else {
			logger.info("비회원 :: 메뉴 삭제 기능 접근");
			result.put("msg", "로그인이 필요한 서비스입니다.");
		}
		
		
		return result;
	}
	

	@RequestMapping(value = "diet/addMaterial.go")
	public String addMaterial(@RequestParam HashMap<String, Object> params) {
		logger.info("addMaterial 페이지로 이동");
		return "diet/addMaterial";
	}

	@RequestMapping(value = "diet/addMaterial.do")
	public String food_addM(@RequestParam HashMap<String, Object> params, HttpSession session, Model model) {
		MemberDTO loginInfo = (MemberDTO) session.getAttribute("loginInfo");
		logger.info("food_addM 함수 접근");

		if (loginInfo == null) {
			String msg = "관리자만 접근할 수 있습니다.(비회원 상태)";
			logger.info("관리자가 아니면 접근 불가(비회원 상태)");
			model.addAttribute("msg", msg);
			return "main";
		} else if (loginInfo.getIs_admin() == 0) {
			String msg = "관리자만 접근할 수 있습니다.(일반회원 상태)";
			logger.info("관리자가 아니면 접근 불가(일반회원 상태)");
			model.addAttribute("msg", msg);
			return "main";
		} else {
			logger.info("관리자 접근");
			logger.info("do params:" + params);
			String msg = "관리자 계정에 접근하셨습니다.";
			dietService.addMaterialAdm(params);
			return "redirect:/main";
		}
	}
}
