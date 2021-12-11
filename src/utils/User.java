package utils;

import java.util.Date;

public class User {
	private int id;
	private String username;
	private String password;
	private String gender;
	private String email;
	private String telephone;
	private String introduce;
	private String activeCode;
	private int state;
	private Date registTime;
	private String shopId=null;

	public String getShopId() {
		return shopId;
	}

	public void setShopId(String shopId) {
		this.shopId = shopId;
	}

	public void setRegistTime(Date registTime) {
		this.registTime = registTime;
	}

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id=id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String usernameString) {
		this.username=usernameString;
	}
	public String  getPassword() {
		return password;
	}
	public void setPassword(String passwordString) {
		this.password=passwordString;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String genderString) {
		this.gender=genderString;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String emailString) {
		this.email=emailString;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String teleString) {
		this.telephone=teleString;
	}
	public String getIntroduce() {
		return introduce;
	}
	public void setIntroduce(String introduceString) {
		this.introduce=introduceString;
	}
	public String getActiveCode() {
		return activeCode;
	}
	public void setActiveCode(String activeString) {
		this.activeCode=activeString;
	}
	public int getState() {
		return state;
	}
	public void setState(int state ) {
		this.state=state;
	}
	public Date getRegistTime() {
		return registTime;
	}
	public void set(Date reDate ) {
		this.registTime=reDate;
	}

}
