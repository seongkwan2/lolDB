package com.lol.vo;

import lombok.Data;

@Data
public class LeagueDTO {
  private String queueType;
  private String tier;
  private String rank;
  private int leaguePoints;
}
