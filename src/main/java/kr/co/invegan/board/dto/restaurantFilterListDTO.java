package kr.co.invegan.board.dto;

public class restaurantFilterListDTO {
	private int post_id;
	private String title;
	private String vegan;
	private String server_file_name;
	private int km;
	private int is_hidden;
	
	public int getIs_hidden() {
		return is_hidden;
	}
	public void setIs_hidden(int is_hidden) {
		this.is_hidden = is_hidden;
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
	public String getVegan() {
		return vegan;
	}
	public void setVegan(String vegan) {
		this.vegan = vegan;
	}
	public String getServer_file_name() {
		return server_file_name;
	}
	public void setServer_file_name(String server_file_name) {
		this.server_file_name = server_file_name;
	}
	public int getKm() {
		return km;
	}
	public void setKm(int km) {
		this.km = km;
	}
	
}
