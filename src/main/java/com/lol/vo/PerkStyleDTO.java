package com.lol.vo;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PerkStyleDTO {
	
	private String description;
	private List<PerkStyleSelectionDTO> selections;
	private int style;

	public PerkStyleDTO() {}
	
}
