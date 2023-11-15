package com.lol.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ObjectivesDTO {
	
	private ObjectiveDTO baron;
	private ObjectiveDTO champion;
	private ObjectiveDTO dragon;
	private ObjectiveDTO inhibitor;
	private ObjectiveDTO riftHerald;
	private ObjectiveDTO tower;
	
	public ObjectivesDTO() {}

}
