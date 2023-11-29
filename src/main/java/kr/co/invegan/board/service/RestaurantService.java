package kr.co.invegan.board.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.google.maps.GeoApiContext;
import com.google.maps.GeocodingApi;
import com.google.maps.errors.ApiException;
import com.google.maps.model.GeocodingResult;

import kr.co.invegan.board.dao.RestaurantDAO;
import kr.co.invegan.board.dto.MenuDTO;
import kr.co.invegan.board.dto.RestaurantDTO;
import kr.co.invegan.board.dto.restaurantFilterListDTO;
import kr.co.invegan.member.dto.MemberDTO;

@Service
public class RestaurantService {
	
	@Autowired RestaurantDAO dao;

	Logger logger = LoggerFactory.getLogger(getClass());

	private String root = "C:/upload";
	
	// 작성 메서드
	public String restaurantWrite(int user_no, MultipartFile[] uploadImages, HashMap<String, Object> param){
		String msg = "식당 등록에 실패했습니다";
		RestaurantDTO dto = insert_RestaurantDTO(user_no, param); // 1. RestaurantDTO에 담기
		
		// 2. Board, Restaurant 테이블 인서트
		int result_board = dao.boardWrite(dto);
		int result_restaurant = dao.restaurantWrite(dto);
		
		int post_id = dto.getPost_id(); // Board 테이블 인서트하면서 생긴 post_id
		logger.info("post_id : "+post_id);
		
		boolean menuChk = menuWrite(post_id, param.get("menu")); // 3. 메뉴 테이블 인서트
		
		boolean imgChk = false;
		try {
			imgChk = saveFile(post_id,uploadImages); // 4. 이미지 DB 및 서버 저장
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(result_board == 1 && result_restaurant == 1 && menuChk && imgChk) {
			msg = "식당을 등록했습니다";
		}else {
			logger.info("작성 중 문제 발생 : "+result_board+result_restaurant+menuChk+imgChk);
		}
		return msg;
		
	}
	
	
	// 수정 메서드
	public String restaurantUpdate(int user_no, MultipartFile[] uploadImages, HashMap<String, Object> param) {
		String msg = "식당 수정에 실패했습니다";
		// 업데이트
		logger.info("restaurantUpdate");
		
		RestaurantDTO dto = insert_RestaurantDTO(user_no, param); // 1. RestaurantDTO에 담기
		int post_id = Integer.parseInt(""+param.get("post_id"));
		dto.setPost_id(post_id);
		
		// 2.Board, Restaurant 테이블 업데이트
		int result_board = dao.boardUpdate(dto);
		int result_restaurant = dao.restaurantUpdate(dto);
		
		// 3. 기존 메뉴 삭제 -> 새로운 메뉴 인서트
		dao.menuDel(post_id);
		boolean menuChk = menuWrite(post_id, param.get("menu"));
		
		// 4. imgDelList 사진을 DB 및 서버 삭제
		boolean imgDelChk = delFile(post_id, param.get("imgDelList"));
		boolean imgChk = false;
		try {
			imgChk = saveFile(post_id,uploadImages);
		} catch (Exception e) {
			logger.info("saveFile 에러");
			e.printStackTrace();
		}
		msg = "식당을 수정했습니다";
		
		return msg;
	}
	
	
	//상세보기 메서드 들
	public RestaurantDTO restaurantDetail(int post_id) {
		return dao.restaurantDetail(post_id);		
	}
	public ArrayList<MemberDTO> menuDetail(int post_id) {
		return dao.menuDetail(post_id);
	}
	public ArrayList<String> photoList(int post_id) {
		return dao.photoList(post_id);
	}
	
	// 리스트(관리자)
	public ArrayList<restaurantFilterListDTO> restaurantList_admin(int page, Double userLat, Double userLng) {
		int p = (page-1)*20;
		return dao.restaurantList_admin(p, userLat, userLng);
	}
	// 리스트(일반)
	public ArrayList<restaurantFilterListDTO> restaurantList_user(int page, Double userLat, Double userLng) {
		int p = (page-1)*20;
		return dao.restaurantList_user(p, userLat, userLng);
	}

	// 메뉴를 DB에 인서트하는 메서드	
	private boolean menuWrite(int post_id, Object object_menu) {
		String menu = (String) object_menu;	
		String[] menuArr= menu.split(",");
		logger.info("메뉴 인서트");
		int len = menuArr.length;
		logger.info("menuArr : "+menuArr+" / len : "+len);
		int chk = 0;
		if(len > 0) {
			for (int i = 0; i < len; i+=3) {
				MenuDTO dto = new MenuDTO();
				dto.setPost_id(post_id);
				dto.setMenu_name(menuArr[i]);
				dto.setPrice(menuArr[i+1]);
				String vt = menuArr[i+2];
				int i_vt = Integer.parseInt(vt);
				dto.setVegan_type(i_vt);
				int result = dao.menuWrite(dto);
				chk += result;
			}
		}
		logger.info("len : "+len+" / result: "+chk);
		int cnt = len/3;

		return  true;
	}


	// 서버에 파일 저장하고 DB에 인서트하는 메서드
	private boolean saveFile(int post_id, MultipartFile[] uploadImages) throws Exception {
		
		String idx = ""+post_id;
		int chk = 0;
		int len = uploadImages.length;
		
		for (MultipartFile image : uploadImages) {
			String oriFileName = image.getOriginalFilename();
			if(!oriFileName.equals("")) {

				String ext = oriFileName.substring(oriFileName.lastIndexOf("."));
				String server_file_name = System.currentTimeMillis()+ext;
				
				byte[] arr = image.getBytes();
				Path path = Paths.get(root+server_file_name);
				logger.info("arr : "+arr);
				logger.info("path : "+path);
				
				Files.write(path, arr);// 파일저장
				int result = dao.photoWrite(idx,server_file_name,"식당");// DB저장
				chk += result;
			}
		}
		return len == chk;
	}
	

	// 수정하는 과정에서 이미지를 DB와 로컬에서 삭제하는 메서드
	private boolean delFile(int post_id, Object object_imgDel) {
		String idx = ""+post_id;
		String imgDel = ""+object_imgDel;
		String[] imgDelArr = imgDel.split(",");
		int len = imgDelArr.length;
		int delImgChk = 0;
		if(len > 0 && !imgDelArr[0].equals("")) {
			for (String img : imgDelArr) {
				int delChk = dao.photoDel(idx, img);
				boolean delFileChk = false;
				File delFile = new File(root+img);
				if(delFile.exists()) {
					delFileChk = delFile.delete();
				}
				if(delFileChk && delChk == 1) {
					delImgChk ++;
				}else {
					logger.info("이미지 삭제 실패 : "+img);
				}
			}
		}
		return len == delImgChk;	
	}
	

	// param 의 값을 RestaurantDTO 에 담아주는 메서드
	private RestaurantDTO insert_RestaurantDTO(int user_no, HashMap<String, Object> param) {
		RestaurantDTO dto = new RestaurantDTO();
		dto.setUser_no(user_no);
		dto.setCategory("식당");
		dto.setTitle((String) param.get("title"));
		dto.setAddress((String) param.get("address"));
		dto.setContent((String) param.get("content"));
		dto.setPhone((String) param.get("phone"));
		dto.setHours((String) param.get("hours"));
		
		double[] latlng = addrLatLng((String)param.get("address"));
		dto.setLat(latlng[0]);
		dto.setLng(latlng[1]);
		return dto;
	}

	// 주소를 위경도로 변환
	private double[] addrLatLng(String addr) {
		double[] result = new double[2];
		String googleApiKey = "AIzaSyBxXjuUT3qQNQ6JPeOJX-X3Eo8f9RO5aEY";
		GeoApiContext context = new GeoApiContext.Builder().apiKey(googleApiKey).build();
		GeocodingResult[] results;
		try {
			results = GeocodingApi.geocode(context,addr).await();
			if(results.length > 0) {
				result[0] = results[0].geometry.location.lat; //위도
				result[1] = results[0].geometry.location.lng; //경도
			}else {
				// 주소가 검색안되면 위경도0으로 반환
				result[0] = 0;
				result[1] = 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}


	public int reviewWrite(HashMap<String, String> param) {
		return 0;
	}

	public String hidden(int post_id, int is_hidden) {
		int result = 0;
		if(is_hidden == 0) {
			result = dao.hidden(post_id);		
		}else {
			result = dao.visible(post_id);			
		}
		return result == 1 ? "완료":"실패";
	}


	public String favorite(HashMap<String, String> param) {
		String result = "";
		int user_no = Integer.parseInt(param.get("user_no"));
		int post_id = Integer.parseInt(param.get("post_id"));
		int favoriteChk = dao.favoriteChk(user_no, post_id);
		logger.info("favoriteChk : "+favoriteChk);
		if(favoriteChk == 0) {
			dao.favoriteInsert(user_no, post_id);
		}else {
			dao.favoriteDel(user_no, post_id);
		}
		result = ""+dao.favoriteChk(user_no, post_id);
		return result;
	}

	public String favoriteChk(int user_no, int post_id) {
		String result = ""+dao.favoriteChk(user_no, post_id);
		logger.info("result: "+result);
		return result;
	}


	public int restaurantList_user_totalpage() {
		return dao.restaurantList_user_totalpage();
	}
	public int restaurantList_admin_totalpage() {
		return dao.restaurantList_admin_totalpage();
	}


	

	
	
}
