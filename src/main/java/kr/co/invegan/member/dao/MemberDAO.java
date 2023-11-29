package kr.co.invegan.member.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Param;

import kr.co.invegan.member.dto.MemberDTO;

public interface MemberDAO {

	MemberDTO login(HashMap<String, Object> params);

	int signup(HashMap<String, Object> params);
	
	String findId(String email);
	
	String findPw(@Param("id") String id, @Param("email") String email);

	int idTrueFalse(String idTrueFalse);

	int validateId(String validateId);
	
}
