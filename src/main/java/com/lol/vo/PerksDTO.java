package com.lol.vo;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PerksDTO {
	
	private PerkStatsDTO statPerks;
	private List<PerkStyleDTO> styles;
	
	public PerksDTO() {}

}
