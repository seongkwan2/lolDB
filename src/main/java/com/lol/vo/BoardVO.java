package com.lol.vo;

import java.util.Date;

import lombok.Data;

@Data
public class BoardVO {

	private long b_num;
	private String b_id;
	private String b_title;
	private String b_cont;
	private Date b_time;
	private String b_category;
	private int b_hits;
	private int b_likes;

}


