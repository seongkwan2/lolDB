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
    // 그 외 필요한 필드들을 추가하세요.

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