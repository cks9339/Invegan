package kr.co.invegan.board.service;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import org.springframework.web.multipart.MultipartFile;

import kr.co.invegan.board.dao.FeedDAO;
import kr.co.invegan.board.dto.FeedDTO;
import kr.co.invegan.board.dto.FeedListDTO;
import kr.co.invegan.board.dto.PhotoDTO;

@Service
public class FeedService {

	Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	FeedDAO dao;
	PhotoDTO photodto = new PhotoDTO();
	FeedListDTO feedlistdto = new FeedListDTO();
	private String root = "C:/upload";

	public void write(int userno, HashMap<String, String> params, MultipartFile[] uploadimages) throws Exception {

		FeedDTO dto = new FeedDTO();
		dto.setContent(params.get("content"));
		dto.setUser_no(userno);
//      dto.setTag_content(params.get("feedTag"));
		dao.feedWrite(dto);

		int feedidx = dto.getTag_id();
		int postidx = dto.getPost_id();
		dto.setTag_id(feedidx);
		dto.setPost_id(postidx);
		logger.info("feedidx:" + feedidx);
		logger.info("postidx:" + postidx);

		String[] tags = params.get("feedTag").split("[,\\s]+");
		for (String tag : tags) {
			// 개별 태그로 분할
			String[] individualTags = tag.split("#");

			for (String individualTag : individualTags) {
				// 공백 및 빈 문자열 제거
				individualTag = individualTag.trim();

				if (!individualTag.isEmpty()) {
					// '#' 문자로 시작하지 않는 경우 '#'를 추가
					if (!individualTag.startsWith("#")) {
						individualTag = "#" + individualTag;
					}

					// 데이터베이스에 태그 저장
					dto.setTag_content(individualTag);
					dao.tagWrite(dto);
					dao.feedtagWrite(dto);
				}
			}
		}

		if (postidx > 0) {
			saveFile(postidx, uploadimages);

		}

	}

	private void saveFile(int postidx, MultipartFile[] uploadimages) throws Exception {

		for (MultipartFile photo : uploadimages) {
			String oriFileName = photo.getOriginalFilename();
			logger.info("oriFileName :" + oriFileName);

			if (!oriFileName.equals("")) {
				String ext = oriFileName.substring(oriFileName.lastIndexOf("."));
				logger.info("ext:" + ext);

				String server_file_name = System.currentTimeMillis() + ext;
				logger.info("서버파일이름: " + server_file_name);

				photodto.setServer_file_name(server_file_name);

				byte[] arr = photo.getBytes();
				Path path = Paths.get(root + server_file_name);
				Files.write(path, arr);

				String server_file_name1 = photodto.getServer_file_name();
				dao.feedWritePhoto(postidx, server_file_name1);

			}

		}

	}
//   public ArrayList<FeedListDTO> list(int limitcnt) {
//      
//      logger.info("service list 접근");
//      
//      return dao.list(limitcnt);
//   }

	public ArrayList<FeedListDTO> detailList(int post_id) {
		logger.info("service detailList 접근");

		return dao.detailList(post_id);
	}

	public ArrayList<FeedListDTO> commentList(int post_id) {
		logger.info("service commentList 접근");

		return dao.commentList(post_id);
	}

	public void feedWriteComment(int user_no, HashMap<String, String> params) {
		FeedListDTO dto = new FeedListDTO();
		dto.setPost_id(params.get("post_id"));
		dto.setComment_text(params.get("comment_text"));
		dto.setUser_no(user_no);

		dao.feedWriteComment(dto);

	}

	public String findCommentUserNickName(int user_no) {

		return dao.findCommentUserNickName(user_no);
	}

	public int findBoardUserno(int post_id) {

		return dao.findBoardUserno(post_id);
	}

	public void feedDelPost(int post_id) {
		dao.feedDelComments(post_id);
		dao.feedDelPost(post_id);

	}

	public void feedUpdatePost(HashMap<String, String> params) {

		dao.feedUpdatePost(params);

	}

	public ArrayList<FeedListDTO> searchByTag(HashMap<String, String> params) {
//		String tags =feedlistdto.getTag_content();
		String searchbt = params.get("searchbt");

		logger.info("limit cnt : " + params.get("limitcnt"));
		ArrayList<FeedListDTO> searchResult = new ArrayList<FeedListDTO>();

		if (searchbt.equals("#전체리스트")) {
			logger.info("전체리스트 뿌려주기");
			searchResult = dao.list(Integer.parseInt(params.get("limitcnt")));
		} else {
			logger.info("태그선택리스트 뿌려주기");
			searchbt = "%" + params.get("searchbt") + "%";
			searchResult = dao.searchByTag(searchbt, Integer.parseInt(params.get("limitcnt")));
		}

		return searchResult;
	}

	public List<Map<String, Object>> autocomplete(Map<String, Object> paramMap) {
		logger.info("검색자동완성기능 서비스");

		return dao.autocomplete(paramMap);
	}

	public ArrayList<FeedListDTO> autoSearchTag(HashMap<String, String> params) {
		String autoText = params.get("autoText");
		logger.info("자동완성 검색버튼클릭 서비스");
		return dao.autoSearchTag(autoText, Integer.parseInt(params.get("limitcnt")));
	}

	public void feedDelComment(int commentId) {

		dao.feedDelComment(commentId);

	}

	public void feedEditComment(HashMap<String, String> params) {

		dao.feedEditComment(params);

	}

	

	public void feedImgDel(String fileName) {
		
		dao.feedImgDel(fileName);
		
	}

	public ArrayList<FeedListDTO> nameSearch(String nameText) {
		
		
		return dao.nameSearch(nameText);
		
	}

	public ArrayList<FeedListDTO> mainClickFeed(HashMap <String, Object> params) {
		return dao.mainClickFeed(params);
	}

}
