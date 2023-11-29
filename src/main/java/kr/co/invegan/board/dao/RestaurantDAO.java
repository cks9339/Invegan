package kr.co.invegan.board.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import kr.co.invegan.board.dto.MenuDTO;
import kr.co.invegan.board.dto.RestaurantDTO;
import kr.co.invegan.board.dto.restaurantFilterListDTO;
import kr.co.invegan.member.dto.MemberDTO;

public interface RestaurantDAO {

	int boardWrite(RestaurantDTO dto);

	int restaurantWrite(RestaurantDTO dto);

	int menuWrite(MenuDTO dto);

	int photoWrite(String post_id, String server_file_name, String category);

	RestaurantDTO restaurantDetail(int post_id);

	ArrayList<MemberDTO> menuDetail(int post_id);

	ArrayList<String> photoList(int post_id);

	ArrayList<restaurantFilterListDTO> restaurantList_admin(@Param("p") int p, @Param("lat") double userLat, @Param("lng") double userLng);
	
	ArrayList<restaurantFilterListDTO> restaurantList_user(@Param("p") int p, @Param("lat") double userLat, @Param("lng") double userLng);

	int boardUpdate(RestaurantDTO dto);

	int restaurantUpdate(RestaurantDTO dto);

	void menuDel(int post_id);

	int photoDel(String idx, String img);

	int hidden(int post_id);

	int visible(int post_id);
	
	int favoriteChk(int user_no, int post_id);

	void favoriteInsert(int user_no, int post_id);

	void favoriteDel(int user_no, int post_id);

	int restaurantList_user_totalpage();
	
	int restaurantList_admin_totalpage();


}
