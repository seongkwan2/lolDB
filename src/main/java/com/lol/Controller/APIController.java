package com.lol.Controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.HttpClientErrorException;

import com.lol.Service.RiotGamesService;
import com.lol.vo.ChampDTO;
import com.lol.vo.LeagueDTO;
import com.lol.vo.MatchDTO;
import com.lol.vo.SummonerDTO;
import com.lol.vo.SummonerSpellDTO;

@Controller
public class APIController {

	@Autowired
	private RiotGamesService riotGamesService; // RiotGamesService 의존성 주입

	@RequestMapping(value="/searchUser")
	public String searchUser(@RequestParam(required = false) String id, Model model) throws Exception {
		boolean searchCheck = (id != null && !id.isEmpty()); // 검색이 시도되었는지 여부 확인
		model.addAttribute("searchCheck", searchCheck); // 모델에 검색 시도 여부 추가

		if(searchCheck) {
			try {
				// API를 통해 사용자 정보를 가져옴
				SummonerDTO userInfo = riotGamesService.getUserAPI(id);
				// 사용자 정보가 유효할 경우
				if (userInfo != null && userInfo.getPuuid() != null) {
					// 사용자의 매치 코드를 가져옴
					List<String> matchCodes = riotGamesService.getMatchCode(userInfo.getPuuid());
					List<MatchDTO> matchList = new ArrayList<>();

					for (String matchCode : matchCodes) {
						try {
							// 각 매치 코드에 대한 세부 정보를 가져옴
							MatchDTO matchDetails = riotGamesService.getMatch(matchCode);
							if (matchDetails != null) {
								matchList.add(matchDetails);
							}
						} catch (HttpClientErrorException.TooManyRequests ex) {
							// API 요청 제한 초과 시 대기하는 로직
							int retryAfter = extractRetryAfterValue(ex.getResponseHeaders());
							if (retryAfter > 0) {
								System.out.println("Rate limit exceeded. Waiting for " + retryAfter + " seconds.");
								Thread.sleep(retryAfter * 1000);
								int matchCodeAsInt = Integer.parseInt(matchCode);
								matchCodeAsInt--;
							}
						}
					}

					// 사용자 랭크, 주문, 챔피언 정보를 가져와 모델에 추가
					List<LeagueDTO> summonerRank = riotGamesService.getSummonerRank(userInfo.getId());
					List<SummonerSpellDTO.SummonerSpell> spells = riotGamesService.getSpells();
					List<ChampDTO.Champion> champions = riotGamesService.getChampions();

					model.addAttribute("UserInfo", userInfo);
					model.addAttribute("MatchCodes", matchCodes);
					model.addAttribute("MatchList", matchList);
					model.addAttribute("SummonerRank", summonerRank);
					model.addAttribute("champions", champions);
					model.addAttribute("spells", spells);
				}
			} catch (HttpClientErrorException e) {
				// HTTP 클라이언트 예외 처리
				if (e.getStatusCode() == HttpStatus.FORBIDDEN) {
					System.err.println("API 키가 적합하지 않습니다. 재발급을 받아주세요.");
				} else if (e.getStatusCode() == HttpStatus.NOT_FOUND) {
					System.err.println("해당 아이디의 전적이 존재하지 않습니다.");
				} else {
					e.printStackTrace();
				}
			}
		}
		return "searchUser"; // 최종적으로 반환할 뷰 이름
	}

	// HTTP 응답 헤더에서 'Retry-After' 값을 추출하는 메서드
	private int extractRetryAfterValue(HttpHeaders headers) {
		List<String> retryAfterHeaders = headers.get("Retry-After");

		if (retryAfterHeaders != null && !retryAfterHeaders.isEmpty()) {
			return Integer.parseInt(retryAfterHeaders.get(0));
		}

		return 0;
	}
}