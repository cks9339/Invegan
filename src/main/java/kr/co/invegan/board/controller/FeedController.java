package kr.co.invegan.board.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.invegan.board.dto.FeedListDTO;
import kr.co.invegan.board.service.FeedService;
import kr.co.invegan.member.dto.MemberDTO;

@Controller
@RequestMapping("/feed")
public class FeedController {
	@Autowired
	FeedService service;
	org.slf4j.Logger logger = LoggerFactory.getLogger(getClass());
	MemberDTO memberdto = new MemberDTO();

	@RequestMapping(value = "write.go") // feedWrite 페이지에 대한 URL 매핑을 추가
	public String feedWrite(Model model) {
		logger.info("feedWrite 접근");
		// 필요한 모델 데이터를 추가

		return "feed/feedWrite"; // feedWrite.jsp로 이동
	}

	@RequestMapping(value ="write")
	@ResponseBody
	public String write(HttpSession session, Model model, @RequestParam HashMap<String, String> params,
			@RequestParam("photos") MultipartFile[] uploadimages) throws Exception {
		logger.info("내용:" + params.get("content"));
		logger.info("태그:" + params.get("feedTag"));
		logger.info("이미지:" + uploadimages);
		memberdto = (MemberDTO) session.getAttribute("loginInfo");

		int user_no = memberdto.getUser_no();
		session.setAttribute("user_no", user_no);

		// 나머지 로직
		logger.info("loginInfo:" + memberdto);
		if (memberdto != null) {
			service.write(user_no, params, uploadimages);
		}

		return "success";
	}

	@RequestMapping(value = "list.go")
	public String list() {
		logger.info("controller list 접근");
		return "feed/feedList";
	}
	
	// 메인에서 리스트로 넘어갈때
	@RequestMapping(value = "list.go/{param}")
	public String listForNickname(RedirectAttributes reAttr, @PathVariable String param) {
		logger.info("메인페이지에서 피드게시판으로");
		String[] Array = StringUtils.split(param, ",");
		logger.info("Array[0] : "+Array[0]);
		logger.info("Array[1] : "+Array[1]);
		
		reAttr.addFlashAttribute("getNickname", Array[0]);
		reAttr.addFlashAttribute("getPost_id", Array[1]);
		return "redirect:/feed/list.go";
	}

	// 전체 리스트불러오기와 Tag를 선택했을떄 리스트불러오기
	@RequestMapping(value = "searchByTag")
	@ResponseBody
	public HashMap<String, Object> searchByTag(HttpSession session, @RequestParam HashMap<String, String> params) {
		logger.info("SearByTag 컨트롤러 접근");
		HashMap<String, Object> result = new HashMap<String, Object>();
		logger.info("Searching by tag: " + params);
		logger.info("searcbt :" + params.get("searchbt"));
		logger.info("limintCnt :" + params.get("limitcnt"));

		ArrayList<FeedListDTO> searchResult = new ArrayList<FeedListDTO>();
		logger.info("search:" + searchResult);
		searchResult = service.searchByTag(params);
		logger.info("search:" + searchResult);
		result.put("loginInfo", session.getAttribute("loginInfo"));
		result.put("list", searchResult);
		result.put("listSize", searchResult.size());
		result.put("limitcnt", params.get("limitcnt"));
		return result;
	}

	@RequestMapping(value = "autoSearchTag")
	@ResponseBody
	public HashMap<String, Object> autoSearchTag(HttpSession session, @RequestParam HashMap<String, String> params) {
		HashMap<String, Object> result = new HashMap<String, Object>();
		logger.info("자동완성 검색버튼클릭 컨트롤러");
		logger.info("autoText :" + params.get("autoText"));
		logger.info("limitcnt :" + params.get("limitcnt"));
		ArrayList<FeedListDTO> searchResult = service.autoSearchTag(params);
		result.put("loginInfo", session.getAttribute("loginInfo"));
		result.put("list", searchResult);
		result.put("listSize", searchResult.size());
		result.put("limitcnt", params.get("limitcnt"));
		return result;
	}

	@RequestMapping(value = "detail.go")
	public String detail() {
		logger.info("controller detail list 접근");

		return "feed/feedDetail";
	}

	@RequestMapping(value = {"feedDetailCall", "feed/feedDetailCall"})
	@ResponseBody
	public HashMap<String, Object> feedDetailCall(HttpSession session, @RequestParam("post_id") int post_id) {

		int user_no = 0;
		int is_admin = 0;
		logger.info("상세보기 접근");
		logger.info("post id:" + post_id);
		memberdto = (MemberDTO) session.getAttribute("loginInfo");

		if (memberdto != null) {
			user_no = memberdto.getUser_no();
			is_admin = memberdto.getIs_admin();
			session.setAttribute("user_no", user_no);
			session.setAttribute("is_admin", is_admin);
		}
		logger.info("로그인 user_no :" + user_no);
		logger.info("memberdto :" + memberdto);

		session.setAttribute("user_no", user_no);
		logger.info("memberdto :" + memberdto);
		logger.info("로그인 user_no :" + user_no);

		HashMap<String, Object> result = new HashMap<String, Object>();
		ArrayList<FeedListDTO> detailList = service.detailList(post_id);
		ArrayList<FeedListDTO> commentList = service.commentList(post_id);
		int findBoardUserno = service.findBoardUserno(post_id);
//      ArrayList<FeedListDTO> comment_text = service.comment_text(post_id);
//      ArrayList<FeedListDTO> commentWrite = service.feedComment(feedComment ,session); 
//      String user_no = (String) session.getAttribute("user_no"); 
//      logger.info("현재세션:"+user_no);
//      String is_admin = (String) session.getAttribute("is_admin");
//      logger.info("현재관리자여부:"+ is_admin);
		logger.info("게시물 로그인 세션 :" + findBoardUserno);
		result.put("loginInfo", session.getAttribute("loginInfo"));
		result.put("detailList", detailList);
		result.put("commentList", commentList);
		result.put("findBoardUserno", findBoardUserno);
		result.put("user_no", user_no);
		result.put("is_admin", is_admin);

		return result;
	}

	@RequestMapping(value = "feedWriteComment")
	@ResponseBody
	public HashMap<String, Object> feedWriteComment(HttpSession session, @RequestParam HashMap<String, String> params) {
		HashMap<String, Object> result = new HashMap<String, Object>();
		logger.info("feedWriteComment 컨트롤러 접근");

		// user_no 로그인 로직설정

		int user_no = 0;

		memberdto = (MemberDTO) session.getAttribute("loginInfo");
		if (memberdto != null) {
			user_no = memberdto.getUser_no();
			session.setAttribute("user_no", user_no);
			service.feedWriteComment(user_no, params);

		}
		int post_id = Integer.parseInt(params.get("post_id"));
		ArrayList<FeedListDTO> commentList = service.commentList(post_id);

		logger.info("params :" + params);
		logger.info("user_no:" + user_no);

		String comment_user_nickname = service.findCommentUserNickName(user_no);

		result.put("user_no", user_no);
		result.put("comment_text", params.get("comment_text"));
		result.put("post_id", params.get("post_id"));
		result.put("comment_user_nickname", comment_user_nickname);
		result.put("loginInfo", session.getAttribute("loginInfo"));
		result.put("commentList", commentList);

		return result;
	}
	
	@RequestMapping(value = "feedImgDel/delete")
	@ResponseBody
	public String feedImgDel(@RequestParam String fileName) {
		logger.info("삭제 > 이미지삭제 컨트롤러 접근");
		logger.info("filename:"+fileName);

		service.feedImgDel(fileName);

		return "success";
	}

	@RequestMapping(value = "feedDelPost/delete")
	@ResponseBody
	public String feedDelPost(Model model, HttpSession session, @RequestParam int post_id) {

		service.feedDelPost(post_id);
		return "success";
	}

	@RequestMapping(value = "update.go")
	public String update() {
		logger.info("controller detail update 접근");

		return "feed/feedUpdate";
	}

	@RequestMapping(value = "feed/autocomplete.do")
	@ResponseBody
	public Map<String, Object> autocomplete(@RequestParam Map<String, Object> paramMap) throws Exception {
		logger.info("검색자동완성기능 컨트롤러");
		logger.info("paramMap :" + paramMap);
		List<Map<String, Object>> resultList = service.autocomplete(paramMap);
		logger.info("paramMap :" + paramMap);
		paramMap.put("resultList", resultList);

		return paramMap;
	}

	@RequestMapping(value = "feedDelComment/delete")
	@ResponseBody
	public String feedDelComment(@RequestParam("commentId") int commentId) {
		logger.info("상세 > 댓글삭제 컨트롤러 접근");
		logger.info("댓글삭제 번호 :" + commentId);

		service.feedDelComment(commentId);

		return "success";
	}

	@RequestMapping(value = "feedUpdatePost/update", method = RequestMethod.POST)
	@ResponseBody
	public String feedUpdatePost(Model model, HttpSession session, @RequestParam HashMap<String, String> params) {
//	   FeedDTO dto = new FeedDTO();
//	   dto.setContent(feed_content);
		logger.info("feed_content:" + params.get("feed_content"));
		logger.info("post_id:" + params.get("post_id"));
		service.feedUpdatePost(params);
		return "success";
	}

	@RequestMapping(value = "feedEditComment/update")
	@ResponseBody
	public String feedEditComment(@RequestParam HashMap<String, String> params) {
		logger.info("상세 > 댓글수정 컨트롤러 접근");
		logger.info("댓글수정 번호 :" + params.get("commentId"));
		logger.info("댓글 수정 내용 :" + params.get("commentTxt"));

		service.feedEditComment(params);

		return "success";
	}
	
	@RequestMapping(value = "feed/nameSearch")
	@ResponseBody
	public HashMap<String, Object> nameSearch(@RequestParam String nameText) {
		HashMap<String, Object> result = new HashMap<String, Object>();
		logger.info("닉네임 검색 컨트롤러");
		logger.info("nameText :" + nameText);
		ArrayList<FeedListDTO> nameSearchList = service.nameSearch(nameText);
		
		result.put("list", nameSearchList);
		return result;
	}
	
	@RequestMapping(value = "feed/mainClickFeed.do")
	@ResponseBody
	public HashMap<String, Object> mainClickFeed(@RequestParam HashMap <String, Object> params) {
		HashMap<String, Object> result = new HashMap<String, Object>();
		logger.info("params :" + params);
		ArrayList<FeedListDTO> mainClickFeed = service.mainClickFeed(params);
		
		result.put("list", mainClickFeed);
		return result;
	}

}