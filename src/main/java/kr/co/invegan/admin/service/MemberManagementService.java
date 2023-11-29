package kr.co.invegan.admin.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.invegan.admin.dao.MemberManagementDAO;
import kr.co.invegan.member.dto.MemberDTO;
import kr.co.invegan.mypage.dto.MyPageDTO;

@Service
public class MemberManagementService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	MemberManagementDAO dao;

	public HashMap<String, Object> memberList(MemberDTO loginInfo, HashMap<String, String> params) {
		int p = Integer.parseInt(params.get("page"));
		int offset = (p-1)*10;

		logger.info("offset:"+offset);
		ArrayList<MemberDTO> memberList = dao.memberList(offset);
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		if(loginInfo != null && loginInfo.getIs_admin() != 0) {
			 map.put("success",1);
		}
		int pages = dao.totalPage();
		logger.info("만들 수 있는 총 페이지 갯수 : "+pages);
		map.put("pages", pages);
		map.put("memberList", memberList);
		map.put("page", p);
		return map;
	}

	public MemberDTO userInfo(String id) {
		return dao.userInfo(id);
	}


}
