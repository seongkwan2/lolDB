package com.lol.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class MiniSeriesDTO {
	
	private int losses;
	private String progress;
	private int target;
	private int wins;
	
	public MiniSeriesDTO() {} //오류 방지를 위한 기본생성자
}
