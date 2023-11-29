package kr.co.invegan.board.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import kr.co.invegan.board.dto.FeedDTO;
import kr.co.invegan.board.dto.FeedListDTO;

public interface FeedDAO {

	void feedWrite(FeedDTO dto);

	void tagWrite(FeedDTO dto);

	void feedtagWrite(FeedDTO dto);

	void feedWritePhoto(@Param("postidx") int postidx, @Param("server_file_name") String server_file_name);

	ArrayList<FeedListDTO> list(int limitcnt);

	ArrayList<FeedListDTO> detailList(int post_id);

	ArrayList<FeedListDTO> commentList(int post_id);

	void feedWriteComment(FeedListDTO dto);

	String findCommentUserNickName(int user_no);

	int findBoardUserno(int post_id);

	void feedDelComments(int post_id);

	void feedDelPost(int post_id);

	void feedUpdatePost(HashMap<String, String> params);

	void feedDelComment(int commentId);

	ArrayList<FeedListDTO> searchByTag(String searchbt, int limitcnt);

	ArrayList<FeedListDTO> autoSearchTag(String autoText, int parseInt);

	List<Map<String, Object>> autocomplete(Map<String, Object> paramMap);

	void feedEditComment(HashMap<String, String> params);

	void feedImgDel(String fileName);

	ArrayList<FeedListDTO> nameSearch(String nameText);

	ArrayList<FeedListDTO> mainClickFeed(HashMap<String, Object> params);



}