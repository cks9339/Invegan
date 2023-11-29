package kr.co.invegan.mypage.dto;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

public class MyPageDTO {

	private int user_no;
	private Date join_date;
	private String id;
	private String pw;
	private Date birthdate;
	private String gender;
	private String nickname;
	private int vegan_type;
	private String vegan_purpose;
	private String interests;
	private int is_admin;
	private int is_suspended;
	private String req_title;
	private int views;
	private String title;
	private String server_file_name;
	private String content;
	private int idx;
	private int image_id;
	private String category;
	private String profile_image;
	private int rating;
	private int post_id;

	
	public int getPost_id() {
		return post_id;
	}
	public void setPost_id(int post_id) {
		this.post_id = post_id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
	public String getProfile_image() {
		return profile_image;
	}
	public void setProfile_image(String profile_image) {
		this.profile_image = profile_image;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public int getImage_id() {
		return image_id;
	}
	public void setImage_id(int image_id) {
		this.image_id = image_id;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getServer_file_name() {
		return server_file_name;
	}
	public void setServer_file_name(String server_file_name) {
		this.server_file_name = server_file_name;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getReq_title() {
		return req_title;
	}
	public void setReq_title(String req_title) {
		this.req_title = req_title;
	}
	public int getViews() {
		return views;
	}
	public void setViews(int views) {
		this.views = views;
	}
	private String perm;
	
	
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	public Date getJoin_date() {
		return join_date;
	}
	public void setJoin_date(Date join_date) {
		this.join_date = join_date;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Date getBirthdate() {
		return birthdate;
	}
	public void setBirthdate(Date birthdate) {
		this.birthdate = birthdate;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public int getVegan_type() {
		return vegan_type;
	}
	public void setVegan_type(int vegan_type) {
		this.vegan_type = vegan_type;
	}
	public String getVegan_purpose() {
		return vegan_purpose;
	}
	public void setVegan_purpose(String vegan_purpose) {
		this.vegan_purpose = vegan_purpose;
	}
	public String getInterests() {
		return interests;
	}
	public void setInterests(String interests) {
		this.interests = interests;
	}
	public int getIs_admin() {
		return is_admin;
	}
	public void setIs_admin(int is_admin) {
		this.is_admin = is_admin;
	}
	public int getIs_suspended() {
		return is_suspended;
	}
	public void setIs_suspended(int is_suspended) {
		this.is_suspended = is_suspended;
	}
	public String getPerm() {
		return perm;
	}
	public void setPerm(String perm) {
		this.perm = perm;
	}
	
	
	
}
