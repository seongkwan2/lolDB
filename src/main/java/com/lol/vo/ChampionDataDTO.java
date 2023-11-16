package com.lol.vo;

import lombok.Data;

@Data
public class ChampionDataDTO {

  private String championName;
  private String imageURL;

  public ChampionDataDTO(String championName, String imageURL) {
    this.championName = championName;
    this.imageURL = imageURL;
  }

}
