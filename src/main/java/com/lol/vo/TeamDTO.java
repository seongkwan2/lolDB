package com.lol.vo;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class TeamDTO {
	
	private List<BanDTO> bans;
	private ObjectivesDTO objectives;
	private int teamId;
	private boolean win;
	
	public TeamDTO() {}
	
}
