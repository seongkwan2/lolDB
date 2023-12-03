package com.lol.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import com.lol.vo.ChampDTO;

@Service
public class ChampionService {
  private final RestTemplate restTemplate;
  private final String championDataUrl = "https://ddragon.leagueoflegends.com/cdn/13.22.1/data/ko_KR/championFull.json";

  public ChampionService(RestTemplate restTemplate) {
    this.restTemplate = restTemplate;
  }

  public List<ChampDTO.Champion> getChampions() {
    ResponseEntity<ChampDTO> response = restTemplate.getForEntity(championDataUrl, ChampDTO.class);
    ChampDTO champData = response.getBody();

    List<ChampDTO.Champion> champions = new ArrayList<>();

    if (champData != null) {
      Map<String, ChampDTO.Champion> championMap = champData.getData();
      champions.addAll(championMap.values());
    }

    return champions;
  }
}
