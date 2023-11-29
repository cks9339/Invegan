package kr.co.invegan.diet.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.invegan.diet.dao.MyRecipeDAO;
import kr.co.invegan.diet.dto.DietDTO;

@Service
public class MyRecipeService {
	
	@Autowired MyRecipeDAO dao;
	
	Logger logger = LoggerFactory.getLogger(getClass());

	public ArrayList<HashMap<String, Object>> mlist(String fName) {
		
		logger.info("fName :"+fName);
		return dao.mlist(fName);
	}

	public void  mMaterial(int food_id, int grams, int menu_id) {
		logger.info("food_id : " + food_id);
		logger.info("gram : "+grams);
		logger.info("menu_id : "+menu_id);
		
		dao.mMaterial(food_id, grams, menu_id);
	}

	public void rListUpdate(HashMap<String, Object> params) {
		
		logger.info("params : "+params);
		dao.rListUpdate(params);
	}

	public ArrayList<HashMap<String, Object>> mrlist(int user_no) {
		logger.info("user_no : "+user_no);
		return dao.mrlist(user_no);
	}

	public ArrayList<HashMap<String, Object>> rMaterial(int menu_id) {
		logger.info("menu_id : "+menu_id);
		return dao.rMaterial(menu_id);
	}

	public boolean mdelete(int material_id) {
		return dao.mdelete(material_id);
	}

	public boolean rdelete(int menu_id) {
		return dao.rdelete(menu_id);
	}

	public boolean rmdelete(int menu_id) {
		return dao.rmdelete(menu_id);
	}

	public ArrayList<HashMap<String, Object>> rNutrido(int menu_id) {
		return dao.rNutrido(menu_id);
	}

	public String addMenuDo(DietDTO dietDTO) {
		logger.info("diteDTO : "+dietDTO);
		String msg = "메뉴 등록 성공";
		dao.dinsert(dietDTO);
		dao.dcinsert(dietDTO);
		return msg;
	}

	public ArrayList<HashMap<String, Object>> mNutrido(int material_id) {
		return dao.mNutrido(material_id);
	}





}
