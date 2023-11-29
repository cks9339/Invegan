package kr.co.invegan.main.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.co.invegan.board.dto.FeedListDTO;
import kr.co.invegan.board.dto.RestaurantDTO;
import kr.co.invegan.main.dto.distCntDTO;
import kr.co.invegan.board.dto.restaurantFilterListDTO;

public interface MainDAO {

//	ArrayList<RestaurantDTO> prf();

	int veganType(int user_no);

	distCntDTO rangeCnt(@Param("list") List<String> vt, @Param("lat") double userLat, @Param("lng") double userLng);

	ArrayList<restaurantFilterListDTO> restaurantFilterList(@Param("list") List<String> vt, @Param("lat") double userLat, @Param("lng") double userLng, @Param("dist") int dist);

	String interests(int user_no);

	ArrayList<FeedListDTO> feedFilterList();

	ArrayList<FeedListDTO> feedInterestFilterList(@Param("list") List<String> inte);

}
