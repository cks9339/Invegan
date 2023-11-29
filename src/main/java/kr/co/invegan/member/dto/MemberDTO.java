package kr.co.invegan.member.dto;

import java.sql.Date;
import java.sql.Timestamp;

import javax.servlet.http.HttpSession;

public class MemberDTO {

	private int user_no;
	private String id;
	private String pw;
	private String email;
	private String nickname;
	private Date birthdate;
	private String gender;
	private int vegan_type;
	private String vegan_purpose;
	private String interests;
	private int is_admin;
	private int is_suspended;
	private String profile_image;
	private String server_file_name;
	
	public String getProfile_image() {
		return profile_image;
	}
	public void setProfile_image(String profile_image) {
		this.profile_image = profile_image;
	}
	public String getServer_file_name() {
		return server_file_name;
	}
	public void setServer_file_name(String server_file_name) {
		this.server_file_name = server_file_name;
	}
	public void setSession(HttpSession session) {
		this.session = session;
	}

	private String profile_img;
	private HttpSession session;
	
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	
	public String getProfile_img() {
		return profile_img;
	}
	public void setProfile_img(String profile_img) {
		this.profile_img = profile_img;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
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
	public HttpSession getSession() {
       
        return session;
    }
	
}
