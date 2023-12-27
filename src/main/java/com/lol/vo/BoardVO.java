package com.lol.vo;

import java.util.Date;

import lombok.Data;

@Data
public class BoardVO {

	private long b_num;
	private String b_id;
	private String b_title;
	private String b_cont;
	private Date b_date;
	private String b_category;
	private int b_hits;
	private int b_likes;
	private int replyCount;	//해당 게시판의 댓글 수
}


