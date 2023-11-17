package com.lol.Controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.client.RestTemplate;

import com.lol.vo.ChampDTO;

@Controller
@PropertySource(value = "classpath:championNames.properties", encoding = "UTF-8") //참조파일, 인코딩 타입 명시
public class ChampionController {

    @Autowired
    private Environment env;
    private RestTemplate restTemplate;
    private String championDataUrl = "https://ddragon.leagueoflegends.com/cdn/13.22.1/data/en_US/champion.json";

    public ChampionController(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    @GetMapping("/championImages")
    public String getChampionImages(Model model) {
        ResponseEntity<ChampDTO> response = restTemplate.getForEntity(championDataUrl, ChampDTO.class);
        ChampDTO champData = response.getBody();

        if (champData != null) {
            Map<String, ChampDTO.Champion> championMap = champData.getData();
            List<ChampDTO.Champion> champions = new ArrayList<>(championMap.values());
            Map<String, String> championKoreanNames = new HashMap<>();

            for (ChampDTO.Champion champion : champions) {
                // 챔피언의 영어 이름을 사용하여 한글 이름을 가져옴
                String koreanName = env.getProperty(champion.getName());
                championKoreanNames.put(champion.getName(), koreanName);
            }

            model.addAttribute("champions", champions);
            model.addAttribute("championKoreanNames", championKoreanNames);
        }

        return "championImages";
    }
}
