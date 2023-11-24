package com.lol.Service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import com.lol.vo.ChampDTO;
import com.lol.vo.LeagueDTO;
import com.lol.vo.MatchDTO;
import com.lol.vo.SummonerDTO;
import com.lol.vo.SummonerSpellDTO;

@Service
public class RiotGamesService {
  private final RestTemplate restTemplate;
  private final String apiKey = "RGAPI-56f9e7ea-9bf2-4946-8fdd-db517fc9e883"; //api키
  private final String spellDataUrl = "https://ddragon.leagueoflegends.com/cdn/13.22.1/data/en_US/summoner.json";
  private final String championDataUrl = "https://ddragon.leagueoflegends.com/cdn/13.22.1/data/ko_KR/champion.json";
  @Value("${riot.api.dataDragonUrl}")
  private String dataDragonUrl;

  @Autowired
  public RiotGamesService(RestTemplate restTemplate) {
    this.restTemplate = restTemplate;
  }

  //검색한 아이디의 정보를 가져오는 메서드
  public SummonerDTO getUserAPI(String id) {
    String url = "https://kr.api.riotgames.com/lol/summoner/v4/summoners/by-name/" + id;
    HttpHeaders headers = new HttpHeaders();
    headers.set("X-Riot-Token", apiKey);

    HttpEntity<String> entity = new HttpEntity<>(headers);
    ResponseEntity<SummonerDTO> response = restTemplate.exchange(url, HttpMethod.GET, entity, SummonerDTO.class);
    return response.getBody();
  }

  //전적을 보기위한 코드를 가져오는 메서드
  public List<String> getMatchCode(String puuid) {                                    //전적 1개만 받아와보기로함
    String url = "https://asia.api.riotgames.com/lol/match/v5/matches/by-puuid/" + puuid + "/ids?start=0&count=20";
    HttpHeaders headers = new HttpHeaders();
    headers.set("X-Riot-Token", apiKey);

    HttpEntity<String> entity = new HttpEntity<>(headers);
    ResponseEntity<List<String>> response = restTemplate.exchange(
        url, HttpMethod.GET, entity, new ParameterizedTypeReference<List<String>>() {});
    return response.getBody();
  }

  //가져온 코드로 전적을 보기위한 메서드
  public MatchDTO getMatch(String matchCode) {
    String url = "https://asia.api.riotgames.com/lol/match/v5/matches/" + matchCode;
    HttpHeaders headers = new HttpHeaders();
    headers.set("X-Riot-Token", apiKey);

    HttpEntity<String> entity = new HttpEntity<>(headers);
    ResponseEntity<MatchDTO> response = restTemplate.exchange(url, HttpMethod.GET, entity, MatchDTO.class);
    return response.getBody();
  }

  // 랭크 메서드
  public List<LeagueDTO> getSummonerRank(String summonerId) {
    String url = "https://kr.api.riotgames.com/lol/league/v4/entries/by-summoner/" + summonerId + "?api_key=" + apiKey;

    ResponseEntity<LeagueDTO[]> response = restTemplate.getForEntity(url, LeagueDTO[].class);

    return Arrays.asList(response.getBody());
  }


  // champ json 받기위한 메서드
  public List<ChampDTO.Champion> getChampions() {
    ResponseEntity<ChampDTO> response = restTemplate.getForEntity(championDataUrl, ChampDTO.class);
    ChampDTO champData = response.getBody();

    List<ChampDTO.Champion> champions = new ArrayList<>();

    if(champData != null) {
      Map<String, ChampDTO.Champion> championMap = champData.getData();
      champions.addAll(championMap.values());
    }
    return champions;
  }

  // spell json
  public List<SummonerSpellDTO.SummonerSpell> getSpells() {
    ResponseEntity<SummonerSpellDTO> response = restTemplate.getForEntity(spellDataUrl, SummonerSpellDTO.class);
    SummonerSpellDTO spellData = response.getBody();

    List<SummonerSpellDTO.SummonerSpell> spells = new ArrayList<>();

    if(spellData != null) {
      Map<String, SummonerSpellDTO.SummonerSpell> spellMap = spellData.getData();
      spells.addAll(spellMap.values());
    }
    return spells;
  }



}
