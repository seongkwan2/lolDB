package com.lol.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MatchDTO {
	
	private MetadataDTO metadata;
	private InfoDTO info;
	
	public MatchDTO() {}
	
}
