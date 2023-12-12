package com.lol.vo;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
public class PageVO {
	
	private int startrow;
	private int endrow;
    private String find_field;
    private String find_name;
}
