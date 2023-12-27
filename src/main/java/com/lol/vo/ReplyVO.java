package com.lol.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyVO {

	private long r_num;
	private String r_id;
	private String r_cont;
	private Date r_date;
	private long r_board_num;
	
}
