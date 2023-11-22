package com.lol.vo;

import java.util.List;
import java.util.Map;
import lombok.Data;

@Data
public class SummonerSpellDTO {
  private String type;
  private String version;
  private Map<String, SummonerSpell> data;

  // Getters and Setters
  @Data
  public static class SummonerSpell {
    private String id;
    private String name;
    private String description;
    private String tooltip;
    private int maxrank;
    private List<Integer> cooldown;
    private String cooldownBurn;
    private List<Integer> cost;
    private String costBurn;
    private Map<String, Object> datavalues;
    private List<Object> effect;
    private List<Object> effectBurn;
    private List<Var> vars;
    private String key;
    private int summonerLevel;
    private List<String> modes;
    private String costType;
    private String maxammo;
    private List<Integer> range;
    private String rangeBurn;
    private Image image;
    private String resource;


    @Data
    public static class Var {
      private String link;
      private double coeff;
      private String key;


    }
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
