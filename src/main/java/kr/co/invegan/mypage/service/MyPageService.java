package kr.co.invegan.mypage.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.co.invegan.member.dto.MemberDTO;
import kr.co.invegan.mypage.dao.MyPageDAO;
import kr.co.invegan.mypage.dto.MyPageDTO;

@Service
public class MyPageService {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	MyPageDAO dao;

	private String root = "C:/upload";

	public MyPageDTO userInfo(int user_no) {

		return dao.userInfo(user_no);
	}

	public boolean overlay(String nickname) {
		boolean use = false;
		int cnt = dao.overlay(nickname);
		if (cnt == 0) {
			use = true;
		}
		return use;
	}

	/*
	 * public HashMap<String, Object> requestBoardList(int user_no, String page) {
	 * 
	 * int p = Integer.parseInt(page); int offset = (p - 1) * 5; logger.info("p:" +
	 * p + "offset:" + offset); ArrayList<MyPageDTO> rqList =
	 * dao.requestBoardList(user_no,offset);
	 * 
	 * HashMap<String, Object> map = new HashMap<String, Object>();
	 * 
	 * int pages = dao.rqTotalPage(); logger.info("만들 수 있는 총 페이지 갯수 : " + pages);
	 * map.put("pages", pages); // 만들 페이지 수 map.put("rqList", rqList);
	 * map.put("page", p);
	 * 
	 * return map; }
	 */
	
	
	 public ArrayList<MyPageDTO> recipeBoardList(int user_no) {
		 return dao.recipeBoardList(user_no); 
	 }
	 

	
	 public ArrayList<MyPageDTO> freeBoardList(int user_no) { 
		 return dao.freeBoardList(user_no); 
	 }
	 

	
	 public ArrayList<MyPageDTO> feedList(Integer user_no) { 
		 return dao.feedList(user_no);
	 }
	 

	public void delUser(int user_no) {
		dao.delUser(user_no);
	}
	 
	 public ArrayList<MyPageDTO> recipeFavorite(int user_no) {
	 return dao.recipeFavorite(user_no); 
	 }
	 
	 public ArrayList<MyPageDTO> freeComments(int user_no) { 
		 return dao.freeComments(user_no); 
	 }
	 
	 public ArrayList<MyPageDTO> feedComments(int user_no) { 
		 return dao.feedComments(user_no); 
	 }
	 
	 public ArrayList<MyPageDTO> restaurantComments(Integer user_no) { 
		 return dao.restaurantComments(user_no); 
	 }
	 
	 public ArrayList<MyPageDTO> restaurantFavorite(Integer user_no) { 
		 return dao.restaurantFavorite(user_no); 
	 }
	 

	public int updateNickname(String nickname, Integer user_no) {
		return dao.updateNickname(nickname, user_no);
	}

	public String pwConfirm(String pw, Integer user_no) {
		return dao.pwConfirm(pw, user_no);
	}

	public int completePw(Map<String, Object> params) {
		return dao.completePw(params);
	}

	public int save(Map<String, Object> params) {
		return dao.save(params);
	}

	
	MyPageDTO dto = new MyPageDTO(); 
	
	 public String imgUpload(HttpSession session, MultipartFile photo, Integer user_no) throws IOException {
	  
		 dto.setIdx(user_no);
		 dto.setCategory("회원");
		 
		 dao.uploadProfile(dto);
	
	 int image_id = dto.getImage_id(); // dto 에 방금 insert 된 image_id 가져오기
	 logger.info("image_id:"+image_id);
	 saveImage(session,photo,image_id,user_no);
	 
	 return "imgUpload성공";
	 
	 
	 }
	 
		
	  // 프로필 이미지 imageTable에 저장 
	  private void saveImage(HttpSession session, MultipartFile photo, int image_id, Integer user_no)
	  throws IOException {
	  
	  String oriFileName = photo.getOriginalFilename(); 
	  logger.info(oriFileName);
	  
	  if(!oriFileName.equals("")) { 
		  String ext = oriFileName.substring(oriFileName.lastIndexOf(".")); 
		  String server_file_name = System.currentTimeMillis()+ext; 
		  logger.info(server_file_name);
	  byte[] arr = photo.getBytes(); 
	  Path path = Paths.get(root+server_file_name);
	  Files.write(path, arr); 
	  logger.info("path:"+path); 
	  
	  MemberDTO loginInfo = (MemberDTO) session.getAttribute("loginInfo"); 
	  session.setAttribute("loginInfo", loginInfo);
	  loginInfo.setProfile_img(server_file_name);
	  
	  dao.saveProfileImg(image_id,server_file_name,user_no);
	  } 
	 }

	 // 프로필 이미지 수정 
	 public void imgModify(HttpSession session, MultipartFile photo, Integer user_no) throws IOException {
		 
		 String oriFileName = photo.getOriginalFilename(); 
		  logger.info(oriFileName);
		  
		  if(!oriFileName.equals("")) { 
			  String ext = oriFileName.substring(oriFileName.lastIndexOf(".")); 
			  String server_file_name = System.currentTimeMillis()+ext; 
			  logger.info(server_file_name);
		  byte[] arr = photo.getBytes(); 
		  Path path = Paths.get(root+server_file_name);
		  Files.write(path, arr); 
		  logger.info("path:"+path); 
		  
		 MemberDTO loginInfo = (MemberDTO) session.getAttribute("loginInfo"); 
	     session.setAttribute("loginInfo", loginInfo);
	     loginInfo.setProfile_img(server_file_name);
	        
		 dao.imgModify(server_file_name,user_no);

			 
	 }
	}

	public ArrayList<MyPageDTO> requestBoardList(Integer user_no) {
		return dao.requestBoardList(user_no);
	}

	public ArrayList<MyPageDTO> recipeComments(Integer user_no) {
		return dao.recipeComments(user_no);
	}


	
		 
		 
	  
/*
 * public HashMap<String, Object> list(String pagePerNum, String page) { int ppn
 * = Integer.parseInt(pagePerNum); int p = Integer.parseInt(page);
 * 
 * int offset = (p-1)*ppn; ArrayList<MyPageDTO> list = dao.list(ppn,offset);
 * 
 * HashMap<String, Object> map = new HashMap<String, Object>();
 * 
 * int pages = dao.totalPage(ppn); logger.info("만들 수 있는 총 페이지 갯수 : "+pages);
 * map.put("pages",pages); // 만들 페이지 수 map.put("list", list);
 * 
 * return map; }
 */
	 

}
