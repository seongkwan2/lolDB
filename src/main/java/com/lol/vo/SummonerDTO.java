package com.lol.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class SummonerDTO {
	
	private String accountId;
	private int profileIconId;
	private long revisionDate;
	private String name;
	private String id;
	private String puuid;
	private long summonerLevel;
	
	
	public SummonerDTO() {} //오류 방지용 기본생성자

}
