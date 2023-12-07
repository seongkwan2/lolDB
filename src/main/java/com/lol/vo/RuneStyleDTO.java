package com.lol.vo;

import java.util.List;
import lombok.Data;

@Data
public class RuneStyleDTO {
  private int id;
  private String key;
  private String icon;
  private String name;
  private List<RuneSlotDTO> slots;


  @Data
  public static class RuneSlotDTO {
    private List<RuneDTO> runes;


    @Data
    public static class RuneDTO {
      private int id;
      private String key;
      private String icon;
      private String name;
      private String shortDesc;
      private String longDesc;

    }
  }
}
