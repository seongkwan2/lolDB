package com.lol.vo;

import java.util.List;
import java.util.Map;
import lombok.Data;

@Data
public class ChampDTO {
  private String type;
  private String format;
  private String version;
  private Map<String, Champion> data;

  @Data
  public static class Champion {
    private String id;
    private String key;
    private String name;
    private String title;
    private Image image;
    private List<Skin> skins;
    private String lore;
    private String blurb;
    private List<String> allytips;
    private List<String> enemytips;
    private List<String> tags;
    private String partype;
    private Info info;
    private Stats stats;
    private List<Spell> spells;
    private Passive passive;
    private List<String> recommended;


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

    @Data
    public static class Skin {
      private String id;
      private int num;
      private String name;
      private boolean chromas;
    }

    @Data
    public static class Info {
      private int attack;
      private int defense;
      private int magic;
      private int difficulty;
    }

    @Data
    public static class Stats {
      private int hp;
      private int hpperlevel;
      private int mp;
      private int mpperlevel;
      private int movespeed;
      private int armor;
      private int armorperlevel;
      private int spellblock;
      private int spellblockperlevel;
      private int attackrange;
      private int hpregen;
      private int hpregenperlevel;
      private int mpregen;
      private int mpregenperlevel;
      private int crit;
      private int critperlevel;
      private int attackdamage;
      private int attackdamageperlevel;
      private double attackspeedperlevel;
      private double attackspeed;
    }

    @Data
    public static class Spell {
      private String id;
      private String name;
      private String description;
      private String tooltip;
      private LevelTip leveltip;
      private int maxrank;
      private List<Double> cooldown;
      private String cooldownBurn;
      private List<Integer> cost;
      private String costBurn;
      private List<Object> effect;
      private List<Object> vars;
      private String costType;
      private String maxammo;
      private List<Integer> range;
      private String rangeBurn;
      private Image image;
      private String resource;


      @Data
      public static class Image {
        private String full;
      }


      @Data
      public static class LevelTip {
        private List<String> label;
        private List<String> effect;
      }
    }

    @Data
    public static class Passive {
      private String name;
      private String description;
      private Image image;

      @Data
      public static class Image {
        private String full;
      }
    }
  }
}
