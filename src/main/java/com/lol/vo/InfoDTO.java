package com.lol.vo;

import java.util.List;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class InfoDTO {

  private long gameCreation;
  private long gameDuration;
  private long gameEndTimestamp;
  private long gameId;
  private String gameMode;
  private String gameName;
  private long gameStartTimestamp;
  private String gameType;
  private String gameVersion;
  private int mapId;
  private List<ParticipantDTO> participants;
  private String platformId;
  private int queueId;
  private List<TeamDTO> teams;


  public InfoDTO() {}

}
