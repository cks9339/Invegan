package kr.co.invegan.diet.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.invegan.diet.dao.DietDAO;
import kr.co.invegan.diet.dto.DailyNutriDTO;
import kr.co.invegan.diet.dto.DietDTO;
import kr.co.invegan.diet.dto.FoodDataDTO;
import kr.co.invegan.diet.dto.GetMonthKcalDTO;

@Service
public class DietService{

	@Autowired DietDAO dietDAO;
	
	Logger logger = LoggerFactory.getLogger(getClass());

	public ArrayList<FoodDataDTO> findFoodList(String keyword) {
		logger.info("findFood() || keyword : " + keyword);
		ArrayList<FoodDataDTO> findFoodList = dietDAO.findFoodList(keyword);
		
		return findFoodList;
	}

	public FoodDataDTO showNutri(int foodId) {
		logger.info("showNutri() || foodId : "+foodId);
		return dietDAO.showNutri(foodId);
	}

	public String addMenuDo(String upsertSort, DietDTO dietDTO){
		logger.info("addMenuDo() 실행");
		int row = 0;
		String msg = "메뉴 등록 실패";
		
		logger.info("메뉴 추가 기능 실행");
		row += dietDAO.addDiet(dietDTO);
		row += dietDAO.addMenu(dietDTO);
		logger.info("get diet_id = "+dietDTO.getDiet_id()+" / get menu_id = "+dietDTO.getMenu_id());
		row += dietDAO.addMaterial(dietDTO);
		row += dietDAO.addDietComp(dietDTO);
		logger.info("저장 결과 : "+row);
		
		if(row == 4) {
			msg = "메뉴를 등록 성공";
		}
		return msg;  
	}

	
	public ArrayList<DietDTO> getDietList(String date, int user_no) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("date", date);
		params.put("loginId", user_no);
		return dietDAO.getDietList(params);
		
	}
	
	public FoodDataDTO getNutri(int loginUser_no, String selectDate, String dietCate) {
		logger.info("getNutri() 실행 || prameter : "+ loginUser_no +" / "+selectDate+" / "+dietCate);
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("loginUser_no", loginUser_no);
		params.put("selectDate", selectDate);
		
		FoodDataDTO getNutriInfo = null;
		
		if(dietCate.equals("전체")) {
			logger.info("전체 영양소 불러오기");
			// 전체 총합 가져오기
			getNutriInfo = dietDAO.getAllNutri(params);
		}else{
			logger.info("특정 식단 영양소 불러오기");
			params.put("dietCate", dietCate);
			getNutriInfo = dietDAO.getNutri(params);
		}
		return getNutriInfo;
	}

	public void addMaterialAdm(HashMap<String, Object> params) {

		int row = dietDAO.addMaterialAdm(params);
		if(row>0) {
			logger.info("식재료가 정상적으로 추가 되었습니다.");
		}else {
			logger.info("식재료 추가에 실패하였습니다.");
		}
	}
	public DailyNutriDTO getDailyNutri(int loginUser_no) {
		logger.info("회원의 영양소별 1회 제공량 가져오기");
		logger.info("loginuser no : "+loginUser_no);
		return dietDAO.getDailyNutri(loginUser_no);
	}
	
	
	// 회원 체크
	public int getUserNo(HashMap<String, Object> params) {
		logger.info("getUserNo() 실행");
		int getUserNo = dietDAO.getUserNo(params);
		if(getUserNo >= 0) {
			logger.info("회원 체크 성공 :: "+getUserNo );
		}else {
			logger.info("회원 번호 불일치");
		}
		return getUserNo;
	}

	// 기본메뉴 삭제
	public int delMenu(HashMap<String, Object> params) {
		logger.info("delMenu():: 기본 메뉴 삭제 실행");
		int row = 0;
		row += dietDAO.delMaterialTbl(params);
		logger.info("row check Material"+row);
		row += dietDAO.delDietCompTbl(params);
		logger.info("row check Menu"+row);
		row += dietDAO.delMenuTbl(params);
		logger.info("row check diet"+row);
		row += dietDAO.delDietTbl(params);
		logger.info("row check dietComposition"+row);
		if(row == 4) {
			logger.info("메뉴 삭제 완료");
		}
		return row;
	}
	

	public int delMyRecipeMenu(HashMap<String, Object> params) {
		logger.info("delMenu():: 나만의레시피 메뉴 삭제 실행");
		int row = 0;
		row += dietDAO.delDietCompTbl(params);
		row += dietDAO.delDietTbl(params);
		return row;
	}

	// 일별 칼로리 가져오기
	public ArrayList<GetMonthKcalDTO> getMonthKcal(Map<String, Object> params) {
		logger.info("getMonthKcal() :: 일별 칼로리 가져오기 실행");
		ArrayList<GetMonthKcalDTO> getMonthKcal = dietDAO.getMonthKcal(params);
		return getMonthKcal;
	}
	
	
	


}
