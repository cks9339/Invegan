package kr.co.invegan.mypage.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import kr.co.invegan.mypage.dto.MyPageDTO;

public interface MyPageDAO {

	MyPageDTO userInfo(int user_no);

	int overlay(String nickname);

	// ArrayList<MyPageDTO> requestBoardList(int user_no, int offset);

	ArrayList<MyPageDTO> recipeBoardList(int user_no);

	
	 ArrayList<MyPageDTO> freeBoardList(int user_no);
	 
	 ArrayList<MyPageDTO> feedList(int user_no);
	 
	void delUser(int user_no);

	ArrayList<MyPageDTO> recipeComments(int user_no);

	ArrayList<MyPageDTO> recipeFavorite(int user_no);

	
	ArrayList<MyPageDTO> freeComments(Integer user_no);
	 
	ArrayList<MyPageDTO> feedComments(int user_no);
	 
	ArrayList<MyPageDTO> restaurantComments(Integer user_no);
	 
	ArrayList<MyPageDTO> restaurantFavorite(Integer user_no);
	 
	int updateNickname(String nickname, Integer user_no);

	String pwConfirm(String pw, Integer user_no);

	int completePw(Map<String, Object> params);

	int save(Map<String, Object> params);

	// int rqTotalPage();

	
	 // ArrayList<MyPageDTO> list(int i, int offset);
	
	 void saveProfileImg(int image_id, String server_file_name, Integer user_no);

	void uploadProfile(MyPageDTO dto);

	void imgModify(String server_file_name, Integer user_no);

	ArrayList<MyPageDTO> requestBoardList(Integer user_no);
	


}
