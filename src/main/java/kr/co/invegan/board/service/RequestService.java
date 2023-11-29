package kr.co.invegan.board.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.invegan.board.dao.RequestDAO;
import kr.co.invegan.board.dto.RequestDTO;

@Service
public class RequestService {
	
	@Autowired RequestDAO dao;
	
	Logger logger = LoggerFactory.getLogger(getClass());

	public Map<String, Object> requestdo(String pagePerNum, String page, int admin) {
		
		int pn = Integer.parseInt(pagePerNum);
		logger.info("보여줄 게시글 수 : "+pn);
		int p = Integer.parseInt(page);
		
		int offset = (p-1) * pn;	
		
		ArrayList<RequestDTO> list = dao.requestdo(pn, offset);
		Map<String, Object> map = new HashMap<String, Object>();
		
		// 만들 수 있는 총 페이지 수
		int pages = dao.totalPage(pn);
		logger.info("만들 수 있는 총 페이지 갯수 : "+pages);
		
		// 만약 현재 보고있는 페이지가, 총 페이지 수 보다 크면 현재 페이지를 총 페이지수로 변경한다.
		if (p > pages) {
			p = pages;
		}
		
		map.put("currPage", p);
		map.put("pages", pages);
		map.put("list", list);
		map.put("admin", admin);
		
		return map;
	}

}
