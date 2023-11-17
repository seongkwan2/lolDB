package com.lol.Controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.client.RestTemplate;
import com.lol.vo.ChampDTO;

@Controller
public class ChampionController {
  private RestTemplate restTemplate;



  private String championDataUrl = "https://ddragon.leagueoflegends.com/cdn/13.22.1/data/en_US/champion.json";


  public ChampionController(RestTemplate restTemplate) {
    this.restTemplate = restTemplate;
  }

  @GetMapping("/championImages")
  public String getChampionImages(Model model) {
    // JSON 데이터를 가져와서 ChampDTO 객체로 변환
    ResponseEntity<ChampDTO> response = restTemplate.getForEntity(championDataUrl, ChampDTO.class);
    ChampDTO champData = response.getBody();

    if (champData != null) {
      // ChampDTO에서 data 필드를 가져와서 Map으로부터 챔피언 리스트를 생성
      Map<String, ChampDTO.Champion> championMap = champData.getData();
      List<ChampDTO.Champion> champions = new ArrayList<>(championMap.values());

      // 이제 champions 리스트를 모델에 추가
      model.addAttribute("champions", champions);
    }

    return "championImages";
  }
}
