package kr.co.invegan.diet.dto;

public class MyRecipeDTO {
	
	private int material_id;
	private int menu_id;
	private String recipe_name;
	private String food_name;
	private int grams;
	private int kcal;
	private int food_id;
	private int hidden;
	
	public int getHidden() {
		return hidden;
	}
	public void setHidden(int hidden) {
		this.hidden = hidden;
	}
	public int getMaterial_id() {
		return material_id;
	}
	public void setMaterial_id(int material_id) {
		this.material_id = material_id;
	}
	public String getFood_name() {
		return food_name;
	}
	public void setFood_name(String food_name) {
		this.food_name = food_name;
	}
	public int getFood_id() {
		return food_id;
	}
	public void setFood_id(int food_id) {
		this.food_id = food_id;
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
	public int getGrams() {
		return grams;
	}
	public void setGrams(int grams) {
		this.grams = grams;
	}
	public int getKcal() {
		return kcal;
	}
	public void setKcal(int kcal) {
		this.kcal = kcal;
	}
}
