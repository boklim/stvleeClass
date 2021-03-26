package com.lbk.study.dto;

public class BoardDto {
	private String writer;
	private String title;
	private String contents;
	private String createTime; 
	private String sessionId; //세션아이디
	
	
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public String getSessionId() {
		return sessionId;
	}
	public void setSessionId(String sessionId) {
		this.sessionId = sessionId;
	}
	
	
	@Override
	public String toString() {
		return "BoardDto [writer=" + writer + ", title=" + title + ", contents=" + contents + ", createTime="
				+ createTime + ", sessionId=" + sessionId + "]";
	}
	
	
}
