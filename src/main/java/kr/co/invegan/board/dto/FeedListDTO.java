package kr.co.invegan.board.dto;

import java.sql.Date;

public class FeedListDTO {
	
	
	private String nickname;
	private String profile_image;
	private int user_no;
	private String tag_content;
	private String content;
	private String comment_text;
	private String comment_user_nickname;
	private Date date;
	private int image_id;
	private String post_id;
	private String server_file_name;
	private int comment_id;
	
	public int getComment_id() {
		return comment_id;
	}
	public void setComment_id(int comment_id) {
		this.comment_id = comment_id;
	}
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	public String getProfile_image() {
		return profile_image;
	}
	public void setProfile_image(String profile_image) {
		this.profile_image = profile_image;
	}
	public String getComment_user_nickname() {
		return comment_user_nickname;
	}
	public String getServer_file_name() {
		return server_file_name;
	}
	public void setServer_file_name(String server_file_name) {
		this.server_file_name = server_file_name;
	}
	public void setComment_user_nickname(String comment_user_nickname) {
		this.comment_user_nickname = comment_user_nickname;
	}
	public int getImage_id() {
		return image_id;
	}
	public void setImage_id(int image_id) {
		this.image_id = image_id;
	}
	public String getPost_id() {
		return post_id;
	}
	public void setPost_id(String string) {
		this.post_id = string;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getTag_content() {
		return tag_content;
	}
	public void setTag_content(String tag_content) {
		this.tag_content = tag_content;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getComment_text() {
		return comment_text;
	}
	public void setComment_text(String comment_text) {
		this.comment_text = comment_text;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	
	

	
	
}
