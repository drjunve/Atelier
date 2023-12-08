package com.edu.springboot.jdbc;

import lombok.Data;

@Data
public class MemberDTO {
	private String id;
	private String pass;
	private String m_name;
	private String phone;
	private String zip;
	private String addr1;
	private String addr2;
	private int midx;
	private String regidate;
	private String leavedate;
	//private String profileo;
	private String profiles;
	//private String placeo;
	private String places;
	private int total_point;
	private int artist;
}
