package kr.co.invegan.board.dto;



public class FeedDTO {
	
	private int post_id;
	private String title;
	private String content;

	private int views;
	private int is_hidden;
	private String category;
	private String feed_content;
	private int user_no;
	private int tag_id;
	private String tag_content;
	

	

	
	public String getFeed_content() {
		return feed_content;
	}
	public void setFeed_content(String feed_content) {
		this.feed_content = feed_content;
	}
	public int getPost_id() {
		return post_id;
	}
	public void setPost_id(int post_id) {
		this.post_id = post_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getViews() {
		return views;
	}
	public void setViews(int views) {
		this.views = views;
	}
	public int getIs_hidden() {
		return is_hidden;
	}
	public void setIs_hidden(int is_hidden) {
		this.is_hidden = is_hidden;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int userno) {
		this.user_no = userno;
	}
	public int getTag_id() {
		return tag_id;
	}
	public void setTag_id(int tag_id) {
		this.tag_id = tag_id;
	}
	public String getTag_content() {
		return tag_content;
	}
	public void setTag_content(String tag_content) {
		this.tag_content = tag_content;
	}


	
	
}
