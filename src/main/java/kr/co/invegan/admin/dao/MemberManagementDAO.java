package kr.co.invegan.admin.dao;

import java.util.ArrayList;

import kr.co.invegan.member.dto.MemberDTO;
import kr.co.invegan.mypage.dto.MyPageDTO;

public interface MemberManagementDAO {

	ArrayList<MemberDTO> memberList(int offset);

	int totalPage();

	MemberDTO userInfo(String id);

}
