package kr.co.invegan.diet.dto;

public class DietDTO {
	
	private String user_no;
	
	private int diet_id;
	private String date;	
	private String diet_category;
	
	private int menu_id;
	private String recipe_name;
	private String category;
	private int grams;
	
	
	private int food_id;
	private String food_name;
	private int kcal;
	
	public int getKcal() {
		return kcal;
	}
	public void setKcal(int kcal) {
		this.kcal = kcal;
	}
	public String getFood_name() {
		return food_name;
	}
	public void setFood_name(String food_name) {
		this.food_name = food_name;
	}
	
	public String getUser_no() {
		return user_no;
	}
	public void setUser_no(String user_no) {
		this.user_no = user_no;
	}
	public int getDiet_id() {
		return diet_id;
	}
	public void setDiet_id(int diet_id) {
		this.diet_id = diet_id;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getDiet_category() {
		return diet_category;
	}
	public void setDiet_category(String diet_category) {
		this.diet_category = diet_category;
	}
	public int getMenu_id() {
		return menu_id;
	}
	public void setMenu_id(int menu_id) {
		this.menu_id = menu_id;
	}
	public String getRecipe_name() {
		return recipe_name;
	}
	public void setRecipe_name(String recipe_name) {
		this.recipe_name = recipe_name;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public int getFood_id() {
		return food_id;
	}
	public void setFood_id(int food_id) {
		this.food_id = food_id;
	}
	public int getGrams() {
		return grams;
	}
	public void setGrams(int grams) {
		this.grams = grams;
	}
	
	
	
	
}
