package kr.co.invegan.diet.dto;

public class GetMonthKcalDTO {
	
	private String date;
	private int total_Kcal;
	private int stdKcal;
	
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public int getTotal_Kcal() {
		return total_Kcal;
	}
	public void setTotal_Kcal(int total_Kcal) {
		this.total_Kcal = total_Kcal;
	}
	public int getStdKcal() {
		return stdKcal;
	}
	public void cal(int stdKcal) {
		this.stdKcal = stdKcal;
	}
	
	

}
