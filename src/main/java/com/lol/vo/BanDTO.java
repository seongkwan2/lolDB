package com.lol.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BanDTO {
	
	private int championId;
	private int pickTurn;
	
	public BanDTO() {}

}
