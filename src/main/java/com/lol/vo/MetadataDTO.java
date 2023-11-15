package com.lol.vo;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MetadataDTO {
	
    private String dataVersion;
    private String matchId;
    private List<String> participants;
    
    public MetadataDTO() {}

}
