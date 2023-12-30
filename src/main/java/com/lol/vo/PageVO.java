package com.lol.vo;

import lombok.Data;

@Data
public class PageVO {
	
	private int startrow;	//시작 행
	private int endrow;		//끝 행
	private int limit;    	// 페이지 당 표시할 게시글 수

}
