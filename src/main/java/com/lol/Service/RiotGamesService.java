package com.lol.Service;

import java.util.List;
import com.lol.vo.ChampDTO;
import com.lol.vo.LeagueDTO;
import com.lol.vo.MatchDTO;
import com.lol.vo.RuneStyleDTO;
import com.lol.vo.SummonerDTO;
import com.lol.vo.SummonerSpellDTO;

public interface RiotGamesService {

  //검색한 아이디의 정보를 가져오는 메서드
  SummonerDTO getUserAPI(String id);

  //전적을 보기위한 코드를 가져오는 메서드
  List<String> getMatchCode(String puuid);

  //가져온 코드로 전적을 보기위한 메서드
  MatchDTO getMatch(String matchCode);

  // 랭크 메서드
  List<LeagueDTO> getSummonerRank(String summonerId);


  // champ json 받기위한 메서드
  List<ChampDTO.Champion> getChampions();

  // 스펠 정보 가져오는 메소드
  List<SummonerSpellDTO.SummonerSpell> getSpells();

  // 룬정보 가져오는 메소드
  List<RuneStyleDTO> getRuneStyles();

}
