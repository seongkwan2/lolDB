package com.lol.Controller;

import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.lol.Service.RiotGamesService;
import com.lol.vo.LeagueDTO;
import com.lol.vo.MatchDTO;
import com.lol.vo.SummonerDTO;

@Controller
public class APIController {

  // HTTP 요청을 보낼수 있게 RestTemplate 의존 주입
  @Autowired
  private RiotGamesService riotGamesService;

  @RequestMapping(value="/searchUser")
  public String searchUser(@RequestParam(required = false) String id, Model model) {
    if (id != null && !id.isEmpty()) {
      try {
        SummonerDTO userInfo = riotGamesService.getUserAPI(id);
        if (userInfo != null && userInfo.getPuuid() != null) {
          List<String> matchCodes = riotGamesService.getMatchCode(userInfo.getPuuid());
          List<MatchDTO> matchList = new ArrayList<>();

          for (String matchCode : matchCodes) {
            MatchDTO matchDetails = riotGamesService.getMatch(matchCode);
            if (matchDetails != null) {
              matchList.add(matchDetails);
            }
          }

          List<LeagueDTO> summonerRank = riotGamesService.getSummonerRank(userInfo.getId());


          // Unix 타임스탬프를 Date 객체로 변환
          model.addAttribute("UserInfo", userInfo);
          model.addAttribute("MatchCodes", matchCodes);
          model.addAttribute("MatchList", matchList);
          model.addAttribute("SummonerRank", summonerRank);
        }
      } catch (Exception e) {
        e.printStackTrace(); // 로그 기록
        System.err.print(">>>>>아이디가 존재하지 않음");
      }
    }
    return "searchUser";
  }
}
