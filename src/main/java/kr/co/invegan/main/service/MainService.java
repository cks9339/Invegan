package kr.co.invegan.main.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.invegan.board.dto.FeedDTO;
import kr.co.invegan.board.dto.FeedListDTO;
import kr.co.invegan.board.dto.restaurantFilterListDTO;
import kr.co.invegan.main.dao.MainDAO;
import kr.co.invegan.main.dto.distCntDTO;
import kr.co.invegan.member.dto.MemberDTO;

@Service
public class MainService {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired MainDAO dao;

	public ArrayList<restaurantFilterListDTO> restaurantFilterList(HttpSession session, double userLat, double userLng) {
		
		ArrayList<restaurantFilterListDTO> resList = null;
		String vegan_type;
		List<String> vt = null;
		distCntDTO distCnt = null;
		int dist = 0;
		
		MemberDTO loginInfo = (MemberDTO) session.getAttribute("loginInfo");
		// 로그인 여부 
		if(loginInfo != null) {
			// 회원 맞춤 정보 제공
			vegan_type = ""+dao.veganType(loginInfo.getUser_no());
			vt = Arrays.asList(vegan_type); //회원의 비건단계를 리스트에 담아서 이용
			
			distCnt = dao.rangeCnt(vt, userLat, userLng);
			logger.info("15km 이내 조건에 맞는 식당 수 : "+distCnt.getCount15());
			if(distCnt.getCount15() < 20) {
				// 비건단계 확대
				vt = null;
				if(vegan_type.equals("1")) vt = Arrays.asList("1");
				if(vegan_type.equals("2")) vt = Arrays.asList("1","2");
				if(vegan_type.equals("3")) vt = Arrays.asList("1","2","3");
				if(vegan_type.equals("4")) vt = Arrays.asList("1","2","4");
				if(vegan_type.equals("5")) vt = Arrays.asList("1","2","3","4","5");
				if(vegan_type.equals("6")) vt = Arrays.asList("1","2","3","4","5","6");
				if(vegan_type.equals("7")) vt = Arrays.asList("1","2","3","4","5","7");
				if(vegan_type.equals("8")) vt = Arrays.asList("1","2","3","4","5","6","7","8");
				if(vegan_type.equals("9")) vt = Arrays.asList("1","2","3","4","5","6","7","8","9");
				logger.info("식당 수 부족, 비건 단계 확대 / vt: "+vt);
			}else {
				dist = 15;
			}
			
		}else {
			logger.info("비로그인");
			vt = Arrays.asList("1","2","3","4","5","6","7","8","9");
		}
		
		
		if(dist == 0) {
			distCnt = dao.rangeCnt(vt, userLat, userLng);
			logger.info("15km 이내 조건에 맞는 식당 수 : "+distCnt.getCount15());
			if(distCnt.getCount15() < 20) {
				dist = 500;
			}else {
				dist = 15;
			}
		}
		
		logger.info("vt :"+vt+" / dist: "+dist);
		resList = dao.restaurantFilterList(vt, userLat, userLng, dist);

		int cnt = 12; // view에 뿌려줄 숫자
		
		Collections.shuffle(resList); // 순서 섞기
		
		restaurantFilterListDTO nullList = null;
		while(resList.size() < cnt) {
			resList.add(nullList);	
		}
		
		ArrayList<restaurantFilterListDTO> result = new ArrayList<restaurantFilterListDTO>();
		for (int i = 0; i < cnt; i++) {
			result.add(resList.get(i));
		}
		return result;

	}

	public ArrayList<FeedListDTO> feedFilterList(HttpSession session) {
		MemberDTO loginInfo = (MemberDTO) session.getAttribute("loginInfo");
		ArrayList<FeedListDTO> feedList = null;
		if(loginInfo != null) {
			// 로그인 상태
			String interests = dao.interests(loginInfo.getUser_no());
			List<String> inteList = new ArrayList<String>();
			logger.info("interests: "+interests);
			String[] inteArr = interests.split(",");
			for (String inte : inteArr) {
				inteList.add('%'+inte+'%');
			}
			System.out.println(inteList);
			feedList = dao.feedInterestFilterList(inteList);
		}else {
			// 비로그인 상태
			logger.info("비로그인");
			feedList = dao.feedFilterList();
		}
		int cnt = 12; // view에 뿌려줄 숫자
		Collections.shuffle(feedList);
		
		FeedListDTO nullList = null;
		//logger.info("resList.size: "+feedList.size());
		while(feedList.size() < cnt) {
			feedList.add(nullList);	
		}
		
		ArrayList<FeedListDTO> result = new ArrayList<FeedListDTO>();
		for(int i = 0; i < cnt; i++) {
			result.add(feedList.get(i));
		}
		return result;
	}
    
    
}
