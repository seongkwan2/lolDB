package com.lol.Service;

import java.util.Arrays;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import com.lol.vo.LeagueDTO;
import com.lol.vo.MatchDTO;
import com.lol.vo.SummonerDTO;

@Service
public class RiotGamesService {
  private final RestTemplate restTemplate;
  private final String apiKey = "RGAPI-f7645bb0-7531-4651-9e58-7e9b312665af"; //api키

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
    String url = "https://asia.api.riotgames.com/lol/match/v5/matches/by-puuid/" + puuid + "/ids?start=0&count=2";
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

}