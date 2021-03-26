package com.lbk.study.dto;

public class UserDto {
	
	private String id;
	private String pw;
	private String name;
	private String birth;
	
	private String authKey;
	
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getBirthday() {
		return birth;
	}
	public void setBirthday(String birth) {
		this.birth = birth;
	}
	
	
	public String getAuthKey() {
		return authKey;
	}
	public void setAuthKey(String authKey) {
		this.authKey = authKey;
	}
	
	@Override
	public String toString() {
		return "UserDto [id=" + id + ", pw=" + pw + ", name=" + name + ", birth=" + birth + ", authKey=" + authKey
				+ "]";
	}

}
