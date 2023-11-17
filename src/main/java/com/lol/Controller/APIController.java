package com.lol.Controller;

import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.HttpClientErrorException;
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
            try {
              MatchDTO matchDetails = riotGamesService.getMatch(matchCode);
              if (matchDetails != null) {
                matchList.add(matchDetails);
              }
            } catch (HttpClientErrorException.TooManyRequests ex) { //호출이 많을경우 예외처리
              // API 호출 제한 초과 시 대기
              int retryAfter = extractRetryAfterValue(ex.getResponseHeaders());// 메서드 사용해서 클라이언트 대기시간 추출

              if (retryAfter > 0) { 
                System.out.println("Rate limit exceeded. Waiting for " + retryAfter + " seconds.");
                Thread.sleep(retryAfter * 1000); // 대기 시간을 밀리초 단위로 변환
                // 다시 시도
                int matchCodeAsInt = Integer.parseInt(matchCode);
                matchCodeAsInt--;  // 감소 연산자를 사용하여 정수를 1만큼 감소 // 이전 요청으로 다시 시도하도록 인덱스를 조절
              }
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
  // Retry-After 헤더 값 추출 메서드
  private int extractRetryAfterValue(HttpHeaders headers) {
    List<String> retryAfterHeaders = headers.get("Retry-After");

    if (retryAfterHeaders != null && !retryAfterHeaders.isEmpty()) {
      return Integer.parseInt(retryAfterHeaders.get(0));
    }

    return 0;
  }
}
