package kr.co.invegan.member.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import kr.co.invegan.member.dao.MemberDAO;
import kr.co.invegan.member.dto.MemberDTO;

@Service
public class MemberService {

    Logger logger = LoggerFactory.getLogger(getClass());

    @Autowired
    MemberDAO dao;

    public MemberDTO login(HashMap<String, Object> params) {
        MemberDTO dto = dao.login(params);
        return dto;
    }

    //아이디 찾기
    public String findId(HttpServletResponse response, String email) throws Exception {
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        String id = dao.findId(email);
        logger.info("id : "+id);
        if (id == null) {
            out.println("<script>");
            out.println("alert('가입된 아이디가 없습니다.');");
            out.println("history.go(-1);");
            out.println("</script>");
            out.close();
        } else {
        	logger.info("id : "+id);
            
        }
        return id;
    }

    //비밀번호 찾기
    public String findPw(HttpServletResponse response, String id, String email) throws Exception {
    	response.setContentType("text/html;charset=utf-8");
    	PrintWriter out = response.getWriter();
    	logger.info("service 접근");
    	String pw = dao.findPw(id, email);
    	logger.info("pw : "+pw);
    	 if (pw == null) {
             out.println("<script>");
             out.println("alert('아이디 또는 이메일을 수정해주세요.');");
             out.println("history.go(-1);");
             out.println("</script>");
             out.close();
         } else {
         	logger.info("pw : "+pw);
             
         }
         return pw;
    }
    
    public int signup(HashMap<String, Object> params) {
        logger.info("회원가입 요청");
        int row = dao.signup(params);
        logger.info("row : "+row);
        if(row > 0) {
        	logger.info("회원가입 성공");
        }else {
        	logger.info("회원가입 실패");
        }
        return row;
    }
    
    // 아이디 중복 확인
	public int validateId(String validateId) {
		logger.info("validateId() 실행"+ validateId);
		return dao.validateId(validateId);
	}
	
	// 회원가입시 파라미터 값 체크
	public String paramsChk(HashMap<String, Object> params) {
		logger.info("회원가입 params check : "+params );
		String pw = (String) params.get("pw");
		String pw_chk = (String) params.get("pw_chk");
		logger.info("pw : "+pw+" | "+"pw chk : "+pw_chk);
		String nickname = (String) params.get("nickname");
		String email = (String) params.get("email");
		String birthdate = (String) params.get("birthdate");
		if(!pw.equals(pw_chk)) {
			return "비밀번호가 일치 하지 않습니다.";
		}else if(pw.length()>10){
			return "비밀번호는 10자리 이내로 입력해주세요";
		}
		if(nickname.equals("")) {
			return "닉네임을 입력해주세요";
		}
		if(nickname.length() > 8) {
			return "닉네임의 길이는 최대 8자입니다."; 
		}
		String regex = "^[a-zA-Z0-9가-힣]{1,8}$";
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(nickname);
        if(!matcher.matches()) {
        	return "닉네임은 영문과 한글만 입력가능합니다."; 
        }
		if(email.equals("@")) {
			return "이메일을 입력해주세요";
		}
		if(birthdate.equals("")){
			return "태어난 날을 선택해주세요.";
		}
	
		return "complete";
	}
	

}