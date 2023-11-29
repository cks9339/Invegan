package kr.co.invegan.board.dto;

public class MenuDTO {

	private int post_id;
	private String menu_name;
	private String price;
	private int vegan_type;
	
	public int getPost_id() {
		return post_id;
	}
	public void setPost_id(int post_id) {
		this.post_id = post_id;
	}
	public String getMenu_name() {
		return menu_name;
	}
	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public int getVegan_type() {
		return vegan_type;
	}
	public void setVegan_type(int vegan_type) {
		this.vegan_type = vegan_type;
	}

	
}
