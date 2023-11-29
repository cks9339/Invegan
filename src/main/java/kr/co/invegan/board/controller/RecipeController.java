package kr.co.invegan.board.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.invegan.board.service.RecipeService;

@Controller
public class RecipeController {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	RecipeService service;
	

	@RequestMapping(value = "/recipe/list")
	public String recipeList(HttpSession session, Model model){
		String page = "recipe/recipeList";
		
		return page;
	}
	
	@RequestMapping(value = "/recipe/search", method = RequestMethod.POST)
	public String search(HttpSession session, Model model, @RequestParam String search, @RequestParam String keyword){
		logger.info(search+"/"+keyword);
		
		
		return "recipe/searchList";
	}
	
	
	
}
