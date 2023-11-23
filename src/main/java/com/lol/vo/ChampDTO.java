package com.lol.vo;

import java.util.Map;
import lombok.Data;

@Data
public class ChampDTO {
  private Map<String, Champion> data;

  @Data
  public static class Champion {
    private String id;
    private String key;
    private String name;
    private String title;
    private Image image;
    private String blurb;

    @Data
    public static class Image {
      private String full;
      private String sprite;
      private String group;
      private int x;
      private int y;
      private int w;
      private int h;
    }
  }
}
