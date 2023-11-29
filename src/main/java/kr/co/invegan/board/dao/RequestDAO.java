package kr.co.invegan.board.dao;

import java.util.ArrayList;

import kr.co.invegan.board.dto.RequestDTO;

public interface RequestDAO {

	int totalPage(int pn);

	ArrayList<RequestDTO> requestdo(int pn, int offset);

}
