package kr.co.invegan.board.dto;

import java.sql.Date;

public class PhotoDTO {
	
	private int image_id;
	private int idx;
	private String server_file_name;
	private Date file_creation_date;
	private String category;
	
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
	public String getServer_file_name() {
		return server_file_name;
	}
	public void setServer_file_name(String server_file_name) {
		this.server_file_name = server_file_name;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public Date getFile_creation_date() {
		return file_creation_date;
	}
	public void setFile_creation_date(Date file_creation_date) {
		this.file_creation_date = file_creation_date;
	}
}
