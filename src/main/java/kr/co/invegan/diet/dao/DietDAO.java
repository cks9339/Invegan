package kr.co.invegan.diet.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import kr.co.invegan.diet.dto.DailyNutriDTO;
import kr.co.invegan.diet.dto.DietDTO;
import kr.co.invegan.diet.dto.FoodDataDTO;
import kr.co.invegan.diet.dto.GetMonthKcalDTO;


public interface DietDAO {	


	ArrayList<FoodDataDTO> findFoodList(String keyword);

	FoodDataDTO showNutri(int foodId);

	int getServingSize(int food_id);	// ?

	int addDiet(DietDTO dietDTO);
	int addMenu(DietDTO dietDTO);
	int addMaterial(DietDTO dietDTO);
	int addDietComp(DietDTO dietDTO);

	ArrayList<DietDTO> getDietList(HashMap<String, Object> params);

	FoodDataDTO getAllNutri(HashMap<String, Object> params);
	FoodDataDTO getNutri(HashMap<String, Object> params);

	int addMaterialAdm(HashMap<String, Object> params);
	DailyNutriDTO getDailyNutri(int loginUser_no);

	int getUserNo(HashMap<String, Object> params);

	// 메뉴 삭제
	int delMaterialTbl(HashMap<String, Object> params);
	int delDietCompTbl(HashMap<String, Object> params);
	int delMenuTbl(HashMap<String, Object> params);
	int delDietTbl(HashMap<String, Object> params);
	
	// 일별 칼로리 합계 가져오기
	ArrayList<GetMonthKcalDTO> getMonthKcal(Map<String, Object> params);



}
