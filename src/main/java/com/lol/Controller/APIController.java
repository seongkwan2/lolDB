package com.lol.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.lol.vo.SummonerDTO;

@Controller
public class APIController {

    // HTTP 요청을 보낼수 있게 RestTemplate 의존 주입
	@Autowired
	private RestTemplate restTemplate;

    // 주어진 소환사 이름으로 Riot Games API를 호출하여 소환사 정보를 가져오는 메서드
	public SummonerDTO getUserAPI(String id) {
        // Riot Games API의 소환사 정보 조회 엔드포인트
		String url = "https://kr.api.riotgames.com/lol/summoner/v4/summoners/by-name/" + id;
		
        // HTTP 요청 헤더를 설정
		HttpHeaders headers = new HttpHeaders();
		headers.set("X-Riot-Token", "RGAPI-04f7384e-4dd7-46a5-a107-1943ab3c7754"); // API 키값

        // HTTP 요청 엔티티를 생성
		HttpEntity<String> entity = new HttpEntity<>(headers);

        // RestTemplate을 사용하여 API 엔드포인트에 GET 요청을 보내고, 응답을 SummonerDTO 객체로 받음
		ResponseEntity<SummonerDTO> response = restTemplate.exchange(url, HttpMethod.GET, entity, SummonerDTO.class);
		return response.getBody(); // 응답 본문을 반환
	}


    // "/searchSummoner" 경로로 요청이 오면 이 메서드가 처리
	@RequestMapping(value="/searchUser")
	public String searchUser(@RequestParam(required = false) String id, Model model) {
            // 소환사 이름이 제공된 경우에만 조회
			if (id != null && !id.isEmpty()) {
				SummonerDTO UserInfo = getUserAPI(id); //API를 호출하여 정보를 가져옴
                // 조회된 정보를 모델에 추가
				model.addAttribute("UserInfo", UserInfo);
			}
		return "searchUser"; // "searchUser.jsp" 파일로 응답
	}

}

