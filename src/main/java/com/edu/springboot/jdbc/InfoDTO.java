package com.edu.springboot.jdbc;

import java.util.ArrayList;

import lombok.Data;

// 메일 작성폼과 동일한 형태로 DTO 구성
@Data
public class InfoDTO {

	private String mailServer;
	private String from;
	private String to;
	private String subject;
	private String format;
	private String content;
	private String randnum;
	
	private String phoneto;
	private String smsContent;
	
	private String logId;
	private String logPass;
	
	private String saveEmail;
	
	private String findPassId;
	private String findPassNum;
	private String findPassSubject;
	
	private String searchField;
	private ArrayList<String> searchWord;
	
	
}
