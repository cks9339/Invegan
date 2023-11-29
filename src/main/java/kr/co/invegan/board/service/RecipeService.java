package kr.co.invegan.board.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.invegan.board.dao.RecipeDAO;

@Service
public class RecipeService {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	RecipeDAO dao;
}
