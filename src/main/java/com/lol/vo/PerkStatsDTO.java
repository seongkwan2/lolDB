package com.lol.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PerkStatsDTO {
	
	private int defense;
	private int flex;
	private int offense;

	public PerkStatsDTO() {}
}
