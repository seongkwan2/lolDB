package com.lol.vo;

import java.util.Date;

import lombok.Data;

@Data
public class MemberVO {

	private long m_num;
	private String m_id;
	private String m_pwd;
	private String m_name;
	private String m_birth;
	private String m_email;
	private String m_phone;
	private int m_state;
	private Date m_regdate;
	private String roles;	//사용자의 권한 정보를 저장하는 리스트

}
